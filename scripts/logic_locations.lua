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
    if DEBUG then
        if Location and weapon then
            print("Checking: " .. Location .. ", " .. weapon)
        elseif Location then
            print("Checking: " .. Location)
        else
            print("Checking: Default Location")
        end
    end
    ---@type accessibilityLevel Accessibility Level to be returned
    local access = AccessibilityLevel.None
    ---@type boolean True when the infobot has been optained
    local infobot = Tracker:ProviderCountForCode("Novalis") > 0
    if infobot then
        access = AccessibilityLevel.Normal
        if (
                Location == "Cave" and
                not Rock_Explosion()
            ) or (
                Location == "Ameboid" and
                Tracker:ProviderCountForCode("Hydro") == 0
            ) then
            access = AccessibilityLevel.SequenceBreak
        elseif Location == "Gold" and
            (
                not Gold(40) or
                not Metal_Detector() or
                ---@diagnostic disable-next-line: param-type-mismatch
                Tracker:ProviderCountForCode(weapon) == 0
            ) then
            access = AccessibilityLevel.SequenceBreak
            ---@diagnostic disable-next-line: param-type-mismatch
            if not Gold(4) or Tracker:ProviderCountForCode(weapon) == 0 then
                access = AccessibilityLevel.Inspect
            end
        end
    end
    return access
end

--#endregion
