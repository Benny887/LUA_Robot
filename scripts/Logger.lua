name_bot = "Net bot"--имя робота
version = "5.0"--версия
Name = "Robot"--заголовок таблицы

depo = ""--торг счет срочн рынка
class = "QJSIM"--класс инструмента
FileStart = getScriptPath().."\\".."start_data.txt"
LogFile = getScriptPath().."\\".."bot_log.txt"

last_price = 0--Последняя цена
ticker = ""--тикер инструмента
min_step = 0--шаг
min_take = 0--тейк
size_lot = 1--размер лота инструмента
max_lot = 5--максимум лотов
trades_work = 0--позиция по роботу
orient_trade = 0--направление торговли: -1 -sell, 0- sell+buy, 1- buy
stop_on = 0-- если один то стоп при 0
start_bot = 0 --0 - бот не работает, 1 - бот работает
is_run = true --переменная для вечного цикла
min_step_price = 0 -- минимальный шаг фьючерса
price_step = 0 -- цена шага фьючерса
pause_t = 0 --пауза в торгах
traders_price = 0 --цена последней сделки
last_sdelka = 0 -- 1 -тейк -1 - шаг
last_rand = 0 --послед сгенер число
rand = 0 -- след сгенерир число
num_r = 25 --номер робота
id_t = 0 -- посл цифра от сегод дня
id_bota = 0 --id бота на сегодня 



function LogWrite(str)--логгирование
    if not lf then
       lf = io.open(LogFile, "a")
    end
    td = getInfoParam("TRADEDATE")
    st = getInfoParam("SERVERTIME")
    local sec_mcs_str = tostring(os.clock()); --сек с мкс
    local mcs_str = string.sub(sec_mcs_str, sec_mcs_str:find("%.") + 1); --мкс
    if td == nil or st == nil then
        lf:write("__-__-__-__"..tostring(str).."\n")
    else
        lf:write(tostring(td).." - "..tostring(st).." - "..tostring(mcs_str).." - "..tostring(str).."\n")    
    end
    lf:flush()
end


function ReadTable()--получение данных из стартового файла
    local f = io.open(FileStart, "r")
    if f then --если файл существует
        Comment, ticker = f:read(16, "l")
        ticker = string.gsub(ticker, "%s+", "")
        LogWrite("ticker = "..ticker)
        
        Comment, trades_work = f:read(16, "l")
        trades_work = string.gsub(trades_work, "%s+", "")
        trades_work = tonumber(trades_work)
        LogWrite("trades_work = "..trades_work)

        Comment, orient_trade = f:read(16, "l")
        orient_trade = string.gsub(orient_trade, "%s+", "")
        orient_trade = tonumber(orient_trade)
        LogWrite("orient_trade = "..orient_trade)

        Comment, size_lot = f:read(16, "l")
        size_lot = string.gsub(size_lot, "%s+", "")
        size_lot = tonumber(size_lot)
        size_lot = math.abs(size_lot)
        LogWrite("size_lot = "..size_lot)

        Comment, min_step = f:read(16, "l")
        min_step = string.gsub(min_step, "%s+", "")
        min_step = tonumber(min_step)
        min_step = math.abs(min_step)
        LogWrite("min_step = "..min_step)

        Comment, min_take = f:read(16, "l")
        min_take = string.gsub(min_take, "%s+", "")
        min_take = tonumber(min_take)
        min_take = math.abs(min_take)
        LogWrite("min_take = "..min_take)

        Comment, max_lot = f:read(16, "l")
        max_lot = string.gsub(max_lot, "%s+", "")
        max_lot = tonumber(max_lot)
        max_lot = math.abs(max_lot)
        LogWrite("max_lot = "..max_lot)

        f:close()
    else
        --  сохран тек данн в файл   
        SaveStart()
    end
end

function SaveStart()-- сох текущ настройки торговли
    local f = io.open(FileStart, "w")-- Режим перезаписи

    f:write("Tool           : "..ticker.."\n")
    f:write("Position       : "..trades_work.."\n")
    f:write("Direction      : "..orient_trade.."\n")
    f:write("Size of lot    : "..size_lot.."\n")
    f:write("Step           : "..min_step.."\n")
    f:write("Take           : "..min_take.."\n")
    f:write("Max of lots    : "..max_lot.."\n")

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

 
    --2я строка
    SetCell(t_id, 2, 1, tostring("Price")); Color("Yellow", t_id, 2, 1)
    Color("Yellow", t_id, 2, 3)

    --3я строка
    SetCell(t_id, 3, 1, tostring("Position")); Color("Gray", t_id, 3, 1)
    Color("Gray", t_id, 3, 2)
    SetCell(t_id, 3, 3, tostring("- ")); Color("Gray", t_id, 3, 3)

    --4я строка
    SetCell(t_id, 4, 1, tostring("Direction")); Color("Gray", t_id, 4, 1)
    SetCell(t_id, 4, 3, tostring("- ")); Color("Gray", t_id, 4, 3)

    --5я строка
    SetCell(t_id, 5, 1, tostring("Lot size")); Color("Blue", t_id, 5, 1)
    Color("Blue", t_id, 5, 2)
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
    Color("Yellow", t_id, 9, 1)
    Color("Blue", t_id, 9, 3)

    SetTableNotificationCallback(t_id, TableMessage) -- ф-я реагирующая на мышь
