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
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	
	--Thanks to (LuCampbell)
	TriggerEvent('es:getPlayerFromId', xPlayer, function(user)
		if (tonumber(user.money) >= tonumber(amountt)) then
			local player = user.identifier
			user:removeMoney((amountt))	
		
			TriggerEvent('es:getPlayerFromId', zPlayer, function(user2)
				local player2 = user2.identifier
				user2:addMoney((amountt))
				TriggerClientEvent("chatMessage", zPlayer , "You received money ", { 52, 201, 36 }, "You received the sum of "..amountt.." dollars")
				TriggerClientEvent("chatMessage", xPlayer, "Payment receipt ", { 255, 0, 0 }, "Your payment of "..amountt.." dollars is done")
			end)	
		else
			if (tonumber(user.money) < tonumber(amountt)) then
			
				TriggerClientEvent("chatMessage", player, "", { 255, 0, 0 }, "You do not have enough money")
			end
		end
	end) 
end)





