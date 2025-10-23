local towns = {
   { name = "Valentine",   coords = vector3(-303.7371, 790.1096, 117.9256) },
   { name = "Rhodes",      coords = vector3(1328.0349, -1305.6835, 76.4965) },
   { name = "Saint Denis", coords = vector3(2577.8716, -1203.7582, 53.9307) },
   { name = "Blackwater",  coords = vector3(-799.7812, -1312.3982, 43.5576) },
   { name = "Van Horn",    coords = vector3(2961.6873, 533.8214, 44.2691) },
   { name = "Annesburg",   coords = vector3(2936.2922, 1351.4191, 43.9731) },
   { name = "Armadillo",   coords = vector3(-3668.4722, -2611.1152, -14.0843) },
   { name = "Tumbleweed",  coords = vector3(-5513.7842, -2936.2283, -2.1639) },
   { name = "Snow Town",   coords = vector3(-1341.3125, 2430.0481, 307.6642) },
   { name = "Strawberry",  coords = vector3(-1793.1526, -370.8012, 160.3479) },
   { name = "Wapiti",      coords = vector3(454.8392, 2235.6143, 247.6681) }
}

local function distance2D(a, b)
  local dx = a.x - b.x
  local dy = a.y - b.y
  return math.sqrt(dx*dx + dy*dy)
end

local function findNearestTown(playerCoords)
  if #towns == 0 then return nil, nil end
  local bestName, bestCoords, bestDist
  for i = 1, #towns do
    local d = distance2D(playerCoords, towns[i].coords)
    if not bestDist or d < bestDist then
      bestDist  = d
      bestName  = towns[i].name
      bestCoords = towns[i].coords
    end
  end
  return bestName, bestCoords, bestDist
end

local function notifySimple(_, text)
  TriggerEvent("vorp:TipRight", text, 4000)
end

local function _wait(ms)
  if Wait then Wait(ms) else Citizen.Wait(ms) end
end

local function setWaypointTo(coords, label)
  label = label or "Target"

  if ClearGpsMultiRoute then ClearGpsMultiRoute() end
  if SetGpsMultiRouteRender then SetGpsMultiRouteRender(false) end
  if SetWaypointOff then SetWaypointOff() end
  _wait(100)

  if SetNewWaypoint then
    SetNewWaypoint(coords.x + 0.0, coords.y + 0.0)
  end

  if StartGpsMultiRoute and AddPointToGpsMultiRoute and SetGpsMultiRouteRender then
    StartGpsMultiRoute(6, true, true)
    AddPointToGpsMultiRoute(coords.x + 0.0, coords.y + 0.0, coords.z + 0.0)
    SetGpsMultiRouteRender(true)
  end

  TriggerEvent("chat:addMessage", {
    args = { "^2Route", ("→ %s"):format(label) }
  })

  Citizen.CreateThread(function()
    local active = true
    while active do
      _wait(0)
      local p = GetEntityCoords(PlayerPedId())
      local dx, dy, dz = (p.x - coords.x), (p.y - coords.y), (p.z - coords.z)
      local dist = math.sqrt(dx*dx + dy*dy + dz*dz)

      local playerSetWp = IsWaypointActive and IsWaypointActive()
      if dist < 5.0 or playerSetWp then
        active = false
        if ClearGpsMultiRoute then ClearGpsMultiRoute() end
        if SetGpsMultiRouteRender then SetGpsMultiRouteRender(false) end
      end
    end
  end)
end

RegisterCommand("nearesttown", function()
  local ped     = PlayerPedId()
  local pcoords = GetEntityCoords(ped)

  if #towns == 0 then
    notifySimple("Warning", "Town list is empty. Fill the towns table!")
    return
  end

  local name, coords, dist = findNearestTown(pcoords)
  if not name then
    notifySimple("Error", "No nearby town found.")
    return
  end

  if dist > 2000.0 then
    notifySimple("Info", "There doesn't seem to be a nearby town.")
    return
  end

  setWaypointTo(coords, name)
  notifySimple("Nearest Town", string.format("%s (%.1f m)", name, dist))
end)

RegisterNetEvent("nearest_town:open")
AddEventHandler("nearest_town:open", function()
  ExecuteCommand("nearesttown")
end)
