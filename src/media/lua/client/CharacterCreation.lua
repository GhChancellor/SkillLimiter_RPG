
---@class CharacterCreation

local characterLib = require("CharacterLib")
local perkFactoryPZ = require("lib/PerkFactoryPZ")
local characterPz = require("lib/CharacterPZ")
require("lib/CharacterBaseObj")

local mergeTraitsPerks_ = {}

---Merge Traits and Perks into a table.
---@param key
local function mergeTraitsPerks(key)
    local unusedValue = "unusedValue"
    if not mergeTraitsPerks_[key] then
        mergeTraitsPerks_[key] = unusedValue
    end
end

---Destory tables
local function destroyTables()
    mergeTraitsPerks_ = {}
end

---Crea le regole del personaggio
---@param character IsoGameCharacter
--- - Zero add perk to list " Combat "
--- - One add perk to list " No limits "
--- - Two add perk to list " Profession trait and Perk  "
--- - Three add perk to list " Generic  "
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function getCharacterCreation(character)
    if not character then
        return nil
    end

    ---@type CharacterBaseObj
    local CharacterProfessionObj = CharacterBaseObj:new()
    CharacterProfessionObj = characterLib.getPerkProfession(character)

    local CharacterTraitsPerkObj = CharacterBaseObj:new()
    CharacterTraitsPerkObj = characterLib.getTraitsPerk(character)

    local CharacterAllPerksObj = CharacterBaseObj:new()
    CharacterAllPerksObj = characterLib.getAllPerks(character)

    local CharacterMergeTraitsPerksProfessionObj = CharacterBaseObj:new()

    for _, v in pairs(CharacterProfessionObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk())
    end

    for _, v in pairs(CharacterTraitsPerkObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk())
    end

    -- mergeTraitsPerks_ > Trait and Perk of the profession
    for i, _ in pairs(mergeTraitsPerks_) do
        CharacterMergeTraitsPerksProfessionObj:addPerkDetails(i, nil, nil)
    end

    local skipIteration = false

    for i, v in pairs(CharacterAllPerksObj:getPerkDetails()) do

        --- add Fitness/Strength  perks to list " no limits "
        --- Skip if skipIteration is true all other conditions are false
        if not skipIteration then
            if v:getPerk() == Perks.Fitness or
                    v:getPerk() == Perks.Strength then

                v:setIdGroup(characterPz.EnumNumbers.ZERO) -- IdGroup add perk to list " no limits "
                skipIteration = true
            end
        end

        --- add perks to list " Profession trait and Perk  "
        --- Skip if skipIteration is true all other conditions are false
        if not skipIteration then
            -- CharacterMergeObj > IdGroup add perk ( Profession trait and Perk )
            -- to list Profession trait/Perk
            for i2, v2 in pairs(CharacterMergeTraitsPerksProfessionObj:getPerkDetails()) do
                if v:getPerk() == v2:getPerk() then
                    -- IdGroup add perk to list " Profession trait and Perk  "
                    v:setIdGroup(characterPz.EnumNumbers.ONE)
                    skipIteration = true
                end
            end
        end

        local combat = "Combat"

        --- add perks to list " Combat "
        --- Skip if skipIteration is true all other conditions are false
        if not skipIteration then
            
            if v:getIdGroup() ~= characterPz.EnumNumbers.ONE then
                if combat == perkFactoryPZ.getParent_PZ( v:getPerk() )  then
                    -- IdGroup add perk to list " combat "
                    v:setIdGroup(characterPz.EnumNumbers.TWO)
                    skipIteration = true
                end
            end
        end

        -- IdGroup add perk to list " Generic "
        if not skipIteration then
            v:setIdGroup(characterPz.EnumNumbers.THREE)
            skipIteration = true
        end

        skipIteration = false
    end

    destroyTables()

    return CharacterAllPerksObj
end





































