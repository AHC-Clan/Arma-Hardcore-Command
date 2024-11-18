// 2018-10-21 패치
// 2024-11-03 리팩토링
// InitPlayerLocal.sqf 에 둘것

// ID, 발사, 리스폰, 적사살, 시민사살, 헤드샷
// pPlayerInfo = [name player, 0, 0, 0, 0, 0, 0];
// missionNamespace setVariable[name player, pPlayerInfo];
// publicVariable name player;

// CBA 키바인딩
// if (isClass (configFile >> "CfgPatches" >> "cba_main")) then 
// {
// 	["AHC 설정창", "AHC_Status_View", ["AHC 현재 미션 전적", "내 전적을 열어봅니다."], { }, { []execVM "PHPlayerStatus\PH_StatusDialog.sqf"; }, [43, [false, true, false]]] call cba_fnc_addKeybind;
// };

// ACE 셀프 인터렉션
// if (isClass (configFile >> "CfgPatches" >> "ace_main")) then 
// {
// 	_action = ["AHC","AHC 클랜","", {},{true}] call ace_interact_menu_fnc_createAction;
// 	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	//_action = ["AHC_Status","현재 미션 전적 보기","",{execVM "PHPlayerStatus\PH_StatusDialog.sqf"},{true}] call ace_interact_menu_fnc_createAction;
	//[player, 1, ["ACE_SelfActions", "AHC"], _action] call ace_interact_menu_fnc_addActionToObject;
// };
	
player addEventHandler ["MagazineReloading", 
{
	params ["_unit", "_weapon", "_muzzle", "_magazine"];

	if ( name _unit == name player ) then
	{
		[_weapon] call compile preprocessFileLineNumbers "PHDatabase\PH_ReloadWeapon.sqf";
	};
}];

// 새로운 유닛이 생성될 때마다 이벤트 핸들러 추가
addMissionEventHandler ["EntityCreated", {
    params ["_newUnit"];

 	if (!(_newUnit isKindOf "CAManBase")) exitWith {};

    // 위와 동일한 이벤트 핸들러 추가
    private _unit = _newUnit;
	
	if (!(_unit getVariable ["hasEventHandlers", false])) then 
    {
        _unit setVariable ["hasEventHandlers", true];

		_unit addEventHandler ["HitPart", {
			_target = _this select 0 select 0;
			_shooter = _this select 0 select 1;
			_hitPoint = _this select 0 select 5;

			// 헤드샷 카운트
			if ( "head" in _hitPoint && alive _target) then
			{
				if (name _shooter == name player && side group _target in [east, sideEnemy]) then
				{
					if (!(_target getVariable ["headshotCounted", false])) then
					{
						_target setVariable ["headshotCounted", true];
						["AHC_KillHeadShotCount"] call compile preprocessFileLineNumbers "PHDatabase\PH_AddCount.sqf";
					};				
				};
			};		
		}];

		_unit addEventHandler ["killed", {
			params ["_man", "_killer"];
		
			// 플레이어가 AI를 사살했을 때
			if (name _killer == name player) then
			{
				// 적군이면
				if (side group _man in [east, sideEnemy]) then 
				{
					["AHC_KillCount"] call compile preprocessFileLineNumbers "PHDatabase\PH_AddCount.sqf";            
				};

				// 시민이면
				if (side group _man == civilian) then
				{
					["AHC_KillCivilianCount"] call compile preprocessFileLineNumbers "PHDatabase\PH_AddCount.sqf";            
				};
			};

			// AI가 플레이어를 사살했을 때
			if (name _man == name player) then 
			{
				// 공격한 유닛이 AI인지 확인
				if (!isPlayer _killer && side group _killer in [east, sideEnemy]) then 
				{
    				[format ["%1 님이 사망했습니다.", name _man]] remoteExec ["systemChat", 0];
					["AHC_RespawnCount"] call compile preprocessFileLineNumbers "PHDatabase\PH_AddCount.sqf";            
				};
			};
		}];
	};
}];