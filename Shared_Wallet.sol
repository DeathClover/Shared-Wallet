//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Owner.sol";
import "./Allowance.sol";

contract SharedWallet is Owner,Allowance{
    
    event MoneySent(address indexed _toWhom,uint _amount);
    event MoneyReceived(address indexed _fromWhom,uint _amount);
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
   
    function withdrawMoney(address payable _to, uint _amount) public OwnerOrAllowed(_amount) {
        require(address(this).balance >= _amount,"Contract does not own enough money.");
        if (!IsOwner()){
            reduceAllowance(msg.sender,_amount);
        }
        emit MoneySent(_to,_amount);
        _to.transfer(_amount);
        
    }
    
    receive() external payable {
        emit MoneyReceived(msg.sender,msg.value);
    }
}
    
 