// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 creador de la moneda
// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db  le cargo credito
// 0x617F2E2fD72FD9D5503197092aC168c91465E7f2   le cargo 500
import "hardhat/console.sol";

contract Coin{
    address public minter; 
    mapping (address => uint) public balances; // dictionary

    event Sent(address from, address to, uint amount);

    constructor(){
        minter = msg.sender;
    }
/*
    function getMinter() public view returns(address){
        return minter;
    }
    function getBalance(address receiver) public view returns(uint){
        return balances[receiver];
    }
*/
    function mint(address receiver, uint amount) public{
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    error InsuficientBalance(uint requested, uint available);

    function send(address receiver, uint amount) public{
        console.log('MG Balance', balances[msg.sender]);
        if(amount > balances[msg.sender])
            revert InsuficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount; 
        emit Sent(msg.sender, receiver, amount);
    }

}