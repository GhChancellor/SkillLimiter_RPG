
---@class CharacterCreation

local characterCreationsTable_ = { perk, level }

local function characterCreationTable(perk, level)
    table.insert(characterCreationsTable_, {
        perk = perk,
        level = level
    })
end

local function initCharacterCreation(character)
    if not character then
        character = getPlayer()
    end

    return character
end

---Get character and get All skills/traits
---@param character IsoGameCharacter
---@return CharacterObj -- CharacterObj.lua = String Perk, int Level
function getCharacterCreation(character)
    characterCreationsTable_ = {}

    local characterProfession = {}
    characterProfession = getCharacterProfession(character)

    local characterTraits = {}
    characterTraits = getCharacterTraits(character)

    for _, v1 in pairs(characterTraits) do
        characterCreationTable(v1.perk, v1.level)
    end

    for _, v1 in pairs(characterCreationsTable_) do
        for i2, v2 in pairs(characterProfession) do
            if  v1.perk == v2.perk then
                v1.level = v1.level:intValue() + v2.level:intValue()
                table.remove(characterProfession, i2)
            end
        end
    end

    for _, v1 in pairs(characterProfession) do
        characterCreationTable(v1.perk, v1.level)
    end

    -- add to CharacterObj
    local CharacterObj = require("objects/CharacterObj")

    for _, v in pairs(characterCreationsTable_) do
        CharacterObj.addPerkDetails(v.perk, v.level)
    end

    return CharacterObj

    --return characterCreationsTable_
end