end



function FillTable()

    --1я строка
    if start_bot == 0 then
        SetCell(t_id, 1, 1, tostring("Start")); Color("Blue", t_id, 1, 1)
        SetCell(t_id, 1, 2, tostring("Doesn't work")); Color("White-Red", t_id, 1, 2)
    else
        SetCell(t_id, 1, 2, tostring("Stop")); Color("Blue", t_id, 1, 2)
        SetCell(t_id, 1, 1, tostring("Working")); Color("White-Red", t_id, 1, 1)
    end
    

    --2я строка
    last_price = FindPrice(ticker, class)
    SetCell(t_id, 2, 2, tostring(last_price)); Color("Yellow", t_id, 2, 2)

    --3я строка
    SetCell(t_id, 3, 2, tostring(trades_work));

    --4я строка
    if orient_trade == -1 then
        SetCell(t_id, 4, 2, tostring("sell      ")); Color("Red", t_id, 4, 2)
    elseif orient_trade == 0 then
        SetCell(t_id, 4, 2, tostring("sell+buy      ")); Color("Cyan", t_id, 4, 2)
    elseif orient_trade == 1 then
        SetCell(t_id, 4, 2, tostring("buy      ")); Color("Green", t_id, 4, 2)
    end

    --5я строка
    SetCell(t_id, 5, 2, tostring(size_lot));

    --6я строка
    SetCell(t_id, 6, 2, tostring(max_lot));

    --7я строка
    SetCell(t_id, 7, 2, tostring(min_step));

    --8я строка
    SetCell(t_id, 8, 2, tostring(min_take));

    --9я строка
    ServerTime = getInfoParam("SERVERTIME")
    if(ServerTime) == nil or ServerTime == 0 or ServerTime == "" then
        ServerTime = "00:00:00"
    end

    if pause_t == 0 then
        SetCell(t_id, 9, 1, tostring(ServerTime));
    else
        SetCell(t_id, 9, 1, tostring("Paused "..ServerTime));    
    end
    
    if stop_on == 0 then
        SetCell(t_id, 9, 2, tostring("x Stop when 0")); Color("Blue", t_id, 9, 2)
    else
        SetCell(t_id, 9, 2, tostring("v Stop when 0")); Color("Yellow", t_id, 9, 2)
    end
end


function TableMessage(t_id, msg, par1, par2) --ф-я обработки событий в таблице (табл, сообщ, стр, столб)
    
    --нажата кнопка Старт
    if msg == QTABLE_LBUTTONDOWN and par1 == 1 and par2 == 1 and start_bot == 0 and pause_t == 0 then

        LogWrite("Нажата кнопка Start")

        if isConnected() == 1 then
            start_bot = 1
        end
    end

    --если нажата кнопка Стоп, закр всех инструмента
    if msg == QTABLE_LBUTTONDOWN and par1 == 1 and par2 == 2 and start_bot == 1 then

        LogWrite("Нажата кнопка Stop")

        start_bot = 0
    end

    --если нажата кнопка Position +
    if msg == QTABLE_LBUTTONDOWN and par1 == 3 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Position +")

        trades_work = trades_work + 1
        SaveStart()
    end

    --если нажата кнопка Position -
    if msg == QTABLE_LBUTTONDOWN and par1 == 3 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Position -")

        trades_work = trades_work - 1
        SaveStart()
    end

    --если нажата кнопка Direction +
    if msg == QTABLE_LBUTTONDOWN and par1 == 4 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Direction +")

        orient_trade = orient_trade + 1
        if orient_trade == 2 then
            orient_trade = -1
        end

        SaveStart()
    end

    --если нажата кнопка Direction -
    if msg == QTABLE_LBUTTONDOWN and par1 == 4 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Direction -")

        orient_trade = orient_trade - 1
        if orient_trade == -2 then
            orient_trade = 1
        end

        SaveStart()
    end


    --если нажата кнопка Lot size +
    if msg == QTABLE_LBUTTONDOWN and par1 == 5 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Lot size +")

        size_lot = size_lot + 1
        size_lot = math.ceil(size_lot)
        if size_lot > max_lot then
            size_lot = math.floor(max_lot)
        end

        SaveStart()
    end

    --если нажата кнопка Lot size -
    if msg == QTABLE_LBUTTONDOWN and par1 == 5 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Lot size -")

        size_lot = size_lot - 1
       
        if size_lot == 0 then
            size_lot = 1
        end
        size_lot = math.ceil(size_lot)

        SaveStart()
    end


    --если нажата кнопка Max lot +
    if msg == QTABLE_LBUTTONDOWN and par1 == 6 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Max lot +")

        max_lot = max_lot + 1
        max_lot = math.ceil(max_lot)

        SaveStart()
    end

    --если нажата кнопка Max lot -
    if msg == QTABLE_LBUTTONDOWN and par1 == 6 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Max lot +")

        max_lot = max_lot - 1
        if size_lot > max_lot then
            max_lot = size_lot
        end
        max_lot = math.ceil(max_lot)

        SaveStart()
    end


    --если нажата кнопка Min шаг +
    if msg == QTABLE_LBUTTONDOWN and par1 == 7 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Min шаг +")
       
        min_step = min_step + min_step_price
        min_step = min_step - min_step%min_step_price

        SaveStart()
    end

    --если нажата кнопка Min шаг -
    if msg == QTABLE_LBUTTONDOWN and par1 == 7 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Min шаг -")

        min_step = min_step - min_step_price

        if min_step < min_step_price then
            min_step = min_step_price
        end
        min_step = min_step - min_step%min_step_price

        SaveStart()
    end



    --если нажата кнопка Take +
    if msg == QTABLE_LBUTTONDOWN and par1 == 8 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Take +")

        min_take = min_take + min_step_price

        SaveStart()
    end

    --если нажата кнопка Take -
    if msg == QTABLE_LBUTTONDOWN and par1 == 8 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Take -")

        min_take = min_take - min_step_price
        if min_take < min_step_price then
            min_take = min_step_price
        end

        SaveStart()
    end


    --если нажата кнопка Stop no 0
    if msg == QTABLE_LBUTTONDOWN and par1 == 9 and par2 == 2 then

        LogWrite("Нажата кнопка Stop no 0")
        
        if stop_on == 0 then
            stop_on = 1
        else 
            stop_on = 0
        end
    end

