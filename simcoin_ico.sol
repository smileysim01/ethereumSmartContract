/* 
SPDX-License-Identifier: UNLICENSED
Simcoin ICO
* @author: Simran
*/

pragma solidity ^0.8.22;

contract simcoin_ico {
    uint public max_simcoins = 1000000;     //Max simcoins available for sale
    uint public usd_to_simcoin = 1000;      // USD to Simcoins conversion rate
    uint public total_simcoins_bought = 0;  // Total Simcoins bought by investors
    
    // Mapping from the investor address to its equity in Simcoins and USD
    mapping(address => uint) equity_simcoins;
    mapping(address => uint) equity_usd;

    //Checking if an investor can buy Simcoins
    modifier can_buy_simcoins(uint usd_invested){
        require(usd_invested * usd_to_simcoin + total_simcoins_bought <= max_simcoins);
        _;
    }

    //Getting equity in Simcoins of investor
    function equity_in_simcoins(address investor) external view returns(uint) {
        return equity_simcoins[investor];
    }

    //Getting equity in USD of investor
    function equity_in_usd(address investor) external view returns(uint) {
        return equity_usd[investor];
    }

    //Buying Simcoins
    function buy_simcoins(address investor, uint usd_invested) external
    can_buy_simcoins(usd_invested) {
        uint simcoins_bought = usd_invested * usd_to_simcoin;
        equity_simcoins[investor] += simcoins_bought;
        equity_usd[investor] += equity_simcoins[investor]/1000;
        total_simcoins_bought += simcoins_bought;
    }

    //Selling Simcoins
    function sell_simcoins(address investor, uint simcoins_sold) external {
        equity_simcoins[investor] -= simcoins_sold;
        equity_usd[investor] += equity_simcoins[investor]/1000;
        total_simcoins_bought -= simcoins_sold;
    }

}