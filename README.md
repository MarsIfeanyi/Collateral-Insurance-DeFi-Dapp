# INSURANCE AND COLATERAL PROTECTION CONTRACT

This Solidity program is a simple implementation of an "Insurance contract" and a "Colateral protection contract", it implements the factory contract model to allow individuals create either an insurance contracts or a collateral protection contract for crypto backed loans.

## Description

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract is a factory contract that deploys new instances of a child contract depending on the users choice. The factory is able to deploy an insurance contract or a Collateral contract. The insurance contract allows a user to pay his premium monthly or annually depending on the users choice while the Collateral management contract implements a logic that helps check if the value of a user's collateral has dropped below 20, of which if it does then the users collateral is liquidated, the user cal also repay back his loan to receive back his collateral.

## Contract Addresses

- Insurance Contract:
  0x88300BeCF48153Ee71F148b7aE744424De52D84D

- Collateral Contract:
  0x871B08f40015CeC00c35adf7703b7C3fd68e1b70

- Factory Contract:
  0x127de15B163C5662892520473f1EF45f3FF51274;

## Authors

Marcellus Ifeanyi
[@metacraftersio](https://twitter.com/Mars_Energy)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
