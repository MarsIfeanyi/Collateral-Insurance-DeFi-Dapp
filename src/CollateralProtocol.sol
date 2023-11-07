// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./interface/IERC20.sol";

/**
 * @title Collateral protection for crypto backed loans
 * @author Marcellus Ifeanyi
 * @notice
 */

contract ColateralProtocol {
    address public owner;
    address factory;
    address loanToken;
    uint256 public collateralAmount;
    uint256 public loanAmount;
    uint256 public lastCollateralCheckTimestamp;
    bool loanLiquidated;
    bool loanRepayed;

    event CollateralCheck(
        address indexed owner,
        uint256 currentCollateralValue
    );

    // CUSTOM ERROS
    error OnlyOwner();
    error CollateralValueCanBeCheckedOncePerMonth();
    error ExcessPaymentAmount();
    error LoanAlreadyLiquidated();

    constructor(
        uint256 _collateralAmount,
        uint256 _loanAmount,
        address _client,
        address _factory,
        address _loanToken
    ) {
        owner = _client;
        collateralAmount = _collateralAmount;
        loanAmount = _loanAmount;
        lastCollateralCheckTimestamp = block.timestamp;
        factory = _factory;
        loanToken = _loanToken;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert OnlyOwner();
        _;
    }

    function checkCollateralValue() external {
        // checks that collateral value is checked at most once per month
        if (block.timestamp < lastCollateralCheckTimestamp + 1 days) {
            revert CollateralValueCanBeCheckedOncePerMonth();
        }
        // Liquidate if the
        bool liquidate = isPriceDropGreaterThan20Percent(
            (getEthPrice() * collateralAmount)
        );

        if (liquidate == true) {
            loanLiquidated = true;
        }

        // Update the timestamp of the last collateral check
        lastCollateralCheckTimestamp = block.timestamp;

        // Emit an event to record the collateral check
        emit CollateralCheck(owner, getEthPrice());
    }

    function getLoanAmount() external view returns (uint256) {
        return loanAmount;
    }

    function repayLoan(uint _repaymentAmount) external {
        if (loanAmount > _repaymentAmount) {
            revert ExcessPaymentAmount();
        }

        if (loanLiquidated) {
            revert LoanAlreadyLiquidated();
        }

        IERC20(loanToken).transferFrom(msg.sender, factory, _repaymentAmount);
        loanAmount -= _repaymentAmount;
        if (loanAmount == 0) {
            loanRepayed = true;
            payable(owner).transfer(collateralAmount);
        }
    }

    function getEthPrice() internal pure returns (uint) {
        // oracle implementation to get ethPrice
        return 1500;
    }

    function isPriceDropGreaterThan20Percent(
        uint256 currentPrice
    ) public view returns (bool) {
        uint initialCollateralPrice = (loanAmount * 1500) / (1000 * 10 ** 18);
        // Calculate the price drop percentage
        uint256 priceDropPercentage = ((initialCollateralPrice - currentPrice) *
            100) / initialCollateralPrice;

        // Check if the price has dropped by 20% or more
        return priceDropPercentage >= 20;
    }

    receive() external payable {}
}
