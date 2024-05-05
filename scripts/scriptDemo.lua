-- message('hello')

-- stopped = false
-- function OnStop()
--     stopped = true 
--     return 5000
-- end

-- function main ()


-- end




-- x = getItem('futures_client_limits', 0)


-- num = x.cbplimit
-- num = num - 10000
-- message(''..num)



-- local n = getNumberOf("rm_holdings")
-- message(''..n)

-- for i=0,n-1 do
--     message(''..n)
--     order = getItem("rm_holdings", i)
--     message(''..order.sec_code)
-- end

-- local function main()
-- 	local n = getNumberOf("securities")
-- 	local order={}
-- 	-- message("total ".. tostring(n) .. " of all orders", 1)
-- 	for i=0,n-1 do
-- 		order = getItem("securities", i)
-- 		-- message("securities: num=" .. tostring(order["order_num"]) .. " qty=" .. tostring(order["qty"]) .. " value=" .. tostring(order["value"]), 1)
--         if order.name == 'SRM4' then
--             message(order.name)
--             message("yeeeeaaaaaa")
--             break
--         end
-- 	end
-- end

-- main()



-- for key, value in pairs(x) do
--     print(key, " -- ", value)
-- end
-- message(x)



-- TRUE structure
Is_Run = true

function OnInit() -- вызывается один раз при запуске робота
    message("Робот запущен")
end

function main()--чтоб не занимать основной поток quik и выполнял код в основном потоке
    while (Is_Run == true) do
        --message(os.date())
        --sleep(1000)
    end
end

function OnTrade()--дает обратный вызов при совершении сделк ив quik
    message("Совершил сделку")
end

function OnStop()--остановить робота
    message("Робот остановлен")
end