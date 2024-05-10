name_bot = "Net bot"--имя робота
version = "8.0"--версия
Name = "Robot"--заголовок таблицы

depo = "NL0011100043"--торг счет срочн рынка
class = ""--класс инструмента
FileStart = getScriptPath().."\\".."start_data.txt"
LogFile = getScriptPath().."\\".."bot_log.txt"
ToolsFile = getScriptPath().."\\".."instruments.txt"
ClassesFile = getScriptPath().."\\".."class codes.txt"
InstrumentTypesFile = getScriptPath().."\\".."instrument type.txt"

current_spread = 0--текущий размер спреда инструмента
ticker = ""--тикер инструмента
min_step = 0--шаг
low_border_spread_to_trade = 0 -- мин спред при котором торгуем чтоб не жрать себя
min_take = 0--тейк
size_lot = 1-- максимальное количество заявок инструмента
max_pos = 5--максимум позиций
spread_limit = 0--текущий спред
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
tr_id = 0
BuyOrder_ID = 0 -- id транзакции покупки
SellOrder_ID = 0 -- id транзакции продажи
BuyOrder_num = 0 -- номер заявки покупной
SellOrder_num = 0 -- номер заявки продажной
dummy = 0
last_operation = ""
num_active_sell_order = 0
num_active_buy_order = 0
buyAppNumberToRemove = 0
sellAppNumberToRemove = 0


offer_value_to_set = 0
bid_value_to_set = 0



function split(partOfWord, inputString, separator)
    if partOfWord == "f" then
        local sepIndex = string.find(inputString, separator)
        local result = string.sub(0, sepIndex)
        return result
    else
        local sepIndex = string.find(inputString, separator) + 1
        local result = string.sub(inputString, sepIndex)
        return result
    end
end


function getParamFromFile(toolName, fileName)
LogWrite("getParamFromFile method start: ticker = "..toolName)
local f = io.open(fileName, "r")
for line in f:lines() do
    if string.match(line, toolName) then
        min_step_loc = split("s", line, ":")
        f:close()
        LogWrite("getParamFromFile method finish: min_step_loc = "..min_step_loc)
        return min_step_loc
    end
end
end


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
        
        Comment, spread_limit = f:read(16, "l")
        spread_limit = string.gsub(spread_limit, "%s+", "")
        spread_limit = tonumber(spread_limit)
        LogWrite("spread_limit = "..spread_limit)

        Comment, orient_trade = f:read(16, "l")
        orient_trade = string.gsub(orient_trade, "%s+", "")
        orient_trade = tonumber(orient_trade)
        LogWrite("orient_trade = "..orient_trade)

        Comment, size_lot = f:read(16, "l")
        size_lot = string.gsub(size_lot, "%s+", "")
        size_lot = tonumber(size_lot)
        size_lot = math.abs(size_lot)
        LogWrite("size_lot = "..size_lot)

        Comment, dummy = f:read(16, "l")
        dummy = string.gsub(dummy, "%s+", "")
        dummy = tonumber(dummy)
        dummy = math.abs(dummy)
        LogWrite("dummy = "..dummy)

        Comment, min_take = f:read(16, "l")
        min_take = string.gsub(min_take, "%s+", "")
        min_take = tonumber(min_take)
        min_take = math.abs(min_take)
        LogWrite("min_take = "..min_take)

        Comment, max_pos = f:read(16, "l")
        max_pos = string.gsub(max_pos, "%s+", "")
        max_pos = tonumber(max_pos)
        max_pos = math.abs(max_pos)
        LogWrite("max_pos = "..max_pos)

        f:close()
    else
        --  сохран тек данн в файл   
        SaveStart()
    end
end

