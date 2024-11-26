addMissionEventHandler ["Ended", 
{
    params ["_endType"];

    switch (_endType) do
    {
        case "end1": {
            // WIN 카운트
            ["AHC_GameWinCount"] call compile preprocessFileLineNumbers "PHDatabase\PH_AddCount.sqf";
        };
        case "lose": {
            // Lose 카운트
            ["AHC_GameLoseCount"] call compile preprocessFileLineNumbers "PHDatabase\PH_AddCount.sqf";        
        };
    };

    missionNamespace setVariable["AHC_MissionEnd", true];  
    _playerData = [getPlayerUID player, name player];
    [_playerData] remoteExec ["savePlayerData", 2];
}];