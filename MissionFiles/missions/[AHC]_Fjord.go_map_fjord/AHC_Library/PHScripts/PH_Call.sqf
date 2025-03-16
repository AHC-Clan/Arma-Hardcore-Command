//! 2018-02-10 패치
//! 호출기능
//! [위치, 닉네임, 타입] execVM "PHScripts\PH_Call.sqf";
_slocation = _this select 0;
_sName = _this select 1;
_CallType = _this select 2;

playSound "ahc_radio_on";

	switch ( _CallType ) do
	{
		case 1:	// 닉네임만 받음
		{
			pCallText = parseText format["<t shadow='1.0'><t size='0.8'><t color='#1DDB16'>%1</t>님이 호출 하였습니다.</t></t>", _sName];  		
		};
		case 2:	// 위치, 닉네임 받음
		{
			pCallText = parseText format["<t shadow='1.0'><t size='0.8'><t color='#FFE400'>%1</t>에서 <t color='#1DDB16'>%2</t>님이 호출 하였습니다.</t></t>", _slocation, _sName];  		
		};
		case 3:	// 위치만 받음
		{
			pCallText = parseText format["<t shadow='1.0'><t size='0.8'><t color='#FFE400'>%1</t>에서 호출 하였습니다.</t></t>", _slocation];  		
		};
		case 4:
		{
			pCallText = parseText format["<t shadow='1.0'><t size='0.75'><t color='#1DDB16'>%1</t>님이 <t color='#FFE400'>%2</t>을(를) 브리핑실로 호출 하였습니다.</t></t>", _sName, _slocation];
		};
		default	
		{
			pCallText = parseText format["<t shadow='1.0'><t size='0.8'><t color='#1DDB16'>%1</t>님이 호출 하였습니다.</t></t>", _sName];
		};
	};

{
	[pCallText,0,0.9,6,0.1,0,0] spawn bis_fnc_dynamicText; 
} remoteExec["bis_fnc_call", 0];


uiSleep 5;
  
playSound "ahc_radio_off";

sleep 1;
