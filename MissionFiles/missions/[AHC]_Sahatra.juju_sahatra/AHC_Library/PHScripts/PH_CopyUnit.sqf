_pUnit = _this select 0;

_pUnit allowDamage false;
_pUnit setFace "GreekHead_A3_13";

_pUnit disableAI "ANIM";
[_pUnit, "InBaseMoves_HandsBehindBack1"] remoteExec ["switchMove", 0];

_pUnit addEventHandler [ "AnimDone", {
	params[ "_unit", "_anim" ];
	
	if ( _anim == "HubStanding_idle3" ) then 
	{
		_unit switchMove "HubStanding_idle3";
	};
	if ( _anim == "InBaseMoves_HandsBehindBack1") Then 
	{
		_unit switchMove "InBaseMoves_HandsBehindBack1";
	};
}];

_pUnit addAction["<t color='#FE2E2E'><t size='1.4'>샘플 등록</t></t>",{[_this select 3, 0] execVM "AHC_Library\PHScripts\PH_Copy.sqf";}, _pUnit]; 
_pUnit addAction["<t color='#31B404'><t size='1.4'>샘플 착용</t></t>",{[_this select 3, 1] execVM "AHC_Library\PHScripts\PH_Copy.sqf";}, _pUnit]; 
_pUnit addAction["<t color='#848484'><t size='1.4'>샘플 초기화</t></t>",{[_this select 3, 2] execVM "AHC_Library\PHScripts\PH_Copy.sqf";}, _pUnit];