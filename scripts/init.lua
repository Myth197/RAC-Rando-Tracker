--  Load configuration options up front
ScriptHost:LoadScript("scripts/settings.lua")

Tracker:AddItems("items/common.json")

if not (string.find(Tracker.ActiveVariantUID, "items_only")) then
	ScriptHost:LoadScript("scripts/logic_common.lua")
	Tracker:AddMaps("maps/maps.json")
	Tracker:AddLayouts("layouts/tracker.json")
	Tracker:AddLayouts("layouts/standard_broadcast.json")
	Tracker:AddLocations("locations/overworld.json")
else
	Tracker:AddLayouts("layouts/item_only.json")
end


Tracker:AddLayouts("layouts/standard_broadcast.json")

