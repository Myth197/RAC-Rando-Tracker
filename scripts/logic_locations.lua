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
        if Location == "Train" or
            Location == "StationGB"
        then
            if RACLogic:lookup_has_any("Pack") then
                access = AccessibilityLevel.Normal
            elseif RACLogic:has_any { ["PDA"] = 1, ["Bomb"] = 1 } then
                access = AccessibilityLevel.SequenceBreak
            end
        elseif Location == "CourseGB" then
            if RACLogic:has { ["Heli"] = 1 } then
                access = AccessibilityLevel.Normal
            else
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
    if RACLogic:has { ["Aridia"] = 1 } then
        if Location == nil or
            (
                Location == "Swing" and
                RACLogic:has { ["Swingshot"] = 1 }
            ) or (
                Location == "Laser" and
                RACLogic:has { ["Magne"] = 1 }
            ) or (
                Location == "Agent" and
                RACLogic:has { ["Zoom"] = 1 }
            ) or (
                Location == "CaveGB" and
                RACLogic:lookup_has_any("Rock_Explosion")
            ) then
            access = AccessibilityLevel.Normal
        elseif Location == "Laser" or
            Location == "CaveGB" or
            (
                RACLogic:lookup_has_any("Speedtech") and
                Location == "Swing"
            ) then
            access = AccessibilityLevel.SequenceBreak
        end
    end
    return access
end

---Eudora general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Eudora(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Eudora"] = 1 } then
        if (
                Location == "Vendor" and
                Metal_Detector()
            ) or (
                (
                    Location == "Suck" or
                    Location == "GB"
                ) and
                RACLogic:has { ["Heli"] = 1 }
            ) or (
                Location == "Boss" and
                RACLogic:has_all { ["Tres"] = 1, ["Swingshot"] = 1, ["Heli"] = 1 }
            ) then
            access = AccessibilityLevel.Normal
        elseif Location == "Vendor" or
            Location == "Boss" or
            Location == "GB" or
            (
                Location == "Suck" and
                RACLogic:has_any { ["Thruster"] = 1, ["PDA"] = 1 }
            ) then
            access = AccessibilityLevel.SequenceBreak
        end
    end
    return access
end

---Blarg general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Blarg(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Blarg"] = 1 } then
        access = AccessibilityLevel.Normal
    end
    return access
end

---Rilgar general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Rilgar(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Rilgar"] = 1 } then
        access = AccessibilityLevel.Normal
    end
    return access
end

---Umbris general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Umbris(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Umbris"] = 1 } then
        access = AccessibilityLevel.Normal
    end
    return access
end
