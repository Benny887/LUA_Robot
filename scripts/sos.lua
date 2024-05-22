-- var1=2
-- var2=4
-- print(var1+var2)

-- var3="Revo"
-- var4="lution"

--[[if string.len(var4) == 6 then
    print(2)
 elseif string.len(var4) == 4 then
    print("aaaaaaa")   
    else 
        print(string.len(var4))
        print("beeee")   
--end]]

-- function split(partOfWord, inputString, separator)
--     if partOfWord == "f" then
--         local sepIndex = string.find(inputString, separator)
--         local result = string.sub(0, sepIndex)
--         return result
--     else
--         local sepIndex = string.find(inputString, separator) + 1
--         local result = string.sub(inputString, sepIndex)
--         return result
--     end
    
-- end


-- function getMinStep(toolName)
-- fileStart = "scripts/instruments.txt"
-- local f = io.open(fileStart, "r")
-- for line in f:lines() do
--     if string.match(line, toolName) then
--         min_step = split("s", line, ":")
--         return min_step
--     end
-- end
-- f:close()
-- end

-- function split(partOfWord, inputString, separator)
--     if partOfWord == "f" then
--         local sepIndex = string.find(inputString, separator)
--         local result = string.sub(0, sepIndex)
--         return result
--     else
--         local sepIndex = string.find(inputString, separator) + 1
--         local result = string.sub(inputString, sepIndex)
--         return result
--     end
-- end


-- function getMinStep(toolName)
-- fileStart = "scripts/class codes.txt"
-- local f = io.open(fileStart, "r")
-- for line in f:lines() do
--     if string.match(line, toolName) then
--         min_step_loc = split("s", line, ":")
--         return min_step_loc
--     end
-- end
-- f:close()
-- end


-- str = "USD000TODTOM:CETS"
-- class_code = getMinStep(str)
-- print(class_code)

-- str = "CAU8:0,0001"
-- print(str:gsub(",", "."))
-- min_step = tonumber((getMinStep(str):gsub(",", ".")))
-- print(min_step)




-- getmetatable("RTU8")

-- local function multy (a, b)
--     return a * b
-- end

-- print(multy(3, 5))



-- print(var3..var4)




















-- КОЛИЧЕСТВО ЗАЯВОК ПРОД/ПОКУП (РАБОЧ)

-- LogFile = getScriptPath().."\\".."bot_log.txt"

function LogWrite(str)--логгирование
    if not lf then
       lf = io.open(LogFile, "a")
    end

      lf:write(tostring(str).."\n")    

    lf:flush()
end

-- function main()

	-- num_orders = getNumberOf("orders")
	-- message("All applies: "..num_orders)
	-- num_active_buy_order = 0
    -- num_active_sell_order = 0

    -- LogWrite("Start job at "..getInfoParam("SERVERTIME"))
	
	-- for i = num_orders - 1, num_orders - 100, -1 do
		
	-- 	myorder = getItem("orders", i)

	-- 	if bit.band(tonumber(myorder["flags"]), 1) > 0 and bit.band(tonumber(myorder["flags"]), 4) == 0 then 
	-- 		message(i..": заявка: "..myorder["order_num"].." цена:"..myorder["price"].." объем: "..myorder["balance"].." комментарий:"..myorder["brokerref"])
	-- 		num_active_buy_order = num_active_buy_order + 1
    --     elseif bit.band(tonumber(myorder["flags"]), 1) > 0 and bit.band(tonumber(myorder["flags"]), 4) > 0 then
    --         message(i..": заявка: "..myorder["order_num"].." цена:"..myorder["price"].." объем: "..myorder["balance"].." комментарий:"..myorder["brokerref"])
	-- 		num_active_sell_order = num_active_sell_order + 1
	-- 	end
		
	-- 	sleep(10)
		
	-- end

    -- LogWrite("Finish job at "..getInfoParam("SERVERTIME"))
	
	-- message("Количество активных хаявок на покупку "..num_active_buy_order)
    -- LogWrite("Количество активных хаявок на покупку "..num_active_buy_order)
    -- message("Количество активных хаявок на продажу "..num_active_sell_order)
    -- LogWrite("Количество активных хаявок на продажу "..num_active_sell_order)

