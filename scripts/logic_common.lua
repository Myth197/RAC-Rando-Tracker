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

local Vendors = {
  ['@Vendor/Novalis Vendor'] = "Novalis_v",
  ['@Vendor/Kerwan Vendor'] = "Kerwan_v",
  ['@Vendor/Eudora Vendor'] = "Eudora_v",
  ['@Vendor/Blarg Vendor'] = "Blarg_v",
  ['@Vendor/Rilgar Vendor'] = "Rilgar_v",
  ['@Vendor/Batalia Vendor'] = "Batalia_v",
  ['@Vendor/Orxon Vendor'] = "Orxon_v",
  ['@Vendor/Gaspar Vendor'] = "Gaspar_v",
  ['@Vendor/Poki Vendor'] = "Poki_v",
  ['@Vendor/Hoven Vendor'] = "Hoven_v",
  ['@Vendor/Oltanis Vendor'] = "Oltanis_v",
}

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

local previous_code = ""
local depth = 0

function Vendor_activate(code)
  depth = depth + 1
  for location, item in pairs(Vendors) do
    local trip = 0
    if Tracker:FindObjectForCode(location).AccessibilityLevel == AccessibilityLevel.Normal and Vendor_flags[item] == 0 then
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
    elseif Tracker:FindObjectForCode(location).AccessibilityLevel < AccessibilityLevel.Normal and Vendor_flags[item] == 1 then
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
    elseif Tracker:FindObjectForCode(location).AccessibilityLevel < AccessibilityLevel.Normal and Vendor_flags[item] == 2 then
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

function Vendor_clear(code)
  for location, item in pairs(Vendors) do
    if code == item then
      Tracker:FindObjectForCode(code).CurrentStage = 2
    end
  end
end

function Highlight(loc, priority)
  Tracker:FindObjectForCode(loc).Highlight = priority
  -- example
  -- Tracker:FindObjectForCode("@Explore as Ratchet/Infobot").Highlight = Highlight.Priority
end
