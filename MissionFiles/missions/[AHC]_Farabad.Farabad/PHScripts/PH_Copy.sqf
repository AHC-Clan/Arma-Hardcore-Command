// 2018-12-02 Patch
// AHC Unit Sample Script

_pUnit = _this select 0;
_pType = _this select 1;

fnc_Paste = {
	_pPlayerf = _this select 0;	
	_pUnitf = _this select 1;
		
	if ( uniform _pPlayerf != "") Then
	{
		 _pUnitf forceAddUniform uniform _pPlayerf;
	}
	else
	{ 
		removeUniform _pUnitf; 
	};


	if ( vest _pPlayerf != "" ) then
	{
		_pUnitf addVest vest _pPlayerf;
	}
	else
	{
		removeVest _pUnitf;
	};

	if ( backpack _pPlayerf != "" ) then
	{ 
		_pUnitf addBackpackGlobal  backpack _pPlayerf;
	};
	clearAllItemsFromBackpack _pUnitf;

	sleep 0.1;

	removeHeadgear _pUnitf;
	if ( headgear _pPlayerf != "" ) then{ _pUnitf addHeadgear headgear _pPlayerf; };

 	removeGoggles _pUnitf;
	if ( goggles _pPlayerf != "" ) then{ _pUnitf addGoggles goggles _pPlayerf;};

	sleep 0.1;

	_pUnitf removeWeaponGlobal primaryWeapon _pUnitf;
	if ( primaryWeapon _pPlayerf != "" ) then{ _pUnitf addWeaponGlobal primaryWeapon _pPlayerf; };
	{
		_pUnitf addPrimaryWeaponItem _x;
	}forEach primaryWeaponItems _pPlayerf;
 
	sleep 0.1;

	_pUnitf removeWeaponGlobal handgunWeapon _pUnitf;
	if ( handgunWeapon  _pPlayerf != "" ) then{ _pUnitf addWeaponGlobal handgunWeapon _pPlayerf; };
	{
		_pUnitf addHandgunItem   _x;
	}forEach handgunItems   _pPlayerf;

	sleep 0.1;
	
	if ( hmd _pPlayerf != "" ) then { _pUnitf addWeaponGlobal hmd _pPlayerf;};

	//_pUnitf addItemToUniform "ACE_EarPlugs";

	if ( _pUnitf != player) then
	{
		if ( primaryWeapon _pPlayerf == "") then{ [_pUnitf, "InBaseMoves_HandsBehindBack1"] remoteExec ["switchMove", 0];  }else{[_pUnitf, "HubStanding_idle3"] remoteExec ["switchMove", 0]; };
	};
};

fnc_ClearForm = {
	_pUnitf = _this select 0;

	removeAllWeapons _pUnitf;
	removeAllItems _pUnitf;
	removeAllAssignedItems _pUnitf;
	removeUniform _pUnitf;
	removeVest _pUnitf;
	removeBackpack _pUnitf;
	removeHeadgear _pUnitf;
	removeGoggles _pUnitf;
	
	[_pUnitf, "InBaseMoves_HandsBehindBack1"] remoteExec ["switchMove", 0];
};

missionNamespace setVariable["_pUnit", _pUnit];

switch (_pType) do {
	case 0: { 	
		if ( uniform (missionNamespace getVariable "_pUnit") != "") then {
			systemChat format["샘플 등록 | 샘플 지정자 : [%1]", name player];
		}else{
			systemChat "샘플 등록";
		};

		[missionNamespace getVariable "_pUnit"] spawn fnc_ClearForm; 
		sleep 0.15;
		[player, missionNamespace getVariable "_pUnit"] spawn fnc_Paste;
	};
	case 1: { 	
		if ( uniform (missionNamespace getVariable "_pUnit") != "") then {
			systemChat format["샘플 등록 | 샘플 지정자 : [%1]", name player];
		}else{
			systemChat "샘플 착용";
		};
		
		[missionNamespace getVariable "_pUnit", player] spawn fnc_Paste;
	};
	case 2: { 	
		if ( uniform (missionNamespace getVariable "_pUnit") != "") then {
			systemChat format["샘플 등록 | 샘플 지정자 : [%1]", name player];
		}else{
			systemChat "샘플 초기화";
		};

		[missionNamespace getVariable "_pUnit"] spawn fnc_ClearForm;
	};
	default { };
};