--     countAllBuyOrders()
--     countAllSellOrders()
	
-- end



-- function countAllBuyOrders()
--     LogWrite("Count active buy orders")
--     num_orders = getNumberOf("orders")

--     scan_max_limit = 100
--     scan_limit = 0
--     if num_orders > 100 then
--         scan_limit = num_orders - scan_max_limit   
--     end
    
-- 	num_active_buy_order = 0

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

-- function countAllSellOrders()
--     LogWrite("Count active sell orders")
--     num_orders = getNumberOf("orders")

--     scan_max_limit = 100
--     scan_limit = 0
--     if num_orders > 100 then
--         scan_limit = num_orders - scan_max_limit   
--     end
    
-- 	num_active_sell_order = 0

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









function OrdersLimit(price_o, quant_o, operation_o) -- цена, количество и направление заявки
    --случ число для номера заявки бота 
    if tr_id == 0 then--id траназакции
        tr_id = num_r..id_t..math.floor(os.clock()) % 100000 -- формир псевдослуч числа, id_t - последнее число сегодняшней даты для отлич дня сделок (тут не использ), num_r - номер робота
    else
        tr_id = tr_id + 1    --номер транзак заявки
    end
    
    LogWrite("tr_id = "..tr_id)
    LogWrite("price_o = "..price_o)

    -- if operation_o == "S" then
    --     SellOrder_ID = tr_id
    --     SellOrder_num = 0
    --     LogWrite("SellOrder_ID = "..SellOrder_ID)
    -- else
    --     BuyOrder_ID = tr_id
    --     BuyOrder_num = 0
    --     LogWrite("BuyOrder_ID = "..BuyOrder_ID)    
    -- end

    -- if tonumber(min_step_price) >= 1 then
    --     price_o = math.ceil(price_o)
    -- end

    quant_o = math.ceil(quant_o)

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
   

end
















--КОЛИЧЕСТВО ТЕКУЩИХ ПОЗИЦИЙ


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
    local f = io.open(fileName, "r")
    for line in f:lines() do
        if string.match(line, toolName) then
            min_step_loc = split("s", line, ":")
            return min_step_loc
        end
    end
    f:close()
    end


-- currentpos	NUMBER	Текущий остаток

-- account_positions  = orders

LogFile = getScriptPath().."\\".."bot_log.txt"


ticker = "SBERP"
class = "QJSIM"

depo = "NL0011100043"

num_r = 25

tr_id = num_r..math.floor(os.clock()) % 100000

operation_o = "S"

alarmRatio = 0.95


function main()
    -- account_positions = getNumberOf("account_positions") 
    -- message(" account_positions = "..account_positions)
    -- LogWrite(" account_positions = "..account_positions)

    -- currentpos = getItem("account_positions", 1).currentpos

    -- message(" currentpos = "..currentpos)
    -- LogWrite(" currentpos = "..currentpos)

    -- currentpos = getItem("firm_holding", 1)

    -- number = getNumberOf("futures_client_holding") -- колич записей таблицы фьючерсов

    -- message(" number = "..number)
    -- LogWrite(" currentpos = "..currentpos)

    -- sec_code = getItem("futures_client_holding", 0).sec_code --поллучить параметр sec_code(назв инстр) из таблицы фьчерсов
    -- openbuys = getItem("futures_client_holding", 0).openbuys -- 	Активные на покупку
    -- message(" openbuys = "..openbuys)
    -- opensells = getItem("futures_client_holding", 0).opensells -- 	Активные на покупку
    -- message(" openbuys = "..opensells)
                    -- totalnet = getItem("futures_client_holding", 0).totalnet -- 	currentpos
                    -- message(" totalnet = "..math.abs(totalnet))

                    

-- firms = getNumberOf("firms")
-- LogWrite(" firms = "..firms)
-- classes = getNumberOf("classes")
-- LogWrite(" classes = "..classes)
-- securities = getNumberOf("securities")
-- LogWrite(" securities = "..securities)

-- client_codes = getNumberOf("client_codes")
-- LogWrite(" client_codes = "..client_codes)

-- all_trades = getNumberOf("all_trades")
-- LogWrite(" all_trades = "..all_trades)

