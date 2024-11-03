// 플레이어가 미션에 참여할 때 로컬에서 호출됩니다.

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

// AHC 상태창 초기화
[] execVM "PHPlayerStatus\PH_InitStatusPlayerLocal.sqf";