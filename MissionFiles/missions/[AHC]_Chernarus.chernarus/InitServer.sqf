savePlayerData = 
{
    params ["_data"];

    private _uid = _data select 0;
    private _name = _data select 1;

    diag_log format ["[AHC 데이터베이스 저장] UID: %1, 이름: %2, 승리횟수: %3", _uid, _name];

    missionNamespace setVariable [format ["AHC_PlayerData_%1_%1", _name, _uid], _data];
    saveProfileNamespace;
};

waitUntil { missionNamespace getVariable["AHC_MissionEnd", false] };

// 서버에 함수 등록
"savePlayerData" remoteExec ["savePlayerData", 2];