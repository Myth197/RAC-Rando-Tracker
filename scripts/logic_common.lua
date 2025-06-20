---@alias WeaponBool
---| 1 # valid weapon collected
---| 0 # no valid weapon

---True if a weapon can be used to hit a switch on Kalebo III
---@return WeaponBool
function Kalebo_switch()
  if Tracker:ProviderCountForCode("Bomb") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Blaster") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Dev") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Visi") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Tesla") > 0 then
    return 1
  else
    return Tracker:ProviderCountForCode("RYNO")
  end
end

---True if an explosive weapon is obtained
---@return WeaponBool
function Rock_Explosion()
  if Tracker:ProviderCountForCode("Bomb") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Mine") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Dev") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Visi") > 0 then
    return 1
  else
    return Tracker:ProviderCountForCode("RYNO")
  end
end

---@alias LocationReachable
---| 1 # Location is Reachable
---| 0 # Location is not Reachable

---Returns true if there is access to any Metal Detector location.
---
---**TODO**: *Update if conditions to use functions used in the rest of the logic*
---@return LocationReachable
function Metal_Detector()
  if Tracker:ProviderCountForCode("Metal") == 0 then
    return 0
  elseif Tracker:ProviderCountForCode("Novalis") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Kerwan") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Aridia") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Eudora") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Blarg") > 0 and (Tracker:ProviderCountForCode("Swingshot") > 0 or (Tracker:ProviderCountForCode("O2") > 0 and Tracker:ProviderCountForCode("Tres") > 0)) then
    return 1
  elseif Tracker:ProviderCountForCode("Rilgar") > 0 and (Tracker:ProviderCountForCode("Heli") > 0 or Tracker:ProviderCountForCode("Thruster") > 0) then
    return 1
  elseif Tracker:ProviderCountForCode("Umbris") > 0 and Tracker:ProviderCountForCode("Swingshot") > 0 and (Tracker:ProviderCountForCode("Heli") > 0 or Tracker:ProviderCountForCode("Thruster") > 0) then
    return 1
  elseif Tracker:ProviderCountForCode("Batalia") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Orxon") > 0 and Tracker:ProviderCountForCode("O2") > 0 and (Tracker:ProviderCountForCode("Heli") > 0 or Tracker:ProviderCountForCode("Thruster") > 0) then
    return 1
  elseif Tracker:ProviderCountForCode("Gaspar") > 0 and (Tracker:ProviderCountForCode("Swingshot") > 0 or Tracker:ProviderCountForCode("Heli") > 0 or Tracker:ProviderCountForCode("Thruster") > 0) then
    return 1
  elseif Tracker:ProviderCountForCode("Poki") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Hoven") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Gemlik") > 0 and (Tracker:ProviderCountForCode("Tres") > 0 and Tracker:ProviderCountForCode("Magne") > 0 and Tracker:ProviderCountForCode("Swingshot") > 0 and (Tracker:ProviderCountForCode("Dev") > 0 or Tracker:ProviderCountForCode("Visi") > 0)) then
    return 1
  elseif Tracker:ProviderCountForCode("Oltanis") > 0 and (Tracker:ProviderCountForCode("Magne") > 0 or Tracker:ProviderCountForCode("Swingshot") > 0) then
    return 1
  elseif Tracker:ProviderCountForCode("Quartu") > 0 then
    return 1
  elseif Tracker:ProviderCountForCode("Kalebo") > 0 and (Tracker:ProviderCountForCode("Grind") > 0 or (Kalebo_switch > 0 and (Tracker:ProviderCountForCode("Swingshot") > 0 or Tracker:ProviderCountForCode("Heli") > 0 or Tracker:ProviderCountForCode("Thruster") > 0))) then
    return 1
  elseif Tracker:ProviderCountForCode("Fleet") > 0 and (Tracker:ProviderCountForCode("Hologuise") > 0 or (Tracker:ProviderCountForCode("O2") > 0 and Tracker:ProviderCountForCode("Hydro") > 0)) then
    return 1
  elseif Tracker:ProviderCountForCode("Veldin") > 0 and Tracker:ProviderCountForCode("Tres") > 0 and Tracker:ProviderCountForCode("Magne") > 0 and Tracker:ProviderCountForCode("Hydrod") > 0 and Tracker:ProviderCountForCode("Thruster") > 0 and Tracker:ProviderCountForCode("Swingshot") > 0 then
    return 1
  end
end

---@alias GoldAmount
---| 1 # Gold Bolt amount acquired
---| 0 # not enough Gold Bolts


--- Takes a number of Gold Bolts and returns true if that many have been collected
--- @param count integer The number of Gold bolts to compare to
--- **TODO**: *`^$func` to set accessibility level for golden weapon shops*
--- @return GoldAmount
function Gold(count)
  if Tracker:ProviderCountForCode("Gold") >= tonumber(count) then
    return 1
  else
    return 0
  end
end

