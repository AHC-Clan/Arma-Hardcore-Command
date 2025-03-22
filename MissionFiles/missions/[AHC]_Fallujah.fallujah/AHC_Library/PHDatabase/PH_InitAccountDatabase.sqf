// 2024-11-17 Patch
// 나의 AHC 계정 정보를 확인합니다.

if (isClass (configFile >> "CfgPatches" >> "ace_main")) then 
{
	_action = ["AHC","AHC 클랜","", {},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;
	
	_action = ["AHC_Account","내 클랜 활동 보기","",{execVM "AHC_Library\PHDatabase\PH_DialogAccount.sqf"},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "AHC"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["AHC_CopyID","(유틸) 내 정보 복사","",{ [name player] execVM "AHC_Library\PHDatabase\PH_GetUID.sqf"},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "AHC"], _action] call ace_interact_menu_fnc_addActionToObject;
};