-- account_positions = getNumberOf("account_positions")
-- LogWrite(" account_positions = "..account_positions)

-- orders = getNumberOf("orders")
-- LogWrite(" orders = "..orders)

-- futures_client_holding = getNumberOf("futures_client_holding")
-- LogWrite(" futures_client_holding = "..futures_client_holding)
-- futures_client_limits = getNumberOf("futures_client_limits")
-- LogWrite(" futures_client_limits = "..futures_client_limits)
-- money_limits = getNumberOf("money_limits")
-- LogWrite(" money_limits = "..money_limits)

-- depo_limits = getNumberOf("depo_limits")
-- LogWrite(" depo_limits = "..depo_limits)



-- LogWrite("\n")
-- for i = 0, depo_limits, 1 do
		
--     acc = getItem("depo_limits", i)


--     LogWrite(getParamEx(class, acc.sec_code, "BID").param_value)
--     LogWrite(getParamEx(class, acc.sec_code, "OFFER").param_value)
--     LogWrite("currentbal = "..acc.currentbal)
--     LogWrite("wa_position_price = "..acc.wa_position_price)

--     LogWrite("\n")
-- end

-- trades = getNumberOf("trades")
-- LogWrite(" trades = "..trades)
-- stop_orders = getNumberOf("stop_orders")
-- LogWrite(" stop_orders = "..stop_orders)
-- neg_deals = getNumberOf("neg_deals")
-- LogWrite(" neg_deals = "..neg_deals)
-- neg_trades = getNumberOf("neg_trades")
-- LogWrite(" neg_trades = "..neg_trades)
-- neg_deal_reports = getNumberOf("neg_deal_reports")
-- LogWrite(" neg_deal_reports = "..neg_deal_reports)
-- firm_holding = getNumberOf("firm_holding")
-- LogWrite(" firm_holding = "..firm_holding)
-- account_balance = getNumberOf("account_balance")
-- LogWrite(" account_balance = "..account_balance)
-- ccp_holdings = getNumberOf("ccp_holdings")
-- LogWrite(" ccp_holdings = "..ccp_holdings)
-- rm_holdings = getNumberOf("rm_holdings")

-- countCurrentFirms()
-- countCurrentClasses()
-- findCurPosFutures(ticker)

-- KillMFutureOrder()

-- checkFuturePriceDeviationAndRem()
checkFondsPriceDeviationAndRem()


-- findStep()

-- findToolParamTable(class, ticker)


end

-- ticker = "YNM4"
-- class = "SPBFUT"

-- tr_id = 0

-- depo = "NL0011100043"

-- num_r = 25

-- operation_o == "S"


-- a=getSecurityInfo("", «GZH5»).class_code -- узнать класс ТОЛЬКО  по инструменту !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



--string.format("%.2f", numb) - урезать нули !!!!!!!!!!!!!!!!!!!!!!!!!!!!!


function KillMFutureOrder()
    LogWrite("Find tool data start")

    
    bid=getParamEx(class,ticker, "BID").param_value
    LogWrite("bid = "..bid)

    class=getSecurityInfo("", ticker).class_code
    LogWrite("class = "..class)


    -- transaction = {

    --     ACCOUNT=depo,
    --     ACTION="NEW_ORDER",
    --     TRANS_ID=tostring(tr_id),
    --     CLASSCODE=class,
    --     SECCODE=ticker,
    --     CLIENT_CODE="1016",
    --     TYPE="L",
    --     OPERATION="S", -- тот же что и в таблице позиций
    --     QUANTITY="3", -- то же что и в таблице позиций
    --     PRICE=bid, -- продаем/покупаем по рыночной цене
    --             }

    -- Err_K = sendTransaction(transaction) 

    -- if Err_Order ~= "" then
    --     LogWrite("Ошибка отправки транзакции: "..Err_K)
    -- else
    --     LogWrite("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE DESTRUCTION!!!!!!!!!!!!!!!!!!: "..Err_K)
    -- end
end



