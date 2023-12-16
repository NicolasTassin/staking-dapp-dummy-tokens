// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract Wazllet {
    address owner;
    uint256 balance;
    mapping(address => uint256) public balances;

    event Deposit(address indexed _from, uint256 _value);
    event Withdrawal(address indexed _to, uint256 _value);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can withdraw");
        _;
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= balance, "Insufficient balance");
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }
}
