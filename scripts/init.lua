--  Load configuration options up front

DEBUG = true
---@type boolean True when saving function evaluations for performance improvements
CACHING = false
Tracker.BulkUpdate = true
Tracker:AddItems("items/common.json")

if not (string.find(Tracker.ActiveVariantUID, "items_only")) then
	Tracker:AddMaps("maps/maps.json")
	require("scripts.logic_common")
	require("scripts.logic_locations")
	Tracker:AddLayouts("layouts/tracker.json")
	Tracker:AddLocations("locations/overworld.json")
else
	Tracker:AddLayouts("layouts/item_only.json")
end
Tracker:AddLayouts("layouts/standard_broadcast.json")
RACLogic:__init__()

---Table of All Planets
Planets = {
	"Novalis",
	"Kerwan",
	"Aridia",
	"Eudora",
	"Blarg",
	"Rilgar",
	"Umbris",
	"Batalia",
	"Orxon",
	"Gaspar",
	"Poki",
	"Hoven",
	"Gemlik",
	"Oltanis",
	"Quartu",
	"Kalebo",
	"Fleet",
	"Veldin"
}

for _, name in pairs(Planets) do
	---@type JsonItem
	---@diagnostic disable-next-line: assign-type-mismatch
	local infobot = Tracker:FindObjectForCode(name)
	infobot.BadgeText = string.sub(name, 1, 3)
	infobot:SetOverlayFontSize(12)
	infobot:SetOverlayAlign("center")
	---Checks the planet has a valid vendor
	if pcall(function()
			Tracker:FindObjectForCode(name .. "_v").BadgeText = "Test"
		end) then
		---@type JsonItem
		---@diagnostic disable-next-line: assign-type-mismatch
		local vendor = Tracker:FindObjectForCode(name .. "_v")
		vendor.BadgeText = string.sub(name, 1, 3)
		vendor:SetOverlayFontSize(12)
		vendor:SetOverlayAlign("left")
	end
end

ScriptHost:AddWatchForCode("Gold Bolts Setting", "AGB", Update_Setting)
Update_Setting("AGB")
ScriptHost:AddWatchForCode("Weapon Setting", "Weapons", Update_Setting)
Update_Setting("Weapons")
ScriptHost:AddWatchForCode("Vendor Setting", "Vendor", Update_Setting)
Update_Setting("Vendor")

-- TODO: Vanilla Golden Weapons

if CACHING then
	Cache = 0
	Reset = false
	Function_cache = {}
end

-- ScriptHost:AddWatchForCode("AccessUpdating", "*", Update_Access)
-- ScriptHost:AddWatchForCode("Vendor in Logic", "*", Vendor_activate)

Tracker.BulkUpdate = false