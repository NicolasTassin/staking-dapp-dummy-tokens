// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

import "./Tether.sol";
import "./Dummy_token.sol";

contract Staking_dapp {

    string public name = "Staking Dapp";
    address public owner;
    dummy public dummy_token;
    Tether public tether_token;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaked;

    constructor(dummy _dummyToken, Tether _tetherToken) public {

        dummy_token = _dummyToken;
        tether_token = _tetherToken;
        owner = msg.sender;
    }

    function stakeToken(uint _amount) public{
        require(_amount > 0, "Amount should be greater than 0");
        tether_token.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;
        
    }
}