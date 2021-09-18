//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Owner.sol";

contract Allowance is Owner{
    
    event AllowanceChanced(address indexed _forWho,address indexed _byWhom,uint _oldAmount,uint _newAmount);
    mapping(address => uint) public allowance;
    
    function setAllowance(address _who,uint _amount) public onlyOwner{
        emit AllowanceChanced(_who,msg.sender,allowance[_who],_amount);
        allowance[_who] = _amount;
    }
    
    function reduceAllowance(address _who,uint _amount) internal OwnerOrAllowed(_amount){
        emit AllowanceChanced(_who,msg.sender,allowance[_who],allowance[_who] - _amount);
        allowance[_who] -= _amount;
    }
    
    modifier OwnerOrAllowed(uint _amount) {
        require(IsOwner() || allowance[msg.sender] >= _amount, "You are not allowed.");
        _;
    }
    
    
    
}