-- local Metal_Detector_Spots = {
--   ["Novalis_1"] = "Nothing, 1st cave",
--   ["Novalis_2"] = "Nothing, Before Bridge",
--   ["Kerwan_1"] = "Nothing, Training Course start",
--   ["Kerwan_2"] = "Nothing, Before Al",
--   ["Aridia_1"] = "Nothing, Construction zone upper",
--   ["Aridia_2"] = "Nothing, Construction zone lower",
--   ["Eudora_1"] = "Nothing, After 3rd Bridge",
--   ["Eudora_2"] = "Heli/Thruster, After Suck",
--   ["Blarg_1"] = "O2, Tres, Near Outside Gold Bolt",
--   ["Blarg_2"] = "Swingshot, before Animal Cages Checkpoint",
--   ["Rilgar_1"] = "Heli/Thruster, Ameboid Fight Cave",
--   ["Rilgar_2"] = "Heli/Thruster, by hoverboard race",
--   ["Umbris_1"] = "Swingshot, Heli/Thruster, Near first pad puzzle",
--   ["Umbris_2"] = "Hydrodisplacer, Swingshot, Heli/Thruster, Snagglebeast Arena",
--   ["Batalia_1"] = "Nothing, near cliff gold bolt",
--   ["Batalia_2"] = "Magneboots, near the turret",
--   ["Orxon_1"] = "O2, Heli/Thruster, Clank only cave near Gold Bolt",
--   ["Orxon_2"] = "O2, Heli/Thruster, near Sniper skillpoint pipe",
--   ["Gaspar_1"] = "Swingshot, After 2nd Ship destroyed",
--   ["Gaspar_2"] = "Heli/Thruster, Cave before Gold Bolt",
--   ["Poki_1"] = "Nothing, Before 2nd boat ride",
--   ["Poki_2"] = "Hydrodisplacer, Tres, After first Trespasser lock",
--   ["Hoven_1"] = "Nothing, 1st switch puzzle in west section",
--   ["Hoven_2"] = "Hydrodisplacer, near Edwina",
--   ["Gemlik_1"] = "Tres,Magne,Swingshot,Dev/Vis, Trespasser lock for turret bunker",
--   ["Gemlik_2"] = "Tres,Magne,Swingshot,Dev/Vis, Qwark runway",
--   ["Oltanis_1"] = "Magneboots, Final Ice patch before Steve",
--   ["Oltanis_2"] = "Swingshot, Below Morph-o-ray",
--   ["Quartu_1"] = "Nothing, Below Ship area",
--   ["Quartu_2"] = "Swingshot, Giant Clank Pad",
--   ["Kalebo_1"] = "$Kalebo_switch, Swingshot/Heli/Thruster, Bottom area below first yellow swingshot target",
--   ["Kalebo_2"] = "Grind, By Help Desk",
--   ["Fleet_1"] = "O2,Hydro, End of water path",
--   ["Fleet_2"] = "Hologuise, Drek's Flagship First Room (before outside)",
--   ["Veldin_1"] = "Tres, Magne, Hydrod, Thruster, Swingshot, Mushroom Cave near Final Gold Bolt",
--   ["Veldin_2"] = "Tres, Magne, Hydrod, Thruster, Swingshot, Giant Clank Area",
-- }

---called by code watch for pack settings
---@param code string name for setting to update badge text and formatting, based off current stage
function Update_Setting(code)
  ---@class JsonItem
  local object = Tracker:FindObjectForCode(code)
  object:SetOverlayFontSize(12)
  object:SetOverlayAlign("center")
  object:SetOverlayBackground("#80000000")
  if code == "AGB" then
    ScriptHost:RemoveWatchForCode("Gold Bolts Setting")
    if object.CurrentStage == 0 then
      object.BadgeText = "Vanilla"
      object.BadgeTextColor = "#A0A0A0"
    else
      object.BadgeText = "Shuffled"
      object.BadgeTextColor = "#FFFF00"
    end
    ScriptHost:AddWatchForCode("Gold Bolts Setting", "AGB", Update_Setting)
  elseif code == "Weapons" then
    ScriptHost:RemoveWatchForCode("Weapon Setting")
    if object.CurrentStage == 0 then
      object.BadgeText = "Vanilla"
      object.BadgeTextColor = "#A0A0A0"
    elseif object.CurrentStage == 1 then
      object.BadgeText = "Weapons Shuffled"
      object.BadgeTextColor = "#FFFFFF"
    else
      object.BadgeText = "Gold Shuffled"
      object.BadgeTextColor = "#FFFF00"
    end
    ScriptHost:AddWatchForCode("Weapon Setting", "Weapons", Update_Setting)
  elseif code == "Vendor" then
    ScriptHost:RemoveWatchForCode("Vendor Setting")
    if object.CurrentStage == 0 then
      object.BadgeText = "Hidden"
      object.BadgeTextColor = "#A0A0A0"
    elseif object.CurrentStage == 1 then
      object.BadgeText = "One Visible"
      object.BadgeTextColor = "#FFFFFF"
    else
      object.BadgeText = "All Visible"
      object.BadgeTextColor = "#00FFFF"
    end
    ScriptHost:AddWatchForCode("Vendor Setting", "Vendor", Update_Setting)
  else
    print("New Setting needs Badge Compatability: " .. code)
  end
