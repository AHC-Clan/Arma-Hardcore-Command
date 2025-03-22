//! 패치
//! 리스폰시 작동 합니다.
//! 베이스 사격에 따른 리스폰 체크 및 리스폰 지역 이동

player addEventHandler ["Respawn", 
{	
	 // 베이스 사격이 0 이하일 때 무기 및 아이템 제거, 화면을 블랙으로 전환
	if(nBaseFire <= 0 ) then 
	{
		removeAllWeapons player;
		removeAllItems player;
		9999 cutText ["", "BLACK", 0.01];
	}
	else
	{
		// 플레이어 위치 설정 (리스폰 확인)
		if ( !isNil "RespawnPoint") then
		{
    		player setDir (direction RespawnPoint);
			player setPosASL(getPosASL RespawnPoint); 
		}
		else
		{
			player setDir (direction respawn);
    		player setPosASL (getPosASL respawn); 
			systemChat "리스폰 지점을 찾을 수 없습니다.";
		};

		// 권한 스크립트 실행
		[] execVM "AHC_Library\PHLogic\PH_Permission.sqf";
	};	
}];