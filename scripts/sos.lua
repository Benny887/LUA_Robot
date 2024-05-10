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


ticker = "EuM4"

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


--     securities = getNumberOf("securities")
-- LogWrite(" securities = "..securities)
-- trade_accounts = getNumberOf("trade_accounts")
-- LogWrite(" trade_accounts = "..trade_accounts)
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

message(countCurrentPositions(ticker))


end



InstrumentTypesFile = getScriptPath().."\\".."instrument type.txt"


function countCurrentPositions(ticker)
    LogWrite("Count active current positions")
    local totalnet = 0

    if getParamFromFile(ticker, InstrumentTypesFile) == "futures" then
        totalnet = getItem("futures_client_holding", 0).totalnet
    end
    
    LogWrite("Count active current positions = "..totalnet)
    return math.abs(totalnet)
end







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
