// 입력 변수 초기화
private ["_result", "_last"];
_result = _this select 0;
_last = _this select 1;

missionNamespace setVariable ["AHC_URL_READY", false];

// 데이터 요청이 완료될 때까지 대기
waitUntil 
{
	if (("url_fetch" callExtension format ["%1", _result]) == "OK") exitWith 
	{
		true
	};

    false
};

// 데이터 응답이 처리될 때까지 대기
waitUntil 
{
    _result = "url_fetch" callExtension "OK";

    if (_result != "WAIT") exitWith 
	{
		true
	};

    false
};

// 오류 처리
if (_result == "ERROR") exitWith 
{
    systemChat format 
	[
        "AHC DB Error: %1; %2",
        "url_fetch" callExtension "ERROR",
        _result
    ];
};

// 결과를 미션 네임스페이스에 저장
missionNamespace setVariable [_last, _result];
missionNamespace setVariable ["AHC_URL_READY", true];