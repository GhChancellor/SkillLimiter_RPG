---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 23/03/23 10:33
---

---@class BlockLevel

---Block Level
---@param character IsoGameCharacter
---@param currentPerkLevel int
---@param perk PerkFactory
---@param maxLevel int
local function blockLevel(character, currentPerkLevel , perk, maxLevel)
    local convertLevelToXp_ = 0.0

    if currentPerkLevel >= maxLevel then
        for level_ = 1, maxLevel do
            convertLevelToXp_ = convertLevelToXp_ + convertLevelToXp(perk, level_)
        end
    end

    local totalXp = ( convertLevelToXp_ -
            getXpPerk_PZ( character, perk ) ) -- * 2

    if totalXp == 0 then
        return
    end

    addXP_PZ(character, perk, totalXp, false, false, true)
end

---Calculate Block Level
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param tables --- perk level
local function calculateBlockLevel(character, perk, tables)
    local currentPerkLevel = getPerkLevel_PZ(character, perk)

    for _, v in pairs(tables) do
        if v.perk == perk then
            if currentPerkLevel >= v.level then
                blockLevel(character, currentPerkLevel, v.perk, v.level)
            end
        end
    end
end

---Check Level Max
---@param character IsoGameCharacter
---@param perk PerkFactory.Perk
---@param _ --- unused
function checkLevelMax(character, perk, characterMaxLevelCombats, characterMaxLevelPerks)
    if not character or not perk then
        return nil
    end

    calculateBlockLevel(character, perk, characterMaxLevelCombats)
    calculateBlockLevel(character, perk, characterMaxLevelPerks)
end