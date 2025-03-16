// AHC
[] execVM "initPlayerLocalKillHouse.sqf";

waitUntil 
{
    !isNull player && player == player && alive player
};

missionNamespace setVariable["AHC_MissionEnd", false];

if (!hasInterface || isDedicated) exitWith { };

_blackScreenLoop = true;
while { _blackScreenLoop } do
{
    if ( time > 4 ) exitWith
    {
        _blackScreenLoop = false;
    };

    cutText [localize "STR_MISSION_LOAD", "BLACK", 0.001];
    
    sleep 0.1;
};

// 디브리핑 세팅
[] spawn compile preprocessFileLineNumbers "AHC_Library\PHLogic\PH_Debriefing.sqf";

// AHC 로딩
sleep 0.3;

[] spawn compile preprocessFileLineNumbers "AHC_Library\PHLogic\PH_Loading.sqf";

