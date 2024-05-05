name_bot = "Net bot"--имя робота
version = "2.0"--версия
Name = "Robot"--заголовок таблицы

depo = ""--торг счет срочн рынка
class = "QJSIM"--класс инструмента
FileStart = getScriptPath().."\\".."start_data.txt"

last_price = 0--Последняя цена
ticker = ""--тикер инструмента
min_step = 0--шаг
min_take = 0--тейк
size_lot = 1--размер лота инструмента
max_lot = 5--максимум лотов
trades_work = 0--позиция по роботу
orient_trade = 0--направление торговли: -1 -sell, 0- sell+buy, 1- buy
stop_on = 0-- если один то стоп при 0

function ReadTable()--получение данных из стартового файла
    local f = io.open(FileStart, "r")
    if f then --если файл существует
        Comment, ticker = f:read(16, "l")
        ticker = string.gsub(ticker, "%s+", "")
        
        Comment, trades_work = f:read(16, "l")
        trades_work = string.gsub(trades_work, "%s+", "")
        trades_work = tonumber(trades_work)

        Comment, orient_trade = f:read(16, "l")
        orient_trade = string.gsub(orient_trade, "%s+", "")
        orient_trade = tonumber(orient_trade)

        Comment, size_lot = f:read(16, "l")
        size_lot = string.gsub(size_lot, "%s+", "")
        size_lot = tonumber(size_lot)
        size_lot = math.abs(size_lot)

        Comment, min_step = f:read(16, "l")
        min_step = string.gsub(min_step, "%s+", "")
        min_step = tonumber(min_step)
        min_step = math.abs(min_step)

        Comment, min_take = f:read(16, "l")
        min_take = string.gsub(min_take, "%s+", "")
        min_take = tonumber(min_take)
        min_take = math.abs(min_take)

        Comment, max_lot = f:read(16, "l")
        max_lot = string.gsub(max_lot, "%s+", "")
        max_lot = tonumber(max_lot)
        max_lot = math.abs(max_lot)

        f:close()
    else
        --  сохран тек данн в файл   
        SaveStart()
    end
end

function SaveStart()-- сох текущ настройки торговли
    local f = io.open(FileStart, "w")-- Режим перезаписи

    f:write("Tool            :  "..ticker.."\n")
    f:write("Position        :  "..trades_work.."\n")
    f:write("Direction       :  "..orient_trade.."\n")
    f:write("Size of lot     :  "..size_lot.."\n")
    f:write("Step            :  "..min_step.."\n")
    f:write("Take            :  "..min_take.."\n")
    f:write("Max of lots     :  "..max_lot.."\n")

    f:close()
end



--INTERFACE


function Color(color, id, line, column)--раскрасить таблицу
    if not column then
        column = QTABLE_NO_INDEX
    end
    if color == "Blue" then
        SetColor(id, line, column, RGB(173, 216, 230), RGB(0, 0, 0), RGB(173, 216, 230), RGB(0, 0, 0))
    end
    if color == "White-Red" then
        SetColor(id, line, column, RGB(255, 255, 255), RGB(217, 20, 29), RGB(255, 255, 255), RGB(217, 20, 29))
    end
    if color == "Yellow" then
        SetColor(id, line, column, RGB(255, 255, 0), RGB(0, 0, 0), RGB(255, 255, 0), RGB(0, 0, 0))
    end
    if color == "Gray" then
        SetColor(id, line, column, RGB(230, 230, 230), RGB(0, 0, 0), RGB(230, 230, 230), RGB(0, 0, 0))
    end
    if color == "Cyan" then
        SetColor(id, line, column, RGB(44, 112, 188), RGB(255, 255, 255), RGB(44, 112, 188), RGB(255, 255, 255))
    end
    if color == "Orange" then
        SetColor(id, line, column, RGB(255, 165, 0), RGB(0, 0, 0), RGB(255, 165, 0), RGB(0, 0, 0))
    end
    if color == "Green" then
        SetColor(id, line, column, RGB(165, 227, 128), RGB(0, 0, 0), RGB(165, 227, 128), RGB(0, 0, 0))
    end
    if color == "Red" then
        SetColor(id, line, column, RGB(255, 168, 164), RGB(0, 0, 0), RGB(255, 168, 164), RGB(0, 0, 0))
    end
    
end

