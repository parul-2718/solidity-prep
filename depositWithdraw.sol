//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract depositWithdraw{


    address owner;
    constructor() {
      owner = msg.sender;
   }

    uint256 contractBalance = address(this).balance;

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function deposit()public payable{

        contractBalance+=msg.value;
    }
    

    function sendPayment(address payable recipient, uint256 amt) public onlyOwner{
        require(amt<contractBalance);
        (bool success, ) = recipient.call{value: amt}("");
        require(success, "Payment failed.");
        contractBalance-=amt;
    }


    function getBalance(address recipient) public view returns(uint256){
        return recipient.balance;
    }

    
}
