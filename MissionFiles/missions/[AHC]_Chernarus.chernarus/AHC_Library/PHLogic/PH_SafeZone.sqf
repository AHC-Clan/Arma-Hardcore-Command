player addEventHandler ["Fired", 
{
	private _safeZoneName = "safezone";

	// 플레이어가 안전 구역 내에 있는지 확인
	if (player inArea _safeZoneName) then
	{
		nBaseFire = nBaseFire - 1;
		
		// 사격 제한 카운트에 따른 행동 처리
		switch ( nBaseFire ) do
		{
			case 2:
			{
				removeAllWeapons player;
				TitleText ["베이스 사격 제한 2회 남았습니다.", "plain"];
			};
			case 1:
			{
				removeAllWeapons player;
				TitleText ["베이스 사격 제한 1회 남았습니다.", "plain"];
			};
			case 0:
			{
				 // 플레이어의 무기 제거, 화면 블랙 처리, 피해 적용
				removeAllWeapons player;
				player setDamage 1;
				9999 cutText ["", "BLACK", 0.01];
				
				// 서버에 경고 메시지 전송 및 플레이어 강제 퇴장
				  ["누군가 과도한 베이스 사격으로 게임이 제재되었습니다."] remoteExec ["systemChat", 0];
                serverCommand format ["#kick %1", name player];
                serverCommand format ["#exec kick %1", name player];
			};
		};
	};
}];