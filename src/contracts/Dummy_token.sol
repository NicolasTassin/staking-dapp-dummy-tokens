// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract dummy {
    string public name = "Dummy Token";
    string public symbol = "DUM";
    uint public totalSupply = 100000000000000000;
    uint public decimals = 18;

    event Transfer (
        address indexed _from,
        address indexed _to,
        uint indexed _value
    );
    event Approve (
        address indexed _owner,
        address indexed _spender,
        uint indexed _value
    );

    mapping(address => uint256) public balance;
    mapping(address => mapping( address => uint256)) public allowance;

    constructor() {
        balance[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns(bool success) {
        require(balance[msg.sender] >= _value, "Not enough funds");
        balance[msg.sender] -= _value;
        balance[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve( address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approve(msg.sender, _spender, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_value <= balance[_from], "Not enough funds");
        require(_value <= allowance[_from][msg.sender], "Not enough allowance");
        balance[_from] -= _value;
        balance[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }


}