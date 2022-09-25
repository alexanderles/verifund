// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import './interfaces/ICampaign.sol';
import './libraries/SafeMath.sol';

contract Ownable {

  address public owner;

  modifier onlyOwner {
    require(msg.sender == owner, "Ownable: You are not the owner, Bye.");
    _;
  }

  constructor () public {
    owner = msg.sender;
  }
}

contract Campaign is ICampaign, Ownable {
    using SafeMath for uint;

    string private s_name;
    uint256 private immutable i_targetAmount;
    address private immutable i_owner;
    address[] private s_whiteList;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint value);
    event CampaignCreated(address campaign, string name, uint256 targetAmount, address[] whiteList);

    constructor(address[] memory wl, uint256 targetAmount) {
       i_targetAmount = targetAmount;
       s_whiteList = wl;
       i_owner = msg.sender;
       emit CampaignCreated(address(this), s_name, i_targetAmount, s_whiteList);
    }

    function _transfer(address from, address to, uint value) internal {
        balanceOf[from] = balanceOf[from].sub(value);
        balanceOf[to] = balanceOf[to].add(value);
        emit Transfer(from, to, value);
    }

    function transfer(address to, uint value) external returns (bool) {
        _transfer(msg.sender, to, value);
        return true;
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {
        fund(msg.sender, msg.value);
    }

    function withdraw(address to, uint256 val) external onlyOwner returns (bool) {
        for (uint i=0; i < s_whiteList.length; i++) {
            if (to == s_whiteList[i]) {
                _transfer(address(this), to, val);
                break;
            }
        }
    }

    function fund(address from, uint256 val) public returns (bool) {
        _transfer(from, address(this), val);
    }

    function getTargetAmount() external view returns (uint256) {
        return i_targetAmount;
    }
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
    function getWhiteList() external view returns (address[] memory) {
        return s_whiteList;
    }
    function getName() external view returns (string memory) {
        return s_name;
    }   
}