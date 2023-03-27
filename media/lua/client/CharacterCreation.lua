
---@class CharacterCreation

require("media.lua.shared.objects.CharacterTableX")

local characterCreationsTable_ = { perk, level, flag }
local removeValueFromTable_ = { values }

---Add value to table CreationsTable
---@param perk PerkFactory.Perk
---@param level int
local function characterCreationTable(perk, level)
    table.insert(characterCreationsTable_, {
        perk = perk,
        level = level,
    })
end

---Destroy characterCreationsTable_
local function characterCreation_DestroyTable()
    characterCreationsTable_ = { perk, level }
end

---@param int
local function addValueFromTable(value)
    table.insert(removeValueFromTable_, value)
end

---Remove elements from characterProfession_
---@param table
local function removeValueFromTable(characterProfession_)
    for i, v in pairs(removeValueFromTable_) do
        table.remove(characterProfession_, v)
    end
end

---Get character and get All skills/traits
---@param character IsoGameCharacter
---@return table string profession, PerkFactory.Perk perk, int level, float xp, boolean flag
function getCharacterCreation(character)
    if not character then
        return nil
    end

    characterCreation_DestroyTable()

    local characterProfession_ = { perk, level }
    characterProfession_ = getCharacterProfession(character)

    local characterTraits_ = { perk, level }
    characterTraits_ = getCharacterTraits(character)

    for _, v1 in pairs(characterTraits_) do
        characterCreationTable(v1.perk, v1.level)
    end

    for _, v1 in pairs(characterCreationsTable_) do
        for i2, v2 in pairs(characterProfession_) do
            if  v1.perk == v2.perk then
                v1.level = v1.level:intValue() + v2.level:intValue()
                addValueFromTable(i2)
            end
        end

    end

    removeValueFromTable(characterProfession_)

    for _, v in pairs(characterProfession_) do
        characterCreationTable(v.perk, v.level)
    end

    characterTableX_DestroyTable()

    -- add to CharacterObj
    for i, v in pairs(characterCreationsTable_) do
        characterTableX_addPerkDetails(_, v.perk, v.level, _)
    end

    return characterTableX_getPerkDetails()
end