// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ICampaign {
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);

    function getTargetAmount() external view returns (uint256);
    function getBalance() external view returns (uint256);
    function getWhiteList() external view returns (address[] memory);
    function getName() external view returns (string memory);

    function withdraw(address, uint256) external returns (bool);
    function fund(address, uint256) external returns (bool);
} 