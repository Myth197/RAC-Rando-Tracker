---- RACLogic ----

---@class RACLogic
RACLogic = {
  ["Early_Metal_Detector"] = { ["Novalis"] = 1, ["Kerwan"] = 1, ["Aridia"] = 1, ["Eudora"] = 1, ["Batalia"] = 1, ["Poki"] = 1, ["Hoven"] = 1, ["Quartu"] = 1 }, -- Any
  --["Blarg"] = { ["Swingshot"] = 1, ["O2"] = 1, ["Tres"] = 1 },
  --["Rilgar"] = { ["Heli"] = 1, ["Thruster"] = 1 }, -- ["Pack"]
  --["Umbris"] = { ["Swingshot"] = 1, ["Heli"] = 1, ["Thruster"] = 1 },
  --["Orxon"] = { ["O2"] = 1, ["Heli"] = 1, ["Thruster"] = 1 },
  ["Gaspar"] = { ["Swingshot"] = 1, ["Heli"] = 1, ["Thruster"] = 1 }, -- Any
  --["Gemlik"] = {[] = 1, },
  --["Oltanis"] = {[] = 1, },
  --["Kalebo"] = {[] = 1, },
  --["Fleet"] = {[] = 1, },
  ["Veldin"] = { ["Tres"] = 1, ["Magne"] = 1, ["Hydrod"] = 1, ["Thruster"] = 1, ["Swingshot"] = 1, }, -- All
  ["Kalebo_Switch"] = { ["Bomb"] = 1, ["Blaster"] = 1, ["Dev"] = 1, ["Visi"] = 1, ["Tesla"] = 1, ["RYNO"] = 1 },
  ["Rock_Explosion"] = { ["Bomb"] = 1, ["Mine"] = 1, ["Dev"] = 1, ["Visi"] = 1, ["RYNO"] = 1 },
  ["Ranged"] = { ["Blaster"] = 1, ["Dev"] = 1, ["Visi"] = 1, ["RYNO"] = 1 },
  ["LongRanged"] = { ["Dev"] = 1, ["Visi"] = 1 },
  ["Qwark_bot"] = { ["Bomb"] = 1, ["Dev"] = 1, ["Visi"] = 1, ["RYNO"] = 1 }, -- TODO: Can this be done with the Mine glove?
  ["Pack"] = { ["Heli"] = 1, ["Thruster"] = 1 },
  ["Speedtech"] = { ["Heli"] = 1, ["Thruster"] = 1, ["PDA"] = 1 },
  ["Proxy"] = { ["Bomb"] = 1, ["Doom"] = 1, ["Mine"] = 1, ["Decoy"] = 1, ["Drone"] = 1 }
}


function RACLogic:__init__()
  ---@type table
  local itemlists = {}
  for key, value in pairs(self) do
    if not string.find(tostring(value), "function") then
      print(key)
      table.insert(itemlists, key)
    end
  end
  self.All_Lists = itemlists
end

---@param items table<string,integer> list with a single element
---@return boolean --true when the item count has been obtained
function RACLogic:has(items)
  for item, count in pairs(items) do
    return Tracker:ProviderCountForCode(item) >= count
  end
end

---@param items table<string,integer> list with a single element
---@return boolean --true when the item count has not been obtained
function RACLogic:hasnt(items)
  for item, count in pairs(items) do
    return Tracker:ProviderCountForCode(item) < count
  end
end

---@see RACLogic
---@param listname table<string,integer> list of has requirements
---@return boolean --true when any element of the list is obtained
function RACLogic:has_any(listname)
  for item, count in pairs(listname) do
    if self:has { [item] = count } then
      return true
    end
  end

  return false
end

---@see RACLogic
---@param listname table<string,integer> list of has requirements
---@return boolean --true when all elements of the list are not obtained
function RACLogic:has_none(listname)
  for item, count in pairs(listname) do
    if self:has { [item] = count } then
      return false
    end
  end
  return true
end

---@see RACLogic
---@param listname table<string,integer> list of hasnt requirements
---@return boolean --true when all elements of the list are obtained
function RACLogic:has_all(listname)
  for item, count in pairs(listname) do
    if self:hasnt { [item] = count } then
      return false
    end
  end
  return true
end

---@see RACLogic
---@param listname table<string,integer> list of hasnt requirements
---@return boolean --true when any element of the list is not obtained
function RACLogic:has_notall(listname)
  for item, count in pairs(listname) do
    if self:hasnt { [item] = count } then
      return true
    end
  end
  return false
end

---@see RACLogic
---@param listname string key name for list in RACLogic
---@return boolean --true when any element of the list is obtained
function RACLogic:lookup_has_any(listname)
  return self:has_any(self[listname])
end

---@see RACLogic
---@param listname string key name for list in RACLogic
---@return boolean --true when all elements of the list are not obtained
function RACLogic:lookup_has_none(listname)
  return self:has_none(self[listname])
end

---@see RACLogic
---@param listname string key name for list in RACLogic
---@return boolean --true when all elements of the list are obtained
function RACLogic:lookup_has_all(listname)
  return self:has_all(self[listname])
end

