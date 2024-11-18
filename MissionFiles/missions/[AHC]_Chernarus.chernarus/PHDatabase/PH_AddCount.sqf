// 2024-11-17 Patch
// 카운트 저장 함수

params["_variableName"];

if ( isNil "_variableName") exitWith
{
    systemChat "카운트 저장 인자값 알 수 없음";
};

_playerUID  = getPlayerUID player;
_key = format["%1_%2", _variableName, _playerUID];
_currentCount = [_key, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataLoad.sqf";
_currentCount = _currentCount + 1;

[_key, _currentCount] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";