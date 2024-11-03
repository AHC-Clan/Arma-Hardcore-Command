// 2018-10-21 패치
// 순위 정보 공개
// [] execVM "PH_ShowDB.sqf";

// 데이터베이스 체크
if (isNil "pPlayerInfo") exitWith { hint "DB가 존재하지 않습니다."; };

// 초기 변수 설정
private _playerArr = [];
private _nKiller = [];
private _nRespawn = [];
private _nEnemyKill = [];
private _nCityKill = [];
private _nHeadShot = [];
private _nFriendlyKill = [];

// 플레이어 배열 생성
_playerArr = allPlayers apply { name _x };

// 각 순위 정보 배열에 값 채우기
{
    private _sInfo = missionNamespace getVariable [_x, []];
    if (count _sInfo > 0) then {
        _nKiller pushBack (_sInfo select 1);
        _nRespawn pushBack (_sInfo select 2);
        _nEnemyKill pushBack (_sInfo select 3);
        _nCityKill pushBack (_sInfo select 4);
        _nHeadShot pushBack (_sInfo select 5);
        _nFriendlyKill pushBack (_sInfo select 6);
    };
} forEach _playerArr;

// 최대/최소 값 계산
private _nKillerMax = selectMax _nKiller;
private _nKillerMin = selectMin _nKiller;
private _nRespawnMax = selectMax _nRespawn;
private _nEnemyKillMax = selectMax _nEnemyKill;
private _nCityKillMax = selectMax _nCityKill;
private _nHeadShotMax = selectMax _nHeadShot;
private _nFriendlyKillMax = selectMax _nFriendlyKill;

// 각 순위 정보 저장
private _sBestKiller = [];
private _sBestPeace = [];
private _sBestRespawn = [];
private _sBestEnemyKill = [];
private _sBestCityKill = [];
private _sBestHeadShot = [];
private _sBestFriendlyKill = [];

// 순위 정보 확인 및 저장
{
    private _sInfo = missionNamespace getVariable [_x, []];
    if (count _sInfo > 0) then {
        if ((_sInfo select 1) == _nKillerMax) then { _sBestKiller pushBack (_sInfo select 0); };
        if ((_sInfo select 1) == _nKillerMin) then { _sBestPeace pushBack (_sInfo select 0); };
        if ((_sInfo select 2) == _nRespawnMax) then { _sBestRespawn pushBack (_sInfo select 0); };
        if ((_sInfo select 3) == _nEnemyKillMax) then { _sBestEnemyKill pushBack (_sInfo select 0); };
        if ((_sInfo select 4) == _nCityKillMax) then { _sBestCityKill pushBack (_sInfo select 0); };
        if ((_sInfo select 5) == _nHeadShotMax) then { _sBestHeadShot pushBack (_sInfo select 0); };
        if ((_sInfo select 6) == _nFriendlyKillMax) then { _sBestFriendlyKill pushBack (_sInfo select 0); };
    };
} forEach _playerArr;

// 현재 플레이어 정보
private _myInfo = missionNamespace getVariable [name player, []];
private _sResultMyHint = "<t color='#E5D85C' size='2.0'>[ 내 정보 (" + name player + ") ]</t><br/>";
_sResultMyHint = _sResultMyHint + format ["<t color='#D5D5D5' size='1.1'>탄소모: %1발<br/>", _myInfo select 1];
_sResultMyHint = _sResultMyHint + format ["리스폰: %1번<br/>", _myInfo select 2];
_sResultMyHint = _sResultMyHint + format ["적 사살: %1명<br/>", _myInfo select 3];
_sResultMyHint = _sResultMyHint + format ["적 헤드샷: %1번<br/></t>", _myInfo select 5];
_sResultMyHint = _sResultMyHint + format ["시민 사살: %1명<br/>", _myInfo select 4];
_sResultMyHint = _sResultMyHint + format ["아군 사살: %1명<br/>", _myInfo select 6];

_sResultMyHint = _sResultMyHint + "---------------------------------------------<br/>";
_sResultMyHint = _sResultMyHint + "<t color='#F15F5F' size='2'>[ 최고의 플레이어 ]</t><br/>";

// 순위 정보 구성
private _sResultHint = "";
if (_nEnemyKillMax > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#86E57F' size='1.4'>[적 사살 훈장]</t><br/>%1 =  %2명<br/><br/>", _sBestEnemyKill, _nEnemyKillMax];
};
if (_nHeadShotMax > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#86E57F' size='1.4'>[헤드샷 훈장]</t><br/>%1 =  %2명<br/><br/>", _sBestHeadShot, _nHeadShotMax];
};
if (_nRespawnMax > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#FFA7A7' size='1.4'>[최다 사망]</t><br/>%1 =  %2번<br/><br/>", _sBestRespawn, _nRespawnMax];
};
if (_nKillerMax > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#CEF279' size='1.4'>[최대 탄소모]</t><br/>%1 =  %2발<br/><br/>", _sBestKiller, _nKillerMax];
};
if (_nKillerMin > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#FFA7A7' size='1.4'>[최소 탄소모]</t><br/>%1 =  %2발<br/><br/>", _sBestPeace, _nKillerMin];
};
if (_nCityKillMax > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#FFA7A7' size='1.4'>[무고한 시민 사살]</t><br/>%1 =  %2명<br/><br/>", _sBestCityKill, _nCityKillMax];
};
if (_nFriendlyKillMax > 0) then 
{
    _sResultHint = _sResultHint + format ["<t color='#FFA7A7' size='1.4'>[아군 진영 사살]</t><br/>%1 =  %2명<br/><br/>", _sBestFriendlyKill, _nFriendlyKillMax];
};

// 결과 출력
if (_sResultHint == "") then 
{
    hint parseText format ["%1%2<br/><br/>", _sResultMyHint, "<t color='#8C8C8C' size='1.5'>현재 기록 대기중 입니다. :D</t>"];
} 
else
{
    hint parseText format ["%1%2%3", _sResultMyHint, _sResultHint, "<t color='#8C8C8C' size='1'>정확하지 않을수 있습니다 재미로만.. :D</t>"];
};
