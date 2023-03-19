---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 01/02/23 19:11
--- function ISSkillProgressBar:renderPerkRect()
--- ISSkillProgressBar:updateTooltip(lvlSelected)

local characterMaxLevelCombats = { perk, maxLevel }
local characterMaxLevelPerks = { perk, maxLevel }
-- local getPlayer = getPlayer -- projectZombieLib 52 error

---Add value to table characterMaxCombat
---@param perk PerkFactory.Perk
---@param level int
local function characterMaxLevelCombat(perk, maxLevel)
    table.insert(characterMaxLevelCombats,{
        perk = perk,
        maxLevel = maxLevel
    })
end

---Add value to table characterMaxPerks
---@param perk PerkFactory.Perk
---@param level int
local function characterMaxLevelPerk(perk, maxLevel)
    table.insert(characterMaxLevelPerks,{
        perk = perk,
        maxLevel = maxLevel
    })
end

local function onCustomUIKeyPressed(key)

    local character = getPlayer()

    --key34(character, key)
    --key35(character, key)
    key36(character, key)
end

function key36(character, key)
    if key == 36 then -- <<<< j
        print("Key = J\n")
        dbg001()
    end
end

function key34(character, key)
    if key == 34 then -- <<<< g
        print("Key = g\n")
    end
end

function key35(character, key)
    if key == 35 then -- <<< h
        print("Key = h\n")
        -- reset tables
        characterMaxLevelPerks = {}
        characterMaxLevelCombats = {}

        createCharacter(character)
        DBG_display_SLExample(false, true, true)
        print("\n")
    end

    if flag_onCustomUIKeyPressed then
        flag_onCustomUIKeyPressed = false
    end
end

---Check Level Max
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param _ --- unused
function checkLevelMax(character, perk, _)
    local CharacterObj = getCharacterCurrentSkill(character, perk)

    -- if per andare direttamente al secondo ciclo

    for _, v in pairs(characterMaxLevelPerks) do
        -- if true
        if (v.perk == CharacterOb:getPerkDetails():getPerk()) then
            if (CharacterObj:getPerkDetails():getLevel() >= v.maxLevel ) then
                blockLevel(character, perk, v.maxLevel, CharacterObj)
            end
        end
    end

    for _, level in pairs(characterMaxLevelCombats) do
        if (v.perk == CharacterObj:getPerkDetails():getPerk()) then
            if (CharacterObj:getPerkDetails():getLevel() >= level.maxLevel ) then
                blockLevel(character, perk, level.maxLevel, CharacterObj)
            end
        end
    end
end

---@param character IsoGameCharacter
---@param perk PerkFactory
---@param maxLevel int
---@param characterObj CharacterObj
function blockLevel(character, perk, maxLevel, characterObj)
    local convertLevelToXp_ = 0.0

    for level_ = 1, maxLevel do
        convertLevelToXp_ = convertLevelToXp_ + convertLevelToXp(perk, level_)
    end

    local totalXp = ( convertLevelToXp_ - characterObj:getPerkDetails():getXp()) * 2
    if totalXp == 0 then
        return
    end

    addXP_PZ(character, perk, totalXp )
end

--- Create Character Static
---@param character IsoGameCharacter
--- - IsoGameCharacter : zombie.characters.IsoGameCharacter
function createCharacter(character)
    if not character then
        return nil
    end

    local CharacterObj = getCharacterAllSkills(character)

    for _, v in pairs(CharacterObj:getPerkDetails()) do
        if "Combat" == v.perk:getParent():getName()  then -- < da creare un metodo
            calculateCombatMaxLevel(v.perk, v.level)
        else
            calculateCharacterMaxPerk(v.perk, v.level)
        end
    end
end

--- Calculate Character Max Perk - table
---@param perk PerkFactory.Perk
---@param level int
function calculateCharacterMaxPerk(perk, level)
    if not perk or not level then
        return nil
    end

    characterMaxLevelPerk(perk, getCharacterMaxPerk(level))
end

--- Calculate Max Level Combat - table
---@param perk PerkFactory.Perk
---@param level int
function calculateCombatMaxLevel(perk, level)
    if not perk or not level then
        return nil
    end

    characterMaxLevelCombat(perk, getCombatMaxLevel(level) )
end

