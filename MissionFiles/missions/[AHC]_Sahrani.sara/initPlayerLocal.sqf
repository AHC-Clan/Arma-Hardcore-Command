
waitUntil 
{
    !isNull player && player == player && alive player
};

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


// AHC 로딩
sleep 1;
[] spawn compile preprocessFileLineNumbers "PHLogic\PH_Loading.sqf";


// AHC 상태창
sleep 1;
[] execVM "PHPlayerStatus\PH_InitStatusPlayerLocal.sqf";