---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 12/02/23 10:20
--- V002

local CharacterObj = require("objects/CharacterObj")
local characterTraitsTable_ = { perk, level }
local professionsTable_ = { perk, level }

local function characterTraitTable(perk, level)
    table.insert(characterTraitsTable_,{
        perk = perk,
        level = level
    })
end

local function professionsTable(perk, level)
    table.insert(professionsTable_,{
        perk = perk,
        level = level
    })
end

function getCharacterTraits(character)
    characterTraitsTable_ = { perk, level }

    local traits_PZ = getTraits_PZ(character)

    for i = 0, traits_PZ:size() - 1 do
        local traitMap = TraitFactory.getTrait(traits_PZ:get(i) ):getXPBoostMap()
        local traitKahluaTable = transformIntoKahluaTable(traitMap)

        for perk, level in pairs(traitKahluaTable) do
            characterTraitTable(perk, level)
        end
    end

    return characterTraitsTable_
end

function getCharacterProfession(character)
    professionsTable_ = { perk, level }

    local characterProfession_PZ = getCharacterProfession_PZ(character)
    local professionMap = ProfessionFactory.getProfession(characterProfession_PZ):getXPBoostMap()
    local professionKahluaTable = transformIntoKahluaTable(professionMap)

    for perk, level in pairs(professionKahluaTable) do
        professionsTable(perk, level)
    end

    return professionsTable_
end


-- ----------------------

-- TODO resetChart
---Reset Character
---@param character IsoGameCharacter
function resetChart(character)
    if not character then
        return nil
    end

    local profession = getCharacterProfession_PZ(character)
    local perk_ = getPerk_PZ(perk)
    local level = getPerkLevel_PZ(character, perk_)
    local xp = getXpPerk_PZ(character, perk_)

end

-- TODO setPerkLevel
---Set Perk Level and level
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return float xp
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function setPerkLevel(character, perk, levelPerk)
    character:setPerkLevelDebug(perk, levelPerk)  -- Perks.Maintenance
end

-- TODO setCharacterProfession_PZ
--- Get Charater profession
---@param character IsoGameCharacter
---@param profession String
--- - SurvivorDesc : zombie.characters.SurvivorDesc
function setCharacterProfession_PZ(character, profession)
    if not character then
        return nil
    end

    character:getDescriptor().setProfession(profession)
end

-- TODO setProfessionSkills_PZ
function setProfessionSkills_PZ()

end

-- TODO setXpLevelToZero
function setXpLevelToZero()

end

-- TODO LoseLevel
---Set Perk Level and level
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return float xp
--- ISPlayerStatsUI.lua 635
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function setPerkLevel_PZ(character, perk, levelPerk)
    --local character = getPlayer()
    --local perk = PerkFactory.getPerk(Perks.Cooking)
    --character:level0(perk)
    --character:LoseLevel(perk)
    --character:LevelPerk(perk)  -- Perks.Maintenance
end

-- TODO getParent_PZ
---@param character IsoGameCharacter
function getParent_PZ(character)

end


-- ----------------------

--- Get Perk
---@param perk PerkFactory
---@return PerkFactory.Perk perk
--- - zombie.characters.skills.PerkFactory
function getPerk_PZ(perk)
    return PerkFactory.getPerk(perk)
end

---Add XP
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param xp float
function addXP_PZ(character, perk, xp )
    if not character then
        return nil
    end

    character:getXp():AddXP(perk, xp );
end

function trunkFloatTo2Decimal(value)
    return tonumber(string.format("%.2f", value)) + 0.0
end

---Get character and get current skill/trait
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return CharacterObj -- CharacterObj.lua = String Perk, int Level
function getCharacterCurrentSkill(character, perk)
    if not character then
        return nil
    end

    local profession = getCharacterProfession_PZ(character)
    local perk_ = getPerk_PZ(perk)
    local level = getPerkLevel_PZ(character, perk_)
    local xp = getXpPerk_PZ(character, perk_)

    CharacterObj.currentCharacter(profession, perk_, level, xp)
    return CharacterObj
end

---Get character and get All skills/traits
---@param character IsoGameCharacter
---@return CharacterObj -- CharacterObj.lua = String Perk, int Level
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function getCharacterAllSkills(character)
    if not character then
        return nil
    end

    local profession = getCharacterProfession_PZ(character)

    -- add profession e add Ability into table
    CharacterObj.createCharacter(profession)

    for i = 0, Perks.getMaxIndex() - 1 do
        local perk = getPerk_PZ(Perks.fromIndex(i))
        local level = getPerkLevel_PZ(character, perk)
        local xp = getXpPerk_PZ(character, perk)
        -- table
        CharacterObj.addAbility(perk, level, xp)
    end
    return CharacterObj
end

--- Get Perk Level
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return int
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function getPerkLevel_PZ(character, perk)
    if not character then
        return nil
    end

    return character:getPerkLevel(perk)
end

--- Get all Traits
---@param character IsoGameCharacter
---@return TraitCollection
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function getTraits_PZ(character)
    if not character then
        return nil
    end

    return character:getTraits()
end

--- Get Character Traits
---@param character IsoGameCharacter
---@return IsoGameCharacter.CharacterTraits
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function getCharacterTraits_PZ(character)
    if not character then
        return nil
    end

    return character:getCharacterTraits()
end

--- Get Charater profession
---@param character IsoGameCharacter
---@return String
--- - SurvivorDesc : zombie.characters.SurvivorDesc
function getCharacterProfession_PZ(character)
    if not character then
        return nil
    end

    return character:getDescriptor():getProfession()
end

--- Get XP perk
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@return float xp
--- - IsoGameCharacter.XP : zombie.characters.IsoGameCharacter.XP
function getXpPerk_PZ(character, perk)
    return trunkFloatTo2Decimal( character:getXp():getXP(perk) ) -- Perks.Maintenance
end

ENUM = {
    Zero = 0,
    One = 1,
    Two = 2,
    Three = 3,
    Four = 4,
    Five = 5,
    Six = 6,
    Seven = 7,
    Eight = 8,
    Nine = 9,
    Ten = 10,
}

--- Convert Level To Xp
---@param level int
---@param perk PerkFactory.Perk
---@return float Xp
function convertLevelToXp(perk, level)
    -- Perks.Sprinting:getXp1()
    if not perk or not level then
        return nil
    end

    if level == ENUM.One then
        return getPerk_PZ(perk):getXp1()
    elseif level == ENUM.Two then
        return getPerk_PZ(perk):getXp2()
    elseif level == ENUM.Three then
        return getPerk_PZ(perk):getXp3()
    elseif level == ENUM.Four then
        return getPerk_PZ(perk):getXp4()
    elseif level == ENUM.Five then
        return getPerk_PZ(perk):getXp5()
    elseif level == ENUM.Six then
        return getPerk_PZ(perk):getXp6()
    elseif level == ENUM.Seven then
        return getPerk_PZ(perk):getXp7()
    elseif level == ENUM.Eight then
        return getPerk_PZ(perk):getXp8()
    elseif level == ENUM.Nine then
        return getPerk_PZ(perk):getXp9()
    elseif level == ENUM.Ten then
        return getPerk_PZ(perk):getXp10()
    end

    return nil
end

function DBG_displayProjectZomboidLibs()
    for i, v in pairs( CharacterObj.getAbilitys() ) do
        print(tostring(v.perk) .. " Level: " .. tostring(v.level) .. " Xp: " .. tostring(v.xp) )
    end
end
