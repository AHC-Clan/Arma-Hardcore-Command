// 2018-10-21 패치
// 2024-11-03 리팩토링
// InitPlayerLocal.sqf 에 둘것

// ID, 발사, 리스폰, 적사살, 시민사살, 헤드샷
pPlayerInfo = [name player, 0, 0, 0, 0, 0, 0];
missionNamespace setVariable[name player, pPlayerInfo];
publicVariable name player;

// 이벤트 핸들러 추가
player addEventHandler ["Respawn", {	
	private _pRespawn = _this select 0;
	[name _pRespawn, 1] execVM "PHPlayerStatus\EventCallback\addRespawn.sqf";	
}];

player addEventHandler ["Fired", {
	private _pName = _this select 0;
	[name _pName, 1] execVM "PHPlayerStatus\EventCallback\addKill.sqf";	
}];

// CBA 키바인딩
if (isClass (configFile >> "CfgPatches" >> "cba_main")) then 
{
	["AHC 상태창", "AHC_Status_View", ["AHC 상태창 보기", "상태창 열어봅니다."], { }, { []execVM "PHPlayerStatus\PH_StatusDialog.sqf"; }, [43, [false, true, false]]] call cba_fnc_addKeybind;
};

// ACE 셀프 인터렉션
if (isClass (configFile >> "CfgPatches" >> "ace_main")) then 
{
	_action = ["AHCStatus","AHC 상태창 보기","",{execVM "PHPlayerStatus\PH_StatusDialog.sqf"},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

// 이벤트 호출 관련 내용은 아래
// https://community.bistudio.com/wiki/Arma_2:_Event_Handlers#HitPart
while { true } do
{
	{
		// 적 사살 및 헤드샷 체크
		 if (side _x in [east, sideEnemy]) then 
		{
			_x addEventHandler ["HitPart", {
				_target = _this select 0 select 0;
				_shooter = _this select 0 select 1;

				if ( "head" in (_this select 0 select 5)) then
				{	
					// 사망하더라도 쏘면 카운트가 올라가서 살아있는지 확인해야함.
					if ( name _shooter == name player && alive _target) then 
					{				
						[name _shooter, 1] execVM "PHPlayerStatus\EventCallback\addHeadshot.sqf";
					};
				};
				
			}];

			_x addEventHandler  ["killed", 
			{
				_man = _this select 0;
				_killer = _this select 1;

				if ( name _killer == name player) then 
				{
					[name player, 1] execVM "PHPlayerStatus\EventCallback\addEnemyKill.sqf";
				};
			}];
		};
	
		// 시민 사살 체크
		if ( side _x == civilian ) then 
		{
			_x addEventHandler  ["killed", 
			{
				_killer = _this select 1;

				if ( name _killer == name player) then 
				{
					[name player, 1] execVM "PHPlayerStatus\EventCallback\addCityKill.sqf";
				};
			}];
		};
		
		// 아군 사살 체크
		if ( side _x == west ) then 
		{
			_x addEventHandler  ["killed", 
			{
				_man = _this select 0;
				_killer = _this select 1;

				if (name _man != name _killer && {name _killer == name player}) then
				{
					[name player, 1] execVM "PHPlayerStatus\EventCallback\addFriendlyKill.sqf";
				};
			}];
		};
	} forEach allUnits;

	sleep 3;

	{
		_x removeAllEventHandlers "HitPart";
		_x removeAllEventHandlers "killed";
	}forEach allUnits;
};