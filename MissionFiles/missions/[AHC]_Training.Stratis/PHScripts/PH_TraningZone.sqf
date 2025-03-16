_obj = _this select 0;
_entryIndex = _this select 1;

PH_MOVE = {
	_tel = _this select 0;
	
	titleCut ["", "BLACK FADED"];
	[  [["이동하는 중","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],  
	["","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"]]  
	] spawn BIS_fnc_typeText; 

	player setPosASL(getPosASL(_tel));
	
	sleep 0.1; 
	titleCut ["", "BLACK IN", 2];	
};

[_obj, "<t color='#d58d00'>카미노 사격장</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [au_respawn] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#4acc16'>공군기지 비행장</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_area4] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#60994a'>다목적 사격장</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_area2] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#60994a'>MOUT 교장</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_area3] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#60994a'>CQC 교장</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_area5] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#555555'>----------</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
}, { }, [], 99, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#a57d2e'>사격장1</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_range1] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#a57d2e'>사격장2</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_range2] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#a57d2e'>사격장3</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_range3] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#a57d2e'>다목적 공간</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [ph_range4] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#555555'>----------</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
}, { }, [], 99, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#3989eb'>항공모함</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [au_brifing3] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;

[_obj, "<t color='#3989eb'>구축함</t>", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa", "true", "true", {}, {}, 
{
    [au_brifing2] spawn PH_Move;
}, { }, [], 0.3, 0, false, true] call BIS_fnc_holdActionAdd;