end

---@type table Table pairing each vendor location with an item associated to their current accessibility stage
local Vendors = {
  ['@Novalis/Novalis Vendor/Novalis Vendor - 2,500'] = "Novalis_v",
  ['@Kerwan/Kerwan Vendor/Kerwan Vendor - 2,500'] = "Kerwan_v",
  ['@Eudora/Eudora Vendor/Eudora Vendor - 7,500'] = "Eudora_v",
  ['@Blarg/Blarg Vendor/Blarg Vendor - 2,500'] = "Blarg_v",
  ['@Rilgar/Rilgar Vendor/Rilgar Vendor - 7,500'] = "Rilgar_v",
  ['@Batalia/Batalia Vendor/Batalia Vendor - 10,000'] = "Batalia_v",
  ['@Orxon/Orxon Vendor/Orxon Vendor - 15,000'] = "Orxon_v",
  ['@Gaspar/Gaspar Vendor/Gaspar Vendor - 7,500'] = "Gaspar_v",
  ['@Pokitaru/Poki Vendor/Poki Vendor - 7,500'] = "Poki_v",
  ['@Hoven/Hoven Vendor/Hoven Vendor - 7,500'] = "Hoven_v",
  ['@Oltanis/Oltanis Vendor/Oltanis Vendor - 40,000'] = "Oltanis_v",
}

---@type table Table of Flags storing the current accessibility stage of the vendor
local Vendor_flags = {
  ["Novalis_v"] = 0,
  ["Kerwan_v"] = 0,
  ["Eudora_v"] = 0,
  ["Blarg_v"] = 0,
  ["Rilgar_v"] = 0,
  ["Batalia_v"] = 0,
  ["Orxon_v"] = 0,
  ["Gaspar_v"] = 0,
  ["Poki_v"] = 0,
  ["Hoven_v"] = 0,
  ["Oltanis_v"] = 0,
}

---@type string code of the most recently changed item detected by the watch
local previous_code = ""
---@type integer counter for how deep the recursive updating is, breaks the recursion beyond a certain depth
local depth = 0

---Called by code watch to update vendor indicators on the tracker based on current accessibility
---@param code string detected by the code watch
---**TODO**: *Metal Detector Compatability*
---
---**BUG**: *Planet selection marks collected*
function Vendor_activate(code)
  depth = depth + 1
  if depth > 10 then
    ScriptHost:RemoveWatchForCode("Vendor in Logic")
    error("Vendor Loop detected", 10)
  end
  for location, item in pairs(Vendors) do
    local trip = 0
    if Tracker:FindObjectForCode(location).AccessibilityLevel >= AccessibilityLevel.SequenceBreak and Vendor_flags[item] == 0 then
      Vendor_flags[item] = 1
      trip = 1
    elseif Vendor_flags[item] == 0 and item == code then
      if previous_code == code then
        break
      end
      if previous_code .. "_v" == item then
        break
      end
      Vendor_flags[item] = 2
      trip = 1
    elseif Tracker:FindObjectForCode(location).AccessibilityLevel < AccessibilityLevel.SequenceBreak and Vendor_flags[item] == 1 then
      Vendor_flags[item] = 0
      trip = 1
    elseif Vendor_flags[item] == 1 and item == code then
      if previous_code == code then
        break
      end
      if previous_code .. "_v" == item then
        break
      end
      Vendor_flags[item] = 2
      trip = 1
    elseif Tracker:FindObjectForCode(location).AccessibilityLevel < AccessibilityLevel.SequenceBreak and Vendor_flags[item] == 2 then
      Vendor_flags[item] = 0
      trip = 1
    elseif Vendor_flags[item] == 2 and item == code then
      if previous_code == code then
        break
      end
      if previous_code .. "_v" == item then
        break
      end
      Vendor_flags[item] = 1
      trip = 1
    end
    if trip == 1 then
      previous_code = code
      Tracker:FindObjectForCode(item).CurrentStage = Vendor_flags[item]
    else
    end
  end
  depth = depth - 1
  for k, v in pairs(Vendor_flags) do
    if depth == 0 or v ~= Tracker:FindObjectForCode(k).CurrentStage then
      Vendor_flags[k] = Tracker:FindObjectForCode(k).CurrentStage
    end
  end
  if depth == 0 then
    previous_code = ""
  end
end

---Sets the highlight colouring of a location on the map
---@param loc string Tracker location to highlight
---@param priority highlight Priority value, used to set the colour of the highlight
function Highlight(loc, priority)
  Tracker:FindObjectForCode(loc).Highlight = priority
  -- example
  -- Tracker:FindObjectForCode("@Explore as Ratchet/Infobot").Highlight = Highlight.Priority
end
