// 2024-11-17 Patch
// 서버 접속시 플레이어의 약장 정보를 읇어줌
private _playerSkillURL = "https://raw.githubusercontent.com/AHC-Clan/Arma-Hardcore-Command/refs/heads/main/Mission/PlayerSkill.txt";
private _playerSkillVar = "AHC_PlayerBadges";

[_playerSkillURL, _playerSkillVar] execVM "PHLogic\PH_UrlReader.sqf"; 
waitUntil { sleep 1; missionNamespace getVariable "AHC_URL_READY" };

_permission = (missionnamespace getVariable _playerSkillVar);
_userList = [_permission, 0] call BIS_fnc_trimString splitString "@\n";

// 현재 플레이어의 UID 가져오기
_playerName = name player;

_unknownPlayer = true;

// 사용자 리스트에서 권한 확인 및 액션 추가
{
    if ( _forEachIndex mod 2 == 1) then
    {
        continue;
    };

    _name = trim (_userList select _forEachIndex);
    if ( _name == "") then
    {
        continue;
    };

    _badges = trim (_userList select (_forEachIndex + 1));
    if ( isNil "_badges") then
    {
        continue;
    };

    if ( toLower _name == toLower trim _playerName) exitWith
    {
         [format ["%1 님이 미션에 참가했습니다.", _name]] remoteExec ["systemChat", 0];
         [format ["   L 보유 배지: %1", _badges]] remoteExec ["systemChat", 0];
        missionNamespace setVariable["AHC_Badges", _badges];
        _unknownPlayer = false;
    };
} forEach _userList;

if ( _unknownPlayer ) then
{
    [format ["%1 님이 미션에 참가했습니다.", _playerName]] remoteExec ["systemChat", 0];
    [format ["   L AHC 데이터에 등록된 정보가 없습니다. 운영진에게 요청해보세요."]] remoteExec ["systemChat", 0];
};

missionNamespace setVariable["AHC_Badges_Ready", true];
