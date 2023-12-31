// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "./InsuranceProtocol.sol";
import "./CollateralProtocol.sol";
import "./interface/IERC20.sol";

contract InsuranceProtocolFactory {
    mapping(address => InsuranceProtocol) public insurancePools;
    mapping(address => ColateralProtocol) public colateralPools;
    address loanToken;
    address Admin;

    address[] public insurancePoolAddresses;
    address[] public colateralPoolAddresses;

    modifier isValidPool(InsuranceProtocol pool) {
        require(address(pool) != address(0), "Invalid pool address");
        _;
    }

    constructor(address _loanToken, address _admin) {
        Admin = _admin;
        loanToken = _loanToken;
    }

    function createInsurancePool(uint _premium) external {
        InsuranceProtocol newPool = new InsuranceProtocol(_premium, msg.sender);
        insurancePools[msg.sender] = newPool;
        insurancePoolAddresses.push(address(newPool));
    }

    // for loan of $1000 worth of tokens, we needs a colateral of $1500 (1 ether)
    // colateral Eth price must be above $1000 / eth
    function createColateralPool() external payable {
        uint ethValue = (msg.value * getEthPrice()) / 10 ** 18;
        uint _LoanAmount = (ethValue * (1000 * 10 ** 18)) / 1500;
        ColateralProtocol newPool = new ColateralProtocol(
            msg.value,
            _LoanAmount,
            msg.sender,
            address(this),
            loanToken
        );
        colateralPools[msg.sender] = newPool;
        colateralPoolAddresses.push(address(newPool));
        IERC20(loanToken).transfer(msg.sender, _LoanAmount);
        payable(address(newPool)).transfer(msg.value);
    }

    function getInsurancePools() external view returns (address[] memory) {
        return insurancePoolAddresses;
    }

    function getColateralPools() external view returns (address[] memory) {
        return colateralPoolAddresses;
    }

    function getEthPrice() internal pure returns (uint) {
        // oracle implementation to get ethPrice
        return 1500;
    }
}
