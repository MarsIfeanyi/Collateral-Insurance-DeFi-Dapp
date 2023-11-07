// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title  Crypto wallet insurance:
 * @author Marcellus Ifeanyi
 * @notice an insurance protocol that helps owners of smart contract wallets stay protected from hackers. The owners will be paying an insurance amount per month, set by the protocol.
 */
contract InsuranceProtocol {
    uint premiumPrice;
    address client;

    constructor(uint _premiumPrice, address _client) {
        premiumPrice = _premiumPrice;
        client = _client;
    }

    struct Client {
        uint validEnd;
        uint lastClaimed;
    }

    mapping(address => Client) public clients;

    // CUSTOM ERROR
    error ActivePremiumAvailable();
    error InsufficientAmount();
    error LastClaimHappenedThisYear();
    error AmountExceeds2YearsPremium();
    error InsufficientFundsToSendTheUser();

    function payMonthlyPremium() external payable {
        if (block.timestamp < clients[client].validEnd) {
            revert ActivePremiumAvailable();
        }

        if (msg.value < premiumPrice) {
            revert InsufficientAmount();
        }

        clients[client].validEnd = block.timestamp + 30 days;
    }

    function payYearlyPremium() external payable {
        if (block.timestamp < clients[client].validEnd) {
            revert ActivePremiumAvailable();
        }

        if (msg.value != (premiumPrice * 12 * 10) / 9) {
            revert InsufficientAmount();
        }

        clients[client].validEnd = block.timestamp + 365 days;
    }

    function claimInsurance(uint _value) external {
        if (block.timestamp <= clients[client].lastClaimed + 365 days) {
            revert LastClaimHappenedThisYear();
        }

        if (_value > premiumPrice * 12 * 2) {
            revert AmountExceeds2YearsPremium();
        }

        if (address(this).balance < _value) {
            revert InsufficientFundsToSendTheUser();
        }

        clients[client].lastClaimed = block.timestamp;
        payable(client).transfer(_value);
    }

    function getPremiumPrice() external view returns (uint) {
        return (premiumPrice);
    }

    function getClientDetails() external view returns (uint, uint) {
        return (clients[client].validEnd, clients[client].lastClaimed);
    }
}
