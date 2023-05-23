
---@class CharacterCreation

local characterLib = require("CharacterLib")
require("lib/CharacterObj")

local mergeTraitsPerks_ = {}

---Merge Traits and Perks into a table
---@param key
---@param value
local function mergeTraitsPerks(key, value)
    if not mergeTraitsPerks_[key] then
        mergeTraitsPerks_[key] = value
    end
end

---@param character IsoGameCharacter
---@return CharacterObj getPerkDetails() -- table PerkFactory.Perk perk, int level, float xp
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function getCharacterCreation(character)
    if not character then
        return nil
    end

    local unusedValue = -10
    local CharacterProfessionObj = CharacterObj:new()
    CharacterProfessionObj = characterLib.getPerkProfession(character)

    local CharacterTraitsPerkObj = CharacterObj:new()
    CharacterTraitsPerkObj = characterLib.getTraitsPerk(character)

    local CharacterAllPerksObj = CharacterObj:new()
    CharacterAllPerksObj = characterLib.getAllPerks(character)

    local CharacterMergeObj = CharacterObj:new()

    for _, v in pairs(CharacterProfessionObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk(), unusedValue)
    end

    for _, v in pairs(CharacterTraitsPerkObj:getPerkDetails()) do
        mergeTraitsPerks(v:getPerk(), unusedValue)
    end

    -- mergeTraitsPerks_ > Trait and Perk of the profession
    for i, v in pairs(mergeTraitsPerks_) do
        CharacterMergeObj:addPerkDetails(i, nil, nil)
    end

    mergeTraitsPerks_ = {}

    for _, v1 in pairs(CharacterAllPerksObj:getPerkDetails()) do
        if v1:getPerk() == Perks.Fitness or v1:getPerk() == Perks.Strength then
           v1:setFlag(true)
        end

        -- CharacterMergeObj > Profession trait and Perk are marked as "true" to indicate bonus in the next step
        for _, v2 in pairs(CharacterMergeObj:getPerkDetails()) do
            if v1:getPerk() == v2:getPerk() then
                v1:setFlag(true)
            end
        end
    end

    return CharacterAllPerksObj
end