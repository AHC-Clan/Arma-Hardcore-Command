// 2024-11-21 Patch
// AHC 유틸리티 메뉴

if (isClass (configFile >> "CfgPatches" >> "ace_main")) then 
{
	_action = ["AHC_Utils","유틸리티2","",{systemChat"asd"},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "AHC"], _action] call ace_interact_menu_fnc_addActionToObject;

    _action = ["AHC_CopyID","내 정보 복사","",{ [name player] execVM "PHDatabase\PH_GetUID.sqf"},{true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions", "AHC_Utils"], _action] call ace_interact_menu_fnc_addActionToObject;
}