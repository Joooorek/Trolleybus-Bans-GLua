# Trolleybus-Bans-GLua

Проект, нацеленный на создание условий, при которых игроки могли комфортно играть на троллейбусных серверах

## Быстрое принятие решений
Блокировка вступает в силу как только жалоба на нарушителя была рассмотрена и одобрена. После этого нарушитель не сможет зайти на сервер, подключенный к этой системе.


## Сплочённость
Система позволяет создать группу серверов, на которых игрокам будет комфортно и атмосферно играть, не задумываясь о том, что на сервере могут играть неадекватные игроки.


## Лёгкое подключение
Мы подготовили ряд способов, позволяющих подключиться Ваш проект этой системе. Это делается в пару кликов.


# Варианты подключения сервера к глобальному банлисту

## Добавление аддона
Вы добавляете <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=2959588161" target="_blank">наш аддон</a> в коллекцию вашего сервера. После этого пользователи из нашего бан листа не смогут подключиться на ваш сервер.

## Загрузка аддона с Github
Вы можете загрузить наш аддон с Github и модифицировать его как вам угодно. Аддон необходимо закинуть в папку "addons" вашего сервера.

## Использование API
Забирайте <a href="https://trolleybussystem.ru/bans/json" target="_blank">полную таблицу банов</a> в формате JSON или отправляйте проверочный запрос на адрес <b>https://trolleybussystem.ru/api/check/{steamid}</b> (обязательно кешируйте ответы). <br>
Ответ имеет следующий формат:
```
{
"result": (bool),
"reason": (string)
}
```