function SaveStart()-- сох текущ настройки торговли
    local f = io.open(FileStart, "w")-- Режим перезаписи

    f:write("Tool           : "..ticker.."\n")
    f:write("Spread limit   : "..spread_limit.."\n")
    f:write("Direction      : "..orient_trade.."\n")
    f:write("Size of lot    : "..size_lot.."\n")
    f:write("Dummy          : "..dummy.."\n")
    f:write("Take           : "..min_take.."\n")
    f:write("Max of pos     : "..max_pos.."\n")

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
    
    SetWindowPos(t_id, 0, 0, 290, 250)--положение и размеры окна таблицы(положение окна(x , y), ширина, высота)

    for m=1, 13 do
        InsertRow(t_id, -1)
    end

 
    --2я строка
    SetCell(t_id, 2, 1, tostring("Current spread")); Color("Yellow", t_id, 2, 1)
    Color("Yellow", t_id, 2, 3)

    --3я строка
    SetCell(t_id, 3, 1, tostring("Spread limit")); Color("Gray", t_id, 3, 1)
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
    SetCell(t_id, 6, 1, tostring("Max of pos")); Color("Blue", t_id, 6, 1)
    SetCell(t_id, 6, 2, tostring(max_pos)); Color("Blue", t_id, 6, 2)
    SetCell(t_id, 6, 3, tostring("- ")); Color("Blue", t_id, 6, 3)

    --7я строка
    SetCell(t_id, 7, 1, tostring("Dummy")); Color("Orange", t_id, 7, 1)
    SetCell(t_id, 7, 2, tostring(dummy)); Color("Orange", t_id, 7, 2)
    SetCell(t_id, 7, 3, tostring("- ")); Color("Orange", t_id, 7, 3)

    --8я строка
    SetCell(t_id, 8, 1, tostring("Take")); Color("Orange", t_id, 8, 1)
    SetCell(t_id, 8, 2, tostring(min_take)); Color("Orange", t_id, 8, 2)
    SetCell(t_id, 8, 3, tostring("- ")); Color("Orange", t_id, 8, 3)

    --9я строка
    Color("Yellow", t_id, 9, 1)
    Color("Blue", t_id, 9, 3)

    --10я строка
    SetCell(t_id, 10, 1, tostring("Tool min step")); Color("Orange", t_id, 10, 1)
    SetCell(t_id, 10, 2, tostring(min_step)); Color("Orange", t_id, 10, 2)
    SetCell(t_id, 10, 3, tostring(" ")); Color("Orange", t_id, 10, 3)

    --11я строка
    SetCell(t_id, 11, 1, tostring("Low bor spr trade")); Color("Red", t_id, 11, 1)
    SetCell(t_id, 11, 2, tostring(low_border_spread_to_trade)); Color("Red", t_id, 11, 2)
    SetCell(t_id, 11, 3, tostring(" ")); Color("Red", t_id, 11, 3)

    --12я строка
    SetCell(t_id, 12, 1, tostring("Class code")); Color("Red", t_id, 12, 1)
    SetCell(t_id, 12, 2, tostring(class)); Color("Red", t_id, 12, 2)
    SetCell(t_id, 12, 3, tostring(" ")); Color("Red", t_id, 12, 3)

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
    current_spread = FindCurrentSpread(ticker, class)
    if (current_spread ~= nil) then
        SetCell(t_id, 2, 2, tostring(current_spread)); Color("Yellow", t_id, 2, 2)
    else
        SetCell(t_id, 2, 2, "error"); Color("Yellow", t_id, 2, 2)
    end
    

    --3я строка
    SetCell(t_id, 3, 2, tostring(spread_limit));

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
    if max_pos == 20 then
        SetCell(t_id, 6, 2, tostring("0"));
    else
        SetCell(t_id, 6, 2, tostring(max_pos));
    end
    

    --7я строка
    SetCell(t_id, 7, 2, tostring(dummy));

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

    --10я строка
    SetCell(t_id, 10, 2, tostring(min_step));

    --11я строка
    SetCell(t_id, 11, 2, tostring(low_border_spread_to_trade));

    --12я строка
    SetCell(t_id, 12, 2, tostring(class));
end


