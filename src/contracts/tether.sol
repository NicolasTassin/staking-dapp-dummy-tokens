// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract Tether {
    string public name = "Dummy Thether Token";
    string public symbol = "Thether";
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

    constructor() public {
        balance[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns(bool) {
        require(balance[msg.sender] >= _value, "Not enough funds");
        balance[msg.sender] -= _value;
        balance[_to] += value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }


}