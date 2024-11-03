// 2018-10-21 패치
// [name player, 1] execVM ".sqf";
_sName = _this select 0;
_nAddCount = _this select 1;
_nResult = 0;

_bCheck = [_sName] call compile preprocessFile "PHPlayerStatus\PH_PlayerIdChecker.sqf";
if ( not _bCheck ) exitWith{ };

[_sName, 1, _nAddCount] call compile preprocessFile "PHPlayerStatus\PH_AddCount.sqf";