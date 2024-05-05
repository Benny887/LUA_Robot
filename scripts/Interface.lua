name_bot = "Net bot"--имя робота
version = "1.0"--версия
ticker = "EDH4"--тикер инструмента
class = "SPBFUT"--класс инструмента
Name = "Robot"--заголовок таблицы


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
    Color("Yellow", t_id, 2, 2); Color("Yellow", t_id, 2, 3)

    --3я строка
    SetCell(t_id, 3, 1, tostring("Position")); Color("Gray", t_id, 3, 1)
    Color("Gray", t_id, 3, 2)
    SetCell(t_id, 3, 3, tostring("- ")); Color("Gray", t_id, 3, 3)

    --4я строка
    SetCell(t_id, 4, 1, tostring("Direction")); Color("Gray", t_id, 4, 1)
    SetCell(t_id, 4, 2, tostring("Buy-Sell")); Color("Cyan", t_id, 4, 2)
    SetCell(t_id, 4, 3, tostring("- ")); Color("Gray", t_id, 4, 3)

    --5я строка
    SetCell(t_id, 5, 1, tostring("Lot size")); Color("Blue", t_id, 5, 1)
    Color("Blue", t_id, 5, 2)
    SetCell(t_id, 5, 3, tostring("- ")); Color("Blue", t_id, 5, 3)

    --6я строка
    SetCell(t_id, 6, 1, tostring("Max of lots")); Color("Blue", t_id, 6, 1)
    Color("Blue", t_id, 6, 2)
    SetCell(t_id, 6, 3, tostring("- ")); Color("Blue", t_id, 6, 3)

    --7я строка
    SetCell(t_id, 7, 1, tostring("Step")); Color("Orange", t_id, 7, 1)
    Color("Orange", t_id, 7, 2)
    SetCell(t_id, 7, 3, tostring("- ")); Color("Orange", t_id, 7, 3)

    --8я строка
    SetCell(t_id, 8, 1, tostring("Take")); Color("Orange", t_id, 8, 1)
    Color("Orange", t_id, 8, 2)
    SetCell(t_id, 8, 3, tostring("- ")); Color("Orange", t_id, 8, 3)

    --9я строка
    SetCell(t_id, 9, 1, tostring("00:00:00")); Color("Yellow", t_id, 9, 1)
    SetCell(t_id, 9, 2, tostring("x Stop when 0")); Color("Blue", t_id, 9, 2)
    Color("Blue", t_id, 9, 3)
end

function main()
    CreateTable()
end