---@see RACLogic
---@param listname string key name for list in RACLogic
---@return boolean --true when any element of the list is not obtained
function RACLogic:lookup_has_notall(listname)
  return self:has_notall(self[listname])
end

---@alias LocationReachable
---| true # Location is Reachable
---| false # Location is not Reachable

---Returns true if there is access to any Metal Detector location.
---@return LocationReachable
function Metal_Detector()
  local canReach = false
  if RACLogic:has { ["Metal"] = 1 } then
    if RACLogic:lookup_has_any("Early_Metal_Detector") then
      canReach = true
      --#region Blarg
    elseif RACLogic:has { ["Blarg"] = 1 } then
      if RACLogic:has { ["Swingshot"] = 1 } or
          RACLogic:has_all { ["O2"] = 1, ["Tres"] = 1 }
      then
        canReach = true
      end
      --#endregion
      --#region Rilgar
    elseif RACLogic:has { ["Rilgar"] = 1 } then
      if RACLogic:lookup_has_any("Pack") then
        canReach = true
      end
      --#endregion
      --#region Umbris
    elseif RACLogic:has { ["Umbris"] = 1 } then
      if RACLogic:has { ["Swingshot"] = 1 } and
          RACLogic:lookup_has_any("Pack")
      then
        canReach = true
      end
      --#endregion
      --#region Orxon
    elseif RACLogic:has { ["Orxon"] = 1 } then
      if RACLogic:has { ["O2"] = 1 } and
          RACLogic:lookup_has_any("Pack")
      then
        canReach = true
      end
      --#endregion
      --#region Gaspar
    elseif RACLogic:has { ["Gaspar"] = 1 } then
      if RACLogic:lookup_has_any("Gaspar") then
        canReach = true
      end
      --#endregion
      --#region Gemlik
    elseif RACLogic:has { ["Gemlik"] = 1 } then
      if RACLogic:has_all { ["Tres"] = 1, ["Magne"] = 1, ["Swingshot"] = 1 } and
          RACLogic:has_any { ["Dev"] = 1, ["Visi"] = 1 }
      then
        canReach = true
      end
      --#endregion
      --#region Oltanis
    elseif RACLogic:has { ["Oltanis"] = 1 } then
      if RACLogic:has_any { ["Magne"] = 1, ["Swingshot"] = 1 } then
        canReach = true
      end
      --#endregion
      --#region Kalebo
    elseif RACLogic:has { ["Kalebo"] = 1 } then
      if RACLogic:has { ["Grind"] = 1 } or
          (
            RACLogic:lookup_has_any("Kalebo_switch") and
            RACLogic:lookup_has_any("Gaspar") -- Swingshot, Heli or Thruster
          ) then
        canReach = true
      end
      --#endregion
      --#region Fleet
    elseif RACLogic:has { ["Fleet"] = 1 } then
      if RACLogic:has { ["Hologuise"] = 1 } or
          RACLogic:has_all { ["O2"] = 1, ["Hydro"] = 1, }
      then
        canReach = true
      end
      --#endregion
      --#region Veldin
    elseif RACLogic:has { ["Veldin"] = 1 } then
      if RACLogic:lookup_has_all("Veldin") then -- List of items to reach the end of veldin
        canReach = true
      end
      --#endregion
    end
  end
  return canReach
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

---Updates any locations that are affected by the detected change
---
---**TODO**: *Create Update Function for items that callsback their parents to percolate updates*
---@param code string
function Update_Access(code)
  if CACHING then
    Cache = Cache + 1
    if Cache > 99999 then
      print("Cache explosion")
      Reset = true
      return
    end
    if Reset then
      Function_cache = {}
    end
    if Function_cache[code] then
      Function_cache[code] = _G[code]()
      print("Updated Access to: " .. code .. " -> " .. LookupAccess(Function_cache[code]))
    end
  end
end

---Caches the result of function calls
---@param name string
---@return integer
function Cached_Function(name)
  if CACHING then
    print("Cache lookup: " .. name)
    ---@type integer
    local f = Function_cache[name]
    if not f then
      print("----new cached item")
      f = _G[name]()
      Function_cache[name] = f
    end
    print("Access: " .. LookupAccess(f))
    return f
  end
  return _G[name]()
end

---@alias AccessName string
---| "None"
---| "Partial"
---| "Inspect"
---| "SequenceBreak"
---| "Normal"
---| "Cleared"

---Looks up the name of the value of the AccessibilityLevel enum
---@param num integer number value of the accessibility level to lookup
---@return AccessName
function LookupAccess(num)
  for key, value in pairs(AccessibilityLevel) do
    if value == num then
      return key
    end
  end
  return "ERROR"
end

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
  elseif code == "SP" then
    ScriptHost:RemoveWatchForCode("Skillpoint Setting")
    if object.CurrentStage == 0 then
      object.BadgeText = "Skillpoints Off"
      object.BadgeTextColor = "#A0A0A0"
    else
      object.BadgeText = "Skillpoints On"
      object.BadgeTextColor = "#FFFFFF"
    end
    ScriptHost:AddWatchForCode("Skillpoint Setting", "SP", Update_Setting)
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
