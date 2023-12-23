if BarricadedWorld == nil then BarricadedWorld = {} end

function BarricadedWorld.setProtection(isoObject, value)
    local modData = isoObject:getModData()
    modData["BarricadedWorld:isPlayerPlaced"] = value
    isoObject:transmitModData()
end

function BarricadedWorld.contextMenuOptions(player, context, worldobjects)
    local playerObj = getSpecificPlayer(player)
    local tileIsoObject = nil
    for _, v in ipairs(worldobjects) do
        if instanceof(v, "IsoDoor") then     
            tileIsoObject = v;
        elseif instanceof(v, "IsoWindow") then
            tileIsoObject = v;
        end
    end
    -- Protect from erosion
    if tileIsoObject then
        local modData = tileIsoObject:getModData()
        if modData["BarricadedWorld:isPlayerPlaced"] then
            context:addOption("Enlever la protection contre la corrosion", tileIsoObject, BarricadedWorld.setProtection, false)
        else
            context:addOption("Mettre en place la protection contre la corrosion", tileIsoObject, BarricadedWorld.setProtection, true)
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(BarricadedWorld.contextMenuOptions);
