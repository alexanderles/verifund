// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import './interfaces/IVerifundFactory.sol';
import './Campaign.sol';

contract VerifundFactory is IVerifundFactory {

    Campaign[] private _campaigns;

    function createCampaign(string memory name, address[] memory whiteList, uint256 targetAmount) external {
        Campaign campaign = new Campaign(whiteList, targetAmount);
        _campaigns.push(campaign);
    }

    function getAllCampaigns() external view returns (Campaign[] memory) {
        return _campaigns;
    }
}