function KillMFutureOrders()
    LogWrite("Find tool data start")

    -- local base_contract = getSecurityInfo(class, ticker).base_active_classcode

    --  LogWrite("base_contract = "..base_contract)


    KillAllFutures = {  
        ACCOUNT = depo,
        ACTION = "KILL_ALL_FUTURES_ORDERS",
        TRANS_ID = tostring(tr_id),
        OPERATION = operation_o,
        BASE_CONTRACT = base_contract,
        CLASSCODE = "SPBFUT"  
                     }
    Err_K = sendTransaction(KillAllFutures) 

        if Err_Order ~= "" then
            LogWrite("Ошибка отправки транзакции: "..Err_K)
        else
            LogWrite("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE DESTRUCTION!!!!!!!!!!!!!!!!!!: "..Err_K)
        end

    LogWrite("Find tool data start")
end



function findStep()
    min_step_price = tonumber(getParamEx(class, ticker, "SEC_PRICE_STEP").param_value) -- находим минимальный шаг фьючерса
    LogWrite("min_step_price = "..min_step_price)
    scale = tonumber(getParamEx(class, ticker, "SCALE").param_value) -- находим кол-во знаков после запятой
    LogWrite("scale = "..scale)
end


function findToolDataTable(typeClassCode, tool)
    LogWrite("Find tool data start")
    local toolDataTable = getSecurityInfo(typeClassCode, tool)

    LogWrite("code = "..toolDataTable.code)
    LogWrite("name = "..toolDataTable.name)
    LogWrite("short_name = "..toolDataTable.short_name)
    LogWrite("class_code = "..toolDataTable.class_code)
    LogWrite("class_name = "..toolDataTable.class_name)
    LogWrite("face_value = "..toolDataTable.face_value)
    LogWrite("face_unit = "..toolDataTable.face_unit)
    LogWrite("scale = "..toolDataTable.scale)
    LogWrite("mat_date = "..toolDataTable.mat_date)
    LogWrite("lot_size = "..toolDataTable.lot_size)
    LogWrite("isin_code = "..toolDataTable.isin_code)
    LogWrite("min_price_step = "..toolDataTable.min_price_step)

    LogWrite("Find tool data finish")
     
end

-- Find tool method start
-- code = SBER
-- name = Sberbank Rossii PAO ao
-- short_name = Sberbank
-- class_code = QJSIM
-- class_name = Shares 1-go level (emulyator)
-- face_value = 3.0
-- face_unit = SUR
-- scale = 2
-- mat_date = 0
-- lot_size = 10
-- isin_code = RU0009029540
-- min_price_step = 0.01
-- Find tool method finish

InstrumentTypesFile = getScriptPath().."\\".."instrument type.txt"


function countCurrentFirms()
    LogWrite("Count firms start")
    local totalnet = 0

    firmsCount = getNumberOf("firms")

    LogWrite("\nfirmsCount = "..firmsCount)

	for i = 0, firmsCount, 1 do
		
		firms = getItem("firms", i)
        LogWrite("firmid = "..firms.firmid)
        LogWrite("firm_name = "..firms.firm_name)
        LogWrite("status = "..firms.status)
        LogWrite("exchange = "..firms.exchange)
		
	end
     
end



function countCurrentClasses()
    LogWrite("Count classes start")
    local totalnet = 0

    classesCount = getNumberOf("classes")

    LogWrite("\nclassesCount = "..classesCount)

	for i = 0, classesCount, 1 do
		
		firms = getItem("classes", i)
        LogWrite("name = "..firms.name)
        LogWrite("code = "..firms.code)
        LogWrite("npars = "..firms.npars)
        LogWrite("nsecs = "..firms.nsecs)
		
	end
     
end



-- function OnTransReply(trn)
-- 	message(string.rep("-",25))
-- 	message(title1.." trn_id="..tostring(trn.trans_id).." / status="..trn.status.." / order_num="..trn.order_num)
-- 	message(title1.." price="..trn.price.." / quantity="..trn.quantity.." / brokerref="..trn.brokerref)
-- 	message(title1.." result_msg="..trn.result_msg)
-- 	time2 = os.clock()
-- 	message(title1.." âðåìÿ îòêëèêà "..(time2-time1).." ñåê.")
-- end