--- Prende il livello massimo che il personaggio può raggiungere.
--- Aggiungere un try catch
---@param levelCurrentPerk int
---@return int
function getCharacterMaxPerk(levelCurrentPerk)
    if not levelCurrentPerk then
        return nil
    end

    if levelCurrentPerk == ENUM.Zero then -- 0
        return ENUM.Four -- max levelPerk 4
    elseif levelCurrentPerk == ENUM.One then -- 1
        return ENUM.Six -- 6
    elseif levelCurrentPerk == ENUM.Two then -- 2
        return ENUM.Eight -- 8
    elseif levelCurrentPerk >= ENUM.Three then -- 3
        return ENUM.Ten -- 10
    end

    return nil
end

---Get Combat Max Level
---Aggiungere un try catch
---@param combatCurrentPerk int
---@return int Combat Max Level
function getCombatMaxLevel(combatCurrentPerk)
    if not combatCurrentPerk then
        return nil
    end

    if combatCurrentPerk == ENUM.Zero then -- 0
        return ENUM.Five -- 5
    elseif combatCurrentPerk == ENUM.One then -- 1
        return ENUM.Seven -- 7
    elseif combatCurrentPerk >= ENUM.Two then -- 2
        return ENUM.Ten -- 10
    end

    return nil
end

function DBG_display_SLExample(profession, perk, weapon)
    if perk then
        print("\n Perk")
    for _, v in pairs(characterMaxLevelPerks) do
            print( tostring(v.perk:getName()) .. " " .. tostring(v.maxLevel) )
        end
    end

    if weapon then
        print("\n weapon")
        for _, v in pairs(characterMaxLevelCombats) do
            print( tostring(v.perk:getName()) .. " " .. tostring(v.maxLevel) )
        end
    end

    --if profession then
    --    print("\n Profession")
    --    local characterObj =
    --    getCharacterCurrentSkill( getPlayer(), characterMaxLevelPerks[3].perkName )
    --    print(characterObj.getProfession())
    --end

end

--- event add Xp
local function AddXP(character, perk, level)
    checkLevelMax(character, perk, level)
end

local function OnGameStart()
    --init()
end




--[[
local function OnGameStart()
    -- Your code here
end

Events.OnGameStart.Add(OnGameStart)]]

--[[
IsoGameCharacter The character who's gaining XP.
PerkFactory.Perk The perk that is being leveled up.
Float The perk level gained.
Examples
local function AddXP(character, perk, level)
	-- Your code here
end

Events.AddXP.Add(AddXP)]]

-- TODO oggetto 3 non svuotato correttamente
function dbg001()
    local character = getPlayer()

    print("------------------------------------")
    local characterCurrentSkill01 =
    getCharacterCurrentSkill(character, Perks.Maintenance)

    print("Oggetto 1 " .. tostring(characterCurrentSkill01:getProfession()))
    print("Oggetto 1 " .. tostring(characterCurrentSkill01:getPerkDetailsObj():getPerk()))
    print("------------------------------------")

    print("------------------------------------")
    local characterCurrentSkill02 =
    getCharacterCurrentSkill(character, Perks.Doctor)

    print("Oggetto 2 " .. tostring(characterCurrentSkill02:getProfession()))
    print("Oggetto 2 " .. tostring(characterCurrentSkill02:getPerkDetailsObj():getPerk()))
    print("------------------------------------")

    print("------------------------------------")
    local characterCreation = getCharacterCreation(character)

    for _, v in pairs(characterCreation:getPerkDetails()) do
        print("Oggetto 3 " .. tostring(v:getPerk()) .. " " .. tostring(v:getLevel()))
    end
    print("------------------------------------")

    print("------------------------------------")
    local characterAllSkills =
    getCharacterAllSkills(character)

    --for _, v in pairs(characterAllSkills:getPerkDetails()) do
    --    print("Oggetto 4 " .. tostring(v:getPerk()))
    --end
    print("------------------------------------")

    characterCurrentSkill01 = nil
    characterCurrentSkill02 = nil
    characterCreation = nil
    characterAllSkills = nil

end

Events.OnCustomUIKeyPressed.Add(onCustomUIKeyPressed)
--Events.OnGameStart.Add(OnGameStart)
--Events.AddXP.Add(AddXP)