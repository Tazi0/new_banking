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
	local zPlayer = ESX.GetPlayerFromId(tonumber(to))
	local balance = 0
	balance = xPlayer.getAccount('bank').money
	zbalance = zPlayer.getAccount('bank').money

	if tonumber(_source) == tonumber(to) then
		TriggerClientEvent('chatMessage', _source, "You cannot transfer to your self")
	else
		if balance < 1 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
			TriggerClientEvent('chatMessage', _source, "You don't have enough money in the bank.")
		else
			xPlayer.removeAccountMoney('bank', tonumber(amountt))
			zPlayer.addAccountMoney('bank', tonumber(amountt))
		end

	end
end)

-- version checker
local CurrentVersion = '1.1'
local GithubResourceName = 'new_banking'
local githubacct = "Tazi0"
local resourceName = GetCurrentResourceName()
local versionurl = "https://raw.githubusercontent.com/"..githubacct.."/"..GithubResourceName.."/master/VERSION"
local changesurl = "https://raw.githubusercontent.com/"..githubacct.."/"..GithubResourceName.."/master/CHANGES"

PerformHttpRequest(versionurl, function(Error, NewestVersion, Header)
	PerformHttpRequest(changesurl, function(Error, Changes, Header)
		print('\n')
		print('====================================================================')
		print('')
		print('New Banking ('..resourceName..')')
		print('')
		print('Current Version: ' .. CurrentVersion)
		print('Newest Version: ' .. NewestVersion)
		print('you can download the newest version at: \n https://github.com/'..githubacct.."/"..GithubResourceName.."/")
		io.write("")
		print('Changelog: \n' .. Changes)
		print('')
		if CurrentVersion ~= NewestVersion then
			print('====================================================================')
		else
			print('===================')
			print('=== Up to date! ===')
			print('===================')
		end
		print('\n')
end)
end)
