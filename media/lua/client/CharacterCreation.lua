
---@class CharacterCreation

require("media.lua.shared.objects.CharacterObj")

local characterCreationsTable_ = { perk, level }

local function characterCreationTable(perk, level)
    table.insert(characterCreationsTable_, {
        perk = perk,
        level = level
    })
end

---Get character and get All skills/traits
---@param character IsoGameCharacter
---@return CharacterObj -- CharacterObj.lua = String Perk, int Level
function getCharacterCreation(character)
    if not character then
        return nil
    end

    local CharacterObj01 = CharacterObj:newObject(nil)

    characterCreationsTable_ = {}

    local characterProfession_ = {}
    characterProfession_ = getCharacterProfession(character)

    local characterTraits_ = {}
    characterTraits_ = getCharacterTraits(character)

    for _, v1 in pairs(characterTraits_) do
        characterCreationTable(v1.perk, v1.level)
    end

    for i1, v1 in pairs(characterCreationsTable_) do
        for i2, v2 in pairs(characterProfession_) do
            if  v1.perk == v2.perk then
                v1.level = v1.level:intValue() + v2.level:intValue()
                table.remove(characterProfession_, i2)
            end
        end
    end

    for _, v1 in pairs(characterProfession_) do
        characterCreationTable(v1.perk, v1.level)
    end

    -- add to CharacterObj

    for _, v in pairs(characterCreationsTable_) do
        CharacterObj01:addPerkDetails(v.perk, v.level)
    end

    return CharacterObj01
end
