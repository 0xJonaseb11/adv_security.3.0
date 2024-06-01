// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @dev The below contract is prone to Cross-Function Reentrancy attack
 */
contract CrossFunctionReentrancy {

    mapping(address => uint) private userBalances;

    function transfer(address to, uint amount) public {
        if (userBalances[msg.sender] >= amount) {
            userBalances[to] += amount;
            userBalances[msg.sender] -= amount;
        }
    }

    function withdrawBalance() public {
        uint amountToWithdraw = userBalances[msg.sender];
        (bool success, ) = msg.sender.call{value: amountToWithdraw}("");
           // At this point, the caller's code is executed, and can call transfer()
           require(success, "Transfer failed");
           userBalances[msg.sender] = 0;

    }

}