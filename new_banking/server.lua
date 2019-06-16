--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)
    if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', tonumber(amount))
    end
end)

RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    amount = tonumber(amount)
    base = xPlayer.getAccount('bank').money
    if amount == nil or amount <= 0 or amount > base then
        TriggerClientEvent('chatMessage', _source, _U('invalid_amount'))
    else
        xPlayer.removeAccountMoney('bank', amount)
        xPlayer.addMoney(amount)
    end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    TriggerClientEvent('currentbalance1', _source, balance)

end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)

    -- Thanks to (LuCampbell)
	TriggerEvent('es:getPlayerFromId', xPlayer, function(user) 
        if zPlayer ~= nil then
            if (tonumber(user.money) >= tonumber(amountt)) then
                local player = user.identifier
                user:removeMoney((amountt))

                TriggerEvent('es:getPlayerFromId', zPlayer, function(user2)
                    local player2 = user2.identifier
                    user2:addMoney((amountt))
                    TriggerClientEvent("chatMessage", zPlayer, _U('recieved1'), {52, 201, 36}, _U('recieved2') .. amountt .. _U('recieved3'))
                    TriggerClientEvent("chatMessage", xPlayer, _U('removed1'), {255, 0, 0}, _U('removed2') .. amountt .. _U('removed3'))
                end)
            else
                if (tonumber(user.money) < tonumber(amountt)) then

                    TriggerClientEvent("chatMessage", player, "", {255, 0, 0}, _U('no_money'))
                end
            end
        end
    end)
end)

