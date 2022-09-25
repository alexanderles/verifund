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

    uint256 private i_targetAmount;
    uint256 private targetAcc;
    bool private _targetReached;
    address private immutable i_owner;
    address[] private s_whiteList;

    mapping(address => uint256) private amountDonated;

    event ReceivedFunds(address indexed from, uint256 indexed amount, uint256 indexed currentAmount);
    event FundsWithdrawn(address indexed to, uint256 indexed amount);
    event TargetReached(uint256 total);

    constructor(address[] memory wl, uint256 targetAmount) public {
       i_targetAmount = targetAmount;
       s_whiteList = wl;
       i_owner = msg.sender;
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {
        amountDonated[msg.sender] = amountDonated[msg.sender] + msg.value;
        targetAcc = targetAcc + msg.value;
        emit ReceivedFunds(msg.sender, msg.value, targetAcc);
        if (targetAcc >= i_targetAmount) {
            if (! _targetReached) {
                emit TargetReached(targetAcc);
                _targetReached = true;
            }
        }
    }

    // Fallback function is called when msg.data is not empty
    fallback() external payable {
        amountDonated[msg.sender] = amountDonated[msg.sender] + msg.value;
        targetAcc = targetAcc + msg.value;
        emit ReceivedFunds(msg.sender, msg.value, targetAcc);
        if (targetAcc >= i_targetAmount) {
            if (! _targetReached) {
                emit TargetReached(targetAcc);
                _targetReached = true;
            }
        }
    }

    function withdraw(address payable to, uint256 val) external override onlyOwner {
        for (uint i=0; i < s_whiteList.length; i++) {
            if (to == s_whiteList[i] && address(this).balance > val) {
                to.transfer(val);
                emit FundsWithdrawn(to, val);
            }
        }
    }

    function fund() public payable override {
        amountDonated[msg.sender] = amountDonated[msg.sender] + msg.value;
        targetAcc = targetAcc + msg.value;
        emit ReceivedFunds(msg.sender, msg.value, targetAcc);
        if (targetAcc >= i_targetAmount) {
            if (! _targetReached) {
                emit TargetReached(targetAcc);
                _targetReached = true;
            }
        }
    }

    function getTargetAmount() external view override returns (uint256) {
        return i_targetAmount;
    }
    function getBalance() external view override returns (uint256) {
        return address(this).balance;
    }
    function getWhiteList() external view override returns (address[] memory) {
        return s_whiteList;
    } 
}