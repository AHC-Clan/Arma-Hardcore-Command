//# 2017-12-25 패치
//# 아스날
//# 사용법 : [this] execVM "PH_Arsnal.sqf";

private _obj = _this select 0;

_obj allowDamage false; 
[_obj, true, true] call ace_arsenal_fnc_initBox; // ACE 아스날 초기화

_obj addAction ["<t color='#FFFF00'><t size='1.5'>장비 세팅</t></t>", {[player, player, true] call ace_arsenal_fnc_openBox;},nil,4]; 
// _obj addAction ["<t color='#FFFF00'><t size='1.5'>장비 세팅 [바닐라]</t></t>", {["Open",true] spawn BIS_fnc_arsenal;},nil,5]; 

[_obj, "<t color='#8A0808'><t size='1.4'>완전 치료</t></t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa", "true", "true", {}, {}, 
{ 
    if (!isNil "ACE_medical_fnc_treatmentAdvanced_fullHeal") then {[player, player] call ACE_medical_fnc_treatmentAdvanced_fullHeal};
    if (!isNil "ACE_medical_treatment_fullHealLocal") then {[player, player] call ACE_medical_treatment_fullHealLocal};
    if (!isNil "ace_medical_treatment_fnc_fullHeal") then {[player, player] call ace_medical_treatment_fnc_fullHeal};
    systemChat "완전 치료 되었습니다!"; 
}, { }, [], 1, 3, false, true] call BIS_fnc_holdActionAdd;

// [_obj, "<t color='#BDBDBD'>모든 착용장비 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { removeAllWeapons player; removeAllItems player; removeUniform player;   removeHeadgear player; removeVest player; removeBackpack player; removeGoggles player; removeallassigneditems player; hint "모든 착용장비가 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;
// [_obj, "<t color='#8C8C8C'>무기 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { removeAllWeapons player; hint "무기가 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;
// [_obj, "<t color='#8C8C8C'>아이템 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { removeAllItems player; hint "기타 아이템들이 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;
// [_obj, "<t color='#8C8C8C'>유니폼 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { removeUniform player; hint "유니폼이 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;
// [_obj, "<t color='#8C8C8C'>방탄복 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { removeVest player; hint "방탄복이 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;
// [_obj, "<t color='#8C8C8C'>가방 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { removeBackpack player; hint "가방이 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;
// [_obj, "<t color='#FFBB00'>가방 내용물 삭제</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, { clearAllItemsFromBackpack player; hint "가방내용물이 정리되었습니다."; }, { }, [], 0.5, 0.5, false, true] call BIS_fnc_holdActionAdd;

clearItemCargo _obj; 
clearBackpackCargo _obj;
ClearWeaponCargo _obj;
ClearMagazineCargo _obj;