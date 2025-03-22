// 2024.11.03 패치
// 서버에서 미션 세팅값을 불러옵니다. 

private _missionSettingURL = "https://raw.githubusercontent.com/AHC-Clan/Arma-Hardcore-Command/refs/heads/main/Mission/MissionSetting.txt";
private _missionSettingVar = "AHC_MissionSetting";

[_missionSettingURL, _missionSettingVar] execVM "AHC_Library\PHLogic\PH_UrlReader.sqf"; 
waitUntil { sleep 1; missionNamespace getVariable "AHC_URL_READY" };

_missionSetting = (missionnamespace getVariable _missionSettingVar);
_settingList = [_missionSetting, 0] call BIS_fnc_trimString splitString "=,";

// 딕셔너리
_settingsMap = [];

// 리스트를 반복하며 key-value 쌍으로 저장
for [{_i = 0}, {_i < count _settingList - 1}, {_i = _i + 2}] do 
{
    private _key = _settingList select _i;
    private _value = _settingList select (_i + 1);
    
    // 맵에 쌍을 추가
    _settingsMap pushBack [trim _key, trim _value];
};

// 설정 맵을 missionNamespace에 저장하여 외부에서 접근 가능하게 함
missionNamespace setVariable ["AHC_SettingsMap", _settingsMap];
missionNamespace setVariable ["AHC_Setting_Ready", true];