function TableMessage(t_id, msg, par1, par2) --ф-я обработки событий в таблице (табл, сообщ, стр, столб)
    
    --нажата кнопка Старт
    if msg == QTABLE_LBUTTONDOWN and par1 == 1 and par2 == 1 and start_bot == 0 and pause_t == 0 then

        LogWrite("Нажата кнопка Start")

            start_bot = 1
            -- while start_bot == 1 do
            --     StartTradeSell(offer_value_to_set)
            --     StartTradeBuy(bid_value_to_set)
            --     sleep(1000)
            -- end
            
    end

    --если нажата кнопка Стоп, закр всех инструмента
    if msg == QTABLE_LBUTTONDOWN and par1 == 1 and par2 == 2 and start_bot == 1 then

        LogWrite("Нажата кнопка Stop")

        start_bot = 0
        -- StopTrade()
    end

    --если нажата кнопка Spread limit +
    if msg == QTABLE_LBUTTONDOWN and par1 == 3 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Spread limit +")

        spread_limit = spread_limit + min_step
        SaveStart()
    end

    --если нажата кнопка Spread limit -
    if msg == QTABLE_LBUTTONDOWN and par1 == 3 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Spread limit -")

        spread_limit = spread_limit - min_step
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
        if size_lot > max_pos then
            size_lot = math.floor(max_pos)
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


    --если нажата кнопка Max pos +
    if msg == QTABLE_LBUTTONDOWN and par1 == 6 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Max lot +")

        max_pos = max_pos + 1
        max_pos = math.ceil(max_pos)
        
        if max_pos == 21 then
            max_pos = 1
        elseif max_pos > 5 then
            max_pos = 5   
        end

        SaveStart()
    end

    --если нажата кнопка Max lot -
    if msg == QTABLE_LBUTTONDOWN and par1 == 6 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Max lot +")

        max_pos = max_pos - 1
        max_pos = math.ceil(max_pos)

        if max_pos == 0 or max_pos == 19 then
            max_pos = 20 
        end

        SaveStart()
    end


    --если нажата кнопка Min шаг +
    if msg == QTABLE_LBUTTONDOWN and par1 == 7 and par2 == 2 and start_bot == 0 then

        LogWrite("Нажата кнопка Min шаг +")
       
        dummy = dummy + min_step_price
        dummy = dummy - dummy%min_step_price

        SaveStart()
    end

    --если нажата кнопка Min шаг -
    if msg == QTABLE_LBUTTONDOWN and par1 == 7 and par2 == 3 and start_bot == 0 then

        LogWrite("Нажата кнопка Min шаг -")

        dummy = dummy - min_step_price

        if dummy < min_step_price then
            dummy = min_step_price
        end
        dummy = dummy - dummy%min_step_price

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

function FindCurrentSpread(sec_code, class_code) --находит последнюю цену актива
    local active_spread = Round((tonumber(getParamEx(class_code, sec_code, "OFFER").param_value - getParamEx(class_code, sec_code, "BID").param_value) * 100)) * 0.01--OFFER, BID
    if active_spread == nil then
        message("Error while getting current spread")
    end
    return active_spread
end

function Round(number)
    return math.floor(number + 0.0005)
end


function OnStop() -- вызывается терминалом Quik при остановке скрипта из диалога управления при закрытии терминала (Типы остановок: 1. "Остановить" в окне запуска  2. Закрыть окно)

    LogWrite("Остановка скрипта")

    is_run = false
    SaveStart()
    -- KillOrderSell()
    -- KillOrderBuy()
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


