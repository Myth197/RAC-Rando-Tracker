--  Load configuration options up front

DEBUG = true
Tracker.BulkUpdate = true
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
-- ScriptHost:AddWatchForCode("Vendor in Logic", "*", Vendor_activate)

Tracker.BulkUpdate = false