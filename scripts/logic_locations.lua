-- -- TODO: CACHING: Create Location Class which returns Access level has no parents and has children,
-- -- Helpers return true or false have parents and children, update parents when updates
-- -- Items return true or false, only have parents, callback parents when updated
--
-- ---@class PlanetLogic
-- PlanetLogic = {}
--
-- ---Novalis general logic function, returns the accessibility level of the location parameter
-- ---@param Location? string The location to be evaluated, left blank for accessible from ship
-- ---@param weapon? string The weapon in the gold weapon shop being evaluated
-- ---@param callback? fun(Item:string) function callback
-- ---@return integer? access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
-- function PlanetLogic:Novalis(Location, weapon, callback) end

--#region Novalis

---Novalis general logic function, returns the accessibility level of the location parameter
---@param Location? string The location to be evaluated, left blank for accessible from ship
---@param weapon? string The weapon in the gold weapon shop being evaluated
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Novalis(Location, weapon)
    ---@type accessibilityLevel Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Novalis"] = 1 } then
        access = AccessibilityLevel.Normal
        if (
                Location == "Cave" and
                RACLogic:lookup_has_none("Rock_Explosion")
            ) or (
                Location == "Ameboid" and
                RACLogic:hasnt { ["Hydro"] = 1 }
            ) then
            access = AccessibilityLevel.SequenceBreak
        elseif Location == "Gold" and
            (
            ---@diagnostic disable-next-line: param-type-mismatch
                RACLogic:has_notall { ["Gold"] = 40, [weapon] = 1 } or
                not Metal_Detector()
            ) then
            access = AccessibilityLevel.SequenceBreak
            ---@diagnostic disable-next-line: param-type-mismatch
            if RACLogic:has_notall { ["Gold"] = 4, [weapon] = 1 } then
                access = AccessibilityLevel.Inspect
            end
        end
    end
    return access
end

--#endregion
--#region Kerwan

---Kerwan general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Kerwan(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Kerwan"] = 1 } then
        if Location == "Train" or Location == "StationGB" then
            if RACLogic:has_any(RACLogic["Pack"]) then
                access = AccessibilityLevel.Normal
            elseif RACLogic:has { ["PDA"] = 1 } then
                access = AccessibilityLevel.SequenceBreak
            end
        elseif Location == "CourseGB" then
            if RACLogic:has { ["Heli"] = 1 } then
                access = AccessibilityLevel.Normal
            elseif RACLogic:has_any { ["Thruster"] = 1, ["PDA"] = 1 } then
                access = AccessibilityLevel.SequenceBreak
            end
        else
            access = AccessibilityLevel.Normal
        end
    end
    return access
end

---Aridia general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Aridia(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    return access
end

---Eudora general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Eudora(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    return access
end

---Blarg general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Blarg(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    return access
end

---Rilgar general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Rilgar(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    return access
end

---Umbris general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Umbris(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    return access
end