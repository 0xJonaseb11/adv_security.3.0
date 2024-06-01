// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VaultCEISecured {

    mapping(address => uint) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint bal = balances[msg.sender];
        // checks
        require(bal > 0, "Insufficient balances");
        // Effects
        balances[msg.sender] = 0;
        // Interaction
        (bool sent, ) = msg.sender.call{value: bal}("");
        require(sent, "Transfer failed");
    }
}