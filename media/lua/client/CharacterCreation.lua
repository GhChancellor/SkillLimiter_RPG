
---@class CharacterCreation

local characterCreationsTable_ = { trait }

local function characterCreationTable(trait)
    table.insert(characterCreationsTable_, trait)
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
    local characterProfessions = {}
    local characterTraits = {}

    characterProfessions = getCharacterProfession(character)
    characterTraits = getCharacterTraits(character)
    characterCreationsTable_ = characterProfessions

    local found = false
    for i, _ in pairs(characterTraits) do
        for j, _ in pairs(characterCreationsTable_) do
            if characterCreationsTable_[j].perk == characterTraits[i].perk then
                characterCreationsTable_[j].level =
                characterCreationsTable_[j].level:intValue() + characterTraits[i].level:intValue()
                found = true
            end
        end

        if not found then
            characterCreationTable(characterTraits[i])
            found = false
        end
    end

    local CharacterObj = require("objects/CharacterObj")

    for i, v in pairs(characterCreationsTable_) do
        CharacterObj.addPerkDetails(v.perk, v.level)
    end

    ---- TODO dbg
    --for i, v in pairs(CharacterObj.getPerkDetails()) do
    --    print("CharacterCreation " .. tostring(v.perk))
    --end
    --
    --print("----------------------------------------------------\n")

    return CharacterObj
end