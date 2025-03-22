// 2024-11-17 Patch
// 재장전이 많은 무기

params["_weaponKey"];

if ( isNil "_weaponKey") exitWith
{
    systemChat "총기 키를 알 수 없음";
};

_playerUID  = getPlayerUID player;
_reloadkey = format["AHC_MagazineReloading_%1", _playerUID];

_currentReloadData = [_reloadkey, []] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";
if ( typeName _currentReloadData != "ARRAY") then
{
    _currentReloadData = [];
};

_reloadCount = if (_currentReloadData findIf { _x select 0 == _weaponKey } isEqualTo -1) then { 0 } else { (_currentReloadData select (_currentReloadData findIf { _x select 0 == _weaponKey })) select 1 };
_reloadCount = _reloadCount + 1;

if ( _currentReloadData findIf { _x select 0 == _weaponKey} isEqualTo -1 ) then
{
    // 신규
    _currentReloadData pushBack [_weaponKey, _reloadCount];
}
else
{
    // 갱신
    _currentReloadData set[_currentReloadData findIf {_x select 0 == _weaponKey}, [_weaponKey, _reloadCount]];
};

[_reloadkey, _currentReloadData] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataSave.sqf";