function StartTradeSell(current_value)
    if is_run and start_bot == 1 then
        if FindCurrentSpread(ticker, class) < spread_limit then
            steeeeeep = tonumber(getParamEx(ticker, class, "SEC_PRICE_STEP").param_value)
            message("Too low spread, steeeeeep = "..steeeeeep)
            LogWrite("Too low spread for sell operation, step = "..steeeeeep)
            return
        end

        if not isAcceptableSpread() then
            message("Incceptable spread:= "..current_value)
            LogWrite("Incceptable spread for sell operation: "..current_value)
            return
        end

        if current_value == 0 then
            actual_offer_value1, bid_value, spred = GetStakanExtremumValues()
            if actual_offer_value1 == 0 then
                message("Instrument is temporary inavailable. Bot is disabled!!!!")
                start_bot = 0
                return
            end
            offer_value_to_set = math.ceil(actual_offer_value1 - min_step) --math.ceil( если с фьючерсами
            
            OrdersLimit(offer_value_to_set, 1, "S")
            LogWrite("start trade, actual_offer_value ="..actual_offer_value1.." set best offer value = "..offer_value_to_set.." bid_value = "..bid_value.." spred ="..spred)
            message("start trade, set best offer value = "..offer_value_to_set.." bid_value = "..bid_value.." spred ="..spred, 1)
        else --countCurrentPositions(ticker)  < max_pos  когда будем работать с позициями) (CountAllSellOrders(ticker) < size_lot - если нужно ограничение по заявкам )
            actual_offer_value, bid_value, spred = GetStakanExtremumValues()
            CountSellOrdersByTool(ticker)
            LogWrite("from trade : actual_offer_value = "..actual_offer_value.." bid_value = "..bid_value.." spred ="..spred.." current_value ="..current_value)--  num of positions "..countCurrentPositions(ticker).." < "..max_pos.."  при участи позиций

            if actual_offer_value ~= 0 and (actual_offer_value ~= current_value) and is_run then
                offer_value_to_set = math.ceil(actual_offer_value - min_step)--math.ceil(
                KillLastOrderByType("S")
                OrdersLimit(offer_value_to_set, 1, "S")
                message("bit current price: actual_offer_value "..actual_offer_value.." > current_value "..current_value.."offer less price : "..offer_value_to_set, 2)
                LogWrite("bit current price: actual_offer_value "..actual_offer_value.." > current_value "..current_value.."offer less price : "..offer_value_to_set)
            elseif actual_offer_value == 0 then
                message("actual_offer_value is nil", 3)
                start_bot = 0
            elseif current_value ~= 0 then
                message("actual_offer_value = "..actual_offer_value.." is equals or greater than current_value = "..current_value.."countCurrentPositions = "..countCurrentPositions(ticker), 3)
            end
        -- else
        --     message("Positions limit - "..max_pos.." is reached! ")    
        --     sleep(500)
        end
        
    else
        message("Bot is disabled")
    end
end

function StartTradeBuy(current_value)
    if is_run and start_bot == 1 then
        if current_spread < spread_limit then
            steeeeeep = tonumber(getParamEx(ticker, class, "SEC_PRICE_STEP").param_value)
            LogWrite("Too low spread for buy operation, step = "..steeeeeep)
            message("Too low spread, steeeeeep = "..steeeeeep)
            return
        end

        if not isAcceptableSpread() then
            message("Incceptable spread : "..current_value)
            LogWrite("Incceptable spread for buy operation: "..current_value)
            return
        end

        if current_value == 0 then
            actual_bid_value, actual_bid_value, spred = GetStakanExtremumValues()
            if actual_bid_value == 0 then
                message("Instrument is temporary inavailable. Bot is disabled!!!!")
                start_bot = 0
                return
            end
            bid_value_to_set = math.ceil(actual_bid_value + min_step)--math.ceil(
            OrdersLimit(bid_value_to_set, 1, "B")
            LogWrite("start trade, actual_bid_value ="..actual_bid_value.." set best bid value = "..bid_value_to_set.." bid_value = "..bid_value.." spred ="..spred)
            message("start trade, set best bid value = "..bid_value_to_set.." bid_value = "..bid_value.." spred ="..spred, 1)
        else -- (countCurrentPositions(ticker) < max_pos  когда будем работать с позициями) (CountAllBuyOrders(ticker) < size_lot then - если нужно ограничение по заявкам)
            actual_offer_value, actual_bid_value, spred = GetStakanExtremumValues()
            CountBuyOrdersByTool(ticker)
            LogWrite("from trade : actual_offer_value = "..actual_offer_value.." actual_bid_value = "..actual_bid_value.." spred ="..spred.." current_value ="..current_value) --num of positions "..countCurrentPositions(ticker).." < "..max_pos..", - при учстии позиций

            if actual_bid_value ~= 0 and (actual_bid_value ~= current_value) and is_run then 
                bid_value_to_set = math.ceil(actual_bid_value + min_step)--math.ceil(
                KillLastOrderByType("B")
                OrdersLimit(bid_value_to_set, 1, "B")
                message("bit current price: actual_bid_value "..actual_bid_value.." > current_value "..current_value.."bid greater price : "..bid_value_to_set, 2)
                LogWrite("bit current price: actual_bid_value "..actual_bid_value.." > current_value "..current_value.."bid greater price : "..bid_value_to_set)
            elseif actual_bid_value == 0 then
                message("actual_bid_value is nil", 3)
                start_bot = 0
            elseif current_value ~= 0 then

                message("actual_bid_value = "..actual_bid_value.."is equals or less than current_value = "..current_value.."countCurrentPositions = "..countCurrentPositions(ticker), 3)
            end
        -- else
        --     message("Positions limit - "..max_pos.." is reached! ")    
        --     sleep(500)       
        end
    else
        message("Bot is disabled")
    end
end

function isAcceptableSpread()
    return low_border_spread_to_trade < current_spread
end


function countCurrentPositions(ticker)
    LogWrite("Count active current positions start")
    local totalnet = 0

    tablesItemsCount = getNumberOf("futures_client_holding")

	for i = 0, tablesItemsCount, 1 do
		
		futures = getItem("futures_client_holding", i)

		if futures ~= nil and futures.sec_code == ticker then 
            LogWrite("Count positions for instrument "..ticker.." found!")
            totalnet = math.abs(futures.totalnet)
            LogWrite("Count active current positions = "..totalnet)
			return totalnet
		end
		
	end
     
    LogWrite("Count active current positions finish. Count positions for instrument "..ticker.." wasn't found!")
    return totalnet
end



function CountBuyOrdersByTool(ticker)
    num_active_buy_order = 0
    LogWrite("Count active buy orders")
    num_orders = getNumberOf("orders")

    scan_max_limit = 100
    scan_limit = 0
    if num_orders > 100 then
        scan_limit = num_orders - scan_max_limit   
    end

    LogWrite("Start job at "..getInfoParam("SERVERTIME"))
	
	for i = num_orders - 1, scan_limit, -1 do
		
		myorder = getItem("orders", i)

		if bit.band(tonumber(myorder["flags"]), 1) > 0 and bit.band(tonumber(myorder["flags"]), 4) == 0 and myorder.sec_code == ticker then 
			num_active_buy_order = num_active_buy_order + 1
            buyAppNumberToRemove = myorder.order_num
		end
		
		sleep(10)
		
	end

    LogWrite("Finish job at "..getInfoParam("SERVERTIME"))
	
    LogWrite("Количество активных заявок на покупку "..num_active_buy_order)

    -- return num_active_buy_order
end

function CountSellOrdersByTool(ticker)
    num_active_sell_order = 0
    LogWrite("Count active sell orders")
    num_orders = getNumberOf("orders")

    scan_max_limit = 100
    scan_limit = 0
    if num_orders > 100 then
        scan_limit = num_orders - scan_max_limit   
    end

    LogWrite("Start job at "..getInfoParam("SERVERTIME"))
	
	for i = num_orders - 1, scan_limit, -1 do
		
		myorder = getItem("orders", i)

		if bit.band(tonumber(myorder["flags"]), 1) > 0 and bit.band(tonumber(myorder["flags"]), 4) > 0 and myorder.sec_code == ticker then 
			num_active_sell_order = num_active_sell_order + 1
            sellAppNumberToRemove = myorder.order_num
		end
		
		sleep(10)
		
	end

    LogWrite("Finish job at "..getInfoParam("SERVERTIME"))
	
    LogWrite("Количество активных заявок на продажу "..num_active_sell_order)
    
    -- return num_active_sell_order
end


-- function CountAllBuyOrders()
--     LogWrite("Count active buy orders")
--     num_orders = getNumberOf("orders")

--     scan_max_limit = 100
--     scan_limit = 0
--     if num_orders > 100 then
--         scan_limit = num_orders - scan_max_limit   
--     end

--     LogWrite("Start job at "..getInfoParam("SERVERTIME"))
	
-- 	for i = num_orders - 1, scan_limit, -1 do
		
-- 		myorder = getItem("orders", i)

-- 		if bit.band(tonumber(myorder["flags"]), 1) > 0 and bit.band(tonumber(myorder["flags"]), 4) == 0 then 
-- 			num_active_buy_order = num_active_buy_order + 1
-- 		end
		
-- 		sleep(10)
		
-- 	end

--     LogWrite("Finish job at "..getInfoParam("SERVERTIME"))
	
--     LogWrite("Количество активных заявок на покупку "..num_active_buy_order)

--     return num_active_buy_order
-- end

-- function CountAllSellOrders()
--     LogWrite("Count active sell orders")
--     num_orders = getNumberOf("orders")

--     scan_max_limit = 100
--     scan_limit = 0
--     if num_orders > 100 then
--         scan_limit = num_orders - scan_max_limit   
--     end

--     LogWrite("Start job at "..getInfoParam("SERVERTIME"))
	
-- 	for i = num_orders - 1, scan_limit, -1 do
		
-- 		myorder = getItem("orders", i)

-- 		if bit.band(tonumber(myorder["flags"]), 1) > 0 and bit.band(tonumber(myorder["flags"]), 4) > 0 then 
-- 			num_active_sell_order = num_active_sell_order + 1
-- 		end
		
-- 		sleep(10)
		
-- 	end

--     LogWrite("Finish job at "..getInfoParam("SERVERTIME"))
	
--     LogWrite("Количество активных заявок на продажу "..num_active_sell_order)
    
--     return num_active_sell_order
-- end





function checkOffer(current_value)
    offer_value, bid_value, spred = GetStakanExtremumValues()

    LogWrite("from checkOffer: current_value= "..current_value.."offer_value = "..offer_value.." bid_value = "..bid_value.." spred ="..spred)

    if current_value < offer_value then
        StartTrade(offer_value)
        message("current_value < offer_value", 4)
    end
end


function GetStakanExtremumValues ()
    offer_value = tonumber(getParamEx(class, ticker, "OFFER").param_value)
    bid_value = tonumber(getParamEx(class, ticker, "BID").param_value)

    spred = Round((offer_value - bid_value) * 100) * 0.01

    LogWrite("from extrem : offer_value = "..offer_value.." bid_value = "..bid_value.." spred ="..spred)

    return offer_value, bid_value, spred
end


function OrdersLimit(price_o, quant_o, operation_o) -- цена, количество и направление заявки
    --случ число для номера заявки бота 
    if tr_id == 0 then--id траназакции
        tr_id = num_r..id_t..math.floor(os.clock()) % 100000 -- формир псевдослуч числа, id_t - последнее число сегодняшней даты для отлич дня сделок (тут не использ), num_r - номер робота
    else
        tr_id = tr_id + 1    --номер транзак заявки
    end
    
    LogWrite("tr_id = "..tr_id)

    if operation_o == "S" then
        SellOrder_ID = tr_id
        SellOrder_num = 0
        LogWrite("SellOrder_ID = "..SellOrder_ID)
    else
        BuyOrder_ID = tr_id
        BuyOrder_num = 0
        LogWrite("BuyOrder_ID = "..BuyOrder_ID)    
    end

    -- if tonumber(min_step_price) >= 1 then
    --     price_o = math.ceil(price_o)
    -- end

    quant_o = math.ceil(quant_o)


    if offer_value ~= nil and bid_value ~= nil then
            local LimitOrder = {
                                    ["ACTION"] = "NEW_ORDER",
                                    ["account"] = depo,--счет
                                    ["OPERATION"] = operation_o,--вид операции
                                    ["CLASSCODE"] = class,--класс инструмента
                                    ["SECCODE"] = ticker,--тикер инструмента
                                    ["PRICE"] = tostring(price_o),--цена
                                    ["QUANTITY"] = tostring(quant_o), --количество
                                    ["TRANS_ID"] = tostring(tr_id),--id транзакции
                                    ["TYPE"] = "L",--лимитная заявка
                                    ["EXPIRY_DATE"] = "GTC",
                                    ["CLIENT_CODE"] = tostring(ticker.."-"..num_r),--комментарий
                                }
            Err_Order = sendTransaction(LimitOrder)

            if Err_Order ~= "" then
                LogWrite("Ошибка отправки транзакции: "..Err_Order, "depo = "..depo.."operation_o = "..operation_o.."ticker = "..ticker.."class = "..class.."price_o = "..price_o.."quant_o = "..quant_o.."tr_id = "..tr_id.."CLIENT_CODE = "..ticker.."-"..num_r)
            else
                last_operation = operation_o
                LogWrite("Транзакция отправлена: ".."depo = "..depo.."operation_o = "..operation_o.."ticker = "..ticker.."class = "..class.."price_o = "..price_o.."quant_o = "..quant_o.."tr_id = "..tr_id.."CLIENT_CODE = "..ticker.."-"..num_r)
                sleep(10)
            end
    else
        message("Ошибка определения ценового лимита. Заявка не выставлена.", 0)
    end

end


function KillLastOrderByType(src_operation)--src_operation - операция для которой делаем предудаление перед более лучшим выствалением цены
    LogWrite("Trying to kill last order "..src_operation)
    tran_id = tostring(math.floor(1000*os.clock()))

    if (src_operation == "B" and num_active_buy_order == 0)  or (src_operation == "S" and num_active_sell_order == 0) then
        LogWrite("Unable to kill last order "..src_operation..": num_active_buy_order = "..num_active_buy_order.."; num_active_sell_order = "..num_active_sell_order.." last_operation = "..last_operation)
        return
    end

    -- order = getItem("orders", last_order).order_num

    local orderToKill = src_operation == "B" and buyAppNumberToRemove or sellAppNumberToRemove

    LogWrite(LogWrite("Удаляем заявку "..tr_id .."с номером = "..orderToKill))

    local killAllOrder = {
                    ["ACTION"]="KILL_ORDER",
                    ["CLASSCODE"]=class,
                    ["SECCODE"]=ticker,
                    ["ORDER_KEY"]=tostring(orderToKill),
                    ["ACCOUNT"]= depo,		
                    ["TRANS_ID"]=tran_id,
                         }
    local res = sendTransaction(killAllOrder)
    if res ~= "" then
        LogWrite("Error while sending order removing transaction: "..res) 
    else 
        LogWrite("Order removing transaction sent")
    end

end

function killLastBuySellOrders()
    KillLastOrderByType("B")
    KillLastOrderByType("S")
end



-- function KillOrderSell()--снятие всех заявок
--     local orderCloseAll = {} --созд табл для записи в нее парам-в выставл заявки
--     local numOrders = getNumberOf("orders") -- колич заявок в системе
--     if numOrders > 0 then -- провер что хотя б одна заявка сущ
--         local j = numOrders - 1 -- присво номер послед заявки
--         while j >= 0 do -- цикл поиска заявок по номеру. выполн пока не совпад номер заяв или не закон таблица
--             orderSellClose = getItem("orders", j) -- в табл orderRTSB запис парам заявки из строки i табл "orders" с пом ф-ии getItem
--             ts_id1 = tostring(orderSellClose.trans_id)

--             if ts_id1 == 0 or ts_id1 == nil then
--                 ts_id1 = 0
--             else
--                 ts_id1 = string.sub(ts_id1, 1, 2)
--             end

--             if(bit.band(orderSellClose.flags, 0x1) ~= 0) and (bit.band(orderSellClose.flags, 0x4) ~= 0) and (tonumber(num_r) == tonumber(ts_id1))
--             and tostring(orderCloseAll.sec_code) == ticker then --услов проверя совпад ли тикер взятой заявки и тике искомой заявки
--                 LogWrite("Удаляем заявку sell "..ts_id1)
--                 tran_id = tostring(math.floor(1000*os.clock()))

--                 local killAllOrder = {
--                                 ["ACTION"]="KILL_ORDER",
--                                 ["CLASSCODE"]=class,
--                                 ["SECCODE"]=ticker,
--                                 ["ORDER_KEY"]=tostring(orderSellClose.order_num),
--                                 ["TRANS_ID"]=tran_id,
--                                      }
--                 local res = sendTransaction(killAllOrder)
--                 if res ~= "" then
--                     LogWrite("Error while sending order removing transaction: "..res) 
--                 else 
--                     LogWrite("Order removing transaction sent")
--                 end
--             end
--             j = j - 1
--         end
--     end
-- end

function KillOrderBuy()--снятие всех заявок
    local orderCloseAll = {} --созд табл для записи в нее парам-в выставл заявки
    local numOrders = getNumberOf("orders") -- колич заявок в системе
    if numOrders > 0 then -- провер что хотя б одна заявка сущ
        local j = numOrders - 1 -- присво номер послед заявки
        while j >= 0 do -- цикл поиска заявок по номеру. выполн пока не совпад номер заяв или не закон таблица
            orderBuyClose = getItem("orders", j) -- в табл orderRTSB запис парам заявки из строки i табл "orders" с пом ф-ии getItem
            ts_id1 = tostring(orderBuyClose.trans_id)

            if ts_id1 == 0 or ts_id1 == nil then
                ts_id1 = 0
            else
                ts_id1 = string.sub(ts_id1, 1, 2)
            end

            if(bit.band(orderBuyClose.flags, 0x1) ~= 0) and (bit.band(orderBuyClose.flags, 0x4) ~= 0) and (tonumber(num_r) == tonumber(ts_id1))
            and tostring(orderCloseAll.sec_code) == ticker then --услов проверя совпад ли тикер взятой заявки и тике искомой заявки
                LogWrite("Удаляем заявку sell "..ts_id1)
                tran_id = tostring(math.floor(1000*os.clock()))

                local killAllOrder = {
                                ["ACTION"]="KILL_ORDER",
                                ["CLASSCODE"]=class,
                                ["SECCODE"]=ticker,
                                ["ORDER_KEY"]=tostring(orderBuyClose.order_num),
                                ["TRANS_ID"]=tran_id,
                                     }
                local res = sendTransaction(killAllOrder)
                if res ~= "" then
                    LogWrite("Error while sending order removing transaction: "..res) 
                else 
                    LogWrite("Order removing transaction sent")
                end
            end
            j = j - 1
        end
    end
end


-- function StopTrade()--остан без закр позиций
--     LogWrite("-- Нажата кнопка СТОП -------")
    -- traders_price = 0

    -- if pause_t == 0 then
    --     KillOrderSell()
    --     KillOrderBuy()
    -- end

--     start_bot = 0
-- end


-- function OnOrder(orders_info) --вызывается автоматически QUIKом при при получении новой заявки или при изменении
--     --если id соответствует id заявки и заявка актуальна
--     if tostring(orders_info.trans_id) == tostring(SellOrder_ID) and tostring(SellOrder_ID) ~= "0" and tostring(orders_info.sec_code) == ticker then

--         -- если флаг показывает активность и еще не присваивали номер заявке
--         if bit.band(orders_info.flags, 0x1) == 1 and SellOrder_num == 0 then
--             SellOrder_num = orders_info.order_num
--             LogWrite("Заявка sell-"..SellOrder_ID.." активна. Присвоен номер ".. SellOrder_num.. "\n".." по цене "..orders_info.price.." объемом "..orders_info.qty)

--             --если флаг показывает неактивность, то снимаем показатели по заявке
--         elseif bit.band(orders_info.flags, 0x1) == 0 then
            
--             --если заявка вообще не исполнена
--             if orders_info.qty == orders_info.balance then
                
--                 --очищаем продажную заявку
--                 if pause_t == 0 then
--                     LogWrite("Не исполнена и снята заявка sell не в паузу "..SellOrder_ID)
--                 else
--                     LogWrite("Не исполнена и снята заявка sell в паузу "..SellOrder_ID)
--                 end

--                 --если заявка хоть частично но исполнена
--             else
                
--                 --изменяем поличество контрактов
--                 spread_limit = spread_limit - (orders_info.qty - orders_info.balance)
--                 LogWrite("spread_limit = "..spread_limit)
--                 SaveStart()

--                 traders_price = orders_info.price
--                 last_sdelka = -1

--                 --если заявка исполнена полностью
--                 if orders_info.balance == 0 then
--                     LogWrite("Заявка Sell исполнена полностью")
--                 else
--                     LogWrite("Заявка Sell исполнена частично")    
--                 end
--             end

--              if start_bot == 0 then
--                 KillOrderBuy()
--                 StartTrade()
--              end

--         end
--     end


--     --для покупной заявки
--     --если id соответствует id заявки и заявка актуальна
--     if tostring(orders_info.trans_id) == tostring(BuyOrder_ID) and tostring(BuyOrder_ID) ~= "0" and tostring(orders_info.sec_code) == ticker then

--         -- если флаг показывает активность и еще не присваивали номер заявке
--         if bit.band(orders_info.flags, 0x1) == 1 and BuyOrder_num == 0 then
--             BuyOrder_num = orders_info.order_num
--             LogWrite("Заявка sell-"..BuyOrder_ID.." активна. Присвоен номер ".. BuyOrder_num.. "\n".." по цене "..orders_info.price.." объемом "..orders_info.qty)

--             --если флаг показывает неактивность, то снимаем показатели по заявке
--         elseif bit.band(orders_info.flags, 0x1) == 0 then
            
--             --если заявка вообще не исполнена
--             if orders_info.qty == orders_info.balance then
                
--                 --очищаем продажную заявку
--                 if pause_t == 0 then
--                     LogWrite("Не исполнена и снята заявка sell не в паузу "..BuyOrder_ID)
--                 else
--                     LogWrite("Не исполнена и снята заявка sell в паузу "..BuyOrder_ID)
--                 end

--                 --если заявка хоть частично но исполнена
--             else
                
--                 --изменяем поличество контрактов
--                 spread_limit = spread_limit - (orders_info.qty - orders_info.balance)
--                 LogWrite("spread_limit = "..spread_limit)
--                 SaveStart()

--                 traders_price = orders_info.price
--                 last_sdelka = -1

--                 --если заявка исполнена полностью
--                 if orders_info.balance == 0 then
--                     LogWrite("Заявка Sell исполнена полностью")
--                 else
--                     LogWrite("Заявка Sell исполнена частично")    
--                 end
--             end

--              if start_bot == 0 then
--                 KillOrderBuy()
--                 StartTrade()
--              end

--         end
--     end


-- end



function main()
    LogWrite("Бот запущен")

    ReadTable()--получ данных из стартов файла
    CreateTable()--созд таблицу


    min_step_price = tonumber(getParamEx(class, ticker, "SEC_PRICE_STEP").param_value) -- находим минимальный шаг фьючерса

    LogWrite("min_step_price = "..min_step_price)

    price_step=tonumber(getParamEx(class, ticker, "STEPPRICE").param_value) -- находим цену шага фьючерса
    LogWrite("price_step = "..price_step)

    min_step = tonumber((getParamFromFile(ticker, ToolsFile):gsub(",", ".")))
    low_border_spread_to_trade = min_step * 2
    class = getParamFromFile(ticker, ClassesFile)

    while is_run == true do --основн цикл скрипта
        FillTable() -- зфполнение экранной таблицы
        -- TimePause() -- проверка на паузы

            if start_bot == 1 then
                if orient_trade == 1 then
                    StartTradeBuy(bid_value_to_set)
                elseif orient_trade == -1 then
                    StartTradeSell(offer_value_to_set)
                else
                    StartTradeSell(offer_value_to_set)
                    StartTradeBuy(bid_value_to_set)
                end
            end

        if IsWindowClosed(t_id) then
            LogWrite("Окно закрыто")
            SaveStart()
            is_run = false
        end

        sleep(1000) --мс
    end
end



