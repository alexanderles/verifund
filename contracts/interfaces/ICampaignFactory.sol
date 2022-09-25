// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import '../campaign.sol';
interface  ICampaignFactory {

    function createCampaign(string memory name, address[] memory whiteList, uint256 targetAmount) external;
    function allCampaigns(uint256 limit, uint256 offset) external view returns (Campaign[] memory coll);
}