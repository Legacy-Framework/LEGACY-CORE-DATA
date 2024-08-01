---@diagnostic disable: undefined-field, missing-parameter
--[[ EXPORT GENERAL MODULE ]]
local Legacy = exports.LEGACYCORE:GetCoreData() or nil
-- local Legacy = exports['LEGACYCORE']:GetCoreData() or nil

--[[ PLAYER LOGOUT EVENT ]]
-- This event is triggered when the player logs out. It can be used to manage actions to be performed when the player disconnects or uses a logout command, such as /relog.
AddEventHandler('LegacyCore:PlayerLogout', function()
    print('The player has logged out.')
    -- Add code here to handle player logout
end)

--[[ PLAYER LOADED EVENT ]]
-- This event is triggered when the player is fully loaded. It can be used to perform initial actions when the player enters the game and their character is ready.
--- @param slot number - The slot used for the player's character.
--- @param playerdata table - The player's data.
--- @param newPlayer boolean - If character is new.
AddEventHandler('LegacyCore:PlayerLoaded', function(slot, playerdata,newPlayer)
    print(string.format('Player Loaded With Slot Used %s', slot))
    print('Player Data:', json.encode(playerdata, { indent = true, sort_keys = true }))
end)

--[[ PLAYER PERSONAL DATA ]]

-- Retrieve The Current Player Data
---@return string | table[] | nil
RegisterCommand('clientdata', function()
    -- Retrieve player data using the CLASS [DATA] module
    local playerData = Legacy.DATA:GetPlayerObject()
    -- Retrieve if the player is dead or not
    local is_dead = playerData.is_dead
    -- Retrieve the player's identifier
    local identifier = playerData.identifier
    -- Retrieve the player's character identifier equivalent of Slot
    -- All players use the same license, but each character has a unique slot
    local charIdentifier = playerData.charIdentifier
    -- Retrieve the player's name
    local playerName = playerData.playerName
    -- Retrieve the player's sex
    local sex = playerData.sex
    -- Retrieve the player's date of birth
    local dob = playerData.dob
    -- Retrieve the player's height
    local height = playerData.height
    -- Retrieve the player's accounts
    local accounts = playerData.accounts
    -- Retrieve the player's status
    local status = playerData.status
    -- Retrieve the player's skin
    local skin = playerData.skin
    -- Retrieve the player's last spawn location
    local lastSpawn = playerData.lastSpawn
    -- Retrieve the player's group
    local playerGroup = playerData.playerGroup
    -- Retrieve the player's job name
    local jobName = playerData.JobName
    -- Retrieve the player's job label
    local jobLabel = playerData.JobLabel
    -- Retrieve the player's job grade
    local jobGrade = playerData.JobGrade
end)

--[[ PLAYER LOADED ]]

-- Retrieve the current Character Status Loaded
-- True if Player Is Loaded / False if Player Is In logout (example /relog)
---@return boolean | string
local IsLoaded = Legacy.DATA:IsPlayerLoaded()
print(IsLoaded)

--[[ GETPLAYERMETADATA]]

-- Retrieves a specific piece of metadata for the player. This function allows you to query specific keys from the player's metadata and get their associated values.
-- Parameters:
--- @param key string - The key for which to retrieve the metadata value. The key should match one of the fields in the player's metadata.
--- @return any, string|nil - Returns the value associated with the specified key. If there is an error, returns nil and the error message.

-- Possible Return Values:
-- If Player Data is Not Loaded:
-- Returns nil and the error message 'Player data is not loaded.'
-- If the Key Parameter is Invalid:
-- Returns nil and the assert error message 'Invalid key type. Expected a string.' if the key is not of type string.
-- If the Key is Not Found:
-- Returns nil and the error message 'Key not found in PlayerData: [key]' if the key does not exist in the metadata.
-- If the Key Exists:
-- Returns the value associated with the specified key. If the value is a JSON string, it will be parsed and returned as a Lua table.

-- Example Usage:
---@field promise any  -- the value associated with the specified key
---@field error string -- the specified error message if any

local promise, error = Legacy.DATA:GetPlayerMetadata('accounts')
if promise then
    print("Player accounts:", json.encode(promise))
else
    print("Error retrieving accounts:", error)
end

-- Notes:
-- Ensure that the player data is loaded before attempting to retrieve metadata.
-- The key parameter must be a string and must correspond to a valid field in the player's metadata.

-- Type Annotations:
--- @param key string - The key for which to retrieve the metadata value.
--- @return string, string[] | nil - Returns the value associated with the specified key. If there is an error, returns nil and the error message.

