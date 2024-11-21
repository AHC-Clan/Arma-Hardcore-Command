params ["_playerName"];

if ( isNil "_playerName") exitWith
{
    systemChat "첫번째 검색할 플레이어 이름을 입력해주세요.";
};

_allPlayerUID = "";

{
    if ( _playerName == "") then
    {
        _allPlayerUID = _allPlayerUID + format["%1, %2%3", name _x, getPlayerUID _x, toString [10]];
    };

    if (toLower trim name _x == toLower trim _playerName) exitWith
    {
        _text = format["%1, %2", name _x, getPlayerUID _x];
        systemChat format["%1 복사되었습니다.", _text];
        copyToClipboard _text;
    };
} foreach allPlayers;

if ( _allPlayerUID != "") then
{
    systemChat _allPlayerUID;
    copyToClipboard _allPlayerUID;
};
