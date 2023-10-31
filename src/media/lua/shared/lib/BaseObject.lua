---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by lele.
--- DateTime: 26/04/23 17:12
---

---@class BaseObject

BaseObject = {}

BaseObject.type = "BaseObject"

function BaseObject:initialise()

end

function BaseObject:derive(type)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.Type = type
    return o
end

--- **Create a new BaseObject**
function BaseObject:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end