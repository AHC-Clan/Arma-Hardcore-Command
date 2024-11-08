// 2018-10-21 패치
// 데이터 값 설정
params ["_sName", "_nSelect", "_nCount"];

// pPlayerInfo 존재 여부 확인
if (isNil "pPlayerInfo") exitWith 
{
    hint "DB가 존재하지 않습니다.";
};

// 선택한 인덱스 값 업데이트
_nResult = (pPlayerInfo select _nSelect) + _nCount;
pPlayerInfo set [_nSelect, _nResult];

// 업데이트된 정보를 네임스페이스에 저장하고 네트워크에 알림
missionNamespace setVariable [_sName, pPlayerInfo];
publicVariable _sName;