/*
   데이터 불러오기 함수
   특정 키를 받아 `profileNamespace`에서 해당 데이터를 반환합니다.
   
   인자:
   - _dataKey: 불러올 데이터의 키 (문자열)
   - _defaultValue: 데이터가 없을 경우 반환할 기본 값 (선택 사항, 기본값은 0)
   
   반환 값:
   - 저장된 데이터 값 또는 기본 값
*/

params ["_dataKey", "_defaultValue"];

// 데이터 불러오기 (없으면 기본 값 반환)
// profileNamespace getVariable [_dataKey, _defaultValue];