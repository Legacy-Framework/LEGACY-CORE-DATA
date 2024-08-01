--[[ GETPLAYERDATABYSLOT FUNCTION ]]

-- Retrieves the full player data based on the player's source identifier and character slot.
-- This function is essential for accessing the comprehensive dataset associated with a player's character, 
-- including stats, inventory, and other relevant information stored server-side.
-- It allows server-side scripts to interact with player-specific data efficiently.

-- Parameters:
--- @param src string - The player's source identifier, which typically represents their unique connection ID on the server.

-- Return Value:
--- @return table|nil - If the player data is found, a table containing the full player data is returned. If no data is found for the specified slot, the function returns nil.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's data based on their slot:
RegisterCommand('dataslot', function(src)
    local playerData = Legacy.DATA:GetPlayerDataBySlot(src)
    if playerData then
        print(string.format("Is Dead: %d", playerData.is_dead))
        print(string.format("Identifier: %s", playerData.identifier))
        print(string.format("Character Identifier: %s", playerData.charIdentifier))
        print(string.format("Player Name: %s", playerData.playerName))
        print(string.format("Sex: %s", playerData.sex))
        print(string.format("Date of Birth: %s", playerData.dob))
        print(string.format("Height: %f", playerData.height))
        print(string.format("Accounts: %s", json.encode(playerData.accounts, { indent = true })))
        print(string.format("Status: %s", playerData.status))
        print(string.format("Skin: %s", json.encode(playerData.skin, { indent = true })))
        print(string.format("Last Spawn Position: %s", json.encode(playerData.lastSpawn, { indent = true })))
        print(string.format("Player Group: %s", playerData.playerGroup))
        print(string.format("Job Name: %s", playerData.JobName))
        print(string.format("Job Label: %s", playerData.JobLabel))
        print(string.format("Job Grade: %d", playerData.JobGrade))
        print(string.format("Inventory: %s", json.encode(playerData.inventory, { indent = true })))
    else
        print("No data found for the given slot.")
    end
end)

--[[ GETPLAYERCHARSLOT FUNCTION ]]

-- Retrieves the character slot identifier based on the player's source identifier.
-- This function is useful when you need to determine which character slot a player is currently using,
-- particularly in systems where players can have multiple characters.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return number|nil - The function returns the character slot identifier as a number if found. If the slot is not found, it returns nil.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the character slot ID:
local charSlot = Legacy.DATA:GetPlayerCharSlot(src)
if charSlot then
    print(string.format("Character slot ID: %d", charSlot))
else
    print("Character slot not found.")
end

--[[ GETPLAYERJOBDATA FUNCTION ]]

-- Retrieves the job-related data for the player based on their source identifier.
-- This function provides access to the player's job name, job label (or title), and job grade (or level),
-- which is particularly useful in role-playing scenarios where jobs or roles are integral to the gameplay.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return string - JobName: The name of the player's job.
--- @return string - JobLabel: The label or title associated with the player's job.
--- @return number - JobGrade: The grade or level within the job hierarchy.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's job data:
local jobName, jobLabel, jobGrade = Legacy.DATA:GetPlayerJobData(src)
print(string.format("Job Name: %s", jobName))
print(string.format("Job Label: %s", jobLabel))
print(string.format("Job Grade: %d", jobGrade))

--[[ GETPLAYERGROUP FUNCTION ]]

-- Retrieves the group associated with the player's character based on their source identifier.
-- Groups can represent factions, teams, or any other collective entities within the game.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return string|nil - The name of the group associated with the player's character if assigned, or nil if no group is assigned.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's group:
local groupName = Legacy.DATA:GetPlayerGroup(src)
if groupName then
    print(string.format("Player's Group: %s", groupName))
else
    print("No group assigned to the player.")
end

--[[ GETNAME FUNCTION ]]

-- Retrieves the name of the player based on their source identifier and character slot.
-- This function provides access to the player's character name.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return string|nil - The name of the player's character if found. If no name is found, the function returns nil.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's name:
local playerName = Legacy.DATA:GetName(src)
if playerName then
    print(string.format("Player Name: %s", playerName))
else
    print("Player Name not found.")
end

--[[ GETGENDER FUNCTION ]]

-- Retrieves the gender of the player based on their source identifier and character slot.
-- This function provides access to the player's character gender.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return string|nil - The gender of the player's character ('m' or 'f') if found. If no gender is found, the function returns nil.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's gender:
local gender = Legacy.DATA:GetGender(src)
if gender then
    print(string.format("Player Gender: %s", gender))
else
    print("Player Gender not found.")
end

--[[ GETINVENTORYDATA FUNCTION ]]

-- Retrieves the inventory data for the player based on their source identifier and character slot.
-- This function provides access to the player's inventory items.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return table|nil - The inventory data of the player's character if found. If no inventory data is found, the function returns nil.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's inventory data:
local inventory = Legacy.DATA:GetInventoryData(src)
if inventory then
    print(string.format("Inventory: %s", json.encode(inventory, { indent = true })))
else
    print("Player Inventory not found.")
end

--[[ GETPLAYERACCOUNT FUNCTION ]]

-- Retrieves the account data for the player based on their source identifier and character slot.
-- This function provides access to the player's account data, including money and bank.

-- Parameters:
--- @param src string - The player's source identifier.

-- Return Value:
--- @return table|nil - The account data of the player's character if found. If no account data is found, the function returns nil.

-- Example Usage:
-- The following example demonstrates how to retrieve and print the player's account data:
local accounts = Legacy.DATA:GetPlayerAccount(src)
if accounts then
    print(string.format("Accounts: %s", json.encode(accounts, { indent = true })))
else
    print("Player Account not found.")
end

--[[ SETPLAYERDATA FUNCTION ]]

-- Updates a specific field in the player's data based on their source identifier and character slot.
-- This function is used to modify various aspects of the player's data.

-- Parameters:
--- @param src string - The player's source identifier.
--- @param key string - The field to be updated.
--- @param value any - The new value for the specified field.
--- @param slot number - The character slot identifier.

-- Return Value:
--- @return boolean - Returns true if the update was successful, or false if there was an error.

-- Example Usage:
-- The following example demonstrates how to update a specific field in the player's data:
local success = Legacy.DATA:SetPlayerData(src, 'playerName', 'NewName', Legacy.DATA:GetPlayerCharSlot(src))
if success then
    print("Player data updated successfully.")
else
    print("Failed to update player data.")
end

--[[ GETCHARACTEREXIST FUNCTION ]]

-- Checks if a character exists for the player based on their source identifier and character slot.
-- This function is used to verify if a character is present in the database.

-- Parameters:
--- @param src string - The player's source identifier.
--- @param slot number - The character slot identifier.

-- Return Value:
--- @return boolean - Returns true if the character exists, or false otherwise.

-- Example Usage:
-- The following example demonstrates how to check if a character exists:
local exists = Legacy.DATA:GetCharacterExist(src, Legacy.DATA:GetPlayerCharSlot(src))
if exists then
    print("Character exists.")
else
    print("Character does not exist.")
end
