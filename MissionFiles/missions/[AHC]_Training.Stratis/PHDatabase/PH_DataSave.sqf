/*
   데이터 저장 함수
   특정 키와 데이터를 받아 `profileNamespace`에 저장합니다.
   
   인자:
   - _dataKey: 저장할 데이터의 키 (문자열)
   - _dataValue: 저장할 데이터 값 (숫자, 문자열, 배열 등)
*/

params ["_dataKey", "_dataValue"];

// 데이터 저장
profileNamespace setVariable [_dataKey, _dataValue];
saveProfileNamespace;