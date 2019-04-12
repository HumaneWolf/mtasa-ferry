function onClientLoad(resource)
    setObjectBreakable(getElementByID("FERRY_GATE_W_EXIT"), false)
    setObjectBreakable(getElementByID("FERRY_GATE_W_ENTRY"), false)
    setObjectBreakable(getElementByID("FERRY_GATE_E_ENTRY_1"), false)
    setObjectBreakable(getElementByID("FERRY_GATE_E_ENTRY_2"), false)
    setObjectBreakable(getElementByID("FERRY_GATE_E_EXIT_1"), false)
    setObjectBreakable(getElementByID("FERRY_GATE_E_EXIT_2"), false)
end
addEventHandler("onClientResourceStart", root, onClientLoad)
