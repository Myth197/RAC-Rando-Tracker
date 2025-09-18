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
            )
        then
            access = AccessibilityLevel.SequenceBreak
        elseif Location == "Gold" and
            (
                RACLogic:has_notall { ["Gold"] = 40, [weapon] = 1 } or
                not Metal_Detector()
            )
        then
            access = AccessibilityLevel.SequenceBreak
            if RACLogic:has_notall { ["Gold"] = 4, [weapon] = 1 } then
                access = AccessibilityLevel.Inspect
            end
        elseif Location == "SP" and
            RACLogic:lookup_has_none("Ranged")
        then
            access = AccessibilityLevel.None
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
        if Location == nil or
            (
                (
                    Location == "Train" or
                    Location == "ShopSP"
                ) and
                RACLogic:lookup_has_any("Pack")
            ) or (
                Location == "CourseGB" and
                RACLogic:has { ["Heli"] = 1 }
            ) or (
                Location == "Blimp" and
                RACLogic:lookup_has_any("LongRanged")
            ) or (
                Location == "Qwark" and
                RACLogic:lookup_has_any("Qwark_bot")
            )
        then
            access = AccessibilityLevel.Normal
        elseif Location == "Blimp" or Location == "Qwark" then
        else
            access = AccessibilityLevel.SequenceBreak
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
                Location == "SwingSP" and
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
            ) or (
                Location == "Shoot" and
                RACLogic:lookup_has_any("Ranged")
            ) then
            access = AccessibilityLevel.Normal
        elseif Location == "Laser" or
            Location == "CaveGB" or
            Location == "Swing" then
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
        access = AccessibilityLevel.SequenceBreak
        if (
                Location == "Vendor" and
                Metal_Detector()
            ) or (
                Location == "Suck" and
                RACLogic:has { ["Heli"] = 1 }
            ) or (
                Location == "Boss" and
                RACLogic:has_all { ["Tres"] = 1, ["Swingshot"] = 1, ["Heli"] = 1 }
            ) or (
                Location == "SP" and
                RACLogic:lookup_has_any("Ranged")
            ) then
            access = AccessibilityLevel.Normal
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
        if Location == nil or
            (
                Location == "Outside" and
                RACLogic:has { ["Tres"] = 1 }
            ) or (
                Location == "Queen" and
                RACLogic:has { ["Swingshot"] = 1 }
            ) or (
                Location == "OutsideGB" and
                RACLogic:has_all { ["Tres"] = 1, ["O2"] = 1 }
            ) then
            access = AccessibilityLevel.Normal
        else
            access = AccessibilityLevel.SequenceBreak
        end
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
        if (
                Location == "Vendor" and
                Metal_Detector()
            ) or (
                Location == "Shady" and
                Metal_Detector() and
                RACLogic:lookup_has_any("Pack")
            ) or (
                Location == "Qwark" and
                RACLogic:lookup_has_any("Pack") and
                RACLogic:has_all { ["Hydrod"] = 1, ["Swingshot"] = 1 }
            ) or (
                Location == "Hover" and
                RACLogic:lookup_has_any("Pack") and
                RACLogic:has { ["Hover"] = 1 }
            ) or (
                Location == "Maze" and
                RACLogic:lookup_has_any("Pack")
            ) or (
                Location == "Sewer" and
                RACLogic:lookup_has_any("Pack") and
                RACLogic:has_all { ["Hydrod"] = 1, ["Swingshot"] = 1, ["O2"] = 1 }
            ) or (
                Location == "Tank" and
                RACLogic:has { ["Morph"] = 1 }
            ) then
            access = AccessibilityLevel.Normal
        else
            if Location == "Vendor" or
                Location == "Shady" or
                Location == "Qwark" or
                Location == "Hover" or
                Location == "Maze" or
                Location == "Sewer"
            then
                access = AccessibilityLevel.SequenceBreak
            end
        end
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
        if (
                Location == "Boss" and
                RACLogic:has_all { ["Hydrod"] = 1, ["Swingshot"] = 1, ["Heli"] = 1 }
            ) or (
                Location == "GB" and
                RACLogic:has_all { ["Swingshot"] = 1, ["Heli"] = 1 }
            ) then
            access = AccessibilityLevel.Normal
        else
            access = AccessibilityLevel.SequenceBreak
        end
    end
    return access
end

