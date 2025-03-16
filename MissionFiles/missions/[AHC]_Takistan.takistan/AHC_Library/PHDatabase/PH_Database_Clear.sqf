// 2024-11-18 Patch
// 플레이어 데이터를 초기화 하기 위함
// ["ALL"] execVM "PHDatabase\PH_Database_Clear.sqf";

params ["_playerName"];
private _executingPlayer = player; // 명령어를 실행한 사람

if ( isNil "_playerName") exitWith
{
    ["초기화 인자값에 플레이어 이름을 입력해주세요."] remoteExec ["systemChat", _executingPlayer];
};

// 데이터베이스 초기화 함수
SetClearDatabase = 
{
    params["_target"];

    _playerUID  = getPlayerUID _target;

    // 적 킬 카운트
    _killCountKey = format["AHC_KillCount_%1", _playerUID];
    [_killCountKey, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";

    // 적 헤드샷 카운트
    _killHeadShotCountKey = format["AHC_KillHeadShotCount_%1", _playerUID];
    [_killHeadShotCountKey, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";

    // 시민 사살 카운트
    _killCivCountKey = format["AHC_KillCivilianCount_%1", _playerUID];
    [_killCivCountKey, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";

    // 적에게 죽은 카운트
    _respawnCountKey = format["AHC_RespawnCount_%1", _playerUID];
    [_respawnCountKey, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";

    // 임무성공
    _gameWinCountKey = format["AHC_GameWinCount_%1", _playerUID];
    [_gameWinCountKey, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";

    // 임무실패
    _gameLoseCountKey = format["AHC_GameLoseCount_%1", _playerUID];
    [_gameLoseCountKey, 0] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";

    // 재장전 횟수
    _reloadkey = format["AHC_MagazineReloading_%1", _playerUID];
    [_reloadkey, []] call compile preprocessFileLineNumbers "PHDatabase\PH_DataSave.sqf";        
};

// 모든 플레이어 데이터 초기화
if ( toLower trim _playerName == "ALL") exitWith
{
    _count = 0;
    {
        [_x] call SetClearDatabase;
        _count = _count + 1;
    } foreach allPlayers;

    if ( _count >= count allPlayers) then
    {
        ["AHC 클랜 데이터베이스가 초기화되었습니다."] remoteExec ["systemChat", _executingPlayer];
    }
    else
    {
        ["AHC 클랜 데이터베이스 부분 초기화되었습니다."] remoteExec ["systemChat", _executingPlayer];       
    };
};

// 특정 플레이어 데이터 초기화
_successClear = false;

{
    if ( toLower trim name _x == toLower trim _playerName) exitWith
    {

        // ---- 초기화 하고자하는 정보는 여기에 -------

        [_x] call SetClearDatabase;

        // ---------------------------------------
        [format["%1 님의 데이터베이스가 초기화되었습니다.", name _x]] remoteExec ["systemChat", _executingPlayer];
        _successClear = true;
    };
} foreach allPlayers;

// 플레이어를 찾지 못했을 경우 메시지 출력
if ( !_successClear) then
{
    ["데이터베이스 초기화 실패"] remoteExec ["systemChat", _executingPlayer];
};