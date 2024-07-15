local ConfigManager = {}

local PROPERTIES = {
	CURRENT_SPREAD = 'current_spread',
    TICKER = 'ticker',--тикер инструмента
    MIN_STEP_PRICE = 'min_step_price', -- минимальный шаг фьючерса
    SPRREAD_LIMIT = 'spread_limit',--текущий спред
    ORIENT_TRADE = 'orient_trade',--направление торговли: -1 -sell, 0- sell+buy, 1- buy
    STOP_ON = 'stop_on',-- если один то стоп при 0
    START_BOT = 'start_bot', --0 - бот не работает, 1 - бот работает
    IS_RUN = 'is_run', --переменная для вечного цикла
    TOOL_SCALE = 'toolScale',
    PAUSE_T = 'pause_t', --пауза в торгах
    TRADERS_PRICE = 'traders_price', --цена последней сделки
    LAST_SDELKA = 'last_sdelka', -- 1 -тейк -1 - шаг
    LAST_RAND = 'last_rand', --послед сгенер число
    RAND = 'rand', -- след сгенерир число
    NUM_R = 'num_r', --номер робота
    ID_T = 'id_t', -- посл цифра от сегод дня
    ID_BOTA = 'id_bota', --id бота на сегодня 
    TR_ID = 'tr_id',
    BUY_ORDER_ID = 'BuyOrder_ID', -- id транзакции покупки
    SELL_ORDER_ID = 'SellOrder_ID', -- id транзакции продажи
    BUY_ORDER_NUM = 'BuyOrder_num', -- номер заявки покупной
    SELL_ORDER_NUM = 'SellOrder_num', -- номер заявки продажной
    LAST_OPERATION = 'last_operation',
    NUM_ACTIVE_SELL_ORDER = 'num_active_sell_order',
    NUM_ACTIVE_BUY_ORDER = 'num_active_buy_order',
    BUY_APP_NUMBER_TO_REMOVE = 'buyAppNumberToRemove',
    SELL_APP_NUMBER_TO_REMOVE = 'sellAppNumberToRemove'
}

local BUNDLE = {}
BUNDLE[PROPERTIES.CURRENT_SPREAD] = 0
BUNDLE[PROPERTIES.TICKER] = ""
BUNDLE[PROPERTIES.MIN_STEP_PRICE] = 0
BUNDLE[PROPERTIES.SPRREAD_LIMIT] = 0
BUNDLE[PROPERTIES.ORIENT_TRADE] = 0
BUNDLE[PROPERTIES.STOP_ON] = 0
BUNDLE[PROPERTIES.START_BOT] = 0
BUNDLE[PROPERTIES.IS_RUN] = true
BUNDLE[PROPERTIES.TOOL_SCALE] = 0
BUNDLE[PROPERTIES.PAUSE_T] = 0
BUNDLE[PROPERTIES.TRADERS_PRICE] = 0
BUNDLE[PROPERTIES.LAST_SDELKA] = 0
BUNDLE[PROPERTIES.LAST_RAND] = 0
BUNDLE[PROPERTIES.RAND] = 0
BUNDLE[PROPERTIES.NUM_R] = 25
BUNDLE[PROPERTIES.ID_T] = 0
BUNDLE[PROPERTIES.ID_BOTA] = 0
BUNDLE[PROPERTIES.TR_ID] = 0
BUNDLE[PROPERTIES.BUY_ORDER_ID] = 0
BUNDLE[PROPERTIES.SELL_ORDER_ID] = 0
BUNDLE[PROPERTIES.BUY_ORDER_NUM] = 0
BUNDLE[PROPERTIES.SELL_ORDER_NUM] = 0
BUNDLE[PROPERTIES.LAST_OPERATION] = ""
BUNDLE[PROPERTIES.NUM_ACTIVE_SELL_ORDER] = 0
BUNDLE[PROPERTIES.NUM_ACTIVE_BUY_ORDER] = 0
BUNDLE[PROPERTIES.BUY_APP_NUMBER_TO_REMOVE] = 0
BUNDLE[PROPERTIES.SELL_APP_NUMBER_TO_REMOVE] = 0

-- print(PROPERTIES.IS_RUN)
-- print(BUNDLE[PROPERTIES.IS_RUN])

function ConfigManager.loadConfigFromFile(configFilePath)
	local file_with_initial_data = io.open(configFilePath, "r")
    if file_with_initial_data then --если файл существует
    	local ticker
        Comment, ticker = file_with_initial_data:read(16, "l")
        ticker = string.gsub(ticker, "%s+", "")
        BUNDLE[PROPERTIES.TICKER] = ticker
        Log("ticker = "..BUNDLE[PROPERTIES.TICKER])
        
        local spread_limit
        Comment, spread_limit = file_with_initial_data:read(16, "l")
        spread_limit = string.gsub(spread_limit, "%s+", "")
        spread_limit = tonumber(spread_limit)
        
        Log("spread_limit = "..spread_limit)

        Comment, orient_trade = file_with_initial_data:read(16, "l")
        orient_trade = string.gsub(orient_trade, "%s+", "")
        orient_trade = tonumber(orient_trade)
        Log("orient_trade = "..orient_trade)

        file_with_initial_data:close()
    else
        --  сохран тек данн в файл   
     SaveCurrentConfigState()
    end
end

function ConfigManager.updateProperty(propertyName)

end

function ConfigManager.updateProperties(properties)

end

function ConfigManager.reconfigureBot()

end

return ConfigManager