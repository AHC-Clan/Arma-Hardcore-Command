[] execVM "PHLogic\PH_InitMission.sqf";
sleep 3;

// 초기 설정
[] execVM "PHLogic\PH_MissionVariable.sqf";
sleep 1;

pGetDistance = viewDistance;
pGetObjDistance = getObjectViewDistance select 0;

// 환경 설정
setViewDistance 1;
setObjectViewDistance 1;
removeAllWeapons player;
removeBackpack player;

enableRadio false; // 무전 비활성화
enableSentences false; // AI 음성 비활성화
enableEnvironment [false, true];  // 환경 효과: 일반 소리 비활성화, 바다 소리 유지

// HUD 설정: 필요한 요소만 표시
ShowHUD [
    false, // 무기 패널
    false, // 스탠스 인디케이터
    true,  // 커서
    false,  // 차량 정보
    true,  // 방향 및 고도
    true, // 채팅
    false, // 팀 정보
    false, // 명령 메뉴
    true,  // 자막
    false   // 그룹 정보
];
cutText ["", "BLACK", 0.001];

// 미션 버전 정보 가져오기
_missionVersion = "AHC_MissionVersion";
["https://raw.githubusercontent.com/AHC-Clan/Arma-Hardcore-Command/refs/heads/main/Mission/MissionVersion.txt", _missionVersion] execVM "PHLogic\PH_UrlReader.sqf";
sleep 1.2;

// 미션 버전 확인
_cv = localize "STR_MISSION_VERSION";
_serverVersion = missionNamespace getVariable _missionVersion;

if (!SkipMissionVersionCheck && !isNil "_serverVersion" && isNil "_cv" && trim _serverVersion != trim _cv) exitWith 
{
    systemChat format["AHC 미션 파일이 최신이 아닙니다. 'Patch'에게 문의 주세요."];
    systemChat format["현재 버전: %1 | 최신버전: %2", _cv, _serverVersion];

    [parseText format["<t font='PuristaBold' size='1.6'>AHC 미션 버전이 틀립니다!<br/>최신버전으로 유지해주세요.</t><br/><br/><t color='#FF0000'>현재버전 : %1</t><br/><t color='#1DDB16'>최신버전 : %2</t>", 
        localize "STR_MISSION_VERSION",
        _serverVersion],
        [1,1,10,10], nil, 9999, 1, 0] spawn BIS_fnc_textTiles;
};

sleep 0.1;

playMusic "EventTrack02_F_Orange";

// 필수 스크립트 실행
["PHLogic\PH_SafeZone.sqf", "PHLogic\PH_Respawn.sqf", "PHLogic\PH_Permission.sqf"] apply 
{
    [] execVM _x;
    sleep 0.3;
};

// 해상도별 텍스트 위치 설정
_resFactor = getResolution select 5;
switch ( _resFactor ) do
{
    case 0.47:
    {
        nTextX = -0.92;
        nTextY = 0.8;
    };
    case 0.55:
    {
        nTextX = -0.72;
        nTextY = 0.7;
    };
    case 0.7:
    {
        nTextX = -0.46;
        nTextY = 0.58;
    };
    case 0.85:
    {
        nTextX = -0.72;
        nTextY = 0.48;
    };    
};

[ 0, 0, false, true] spawn BIS_fnc_cinemaBorder; 
sleep 0.1;

// 인트로 텍스트 출력
[     
 [     
  ["Arma3 Hardcore Command","align = 'center' shadow = '1' size = '1' font='PuristaBold'"],     
  [" "],
  [" "],
  [" "]
 ], nTextX+0.015, nTextY + 0.04
] spawn BIS_fnc_typeText2; 
sleep 2.5;

// 인트로 이미지 출력
_introText = parseText "<t shadow='0'><t size='6.0'><img image='image\ahc.paa' /></t></t>";    
 [_introText,0,0.12,5,2,0,1] spawn bis_fnc_dynamicText;

// 플레이어 위치 설정 (리스폰 확인)
if ( !isNil "RespawnPoint") then
{
    player setPosASL(getPosASL RespawnPoint); 
}
else
{
    player setPosASL(getPosASL respawn); 
    systemChat "리스폰 지점을 찾을 수 없습니다.";
};

sleep 4;

// 초기 설정 복원
setViewDistance pGetDistance;
setObjectViewDistance pGetObjDistance;

cutText ["", "BLACK IN", 2];
sleep 2.4;

[1, 1, false, true] spawn BIS_fnc_cinemaBorder;
sleep 2;

// 버전 및 제작자 정보 출력
[parseText format["<t font='PuristaBold' size='1.6'>AHC Version</t><br />%1", localize "STR_MISSION_VERSION"], [0.3, 1, 7, 7], nil, 3, 0.8, 0] spawn BIS_fnc_textTiles;
sleep 4;
[parseText format["<t font='PuristaBold' size='1.6'>Created by</t><br />%1", localize "STR_MISSION_MAKER"], [0.3, 1, 7, 7], nil, 3, 0.8, 0] spawn BIS_fnc_textTiles;
