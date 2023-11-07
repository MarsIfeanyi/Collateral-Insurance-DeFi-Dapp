# Collateral and Insurance Protocol Contract

This is Solidity-based smart contracts in this project. The contracts enable users to purchase insurance and collateral for crypto-backed loans.

## Table of Contents

- [Collateral and Insurance Protocol Contract](#collateral-and-insurance-protocol-contract)
  - [Table of Contents](#table-of-contents)
  - [Overview-Description](#overview-description)
  - [Deploying and Verifying the Contracts on Sepolia testnet](#deploying-and-verifying-the-contracts-on-sepolia-testnet)
  - [Verified Contract Addresses](#verified-contract-addresses)
  - [Authors](#authors)
  - [License](#license)

## Overview-Description

The project includes a `factory contract model`, which allows users to create either `insurance contracts` or `collateral protection contracts`.
The factory contract can deploy instances of either a child contract based on user preference.

The insurance contract allows users to pay their premiums either `monthly` or `annually`.
The `collateral management contract`, on the other hand, monitors the value of the user's collateral.
If the collateral value drops below 20, the contract liquidates the collateral. Users can also repay their loans to retrieve their collateral.

## Deploying and Verifying the Contracts on Sepolia testnet

- ![01](./images/01.png)

- ![02](./images/02.png)

- ![03](./images/03.png)

- ![04](./images/04.png)

## Verified Contract Addresses

- Insurance Contract:
  https://sepolia.etherscan.io/address/0x6d5100a503560ac86b54f32541220591d44e239e

- Collateral Contract:
  https://sepolia.etherscan.io/address/0x91522f4357f261d81d6a905455df7e5ca850e349

- Factory Contract:
  https://sepolia.etherscan.io/address/0x738cc49d9398aea8130625677c29d74851261890

## Authors

Marcellus Ifeanyi
[@metacraftersio](https://twitter.com/Mars_Energy)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
