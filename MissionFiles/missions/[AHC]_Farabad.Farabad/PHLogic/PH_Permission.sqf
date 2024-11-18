//# 2017-12-13  패치
//# 2019-01-20 웹 DB와 실시간 연동 가능
//# 2024-11-03 권한 부여 부분 코드 리팩토링
//# UID 확인후 특정 인원 카메라 사용 스크립트

private _permissionURL = "https://raw.githubusercontent.com/AHC-Clan/Arma-Hardcore-Command/refs/heads/main/Mission/CameraPermission.txt";
private _permissionVar = "AHC_Permission";

[_permissionURL, _permissionVar] execVM "PHLogic\PH_UrlReader.sqf"; 
waitUntil { sleep 1; missionNamespace getVariable "AHC_URL_READY" };

_permission = (missionnamespace getVariable _permissionVar);
_userList = [_permission, 0] call BIS_fnc_trimString splitString "@,";

// 현재 플레이어의 UID 가져오기
_playerUID = getPlayerUID player;

// 사용자 리스트에서 권한 확인 및 액션 추가
{
    // 홀수 인덱스에 있는 GUID만 체크
    if ((_forEachIndex mod 2 == 1) && { trim _x == _playerUID }) then 
	{
        player addAction 
		[
            "<t color='#FFFF00'>[권한] 카메라 사용</t>",
            {
                systemChat format ["[%1님이 카메라툴을 사용]", _this select 3];
                [] execVM "a3\functions_f\Debug\fn_camera.sqf";
            },
            trim _x
        ];
    };
} forEach _userList;