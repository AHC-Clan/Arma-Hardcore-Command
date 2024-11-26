params["_playerName", "_findVariable"];

if ( isNil "_playerName") exitWith
{
    systemChat "첫번째 검색할 이름을 입력하세요.";
};

if ( isNil "_findVariable") exitWith
{
    systemChat "두번째 검색 db명을 입력하세요.";
};

{
    if (toLower trim name _x == toLower trim _playerName) exitWith
    {
        _result = profileNamespace getVariable format["%1_%2", _findVariable, getPlayerUID _x];
        systemChat format["%1의 %2 조회 결과 : %3", name _x, _findVariable, _result];
    };
} foreach allPlayers;