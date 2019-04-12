-- Lights
local westLight = createMarker(-1213.2, 2683.2, 50.6, "corona", 1, 255, 0, 0, 255)
setElementID(westLight, "FERRY_WEST_LIGHT")
local eastLight = createMarker( -949.40002, 2722, 51.2 , "corona", 1, 255, 0, 0, 255)
setElementID(eastLight, "FERRY_EAST_LIGHT")

-- Payment markers
local payEast = createMarker(-957.90002441406, 2722, 46.2, "cylinder", 2, 135, 170, 84, 150)
setElementID(payEast, "FERRY_PAYMENT_EAST")
local payWest = createMarker(-1208.4000244141, 2683.3999023438, 46, "cylinder", 2, 135, 170, 84, 150)
setElementID(payWest, "FERRY_PAYMENT_WEST")

-- Chat area
local area = createColCuboid(-1282.8984375, 2593.7902832031, 0, 400, 200, 150)
setElementID(area, "FERRY_CHAT_AREA")

-- Creating gates
local gate = createObject(3036, -1212.4004, 2690.7998, 47, 0, 0, 279.488)
setElementID(gate, "FERRY_GATE_W_EXIT")

gate = createObject(3036, -1210.9004, 2680.6006, 47, 0, 0, 96.486)
setElementID(gate, "FERRY_GATE_W_ENTRY")

gate = createObject(3036, -955.09961, 2726.7998, 46.8, 0, 0, 273.995)
setElementID(gate, "FERRY_GATE_E_ENTRY_1")
gate = createObject(3036, -954.2002, 2717.7002, 46.8, 0, 0, 97.995)
setElementID(gate, "FERRY_GATE_E_ENTRY_2")

gate = createObject(3036, -954.40039, 2717.1006, 46.8, 0, 0, 268.246)
setElementID(gate, "FERRY_GATE_E_EXIT_1")
gate = createObject(3036, -953.59961, 2708.1006, 46.8, 0, 0, 99.991)
setElementID(gate, "FERRY_GATE_E_EXIT_2")

-- Create ferry base
local base = createObject(3115, -1151.1, 2688.3, 44.5, 0, 0, 180)
setElementID(base, "FERRY_BASE")

local ferryPart = createObject(3115, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -21, 0, -0.005, 0, 0, 180)

-- ColSpheres
local colWest = createColSphere(0, 0, 0, 15)
setElementID(colWest, "FERRY_COL_WEST")
attachElements(colWest, base)

local colEast = createColSphere(0, 0, 0, 15)
setElementID(colEast, "FERRY_COL_EAST")
attachElements(colEast, ferryPart)

-- Walls
ferryPart = createObject(3114, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -21, -9.805, 1, 90, 0, 180)

ferryPart = createObject(3114, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, 0, -9.8, 1, 90, 0, 180)

ferryPart = createObject(3114, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, 0, 9.8, 1, 90, 0, 0)

ferryPart = createObject(3114, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -21, 9.8, 1, 90, 0, 0)

ferryPart = createObject(3115, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, 9.9, 0, -10.5, 0, 265, 180)

ferryPart = createObject(3115, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -30.9, 0, -10.5, 0, 265, 0)

-- Bridge
ferryPart = createObject(3115, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -10.5, 0, 6.5, 0, 0, 0)

ferryPart = createObject(16096, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -17.6, 0, 8.7, 0, 0, 90)

ferryPart = createObject(16096, -1151.1, 2688.3, 44.5, 0, 0, 0)
attachElements(ferryPart, base, -3.7, 0, 8.7, 0, 0, 270)


-- Start the script
function onResourceStart(resource)
    moveObject(base, 30000, -1014.7, 2711, 44.5, 0, 0, 6, "InOutQuad")
    setTimer(unloadEast, 30000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceStart)


-- Take money from player.
function onPlayerPayment(hitElement, matchingDimension)
    if (getElementType(hitElement) == "vehicle") then
        local driver = getVehicleOccupant(hitElement)
        if (driver ~= false) then
            takePlayerMoney(driver, 25)
            outputChatBox("#00FFFFFERRY:#E7D9B0 You have been charged $25 for the ferry.", player, 231, 217, 176, true)
        end
    end
