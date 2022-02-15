// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

// Please check out the OpenZeppelin contracts for ERC20 tokens!
// Links can be found in the the respective solidity files
import "../interfaces/IERC20.sol";
import '../interfaces/erc20_interface.sol';
import '../libraries/ownable.sol';


// Your token contract
// TODO: Replace "Token" with your token name!
contract Token is Ownable, IERC20 {
    string public constant symbol = '';                 // TODO: Give your token a symbol
    string public constant name = '';                   // TODO: Give your token a name

    constructor() ERC20(name, symbol) {}

    // ============================================================
    //                    FUNCTIONS TO IMPLEMENT
    // ============================================================

    /**
     * Creates `amount` tokens, increasing the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address (the "Black Hole").
     *
     * Requirements:
     *  - only the owner of this contract can mint new tokens
     *  - the account who recieves the minted tokens cannot be the zero address
     *  - you can change the inputs or the scope of your function, as needed
     */
    function _mint(uint amount) 
        public 
        onlyOwner
    {
        /******* TODO: Implement this function *******/
    }

    /**
     * Disables the ability to mint tokens in the future.
     *
     * Requirements:
     *  - only the owner of this contract can disable minting
     *  - once you disable minting, you should never be able to mint ever again. never.
     *  - you can change the inputs or the scope of your function, as needed
     */
    function _disable_mint()
        public
        onlyOwner
    {
        /******* TODO: Implement this function *******/
    }
