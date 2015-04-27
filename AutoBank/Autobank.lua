-----------------------------------
--    Auto Bank Version 0.0.1    --
-----------------------------------

local _prefix ="[Autobank]: "
local _carryMoney = 1000
local _settings = { enabled = true, carryMoney = 1000 }

local function DepositMoney(carryMoney)
	local money = GetCurrentMoney()
	
	local diff = money - carryMoney
	
	if diff > 0 then
		DepositMoneyIntoBank(diff)
	end
	
end

local function DepositItems()
 -- placeholder
end

local function Autobank_Open_Bank(eventCode)
	DepositMoney(_settings.carryMoney)
	DepositItems()
end

local function isOnString(str)
	str = string.lower(str)
	return str == "+" or str == "on"
end

local function isOffString(str)
	str = string.lower(str)
	return str == "-" or str == "off"
end

local function Initialise()

	EVENT_MANAGER:RegisterForEvent("Autobank_Open_Bank",EVENT_OPEN_BANK,Autobank_Open_Bank)

	SLASH_COMMANDS["/ab"] = function(arg)
		
		if isOnString(arg) then
			_settings.enabled = true
			d(_prefix.."Enabled")
		elseif isOffString(arg) then
			_settings.enabled = false
			d(_prefix.."Disabled")
		elseif arg ~= nil and arg ~= "" then
		
			local num = tonumber(arg)
			d(num)
			if num ~= nil then
				_settings.carryMoney = num
				d(_prefix.."Carry gold set to "..tostring(num))
			end
		
		end
	end
	
end

local function Autobank_Loaded(eventCode, addOnName)

	if(addOnName ~= "Autobank") then
        return
    end
	
	_settings = ZO_SavedVars:New("Autobank_SavedVariables", "1", "", _settings, nil)
	
	Initialise()
	
end

EVENT_MANAGER:RegisterForEvent("Autobank_Loaded", EVENT_ADD_ON_LOADED, Autobank_Loaded)