function OnTransReply(trn)

    oper_status= trn.status
    LogWrite(trn.status)
    if oper_status ~= 3 then
        LogWrite("slp swt...")
        waitTrans(trn, oper_status)
    else
        LogWrite("threeeeeeeeeeeeeeeeeeeeeee")
    end
    
end

function waitTrans(table, status)

    while status ~= 3 do
        message("Sleeeeeep sweeeeeeeeeeeeeeeeeet...")
        LogWrite("Sleeeeeep sweeeeeeeeeeeeeeeeeet...")
        sleep(1000)
        checkFondsPriceDeviationAndRem()
        status = table.status
    end 

end


--УДАЛЕНИЕ ПОЗИЦИЙ И ФЬЮЧЕРСОВ



function checkFuturePriceDeviationAndRem()
    LogWrite("Check price deviation start")

    tablesItemsCount = getNumberOf("futures_client_holding")

    LogWrite("\ntablesItemsCount = "..tablesItemsCount)

	for i = 0, tablesItemsCount, 1 do
		
		futures = getItem("futures_client_holding", i)

		if futures ~= nil and futures.sec_code == ticker and math.abs(futures.totalnet) > 1 then 
            LogWrite("Count positions for instrument "..ticker.." found!")

            curPosSign = futures.totalnet

            totalnet = math.abs(curPosSign)

            avrposnprice = futures.avrposnprice

            bid=math.ceil(getParamEx(class, ticker, "BID").param_value)

            offer=math.ceil(getParamEx(class, ticker, "OFFER").param_value)

            operation_o = curPosSign > 0 and "S" or "B"

            LogWrite("Sign position = "..curPosSign.."Count futures current positions = "..totalnet.." avrposnprice = "..avrposnprice.."bid = "..bid.." offer = "..offer.." operation_o = "..operation_o)

            if totalnet >= 1 and curPosSign > 0 and operation_o == "S" then --and wa_position_price * alarmRatio <= bid then) then
                LogWrite("bid = "..bid)
                OrdersLimit(bid, totalnet, operation_o)
            elseif totalnet >= 1 and curPosSign < 0 and operation_o == "B" then --and wa_position_price * alarmRatio >= bid then
                LogWrite("offer = "..offer)
                OrdersLimit(offer, totalnet, operation_o)
            end

		end
		
	end
     
    LogWrite("Check price deviation ended")
end



-- function checkFuturePriceDeviationAndRem()
--     LogWrite("Check future price deviation start")

--     tablesItemsCount = getNumberOf("futures_client_holding")

-- 	for i = 0, tablesItemsCount, 1 do
		
-- 		futures = getItem("futures_client_holding", i)

-- 		if futures ~= nil and futures.sec_code == ticker and math.abs(futures.totalnet) > 10 then  
--             LogWrite("Count positions for instrument "..ticker.."  found and more than 10!")

--             local curPosSign = futures.totalnet

--             local totalnet = math.abs(curPosSign)

--             local avrposnprice = futures.avrposnprice

--             local bid=tonumber(math.ceil(getParamEx(class, ticker, "BID").param_value))

--             local offer=tonumber(math.ceil(getParamEx(class, ticker, "OFFER").param_value))

--             operation_o = curPosSign > 0 and "S" or "B"
--             LogWrite("Sign position = "..curPosSign.." Count future current positions = "..totalnet.." avrposnprice = "..avrposnprice.." bid = "..bid.." offer = "..offer.." operation_o = "..operation_o)

--             LogWrite("for S = "..(bid - avrposnprice).." > "..(bid * 0.05))
--             LogWrite("for B = "..(avrposnprice - offer).." > "..(offer * 0.05))
--             if operation_o == "S" then--and (bid - avrposnprice > (bid * 0.05)) then
--                 LogWrite("bid = "..bid)
--                 OrdersLimit(bid, totalnet, operation_o)
--             elseif operation_o == "B" then --and (avrposnprice - offer > (offer * 0.05)) then
--                 LogWrite("offer = "..offer)
--                 OrdersLimit(offer, totalnet, operation_o)
--             end
-- 		end	
-- 	end
     
--     LogWrite("Check future price deviation finish")
-- end



-- function checkFondsPriceDeviationAndRem()
--     LogWrite("Check price deviation start")
--     local totalnet = 0
--     local currentPosition = 0
--     local avrposnprice = 0
--     local balanceCost = 0
--     local operation_o = ""


