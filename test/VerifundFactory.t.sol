// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/VerifundFactory.sol";

contract VerifundFactoryTest is Test {

    VerifundFactory factory;
    Campaign campaign1;

    function setUp() public {
        factory = VerifundFactory();
        campaign1 = Campaign();
    }

    function testCreateCampaign() public {

    }

    function testAllCampaigns() public {
        
    }
}