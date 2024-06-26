---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 22/01/24 20:10
---

local blockLevel = require("BlockLevel")
local characterMaxSkill = require("CharacterMaxSkill")
local codePerkDetails = require("CodePerkDetails")
local debugDiagnostics = require("lib/DebugDiagnostics")
local errHandler = require("lib/ErrHandler")
local modDataManager = require("lib/ModDataManager")

local function AddXP(character, perk, level)
    -- TODO: Remove this debug

    debugDiagnostics.printLine()
    print("Current Perk", perk)
    debugDiagnostics.printLine()

    -----------------------------
end


---@param character IsoGameCharacter
local function key82(character, key)
    if key == 82 then -- <<<< numpad 0
        print("Key = numpad 0 > Create Basic Character  \n")
        debugDiagnostics.deleteCharacter()
        debugDiagnostics.createBasicCharacter()
    end
end

---@param character IsoGameCharacter
local function key81(character, key)
    if key == 81 then -- <<<< numpad 3
        print("Key = numpad 3 >  \n")

    end
end

---@param character IsoGameCharacter
local function key75(character, key)
    if key == 75 then -- <<<< numpad 4
        print("Key = numpad 4 >  \n")

    end
end

---@param character IsoGameCharacter
local function key76(character, key)
    if key == 76 then -- <<<< numpad 5
        print("Key = numpad 5 >  \n")

    end
end

---@param character IsoGameCharacter
local function key77(character, key)
    if key == 77 then -- <<<< numpad 6
        print("Key = numpad 6 >  \n")

    end
end

---@param character IsoGameCharacter
local function key71(character, key)
    if key == 71 then -- <<<< numpad 7
        print("Key = numpad 7 >  \n")

    end
end

---@param character IsoGameCharacter
local function key72(character, key)
    if key == 72 then -- <<<< numpad 8
        print("Key = numpad 8 >  \n")

    end
end

---@param character IsoGameCharacter
local function key73(character, key)
    if key == 73 then -- <<<< numpad 9
        print("Key = numpad 9 > kill Character \n")
        character:die()
    end
end

local function onCustomUIKeyPressed(key)
    ---@type IsoGameCharacter
    local character = getPlayer()

    key82(character, key) -- numpad 0
    key81(character, key) -- numpad 3
    key75(character, key) -- numpad 4
    key76(character, key) -- numpad 5
    key77(character, key) -- numpad 6
    key71(character, key) -- numpad 7
    key72(character, key) -- numpad 8
    key73(character, key) -- numpad 9
end

Events.AddXP.Add(AddXP)
Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)