--------------------------------------------------------------------------------------------------------------------
--[[

---@param character IsoGameCharacter
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function getCharacterCreation02(character)
    if not character then
        return nil
    end

    includePerksToCombat(Perks.Lightfoot)
    includePerksToCombat(Perks.Nimble)
    includePerksToCombat(Perks.Sneak)

    local CharacterProfessionObj = CharacterBaseObj:new()
    CharacterProfessionObj = characterLib.getPerkProfession(character)

    local CharacterTraitsPerkObj = CharacterBaseObj:new()
    CharacterTraitsPerkObj = characterLib.getTraitsPerk(character)

    local CharacterAllPerksObj = CharacterBaseObj:new()
    CharacterAllPerksObj = characterLib.getAllPerks(character)

    local CharacterMergeObj = CharacterBaseObj:new()

    for _, v in pairs(CharacterProfessionObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk())
    end

    for _, v in pairs(CharacterTraitsPerkObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk())
    end

    -- mergeTraitsPerks_ > Trait and Perk of the profession
    for i, v in pairs(mergeTraitsPerks_) do
        CharacterMergeObj:addPerkDetails(i, nil, nil)
    end

    local skipIteration = false

    for _, v1 in pairs(CharacterAllPerksObj:getPerkDetails()) do

        for _, v2 in pairs(excludePerks_) do
            if v1 == v2  then
                dgLeleLib.display(v2, nil, nil, nil, nil)
                skipIteration = true
            end
        end

        --- skip if is true. Because all other conditions are false
        if not skipIteration then
            if v1:getPerk() == Perks.Fitness or v1:getPerk() == Perks.Strength then
                v1:setFlag(true)
                skipIteration = true
            end
        end

        --- skip if is true. Because all other conditions are false
        if not skipIteration then
            -- CharacterMergeObj > Profession trait and Perk are marked as "true" to indicate bonus in the next step
            for _, v2 in pairs(CharacterMergeObj:getPerkDetails()) do
                if v1:getPerk() == v2:getPerk() then
                    v1:setFlag(true)
                end
            end
        end

        skipIteration = false

    end

    destroyTables()

    return CharacterAllPerksObj
end
]]

---------------------------------------------------------------------------------------------------


--[[
---@param character IsoGameCharacter
---@return CharacterBaseObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
local function getCharacterCreation_Back(character)
    if not character then
        return nil
    end

    includePerksToCombat(Perks.Lightfoot)
    includePerksToCombat(Perks.Nimble)
    includePerksToCombat(Perks.Sneak)

    local CharacterProfessionObj = CharacterBaseObj:new()
    CharacterProfessionObj = characterLib.getPerkProfession(character)

    local CharacterTraitsPerkObj = CharacterBaseObj:new()
    CharacterTraitsPerkObj = characterLib.getTraitsPerk(character)

    local CharacterAllPerksObj = CharacterBaseObj:new()
    CharacterAllPerksObj = characterLib.getAllPerks(character)

    local CharacterMergeObj = CharacterBaseObj:new()

    for _, v in pairs(CharacterProfessionObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk())
    end

    for _, v in pairs(CharacterTraitsPerkObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk())
    end

    -- mergeTraitsPerks_ > Trait and Perk of the profession
    for i, v in pairs(mergeTraitsPerks_) do
        CharacterMergeObj:addPerkDetails(i, nil, nil)
    end

    for _, v1 in pairs(CharacterAllPerksObj:getPerkDetails()) do

        for _, v2 in pairs(excludePerks_) do
            if v1 == v2  then
                dgLeleLib.display(v2, nil, nil, nil, nil)
            end
        end

        if v1:getPerk() == Perks.Fitness or v1:getPerk() == Perks.Strength then
            v1:setFlag(true)
        end

        -- CharacterMergeObj > Profession trait and Perk are marked as "true" to indicate bonus in the next step
        for _, v2 in pairs(CharacterMergeObj:getPerkDetails()) do
            if v1:getPerk() == v2:getPerk() then
                v1:setFlag(true)
            end
        end

        ::continue::
    end

    destroyTables()

    return CharacterAllPerksObj
end]]
