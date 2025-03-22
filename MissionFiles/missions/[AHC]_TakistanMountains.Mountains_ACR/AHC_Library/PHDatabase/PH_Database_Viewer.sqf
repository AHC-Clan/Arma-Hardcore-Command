// 2024-11-18 Patch
// 플레이어 데이터를 조회
// ["ALL"] execVM "AHC_Library\PHDatabase\PH_Database_Viewer.sqf";

params ["_playerName"];
private _executingPlayer = player; // 명령어를 실행한 사람

if ( isNil "_playerName") exitWith
{
    systemChat "인자값에 플레이어 이름을 입력해주세요.";
    ["인자값에 플레이어 이름을 입력해주세요."] remoteExec ["systemChat", _executingPlayer];
};

GetFavoriteWeapon = 
{
    params["_reloadData"];

    if ( !isNil "_reloadData" && count _reloadData > 0 ) then
    {
        _maxCount = selectMax (_reloadData apply {_x select 1});
        _maxWeaponIndex = _reloadData findIf {(_x select 1) == _maxCount };
        _maxWeapon = _reloadData select _maxWeaponIndex select 0;
        _maxWeaponCount = _reloadData select _maxWeaponIndex select 1;

        _weaponName = getText (configFile >> "CfgWeapons" >> _maxWeapon >> "displayName");
        format["%1", _weaponName];
    }
    else
    {
        "아직 선호하는 무기가 없어요.";
    };
};

GetDataBaseALL = 
{
    params["_target"];

    _playerUID  = getPlayerUID _target;

    // 적 킬 카운트
    _killCountKey = format["AHC_KillCount_%1", _playerUID];
    _loadKillCount = [_killCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 적 헤드샷 카운트
    _killHeadShotCountKey = format["AHC_KillHeadShotCount_%1", _playerUID];
    _loadKillHeadShotCount = [_killHeadShotCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 임무 성공, 실패 횟수 카운트
    _gameWinCountKey = format["AHC_GameWinCount_%1", _playerUID];
    _gameLoseCountKey = format["AHC_GameLoseCount_%1", _playerUID];
    _loadGameWinCount = [_gameWinCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";
    _loadGameLoseCount = [_gameLoseCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 시민 사살 카운트
    _killCivilianCountKey = format["AHC_KillCivilianCount_%1", _playerUID];
    _loadKillCivilianCount = [_killCivilianCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // AI에게 죽어서 리스폰한 카운트
    _killedAiRespawnCount = format["AHC_RespawnCount_%1", _playerUID];
    _loadRespawnCount = [_killedAiRespawnCount, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 재장전 횟수, 선호하는 총기
    _reloadWeaponKey = format["AHC_MagazineReloading_%1", _playerUID];
    _loadReloadWeapon = [_reloadWeaponKey, []] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    _myBadges = missionNamespace getVariable "AHC_Badges";

    // 만약 배지 정보를 읽어오지 못했다면 데이터베이스에 등록 안된사람.
    if ( isNil "_myBadges") exitWith
    {
        _displayText = _displayText + format["<t color='#747474' size='1.0'>AHC 데이터베이스에 등록되지 않았어요.<br/>운영진에게 등록 요청해보세요.</t>"];
        hint parseText format["%1", _displayText];
    };

    systemChat format["[ %1(%2) 조회 ]", name _target, _playerUID];
    systemChat format["적사살:(%1) 헤드샷(%2), 성공(%3), 실패(%4), 시민사살(%5), 죽음(%6), 선호총기(%7)", _loadKillCount, _loadKillHeadShotCount, _loadGameWinCount, _loadGameLoseCount, _loadKillCivilianCount, _loadRespawnCount, [_loadReloadWeapon] call GetFavoriteWeapon];
};

GetDatabaseTarget = 
{
    params["_target"];

    _playerUID  = getPlayerUID _target;

    // 적 킬 카운트
    _killCountKey = format["AHC_KillCount_%1", _playerUID];
    _loadKillCount = [_killCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 적 헤드샷 카운트
    _killHeadShotCountKey = format["AHC_KillHeadShotCount_%1", _playerUID];
    _loadKillHeadShotCount = [_killHeadShotCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 임무 성공, 실패 횟수 카운트
    _gameWinCountKey = format["AHC_GameWinCount_%1", _playerUID];
    _gameLoseCountKey = format["AHC_GameLoseCount_%1", _playerUID];
    _loadGameWinCount = [_gameWinCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";
    _loadGameLoseCount = [_gameLoseCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // 시민 사살 카운트
    _killCivilianCountKey = format["AHC_KillCivilianCount_%1", _playerUID];
    _loadKillCivilianCount = [_killCivilianCountKey, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    // AI에게 죽어서 리스폰한 카운트
    _killedAiRespawnCount = format["AHC_RespawnCount_%1", _playerUID];
    _loadRespawnCount = [_killedAiRespawnCount, 0] call compile preprocessFileLineNumbers "AHC_Library\PHDatabase\PH_DataLoad.sqf";

    _myBadges = missionNamespace getVariable "AHC_Badges";

    _displayText = "<t color='#E5D85C' size='2.0'>[ AHC 데이터 조회 ]</t><br/>";
    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>조회 대상</t><br/>%1<br/><br/>", name player];
    //_displayText = _displayText + format["<t color='#747474'>%1</t><br/><br/>", _playerUID];

    // 만약 배지 정보를 읽어오지 못했다면 데이터베이스에 등록 안된사람.
    if ( isNil "_myBadges") exitWith
    {
        _displayText = _displayText + format["<t color='#747474' size='1.0'>AHC 데이터베이스에 등록되지 않았어요.<br/>운영진에게 등록 요청해보세요.</t>"];
        hint parseText format["%1", _displayText];
    };

    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>보유한 배지</t><br/>%1<br/><br/>", _myBadges];
    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>임무 성공/실패/전체</t><br/>%1 / %2 / %3<br/>", _loadGameWinCount, _loadGameLoseCount, _loadGameWinCount + _loadGameLoseCount];
    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>적 사살 / 헤드샷</t><br/>%1 / %2<br/>", _loadKillCount, _loadKillHeadShotCount];
    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>시민 사살 </t><br/>%1<br/>", _loadKillCivilianCount];
    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>적에게 죽었던 횟수 </t><br/>%1<br/>", _loadRespawnCount];
    _displayText = _displayText + format["<t color='#ea9229' size='1.3'>선호하는 총기 </t><br/>%1<br/>", [_loadReloadWeapon] call GetFavoriteWeapon];

    hint parseText format["%1", _displayText];
};

// 모든 플레이어 데이터 조회
if ( toLower trim _playerName == "ALL") exitWith
{
    {
        [_x] call GetDataBaseALL;
    } foreach allPlayers;
};

// 특정 플레이어 데이터 조회
_successClear = false;

{
    if ( toLower trim name _x == toLower trim _playerName) exitWith
    {

        // ---- 초기화 하고자하는 정보는 여기에 -------

        [_x] call GetDatabaseTarget;

        // ---------------------------------------
        [format["%1 님의 데이터베이스 조회.", name _x]] remoteExec ["systemChat", _executingPlayer];
        _successClear = true;
    };
} foreach allPlayers;

// 플레이어를 찾지 못했을 경우 메시지 출력
if ( !_successClear) then
{
    ["데이터베이스 조회 실패"] remoteExec ["systemChat", _executingPlayer];
};