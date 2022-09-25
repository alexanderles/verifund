// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import '../Campaign.sol';
interface  IVerifundFactory {

    function createCampaign(string memory name, address[] memory whiteList, uint256 targetAmount) external;
    function getAllCampaigns() external view returns (Campaign[] memory);
}