function CreateTable()
    t_id = AllocTable() --получ доступ id для создания
    AddColumn(t_id, 1, name_bot, true, QTABLE_INT_TYPE, 17)--name_bot - сеточный бот
    AddColumn(t_id, 2, ticker, true, QTABLE_INT_TYPE, 15)--EDH4
    AddColumn(t_id, 3, version, true, QTABLE_INT_TYPE, 5)--version

    CreateWindow(t_id)--создает таблицу
    SetWindowCaption(t_id, Name)--устан заголовок
    
    SetWindowPos(t_id, 0, 0, 290, 220)--положение и размеры окна таблицы(положение окна(x , y), ширина, высота)

    for m=1, 9 do
        InsertRow(t_id, -1)
    end

    --1я строка
    SetCell(t_id, 1, 1, tostring("Start")); Color("Blue", t_id, 1, 1)
    SetCell(t_id, 1, 2, tostring("Doesn't work")); Color("White-Red", t_id, 1, 2)

    --2я строка
    SetCell(t_id, 2, 1, tostring("Price")); Color("Yellow", t_id, 2, 1)
    last_price = FindPrice(ticker, class)
    SetCell(t_id, 2, 2, tostring(last_price)); Color("Yellow", t_id, 2, 2)
    Color("Yellow", t_id, 2, 3)

    --3я строка
    SetCell(t_id, 3, 1, tostring("Position")); Color("Gray", t_id, 3, 1)
    SetCell(t_id, 3, 2, tostring(trades_work)); Color("Gray", t_id, 3, 2)
    SetCell(t_id, 3, 3, tostring("- ")); Color("Gray", t_id, 3, 3)

    --4я строка
    SetCell(t_id, 4, 1, tostring("Direction")); Color("Gray", t_id, 4, 1)
    if orient_trade == -1 then
        SetCell(t_id, 4, 2, tostring("sell      ")); Color("Red", t_id, 4, 2)
    elseif orient_trade == 0 then
        SetCell(t_id, 4, 2, tostring("sell+buy      ")); Color("Cyan", t_id, 4, 2)
    elseif orient_trade == 1 then
        SetCell(t_id, 4, 2, tostring("buy      ")); Color("Green", t_id, 4, 2)
    end
    SetCell(t_id, 4, 3, tostring("- ")); Color("Gray", t_id, 4, 3)

    --5я строка
    SetCell(t_id, 5, 1, tostring("Lot size")); Color("Blue", t_id, 5, 1)
    SetCell(t_id, 5, 2, tostring(size_lot)); Color("Blue", t_id, 5, 2)
    SetCell(t_id, 5, 3, tostring("- ")); Color("Blue", t_id, 5, 3)

    --6я строка
    SetCell(t_id, 6, 1, tostring("Max of lots")); Color("Blue", t_id, 6, 1)
    SetCell(t_id, 6, 2, tostring(max_lot)); Color("Blue", t_id, 6, 2)
    SetCell(t_id, 6, 3, tostring("- ")); Color("Blue", t_id, 6, 3)

    --7я строка
    SetCell(t_id, 7, 1, tostring("Step")); Color("Orange", t_id, 7, 1)
    SetCell(t_id, 7, 2, tostring(min_step)); Color("Orange", t_id, 7, 2)
    SetCell(t_id, 7, 3, tostring("- ")); Color("Orange", t_id, 7, 3)

    --8я строка
    SetCell(t_id, 8, 1, tostring("Take")); Color("Orange", t_id, 8, 1)
    SetCell(t_id, 8, 2, tostring(min_take)); Color("Orange", t_id, 8, 2)
    SetCell(t_id, 8, 3, tostring("- ")); Color("Orange", t_id, 8, 3)

    --9я строка
    ServerTime = getInfoParam("SERVERTIME")
    if(ServerTime) == nil or ServerTime == 0 or ServerTime == "" then
        ServerTime = "00:00:00"
    end
    SetCell(t_id, 9, 1, tostring(ServerTime)); Color("Yellow", t_id, 9, 1)
    if stop_on == 0 then
        SetCell(t_id, 9, 2, tostring("x Stop when 0")); Color("Blue", t_id, 9, 2)
    else
        SetCell(t_id, 9, 2, tostring("v Stop when 0")); Color("Yellow", t_id, 9, 2)
    end
    
    Color("Blue", t_id, 9, 3)
end

function FindPrice(sec_code, class_code) --находит последнюю цену актива
    local AktivPrice = tonumber(getParamEx(class_code, sec_code, "OFFER").param_value - getParamEx(class_code, sec_code, "BID").param_value)--OFFER, BID
    if AktivPrice == nil then
        message(''..nil)
        AktivPrice = tonumber(getParamEx(class_code, sec_code, "HIGH").param_value)
    end
    return AktivPrice
end

function main()
    ReadTable()--получ данных из стартов файла
    CreateTable()--созд таблицу
end

