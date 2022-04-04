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