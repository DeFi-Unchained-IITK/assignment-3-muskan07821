// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank{

    event deposit(address depositedAccount, uint256 depositedAmmount);
    event withdraw(address withdrawAccount, uint256 withdrawAmmount);
    event transfer(address transferAccount, uint256 transferAmmount);

    mapping (address=> uint256) private bankAccount;

    function Deposit() external payable {
        bankAccount[msg.sender] += msg.value;
        emit deposit(msg.sender, msg.value);
    }

    function Withdraw(uint256 withdrawAmount) external payable {
        require(withdrawAmount <= bankAccount[msg.sender], "Amount you are trying to withdraw is more than you have in your bank account!");
        (bool sent,) = (msg.sender).call{value: withdrawAmount}("");
        require(sent, "Failed to send Ether");
        bankAccount[msg.sender] -= withdrawAmount;
        emit withdraw(msg.sender, withdrawAmount);
    }

    function Transfer(address toAccount, uint256 transferAmmount) external {
        require(transferAmmount <= bankAccount[msg.sender], "Amount you are trying to transfer is more than you have in your bank account!");
        bankAccount[msg.sender] -= transferAmmount;
        bankAccount[toAccount] += transferAmmount;
        emit transfer(msg.sender, transferAmmount);
    }

    function CheckBalance() external view returns(uint256){
        return bankAccount[msg.sender];
    }
}