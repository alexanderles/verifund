// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Campaign.sol";

contract CampaignTest is Test {
    Campaign campaign;
    address[] wl1 = [0x00000000];
    address dummy = 0x00000000;

    function setUp() public {
        campaign = Campaign(wl1, 10);
    }

    function testTransfer() public {

    }
}