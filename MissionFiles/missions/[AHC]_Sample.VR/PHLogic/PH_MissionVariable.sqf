AHC_SettingMap = missionNamespace getVariable ["AHC_SettingsMap", []];
if ( !isNil "AHC_SettingMap") then
{
    {
        private _result = _x select 1;

        switch (_x select 0 ) do
        {
            case "AHC_BaseFireCount": 
            {
                nBaseFire = _result call BIS_fnc_parseNumber;
            };
            case "AHC_SkipMissionVersionCheck": 
            {
                SkipMissionVersionCheck =  switch (toLower _result) do 
                {
                    case "true": {true};
                    case "false": {false};
                };
            };
            case "AHC_RespawnPoint":
            {
                RespawnPoint = missionNamespace getVariable _result;
            };
        };    
    } forEach AHC_SettingMap;
};