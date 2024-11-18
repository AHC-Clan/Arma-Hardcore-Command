[] spawn {
    waitUntil {sleep 1; !isNull findDisplay 46};
    player addEventHandler ["Killed", {tsp_loadout_retain = getUnitLoadout player}];
    while {sleep 1; true} do {
        1 fadeEnvironment (if (player inArea zone_inside_1 || player inArea zone_inside_2) then {0.25} else {1});
        player setCaptive (player inArea zone_captive);  //-- Captive on the catwalk
    };
};