---Batalia general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Batalia(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Batalia"] = 1 } then
        if Location == nil or
            (
                Location == "Vendor" and
                Metal_Detector()
            ) or (
                (
                    Location == "Grind" or
                    Location == "GrindSP"
                ) and
                RACLogic:has { ["Grind"] = 1 }
            ) or (
                Location == "Turret" and
                RACLogic:has { ["Magne"] = 1 }
            ) or (
                Location == "Cliff" and
                RACLogic:lookup_has_any("Pack")
            ) or (
                Location == "Tanks" and
                RACLogic:has_all { ["Sonic"] = 1, ["Magne"] = 1 }
            ) then
            access = AccessibilityLevel.Normal
        else
            if Location == "GrindSP" or
                (
                    Location == "Tanks" and
                    RACLogic:hasnt { ["Sonic"] = 1 }
                ) then
            else
                access = AccessibilityLevel.SequenceBreak
            end
        end
    end
    return access
end

---Orxon general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Orxon(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Orxon"] = 1 } then
        if Location == nil or
            (
                Location == "Vendor" and
                (
                    RACLogic:has_all { ["O2"] = 1, ["Heli"] = 1, ["Metal"] = 1 } or
                    (
                        RACLogic:lookup_has_any("Orxon") and
                        Metal_Detector()
                    )
                )
            ) or (
                Location == "NanoVendor1" and
                RACLogic:has_all { ["O2"] = 1, ["Heli"] = 1 }
            ) or (
                Location == "NanoVendor2" and
                RACLogic:has_all { ["O2"] = 1, ["Heli"] = 1, ["Metal"] = 1 }
            ) or (
                Location == "Infobot" and
                RACLogic:has_all { ["O2"] = 1, ["Swingshot"] = 1, ["Magne"] = 1, ["Heli"] = 1 }
            ) or (
                Location == "CavesGB" and
                RACLogic:has { ["O2"] = 1 }
            ) or (
                Location == "TunnelGB" and
                RACLogic:has_all { ["O2"] = 1, ["Swingshot"] = 1, ["Magne"] = 1, ["Heli"] = 1, ["Visi"] = 1 }
            ) or (
                Location == "SniperSP" and
                RACLogic:has_all { ["O2"] = 1, ["Heli"] = 1 } and
                RACLogic:has_any { ["Dev"] = 1, ["Blaster"] = 1, ["Visi"] = 1 }
            ) or (
                Location == "HeySP" and
                RACLogic:has_all { ["O2"] = 1, ["Magne"] = 1, ["Taunt"] = 1 }
            ) then
            access = AccessibilityLevel.Normal
        else
            if RACLogic:hasnt { ["O2"] = 1 } and
                (
                    (
                        Location == "CavesGB"
                    ) or (
                        Location == "TunnelGB"
                    ) or (
                        Location == "Vendor" and
                        RACLogic:lookup_has_none("Orxon")
                    )
                ) or (
                    Location == "SniperSP" and
                    (
                        RACLogic:has_none { ["Dev"] = 1, ["Blaster"] = 1, ["Visi"] = 1 } or
                        RACLogic:hasnt { ["O2"] = 1 }
                    )
                ) or (
                    Location == "HeySP" and
                    (
                        RACLogic:has_notall { ["Taunt"] = 1, ["O2"] = 1 }
                    )
                ) then
            else
                access = AccessibilityLevel.SequenceBreak
            end
        end
    end
    return access
end

---Gaspar general logic function, returns the accessibility level of the location parameter
---@param Location? string
---@return integer access None(Red), Normal(Green), SequenceBreak(Yellow) or Inspect(Blue)
function Gaspar(Location)
    ---@type integer Accessibility Level to be returned
    local access = AccessibilityLevel.None
    if RACLogic:has { ["Gaspar"] = 1 } then
        if Location == nil or
            (
                Location == "Vendor" and
                Metal_Detector()
            ) or (
                Location == "BombersGB" and
                RACLogic:has { ["Swingshot"] = 1 }
            ) or (
                Location == "VolcanoGB" and
                RACLogic:lookup_has_any("Pack")
            ) or (
                Location == "BombersSP" and
                (
                    RACLogic:has { ["Visi"] = 1 } or
                    (
                        RACLogic:has { ["Swingshot"] = 1 } and
                        RACLogic:lookup_has_any("Ranged")
                    )
                )
            ) then
            access = AccessibilityLevel.Normal
        else
            access = AccessibilityLevel.SequenceBreak
        end
    end
    return access
end