--     depo_limits = getNumberOf("depo_limits")
--     LogWrite(" depo_limits = "..depo_limits)
    
    
    
--     -- LogWrite("\n")
--     -- for i = 0, depo_limits, 1 do
            
--     --     acc = getItem("depo_limits", i)
    
    
--     --     LogWrite(getParamEx(class, acc.sec_code, "BID").param_value)
--     --     LogWrite(getParamEx(class, acc.sec_code, "OFFER").param_value)
--     --     LogWrite("currentbal = "..acc.currentbal)
--     --     LogWrite("wa_position_price = "..acc.wa_position_price)
    
--     --     LogWrite("\n")
--     -- end

--     LogWrite(getItem("depo_limits", 0).sec_code)


-- 	for i = 0, depo_limits, 1 do
--         LogWrite(" go  i= "..i)
		
-- 		fonds = getItem("depo_limits", i)

--         -- LogWrite(" fonds = "..fonds ~= nil)

-- 		if fonds ~= nil and fonds.sec_code == ticker then 
--             LogWrite("Count positions for instrument "..ticker.." found!")

--             currentPos = fonds.currentbal
--             LogWrite("Sign position = "..currentPos)

--             currentbal = math.abs(currentPos)
--             LogWrite("Count active current positions fonds = "..currentPos)

--             wa_position_price = fonds.wa_position_price
--             LogWrite("wa_position_price = "..wa_position_price)

--             bid=tonumber(getParamEx(class, ticker, "BID").param_value)
--             LogWrite("bid = "..bid)

--             offer=tonumber(getParamEx(class, ticker, "OFFER").param_value)
--             LogWrite("offer = "..offer)

--             operation_o = currentPos > 0 and "S" or "B"
--             LogWrite("operation_o = "..operation_o)

--             LogWrite("for S = "..(bid - wa_position_price).." > "..(bid * 0.05))
--             LogWrite("for B = "..(wa_position_price - offer).." > "..(offer * 0.05))
--             if currentbal >= 1 and currentPos > 0 and operation_o == "S" then --and (bid - wa_position_price > (bid * 0.05)) then
--                 LogWrite("bid = "..bid)
--                 OrdersLimit(bid, currentbal, operation_o)
--             elseif currentbal >= 1 and currentPos < 0 and operation_o == "B" then --and (wa_position_price - offer > (offer * 0.05)) then
--                 LogWrite("offer = "..offer)
--                 OrdersLimit(offer, currentbal, operation_o)
--             end

-- 		end
		
-- 	end
     
--     LogWrite("Check price deviation ended")
-- end






function checkFondsPriceDeviationAndRem()
    LogWrite("Check fond price deviation start")

    depo_limits = getNumberOf("depo_limits")
    
	for i = 0, depo_limits, 1 do
		
		fonds = getItem("depo_limits", i)

		if fonds ~= nil and fonds.sec_code == ticker and math.abs(fonds.currentbal) > 1 then 
            LogWrite("Count positions for instrument "..ticker.." found and more than 10!")

            local curPosSign = fonds.currentbal

            local currentbal = math.abs(curPosSign)

            local wa_position_price = fonds.wa_position_price

            local bid=tonumber(getParamEx(class, ticker, "BID").param_value)

            local offer=tonumber(getParamEx(class, ticker, "OFFER").param_value)

            operation_o = curPosSign > 0 and "S" or "B"
            
            LogWrite("Sign position = "..curPosSign.."Count fonds current positions = "..currentbal.." wa_position_price = "..wa_position_price.."bid = "..bid.." offer = "..offer.." operation_o = "..operation_o)

            LogWrite("for S = "..(bid - wa_position_price).." > "..(bid * 0.05))
            LogWrite("for B = "..(wa_position_price - offer).." > "..(offer * 0.05))
            if operation_o == "S" then --and wa_position_price * alarmRatio <= bid then
                LogWrite("bid = "..bid)
                OrdersLimit(bid, currentbal, operation_o)
            elseif operation_o == "B" then --and wa_position_price * alarmRatio <= bid then
                LogWrite("offer = "..offer)
                OrdersLimit(offer, currentbal, operation_o)
            end
		end
	end
     
    LogWrite("Check fond price deviation finish")
