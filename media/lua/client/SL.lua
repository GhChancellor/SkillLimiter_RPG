---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 01/02/23 19:11
--- function ISSkillProgressBar:renderPerkRect()
--- ISSkillProgressBar:updateTooltip(lvlSelected)--- event add Xp


local function AddXP(character, perk, level)
    checkLevelMax(character, perk, _)
end

Events.AddXP.Add(AddXP)