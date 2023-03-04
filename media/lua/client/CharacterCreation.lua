
local characterCreationsTable_ = { perk, level }

local function characterCreationTable(trait)
    table.insert(characterCreationsTable_, trait)
end

--local function characterCreationTable(perk, level)
--    table.insert(characterCreationsTable_,{
--        perk = perk,
--        level = level
--    })
--end

local function initCharacterCreation(character)
    if not character then
        character = getPlayer()
    end

    return character
end

function getCharacterCreation(character)
    -- character = initCharacterCreation(character)
    --local characterProfessions = {perk, level}
    --local characterTraits = {perk, level}

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
        end
    end

    --for perk, level in pairs(characterTraits) do
    --
    --    local dbg1 = characterCreationsTable_[perk].perk
    --    local dbg2 = characterCreationsTable_[perk].level
    --    local dbg3 = characterTraits[perk].perk
    --    local dbg4 = characterTraits[perk].level
    --    local dbg5 = {}
    --    dbg5 = characterTraits
    --    local dbg6 = {}
    --    dbg6 = characterCreationsTable_
    --
    --    local dbg
    --
    --    if characterCreationsTable_[perk].perk == characterTraits[perk].perk then
    --        characterCreationsTable_[perk].level = characterCreationsTable_[perk].level:intValue() + characterTraits[perk].level:intValue()
    --    else
    --         -- characterCreationTable(characterTraits[perk].perk, characterTraits[perk].level)
    --         characterCreationTable(characterTraits[perk])
    --    end
    --end

    return characterCreationsTable_
end