end








function findCurPosFutures(ticker)
    LogWrite("Count active current positions start")
    local totalnet = 0

    tablesItemsCount = getNumberOf("futures_client_holding")

    LogWrite("\ntablesItemsCount = "..tablesItemsCount)

	for i = 0, tablesItemsCount, 1 do
		
		futures = getItem("futures_client_holding", i)
        -- LogWrite("firmid"..futures.firmid)
        -- LogWrite("trdaccid"..futures.trdaccid)
        -- LogWrite("sec_code"..futures.sec_code)
        -- LogWrite("type"..futures.type)
        -- LogWrite("startbuy"..futures.startbuy)
        -- LogWrite("startsell"..futures.startsell)
        -- LogWrite("startnet"..futures.startnet)
        -- -- LogWrite("todaybuy"..futures.todaybuy)
        -- -- LogWrite("todaysell"..future.todaysell)
        -- LogWrite("totalnet"..futures.totalnet)
        -- LogWrite("openbuys"..futures.openbuys)
        -- LogWrite("opensells"..futures.opensells)
        -- LogWrite("cbplused"..futures.cbplused)
        -- LogWrite("cbplplanned"..futures.cbplplanned)
        -- LogWrite("varmargin"..futures.varmargin)
        -- LogWrite("avrposnprice"..futures.avrposnprice)
        -- LogWrite("positionvalue"..futures.positionvalue)
        -- LogWrite("real_varmargin"..futures.real_varmargin)
        -- LogWrite("total_varmargin"..futures.total_varmargin)
        -- LogWrite("futures.sec_code = "..futures.sec_code.." and actual is "..ticker)

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















-- function countAllBuyOrders()
--     LogWrite("Count active buy orders")
--     num_orders = getNumberOf("orders")

--     scan_max_limit = 100
--     scan_limit = 0
--     if num_orders > 100 then
--         scan_limit = num_orders - scan_max_limit   
--     end
    
-- 	num_active_buy_order = 0

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










--УДАЕНИЕ ПОСЛЕДНЕГО ОРДЕРА (РАБОТАЕТ)


-- LogFile = getScriptPath().."\\".."bot_log.txt"

-- function LogWrite(str)--логгирование
--     if not lf then
--        lf = io.open(LogFile, "a")
--     end

--       lf:write(tostring(str).."\n")    

--     lf:flush()
-- end
-- -- depo = NL0011100043 operation_o = B ticker = BANE class = QJSIM price_o = 3376.5 quant_o = 1 tr_id = 2503931 CLIENT_CODE = BANE-25
-- client_code = "1016"

-- -- tr_id=2503931
-- tr_id = 0

-- last_order = getNumberOf("orders") - 1

-- class = "QJSIM"

-- ticker = "BANE"

-- depo = "NL0011100043"

-- num_r = 25

-- function trasactiondelete(number_order)

-- deleteorder  = 
-- 	{
-- 	["TRANS_ID"]			= tostring(tr_id), 
-- 	["ACTION"]				= "KILL_ORDER", 			 
-- 	["CLASSCODE"]			= class ,				 
-- 	["SECCODE"]				= ticker,				 			 
-- 	["ACCOUNT"]				= depo,				
-- 	["ORDER_KEY"] 			= tostring(number_order)		
-- 	}
	
-- end


-- function OrdersLimit(price_o, quant_o, operation_o) -- цена, количество и направление заявки
--     --случ число для номера заявки бота 
--     if tr_id == 0 then--id траназакции
--         tr_id = "250"..math.floor(os.clock()) % 100000 -- формир псевдослуч числа, id_t - последнее число сегодняшней даты для отлич дня сделок (тут не использ), num_r - номер робота
--     else
--         tr_id = tr_id + 1    --номер транзак заявки
--     end
    
--     LogWrite("tr_id = "..tr_id)

