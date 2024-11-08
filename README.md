---------------------------------------------------------------
# [ 샘플 처음 사용자 ]
---------------------------------------------------------------

<img src="https://github.com/AHC-Clan/Arma-Hardcore-Command/blob/main/Sample/ahc.png"></img><br/>
AHC 미션 샘플 [**[AHC]_Sample.VR.7z**](https://github.com/AHC-Clan/Arma-Hardcore-Command/blob/main/Sample/%5BAHC%5D_Sample.VR.7z) 파일을 받아주세요.

샘플 사용 및 적용 방법은 아래 영상을 참고해 주세요.

<https://youtu.be/_5X15Tm-6zE?si=ZEvv0SFyN-Vqfrnp>


샘플버전은 항상 에디터에서 작업 모두 끝나고나서

마무리 작업때 적용해주시면 좋습니다. ( 상관없긴함.. )

Description.ext에서 필요시 제목 같은거 설정해주세요!

> 제작 : Patch
> 도움 : Zeratulspc

---------------------------------------------------------------
# [ 명령어 사용법 ]
## 복사하셔서 사용하세요 :D
---------------------------------------------------------------

### 해당 오브젝트를 아스날 메뉴를 만듭니다.
> [this] execVM "PHScripts\PH_Arsnal.sqf";

### 복장샘플 적용 스크립트 AI유닛에 적용시키면 됩니다.
> [this] execVM "PHScripts\PH_CopyUnit.sqf";

### 자막호출 = 홍길동님이 호출 하였습니다.
> [nil, "홍길동", 1] execVM "PHScripts\PH_Call.sqf";

### 자막호출 = AHC에서 홍길동님이 호출 하였습니다.
> ["AHC", "홍길동", 2] execVM "PHScripts\PH_Call.sqf";

### 자막호출 = AHC에서 호출 하였습니다.
> ["AHC", nil, 3] execVM "PHScripts\PH_Call.sqf";

### 자막호출 = 홍길동님이 멍청이을(를) 브리핑실로 호출 하였습니다.
> ["멍청이", "홍길동", 4] execVM "PHScripts\PH_Call.sqf";


---------------------------------------------------------------
# [ 수정내역 ]
---------------------------------------------------------------

#### 2024.11.04 ( 작업자 Patch )
> - 샘플 리팩토링

#### 2019.03.22 ( 작업자 Zeratulspc )
> - ph_db\PH_Dedicate.sqf 수정 ( usafserver -> usafserver2 )
> - stringtable.xml 수정 ( 버전업 )

#### 2019.02.27 ( 작업자 Patch )
> - README 파일 수정
> - README 수정내역 작성
> - [에디터] 각 브리핑룸쪽 트리거 추가
> - [기능] 각 브리핑룸에서 무적 및 가시거리 최적화
> - [코드] PH_Loading.sqf 시야 관련 및 버전불일치시 메세지 수정
> - [코드] initPlayerLocal.sqf 시야 관련 스크립트 주석처리
