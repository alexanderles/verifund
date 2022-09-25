// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import './interfaces/IVerifundFactory.sol';
import './Campaign.sol';

contract VerifundFactory is IVerifundFactory {

    address[] private _campaigns;
    event CampaignCreated(address indexed c, address[] whiteList, uint256 indexed targetAmount);

    function createCampaign(address[] memory whiteList, uint256 targetAmount) external override {
        
        address campaign = address(new Campaign(whiteList, targetAmount));
        _campaigns.push(campaign);
        emit CampaignCreated(campaign, whiteList, targetAmount);
    }

    function getAllCampaigns() external view override returns (address[] memory) {
        return _campaigns;
    }
}