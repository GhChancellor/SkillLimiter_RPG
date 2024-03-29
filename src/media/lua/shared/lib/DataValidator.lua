---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 16/09/23 11:07
---

---@class DataValidator

local DataValidator = {}

--- **Trunk Float To 2 Decimal**
---@param value double
---@return double
function DataValidator.trunkFloatTo2Decimal(value)
    return tonumber(string.format("%.2f", value)) + 0.0
end

--- **Validate Table Value**
---@param table table
---@param key string
---@param value any
---@return boolean
function DataValidator.validateTableValue( table, key, value)
    local success, error = pcall(function()
        table[key] = value
    end)

    if not success then
        return false
    end

    return true
end

--- **Is String**
---@param value string
---@return boolean
function DataValidator.isString(value)
    if type(value) ~= "string" then
        return false
    end

    return true
end

--- **Is Character**
---@param character IsoGameCharacter
---@return boolean
function DataValidator.isCharacter(character)
    if not instanceof(character, "IsoGameCharacter") then
        return false
    end

    return true
end


--- **Is Number**
---@param value number
---@return boolean
function DataValidator.isNumber(value)
    if type(value) ~= "number" then
        return false
    end

    return true
end

--- **Is Int**
---@param value int
---@return boolean
function DataValidator.isInt(value)
    if not DataValidator.isNumber(value) or
            math.floor(value) ~= value then
        return false
    end

    return true
end

--- **Is Double Or Float**
---@param value double or float
---@return boolean
function DataValidator.isDoubleFloat(value)
    if not DataValidator.isNumber(value) or not
    (value % 1 ~= 0) then
        return false
    end

    return true
end

--- **Is Table**
---@param value table
---@return boolean
function DataValidator.isTable(value)
    if type(value) ~= "table" then
        return false
    end

    return true
end

--- **Destroy Table**
---@param value table
---@return void
function DataValidator.destroyTable(value)
    if not DataValidator.isTable(value) then
        return nil
    end

    for k in pairs(value) do
        table.remove(value, k)
    end
end

--- **UNTESTED**
--- **Transform Array List To Table**
---@param arrayList ArrayList
---@return table
function DataValidator.transformArrayListToTable(arrayList)
    ---@type table
    local arrayListToTable = {}

    for i = 1, arrayList:size() - 1 do
        local nameTable = arrayList:get(i)
        table.insert(arrayListToTable, nameTable)
    end

    return arrayListToTable
end

--- **UNTESTED**
--- **Transform Kahlua Table To Table**
---@param kahluaTable KahluaTable
---@return table
function DataValidator.transformKahluaTableToTable(kahluaTable)
    local kahluaTableToTable = DataValidator.transformArrayListToTable(kahluaTable)

    local tables = {}
    for i, v in pairs(kahluaTableToTable) do
        tables[i] = v
    end

    return kahluaTableToTable
end

--- **UNTESTED it's correct but it doesn't work**
--- -
--- **Transform Mod Data To Table**
---@param kahluaTable KahluaTable
---@return table
function DataValidator.transformModDataToTable(kahluaTable)
    ---@type table
    local conversionToTable ={}

    ---@type table
    for _, v in pairs(kahluaTable) do
        table.insert(conversionToTable, v)
    end

    return conversionToTable
end

return DataValidator