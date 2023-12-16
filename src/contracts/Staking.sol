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
    mapping(address => bool) public isStaking;

    constructor(dummy _dummyToken, Tether _tetherToken) public {

        dummy_token = _dummyToken;
        tether_token = _tetherToken;
        owner = msg.sender;
    }

    function stakeToken(uint _amount) public{
        require(_amount > 0, "Amount should be greater than 0");
        tether_token.transferFrom(msg.sender, address(this), _amount);
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
        
    }

    function unstakeToken() public {
        uint balance = stakingBalance[msg.sender];
        require(balance > 0, "Balance is empty");
        tether_token.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

    function issueReward() public {
        require(msg.sender == owner, "Caller of this function must be the owner");
        // issue tokens to all stakers
        for (uint256 index = 0; index < stakers.length; index++) {
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if ( balance > 0 ){
                dummy_token.transfer(recipient, balance);
            }
        }
    }
}