end    

function FindPrice(sec_code, class_code) --находит последнюю цену актива
    local AktivPrice = Round((tonumber(getParamEx(class_code, sec_code, "OFFER").param_value - getParamEx(class_code, sec_code, "BID").param_value) * 100)) * 0.1--OFFER, BID
    if AktivPrice == nil then
        message(''..nil)
        AktivPrice = Round(tonumber(getParamEx(class_code, sec_code, "HIGH").param_value))
    end
    return AktivPrice
end

function Round(number)
    return math.floor(number + 0.0005)
end


function OnStop() -- вызывается терминалом Quik при остановке скрипта из диалога управления при закрытии терминала (Типы остановок: 1. "Остановить" в окне запуска  2. Закрыть окно)

    LogWrite("Остановка скрипта")

    is_run = false
    SaveStart()
    DestroyTable(t_id)
    return 2000
end

function TimePause()
    if string.sub( ServerTime, 2, 2) == ":" then
        Hour_p = tonumber(string.sub(ServerTime, 1, 1))
        Min_p = tonumber(string.sub(ServerTime, 3, 4))
        Sec_p = tonumber(string.sub(ServerTime, 6, 7))
    else
        Hour_p = tonumber(string.sub(ServerTime, 1, 2))
        Min_p = tonumber(string.sub(ServerTime, 4, 5))
        Sec_p = tonumber(string.sub(ServerTime, 7, 8))
    end

    --до начала утренней сессии пауза = 1
    if isConnected() == 0 then
        pause_t = 1
    elseif Hour_p < 9 then
        pause_t = 1
    elseif (Hour_p == 13 and Min_p > 59 and Sec_p >= 55) or (Hour_p == 14 and Min_p < 5) then
        pause_t = 1
    elseif (Hour_p == 18 and Min_p > 49) or (Hour_p == 18 and Min_p == 49 and Sec_p >= 55) or (Hour_p == 19 and Min_p < 5) then
        pause_t = 1
    elseif ((Hour_p == 23 and Min_p > 49) or (Hour_p == 23 and Min_p == 49 and Sec_p >= 45)) then
        start_bot = 0
        pause_t = 1    
    else
        pause_t = 0    
    end
end


function main()
    LogWrite("Бот запущен")

    ReadTable()--получ данных из стартов файла
    CreateTable()--созд таблицу


    min_step_price = tonumber(getParamEx(class, ticker, "SEC_PRICE_STEP").param_value) -- находим минимальный шаг фьючерса

    LogWrite("min_step_price = "..min_step_price)

    price_step=tonumber(getParamEx(class, ticker, "STEPPRICE").param_value) -- находим цену шага фьючерса
    LogWrite("price_step = "..price_step)


    while is_run == true do --основн цикл скрипта
        FillTable() -- зфполнение экранной таблицы
        TimePause() -- проверка на паузы

        if IsWindowClosed(t_id) then
            LogWrite("Окно закрыто")
            SaveStart()
            is_run = false
        end

        sleep(50) --мс
    end
end



