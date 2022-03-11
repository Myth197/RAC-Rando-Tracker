--  Load configuration options up front
ScriptHost:LoadScript("scripts/settings.lua")

Tracker:AddItems("items/common.json")


if not (string.find(Tracker.ActiveVariantUID, "items_only")) then
    ScriptHost:LoadScript("scripts/logic_common.lua")
    Tracker:AddMaps("maps/maps.json")
end

Tracker:AddLayouts("layouts/tracker.json")
Tracker:AddLayouts("layouts/standard_broadcast.json")
Tracker:AddLocations("locations/overworld.json")


if _VERSION == "Lua 5.3" then
  ScriptHost:LoadScript("scripts/autotracking.lua")
else
  print("Your tracker version does not support autotracking")
end