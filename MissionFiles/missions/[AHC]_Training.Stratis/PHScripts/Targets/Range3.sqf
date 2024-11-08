
params ["_actionOwner", "_time","_rangeName", "_targets"];

missionNamespace setVariable["AHC_RangeOwner", _actionOwner];
missionNamespace setVariable["AHC_Range", _targets];
missionNamespace setVariable["AHC_RangeTime", _time];

removeAllActions _actionOwner;
_actionOwner addAction [format["(%1) 모두 올리기", _rangeName], 
{
    params ["_target", "_caller", "_actionId", "_arguments"];

    missionNamespace setVariable ["noPop", false, true];
    (missionNamespace getVariable "AHC_Range") apply { _x animateSource ["terc", 0]}
}, _actionOwner];

_actionOwner addAction [format["(%1) 모두 내리기", _rangeName], 
{
    params ["_target", "_caller", "_actionId", "_arguments"];

    missionNamespace setVariable ["noPop", true, true];
    (missionNamespace getVariable "AHC_Range") apply { _x animateSource ["terc", 1]}
},_actionOwner];


TargetHit = 
{
    params ["_target"];

    _target addEventHandler ["Hit", 
    {
        missionNamespace setVariable["AHC_RangeResult", true];
        systemChat format["%1 명중", _source];

        // 랜덤 자막 실행
        _randomSubtitle = round (random 5);
        _owner = missionNamespace getVariable "AHC_RangeOwner";

        switch (_randomSubtitle) do
        {
            case 0:
            {
                playSound3D ['a3\dubbing_f_beta\firing_drills\Positive\firing_drills_positive_ROF_3.ogg', _owner];
                [['SPEAKER', "좋았어!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
            };
            case 1:
            {
                playSound3D ['a3\dubbing_f_tank\ta_tanks_m03\031_eve_enemy_tank_destroyed01\ta_tanks_m03_031_eve_enemy_tank_destroyed01_ARPLAYER_0.ogg', _owner]; 
                [['SPEAKER', "명중!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
            };
            case 2:
            {
                playSound3D ['a3\dubbing_f_gamma\firing_drills\MiscRC\firing_drills_miscrc_ROF_0.ogg', _owner]; 
                [['SPEAKER', "명중이야!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
            };
            case 3:
            {
                playSound3D ['a3\dubbing_f_gamma\firing_drills\MiscRC\firing_drills_miscrc_ROF_2.ogg', _owner];
                [['SPEAKER', "득점!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
            };
            case 4:
            {
                playSound3D ['a3\dubbing_f_gamma\firing_drills\MiscRC\firing_drills_miscrc_ROF_1.ogg', _owner];
                [['SPEAKER', "조준 잘 했네!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
            };
        };
    }];
};

TargetFail =
{
    // 랜덤 자막 실행
    _randomSubtitle = round (random 4);
    _owner = missionNamespace getVariable "AHC_RangeOwner";

    switch (_randomSubtitle) do
    {
        case 0:
        {
            playSound3D ['a3\dubbing_f_beta\firing_drills\Negative\firing_drills_negative_ROF_4.ogg', _owner];
            [['SPEAKER', "너무 느려!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
        };
        case 1:
        {
            playSound3D ['a3\dubbing_f_beta\firing_drills\Negative\firing_drills_negative_ROF_6.ogg', _owner];
            [['SPEAKER', "표적을 놓쳤다!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
        };
        case 2:
        {
            playSound3D ['a3\dubbing_f_beta\firing_drills\Negative\firing_drills_negative_ROF_9.ogg', _owner];
            [['SPEAKER', "다음을 기약해 봐!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
        };
        case 3:
        {
            playSound3D ['a3\dubbing_f_tacops\to_c03_m02\019_ex_ao_boundary\to_c03_m02_019_ex_ao_boundary_BARKLEM_0.ogg', _owner];
            [['SPEAKER', "음, 이런...", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
        };
    };
};

missionNamespace setVariable["AHC_Targeting", false];
_actionOwner addAction [format["(%1) 무작위 1개 준비 및 시작", _rangeName], 
{
    params ["_target", "_caller", "_actionId", "_arguments"];
    [] spawn
    {
        if ( missionNamespace getVariable "AHC_Targeting") exitWith
        {
            systemChat "이미 진행중";
        };

        missionNamespace setVariable["AHC_Targeting", true];
        _time = missionNamespace getVariable "AHC_RangeTime";
        systemChat format["타겟 등장 후 퇴장까지 %1 초", _time];

        missionNamespace setVariable ["noPop", true, true];
    
        _owner = missionNamespace getVariable "AHC_RangeOwner";
        playSound3D ['a3\dubbing_f_beta\firing_drills\Timing\firing_drills_timing_ROF_0.ogg', _owner];
        [['SPEAKER', "사수 준비.", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;

        BIS_fnc_EXP_camp_playSubtitles_terminate = true; 
        
        missionNamespace setVariable["AHC_RangeResult", false];
        (missionNamespace getVariable "AHC_Range") apply { _x animateSource ["terc", 1]};

        sleep 1.5 + (random 2);

        playSound3D ['a3\dubbing_f_beta\firing_drills\Timing\firing_drills_timing_ROF_4.ogg', _owner];
        [['SPEAKER', "시작!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;

        _targets = missionNamespace getVariable "AHC_Range";
        _randomTarget = selectRandom _targets;
        _randomTarget animateSource ["terc", 0];

        // 모든 표적에 이벤트 핸들러 추가
        {
            [_x] call TargetHit;
        } forEach _targets;

        sleep _time;

        _targetResult = missionNamespace getVariable "AHC_RangeResult";
        if ( !_targetResult) then
        {
            [] call TargetFail;
        };

        // 이벤트 핸들러 제거
        {
            _x animateSource ["terc", 1];
            _x removeAllEventHandlers "Hit";
        } forEach _targets;
        missionNamespace setVariable["AHC_Targeting", false];
    }
}, _actionOwner];

_actionOwner addAction [format["(%1) 무작위 1개 즉시 올리기", _rangeName], 
{
    [] spawn
    {
        if ( missionNamespace getVariable "AHC_Targeting") exitWith
        {
            systemChat "이미 진행중";
        };

        missionNamespace setVariable["AHC_Targeting", true];
        _time = missionNamespace getVariable "AHC_RangeTime";
        systemChat format["타겟 등장 후 퇴장까지 %1 초", _time];

        missionNamespace setVariable ["noPop", true, true];

        _owner = missionNamespace getVariable "AHC_RangeOwner";
        playSound3D ['a3\dubbing_f_beta\firing_drills\CheckPoints\firing_drills_checkpoints_ROF_18.ogg', _owner];
        [['SPEAKER', "다음으로!", 0]] spawn BIS_fnc_EXP_camp_playSubtitles;
        BIS_fnc_EXP_camp_playSubtitles_terminate = true; 
        
        missionNamespace setVariable["AHC_RangeResult", false];
        (missionNamespace getVariable "AHC_Range") apply { _x animateSource ["terc", 1]};

        sleep 0.3;

        _targets = missionNamespace getVariable "AHC_Range";
        _randomTarget = selectRandom _targets;
        _randomTarget animateSource ["terc", 0];

        // 모든 표적에 이벤트 핸들러 추가
        {
            [_x] call TargetHit;
        } forEach _targets;

        sleep _time;

        _targetResult = missionNamespace getVariable "AHC_RangeResult";
        if ( !_targetResult) then
        {
            [] call TargetFail;
        };

        // 이벤트 핸들러 제거
        {
            _x animateSource ["terc", 1];
            _x removeAllEventHandlers "Hit";
        } forEach _targets;
        missionNamespace setVariable["AHC_Targeting", false];
    }
},_actionOwner];