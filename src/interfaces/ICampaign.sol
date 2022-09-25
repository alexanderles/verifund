// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface ICampaign {

    function getTargetAmount() external view returns (uint256);
    function getBalance() external view returns (uint256);
    function getWhiteList() external view returns (address[] memory);

    function withdraw(address payable to, uint256 val) external;
    function fund() external payable;
} 