--             local LimitOrder = {
--                                     ["ACTION"] = "NEW_ORDER",
--                                     ["account"] = depo,--счет
--                                     ["OPERATION"] = operation_o,--вид операции
--                                     ["CLASSCODE"] = class,--класс инструмента
--                                     ["SECCODE"] = ticker,--тикер инструмента
--                                     ["PRICE"] = tostring(price_o),--цена
--                                     ["QUANTITY"] = tostring(quant_o), --количество
--                                     ["TRANS_ID"] = tostring(tr_id),--id транзакции
--                                     ["TYPE"] = "L",--лимитная заявка
--                                     ["EXPIRY_DATE"] = "GTC",
--                                     ["CLIENT_CODE"] = tostring(ticker.."-"..num_r),--комментарий
--                                 }
--             Err_Order = sendTransaction(LimitOrder)

--             if Err_Order ~= "" then
--                 LogWrite("Ошибка отправки транзакции: "..Err_Order, "depo = "..depo.."operation_o = "..operation_o.."ticker = "..ticker.."class = "..class.."price_o = "..price_o.."quant_o = "..quant_o.."tr_id = "..tr_id.."CLIENT_CODE = "..ticker.."-"..num_r)
--             else
--                 LogWrite("Транзакция отправлена: ".."depo = "..depo.."operation_o = "..operation_o.."ticker = "..ticker.."class = "..class.."price_o = "..price_o.."quant_o = "..quant_o.."tr_id = "..tr_id.."CLIENT_CODE = "..ticker.."-"..num_r)
--             end
    

-- end



-- function KillLastOrder()
--     LogWrite("Удаляем заявку "..tr_id)
--     tran_id = tostring(math.floor(1000*os.clock()))
--     message(tran_id)
--     order = getItem("orders", last_order).order_num
--     message(order)
--         LogWrite(order)

--     local killAllOrder = {
--                     ["ACTION"]="KILL_ORDER",
--                     ["CLASSCODE"]=class,
--                     ["SECCODE"]=ticker,
--                     ["ORDER_KEY"]=tostring(math.ceil(order)),
--                     ["ACCOUNT"]= depo,		
--                     ["TRANS_ID"]=tran_id,
--                          }
--     local res = sendTransaction(killAllOrder)
--     if res ~= "" then
--         LogWrite("Error while sending order removing transaction: "..res) 
--     else 
--         LogWrite("Order removing transaction sent")
--     end

-- end



-- function main()
--     OrdersLimit(3380.5, 1, "S")
--     sleep(5000)
--     KillLastOrder()
-- end










-- УДАЛЕНИЕ АКТИВНОЙ ЗАЯВКИ (работает)

-- function deleteOrders()
    
-- 	num_orders = getNumberOf("orders")
-- 	message(" Start: num_orders = "..num_orders)
-- 	for i = num_orders - 1, 0, -1 do
--         message(" In loop: num_orders = "..num_orders)
--         LogWrite(" In loop: num_orders = "..num_orders)

-- 		myorder = getItem("orders", i)
-- 		message(myorder["client_code"])
--         LogWrite(myorder["client_code"])

--         -- message(myorder["sec_code"])
--         -- LogWrite(myorder["sec_code"])

-- 		if myorder["client_code"]==client_code and myorder["sec_code"]==ticker then
--             message(" client_code == sec_code")
-- 			if bit.band(tonumber(myorder["flags"]),1) > 0 then
			
-- 				message(" Order num: "..myorder.order_num)
--                 LogWrite(" Order num: "..myorder.order_num)
					
-- 					trasactiondelete(myorder.order_num)
-- 					error_transaction = sendTransaction(deleteorder)
-- 					sleep(300)
					
-- 					if error_transaction ~= "" then
-- 						message(" : error ="..error_transaction, 3)
--                         LogWrite(" : error ="..error_transaction)
-- 					else
-- 						message(" : it's ok "..myorder["order_num"].." on:"..myorder["price"].." pr: "..myorder["balance"].." bal:"..myorder["brokerref"], 2)
--                         LogWrite(" : it's ok "..myorder["order_num"].." on:"..myorder["price"].." pr: "..myorder["balance"].." bal:"..myorder["brokerref"])
-- 					end
				
-- 				-- break --выход из цикла после удаления заявки

-- 			end
	
-- 		end
	
-- 	end

-- end



-- function main()
--     deleteOrder()
-- end
