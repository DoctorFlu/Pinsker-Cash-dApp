// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "../interfaces/IERC20.sol";
import './token.sol';
import '../libraries/ownable.sol';

/* This exchange is based off of Uniswap V1. The original whitepaper for the constant product rule
 * can be found here:
 * https://github.com/runtimeverification/verified-smart-contracts/blob/uniswap/uniswap/x-y-k.pdf
 */

contract TokenExchange is Ownable {
    address public admin;

    address tokenAddr;                              // TODO: Paste token contract address here.
    Token private token = Token(0x614e948d324d91fc889ae95f7a964aa94314a837);         // TODO: Replace "Token" with your token class.             

    // Liquidity pool for the exchange
    uint public token_reserves = 0;
    uint public eth_reserves = 0;

    // Constant: x * y = k
    uint public k;
    
    // liquidity rewards
    uint private swap_fee_numerator = 0;       // TODO Part 5: Set liquidity providers' returns.
    uint private swap_fee_denominator = 100;
    
    event AddLiquidity(address from, uint amount);
    event RemoveLiquidity(address to, uint amount);

    constructor() 
    {
        admin = msg.sender;
    }


    /**
     * Initializes a liquidity pool between your token and ETH.
     * 
     * This is a payable function which means you can send in ETH as a quasi-parameter. In this
     * case, the amount of eth sent to the pool will be in msg.value and the number of tokens will
     * be amountTokens.
     *
     * Requirements:
     *  - the liquidity pool should be empty to start
     *  - the sender should send positive values for each
     */
    function createPool(uint amountTokens)
        external
        payable
        onlyOwner
    {
        // This function is already implemented for you; no changes needed

        // require pool does not yet exist
        require (token_reserves == 0, "Token reserves was not 0");
        require (eth_reserves == 0, "ETH reserves was not 0.");

        // require nonzero values were sent
        require (msg.value > 0, "Need ETH to create pool.");
        require (amountTokens > 0, "Need tokens to create pool.");

        token.transferFrom(msg.sender, address(this), amountTokens);
        eth_reserves = msg.value;
        token_reserves = amountTokens;
        k = eth_reserves.mul(token_reserves);
    }

    // Given an amount of tokens, calculates the corresponding amount of ETH 
    // based on the current exchange rate of the pool
    
    function amountTokenGivenETH(uint amountToken) 
        public 
        view
        returns (uint)
    {
        /******* TODO: Implement this function *******/
        /* 
            Calculate how much ETH is of equivalent worth based on the current exchange rate.
        */
    }

    // Given an amount of ETH, calculates the corresponding amount of tokens 
    // based on the current exchange rate of the pool.

    function amountETHGivenToken(uint amountETH)
        public
        view
        returns (uint)
    {
        /******* TODO: Implement this function *******/
        /*
            Calculate how much of your token is of equivalent worth based on the current exchange rate.
        */
    }

    /**
     * Adds liquidity given a supply of ETH (sent to the contract as msg.value).
     *
     * Calculates the liquidity to be added based on what was sent in and the prices. If the
     * caller possesses insufficient tokens to equal the ETH sent, then the transaction must
     * fail. A successful transaction should update the state of the contract, including the
     * new constant product k, and then Emit an AddLiquidity event.
     */
    function addLiquidity() 
        external 
        payable
    {
        /******* TODO: Implement this function *******/
        /*
            Calculate the liquidity to be added based on what was sent in and the prices.
            If the caller possesses insufficient tokens to equal the ETH sent, then transaction must fail.
            Update token_reserves, eth_reserves, and k.
            Emit AddLiquidity event.
        */
    }


    /**
     * Removes liquidity given the desired amount of ETH to remove.
     *
     * Calculates the amount of your tokens that should be also removed. If the caller is not
     * entitled to remove the desired amount of liquidity, the transaction should fail. A
     * successful transaction should update the state of the contract, including the new constant
     * product k, transfer the ETH and Token to the sender and then Emit an RemoveLiquidity event.
     */
    function removeLiquidity(uint amountETH)
        public 
        payable
    {
        /******* TODO: Implement this function *******/
        /*
            Calculate the amount of your tokens that should be also removed.
            Transfer the ETH and Token to the provider.
            Update token_reserves, eth_reserves, and k.
            Emit RemoveLiquidity event.
        */
    }

    /**
     * Removes all liquidity that the sender is entitled to withdraw.
     *
     * Calculate the maximum amount of liquidity that the sender is entitled to withdraw and then
     * calls removeLiquidity() to remove that amount of liquidity from the pool.
     */
    function removeAllLiquidity()
        external
        payable
    {
        /******* TODO: Implement this function *******/
        /*
            Decide on the maximum allowable ETH that msg.sender can remove.
            Call removeLiquidity().
        */
    }

    /***  Define helper functions for liquidity management here as needed: ***/

    /**
     * Swaps amountTokens of Token in exchange for ETH.
     *
     * Calculates the amount of ETH that should be swapped in order to keep the constant
     * product property, and transfers that amount of ETH to the provider. If the caller
     * has insufficient tokens, the transaction should fail. If performing the swap would
     * exhaust the total supply of ETH inside the exchange, the transaction must fail.
     *
     * Part 4 – Expand the function to take in additional parameters as needed. If the
     *          exchange rate is greater than the slippage limit, the swap should fail.
     *
     * Part 5 – Only exchange amountTokens minus the fee taken out for liquidity providers
     *          and keep track of the liquidity fees to be added back into the pool.
     *
     * NOTE: You can change the inputs, or the scope of your function, as needed.
     */
    function swapTokensForETH(uint amountTokens)
        external 
        payable
    {
        /******* TODO: Implement this function *******/
        /* 
            Calculate amount of ETH should be swapped based on exchange rate.
            Transfer the ETH to the provider.
            If the caller possesses insufficient tokens, transaction must fail.
            If performing the swap would exhaus total ETH supply, transaction must fail.
            Update token_reserves and eth_reserves.

            Part 4: 
                Expand the function to take in addition parameters as needed.
                If current exchange_rate > slippage limit, abort the swap.
            
            Part 5:
                Only exchange amountTokens * (1 - liquidity_percent), 
                    where % is sent to liquidity providers.
                Keep track of the liquidity fees to be added.
        */


        _checkRounding();
    }



    /**
     * Swaps msg.value ETH in exchange for your tokens.
     *
     * Calculates the amount of tokens that should be swapped in order to keep the constant
     * product property, and transfers that number of tokens to the sender. If performing
     * the swap would exhaust the total supply of tokens inside the exchange, the transaction
     * must fail.
     *
     * Part 4 – Expand the function to take in additional parameters as needed. If the
     *          exchange rate is greater than the slippage limit, the swap should fail.
     *
     * Part 5 – Only exchange amountTokens minus the fee taken out for liquidity providers
     *          and keep track of the liquidity fees to be added back into the pool.
     *
     * NOTE: You can change the inputs, or the scope of your function, as needed.
     */
    function swapETHForTokens()
        external
        payable 
    {
        /******* TODO: Implement this function *******/
        /*
            Calculate amount of your tokens should be swapped based on exchange rate.
            Transfer the amount of your tokens to the provider.
            If performing the swap would exhaus total token supply, transaction must fail.
            Update token_reserves and eth_reserves.

            Part 4: 
                Expand the function to take in addition parameters as needed.
                If current exchange_rate > slippage limit, abort the swap. 
            
            Part 5: 
                Only exchange amountTokens * (1 - %liquidity), 
                    where % is sent to liquidity providers.
                Keep track of the liquidity fees to be added.
        */



        _checkRounding();

    }

    /** 
     * Checks that users are not able to get "free money" due to rounding errors.
     *
     * A liquidity provider should be able to input more (up to 1) tokens than they are theoretically
     * entitled to, and should be able to withdraw less (up to -1) tokens then they are entitled to.
     *
     * Checks for Math.abs(token_reserves * eth_reserves - k) < (token_reserves + eth_reserves + 1));
     * to account for the small decimal errors during uint division rounding.
     */
    function _checkRounding() private view {
        uint check = token_reserves * eth_reserves;
        if (check >= k) {
            check = check - k;
        }
        else {
            check = k - check;
        }
        assert(check < (token_reserves + eth_reserves + 1));
        k = token_reserves * eth_reserves;             // reset k due to small rounding errors
    }
}