end
addEventHandler("onMarkerHit", payEast, onPlayerPayment)
addEventHandler("onMarkerHit", payWest, onPlayerPayment)


-- Print to users in ferry area
function printToArea(message)
    local area = getElementByID("FERRY_CHAT_AREA")
    local players = getElementsWithinColShape(area, "player")
    for key,player in ipairs(players) do
        outputChatBox(message, player, 231, 217, 176, true)
    end
end


-- Attach all users to the ferry
function stickUsers()
end

-- Unattach all users from the ferry.
function unstickUsers()
end


-- Rotate a gate object with the given ID the given amount of degrees.
function rotateGate(gateId, degrees)
    local gate = getElementByID(gateId)
    local x,y,z = getElementPosition(gate)
    moveObject(gate, 1200, x, y, z, 0, 0, degrees, easing)
end

--
-- MOVEMENT CYCLE
--

-- Prepare unloading of ferry on west side.
function unloadWest()
    printToArea("#00FFFFFERRY:#E7D9B0 Prepare to disembark the ferry.")
    rotateGate("FERRY_GATE_W_EXIT", 85)
    setTimer(loadWest, 10000, 1)
end

-- Prepare loading of ferry on west side
function loadWest()
    printToArea("#00FFFFFERRY:#E7D9B0 Prepare to embark the ferry.")
    rotateGate("FERRY_GATE_W_ENTRY", -85)
    setMarkerColor(getElementByID("FERRY_WEST_LIGHT"), 0, 255, 0, 255)
    setTimer(closeWest, 10000, 1)
end

-- Prepare departure from west side
function closeWest()
    printToArea("#00FFFFFERRY:#E7D9B0 The ferry is departing.")
    setMarkerColor(getElementByID("FERRY_WEST_LIGHT"), 255, 0, 0, 255)
    rotateGate("FERRY_GATE_W_EXIT", -80)
    rotateGate("FERRY_GATE_W_ENTRY", 80)
    setTimer(moveEast, 2000, 1)
end

-- Move to the east.
function moveEast()
    moveObject(base, 30000, -1014.7, 2711, 44.5, 0, 0, 0, "InOutQuad")
    setTimer(unloadEast, 30000, 1)
end

-- Prepare unloading of ferry on east side.
function unloadEast()
    printToArea("#00FFFFFERRY:#E7D9B0 Prepare to disembark the ferry.")
    rotateGate("FERRY_GATE_E_EXIT_1", -80)
    rotateGate("FERRY_GATE_E_EXIT_2", 80)
    setTimer(loadEast, 10000, 1)
end

-- Prepare loading of ferry on east side.
function loadEast()
    printToArea("#00FFFFFERRY:#E7D9B0 Prepare to embark the ferry.")
    rotateGate("FERRY_GATE_E_ENTRY_1", -80)
    rotateGate("FERRY_GATE_E_ENTRY_2", 80)
    setMarkerColor(getElementByID("FERRY_EAST_LIGHT"), 0, 255, 0, 255)
    setTimer(closeEast, 10000, 1)
end

-- Prepare departure from east side.
function closeEast()
    printToArea("#00FFFFFERRY:#E7D9B0 The ferry is departing.")
    setMarkerColor(getElementByID("FERRY_EAST_LIGHT"), 255, 0, 0, 255)
    rotateGate("FERRY_GATE_E_EXIT_1", 80)
    rotateGate("FERRY_GATE_E_EXIT_2", -80)
    rotateGate("FERRY_GATE_E_ENTRY_1", 80)
    rotateGate("FERRY_GATE_E_ENTRY_2", -80)
    setTimer(moveWest, 2000, 1)
end

-- Move to the west side.
function moveWest()
    moveObject(base, 30000, -1173.6, 2691.9, 44.5, 0, 0, 0, "InOutQuad")
    setTimer(unloadWest, 30000, 1)
end