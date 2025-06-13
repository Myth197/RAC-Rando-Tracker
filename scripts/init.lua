--  Load configuration options up front
DEBUG = true
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

for v, name in pairs(Planets) do
	local infobot = Tracker:FindObjectForCode(name)
	infobot.BadgeText = string.sub(name, 1, 3)
	infobot:SetOverlayFontSize(12)
	infobot:SetOverlayAlign("center")
	if pcall(function()
			Tracker:FindObjectForCode(name .. "_v").BadgeText = "Test"
		end) then
		local vendor = Tracker:FindObjectForCode(name .. "_v")
		vendor.BadgeText = string.sub(name, 1, 3)
		vendor:SetOverlayFontSize(12)
		vendor:SetOverlayAlign("left")
	end
end

ScriptHost:AddWatchForCode("Vendor in Logic", "*", Vendor_activate)
