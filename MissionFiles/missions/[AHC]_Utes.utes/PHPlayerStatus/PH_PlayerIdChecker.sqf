// 2018-10-21 패치
// 플레이어 값 체크
params ["_sName"];

// 초기 변수 설정
private _bAlive = true;
private _nIDCheckCnt = 0;

if ( isNil "pPlayerInfo") then 
{
	_bAlive = false;
	hint "DB가 존재하지 않습니다."; 
};

// _sName 값 확인
if (_sName == "") then 
{
    hint "ID값 알 수 없음.";
    _bAlive = false;
};

// 모든 플레이어 이름 배열 생성
private _playerArr = allPlayers apply { name _x };

// _sName이 존재하는지 확인
{
    private _pForArr = missionNamespace getVariable [_x, []];
    if (_sName == (_pForArr select 0)) then 
	{
        _nIDCheckCnt = _nIDCheckCnt + 1;
    };
} forEach _playerArr;

// ID가 존재하지 않으면 경고 표시
if (_nIDCheckCnt <= 0) then 
{
    hint "존재하지 않는 ID";
    _bAlive = false;
};

// 결과 반환
_bAlive;