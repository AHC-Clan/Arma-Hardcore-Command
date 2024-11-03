_nState = _this select 0;

switch ( _nState ) do {
	case true:
	{
		sleep 0.5;

		player allowDamage false;
		SafeZoneFireEvent = player addEventHandler ["Fired", {
			params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];    
			
			_Firetext = "";

			switch (currentWeaponMode player) do {
				case "FullAuto": { [player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety; _Firetext = "풀오토"; };
				case "Burst": { player action ["SWITCHWEAPON", player,player, 0];[player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety; _Firetext = "3점사"; };
			};

			if ( _Firetext != "") then 
			{
				systemChat format["이곳에서는 '%1'로 사격할 수 없습니다!", _Firetext];
				[[player, "ph_high_ready"],"playActionNow"] call BIS_fnc_MP;
			};
		}];
	};
	case false:
	{
		player allowDamage true;
		player removeEventHandler["Fired", SafeZoneFireEvent];
	};
};