-- MANAGE SERVER AND ACTION USING [MAIN] CLASS
-- (Consult Documentation for other functions: https://legacy-script.gitbook.io/legacy-core/free-release/legacy-core)

--- Retrieves the player's ID
---@return string|nil

RegisterCommand('myid', function()
    local MyID = Legacy.MAIN:GetID()
    print(MyID)
end)

--- Retrieves the player's coordinates
---@return table|nil

RegisterCommand('mycoord', function()
    local MyCoords = Legacy.MAIN:GetPlayerCoords()
    print(MyCoords)
end)

--- Teleports the player to the specified coordinates (0, 0, 0)
---@return void

RegisterCommand('tpm', function()
    Legacy.MAIN:TeleportPlayer(0, 0, 0, 0)
end)

-- [[USE PLAYER CACHE TO GET PLAYER DATA]]

--- Retrieves and prints the player's cache data
---@return table|nil

RegisterCommand('cache', function(src)
    local ID = Legacy.MAIN:GetID()
    local PlayerCache = Legacy.PLAYERCACHE[ID]
    print(json.encode(PlayerCache, { indent = true }))
end)



--[[ LEGACY CACHE SYSTEM ]]
-- The Legacy Data Cache System provides a way to cache and manage data related to the player's vehicle and ped (player character) in a game.
-- This system updates data periodically based on whether the player is in a vehicle or on foot.

-- Available Classes
-- Legacy.CACHE:GetCache(cacheType)
-- This function retrieves cached data based on the type specified.

-- Parameters
--- @param cacheType string - The type of cache to retrieve. Options are 'vehicle' and 'ped'.
--- @return table|nil - Returns a table containing cached data for the specified type, or nil if no data is available.

--[[ Vehicle Cache Fields ]]
-- When the player is in a vehicle, the system caches data about the vehicle. The following fields are available:
-- name: The display name of the vehicle model.
-- entity: The vehicle entity handle.
-- netId: The network ID of the vehicle.
-- model: The model ID of the vehicle.
-- speed: The current speed of the vehicle.
-- plate: The vehicle's license plate text.
-- driver: The ped handle of the driver.
-- isEngineOn: Boolean indicating if the vehicle's engine is running.
-- isLocked: Boolean indicating if the vehicle is locked.
-- coords: The current coordinates of the vehicle.

--[[ Ped Cache Fields ]]
-- When the player is on foot, the system caches data about the player's ped (character). The following fields are available:
-- pedId: The ped entity handle.
-- coords: The current coordinates of the ped.
-- health: The current health of the ped.
-- armor: The current armor of the ped.
-- weapon: boolean indicating if player is armed or not.
-- source: The server ID of the player associated with the ped.


--[[ Example Usage for Vehicle Cache ]]
--- @return table|nil

RegisterCommand('cache', function()
    local vehicleCache = Legacy.CACHE:GetCache('vehicle')
    if vehicleCache then
        print(json.encode(vehicleCache, { indent = true }))
    else
        print("Not in vehicle or no vehicle data available.")
    end
end)

--[[ Example Usage for Ped Cache ]]
--- @return table|nil

RegisterCommand('pedcache', function()
    local pedCache = Legacy.CACHE:GetCache('ped')
    if pedCache then
        print(json.encode(pedCache, { indent = true }))
    else
        print("No ped data available.")
    end
end)


--[[ PLAYER DATA LOCATED IN STATE BAG ]]

-- To retrieve player data on the client side, you can use the state bag mechanism provided by the LocalPlayer object. This allows for efficient and organized access to player data.
-- LocalPlayer.state.GetPlayerObject
-- The LocalPlayer.state.GetPlayerObject function retrieves player data and returns it as a table.
-- This method provides a straightforward way to access the player's data directly.

-- Parameters
-- No parameters are needed for this function.

-- Returns
--- @return table|nil - Returns a table containing the player's data.

-- Example Usage:

RegisterCommand('bag', function()
    local PlayerData = LocalPlayer.state.GetPlayerObject
    print(json.encode(PlayerData, { indent = true }))
end)


--[[ COMMON REPLACE (STATUS SYSTEM) ]]

-- LEGACYCORE:GetPlayerHunger
-- Returns the current value of the player's hunger.

-- Example:
local Hunger = exports.LEGACYCORE:GetPlayerHunger()
print('My Hunger:', Hunger)

-- LEGACYCORE:GetPlayerThirst
-- Returns the current value of the player's thirst.

-- Example:
local Thirst = exports.LEGACYCORE:GetPlayerThirst()
print('My Thirst:', Thirst)

-- LEGACYCORE:SetPlayerHunger
-- Description:
-- Sets the player's hunger level to the specified value.

-- Parameters:
--- @param number number - The desired hunger level, expressed as a percentage.

-- Example:
-- Set the player's hunger to 50%
exports.LEGACYCORE:SetPlayerHunger(50)

-- LEGACYCORE:SetPlayerThirst
-- Description:
-- Sets the player's thirst level to the specified value.

-- Parameters:
--- @param number number - The desired thirst level, expressed as a percentage.

-- Example:
-- Set the player's thirst to 75%
exports.LEGACYCORE:SetPlayerThirst(75)

--[[ GETPLAYERCHARID FUNCTION ]]

-- Retrieves the current character ID slot used by the player.
-- This function is particularly useful for identifying which character slot the player is currently using.
-- In a game where players can have multiple characters tied to a single account, each character is assigned a unique slot.
-- This function returns the identifier for the character slot that is active when the player spawns into the game.

--- @return string, number | nil - The player's character ID slot, which is an integer representing the slot assigned to the active character.

-- Example:

local charId = Legacy.DATA:GetPlayerCharId()
print(string.format("The player is using character slot ID: %d", charId))

-- Notes:
-- Ensure that the player has fully spawned before calling this function, as the character ID slot is only assigned at that point.
-- This function does not take any parameters.
-- The return value is always a number. If, for any reason, the slot ID cannot be retrieved, consider adding error handling to manage such cases.

