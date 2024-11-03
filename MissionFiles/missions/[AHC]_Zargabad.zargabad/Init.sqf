// 미션이 처음 시작되면 호출됩니다.

if (!isDedicated) then
{
	if (hasInterface) then 
	{
        [] call {
			[] execVM "PHLogic\PH_InitMission.sqf";
            sleep 1;
            cutText ["", "BLACK", 0.01];
            sleep 0.3;
            [] execVM "PHLogic\PH_Loading.sqf";
        };
    };
};