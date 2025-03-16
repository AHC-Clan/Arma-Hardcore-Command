//# 2017-12-22 패치
//# 텔레포트
//# 사용법 : [_this, 이동할 위치(오브젝트), "휠굴릴때 뜨는말"] execVM "PH_Teleport.sqf";

private _obj = _this select 0;
private _telPos = _this select 1;
private _objMsg = if (_this select 2 == "") then { "이동하기" } else { _this select 2 };

// 액션 추가: 플레이어가 선택하면 텔레포트 함수 실행
_obj addAction
[
	format["<t color='ff5f5f'><t size='1.5'>%1</t></t>", _objMsg], 
		{  
			_tel = _this select 3;
        	[_tel] call PH_MOVE;
		},
		_telPos
];

PH_MOVE = {
	 params ["_tel"];
	
	titleCut ["", "BLACK FADED"];

	[
		[["이동하는 중", "<t align='center' shadow='1' size='1.0'>%1</t><br/>"],
		["", "<t align='center' shadow='1' size='0.7'>%1</t><br/>"]]
    ] spawn BIS_fnc_typeText;

	player setPosASL (getPosASL _tel);

	sleep 0.2; 
	titleCut ["", "BLACK IN", 2];	
};

