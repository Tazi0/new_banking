--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('chatMessage', _source, "Invalid Amount")
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
		TriggerClientEvent('chatMessage', _source, "Invalid Amount")
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
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(tonumber(to))
	local balance = sourceXPlayer.getAccount('bank').money
	
	if _source == tonumber(to) then
                -- advanced notification with bank icon
		TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer', 'You cannot send money to yourself!', 'CHAR_BANK_MAZE', 9)
	else
		if balance < 1 or balance < tonumber(amountt) or tonumber(amountt) < 1 then
                        -- advanced notification with bank icon
			TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer', 'You have not enough money to send!', 'CHAR_BANK_MAZE', 9)
		else
			sourceXPlayer.removeAccountMoney('bank', tonumber(amountt))
			targetXPlayer.addAccountMoney('bank', tonumber(amountt))
                        -- advanced notification with bank icon
				TriggerClientEvent('esx:showAdvancedNotification', _source, 'Bank', 'Transfer', 'Sended ~r~$' .. amountt .. '~s~ do ~r~' .. to .. ' .', 'CHAR_BANK_MAZE', 9)
				TriggerClientEvent('esx:showAdvancedNotification', to, 'Bank', 'Transfer', 'Sended to you ~r~$' .. amountt .. '~s~ od ~r~' .. _source .. ' .', 'CHAR_BANK_MAZE', 9)
		end
	end
end)




