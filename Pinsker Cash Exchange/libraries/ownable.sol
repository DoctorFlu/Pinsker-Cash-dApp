// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.0 (access/Ownable.sol)

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

pragma solidity ^0.8.0;

/**
 * A simplified access control mechanism, where an owner is granted exclusive
 * access to specific functions.
 *
 * The owner is the one that deploys the contract. To use this module, modify your
 * contract to be "is Ownable", this will give you access to the `onlyOwner` modifier,
 * which can be applied to your functions to restrict their use to just the owner.
 */
abstract contract Ownable {
    address private _owner;

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _owner = msg.sender;
    }

    /**
     * Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _; // executes the body of the function at this point (after the require passed)
    }
}