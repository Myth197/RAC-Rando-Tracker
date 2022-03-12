--  Load configuration options up front
ScriptHost:LoadScript("scripts/settings.lua")

Tracker:AddItems("items/common.json")


if not (string.find(Tracker.ActiveVariantUID, "items_only")) then
    	Tracker:AddMaps("maps/maps.json")
	Tracker:AddLayouts("layouts/tracker.json")
	Tracker:AddLayouts("layouts/standard_broadcast.json")
	Tracker:AddLocations("locations/overworld.json")
else
	Tracker:AddLayouts("layouts/item_only.json")
end


Tracker:AddLayouts("layouts/standard_broadcast.json")


if _VERSION == "Lua 5.3" then
  ScriptHost:LoadScript("scripts/autotracking.lua")
else
  print("Your tracker version does not support autotracking")
end