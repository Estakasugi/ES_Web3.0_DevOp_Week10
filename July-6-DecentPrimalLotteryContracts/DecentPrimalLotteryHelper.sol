// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    @author: ES_TAKASUGI
*/

import "./DecentPrimalLotteryPool.sol";
import "./DecentPrimalLotteryUser.sol";
import "./SafeMath.sol";
import "./Ownable.sol";
import "./DecentPrimalLottery.sol";
import "./DecentPrimalLotteryRandHelper.sol";

contract DecentPrimalLotteryHelper is DecentPrimalLottery, DecentPrimalLotteryRandHelper {
    
    // use the safe math library
    using SafeMath32 for uint32;
    using SafeMath for uint256;

    // once contracts been deployed, following things happens
    constructor() {
        createPool(); // the first pool is created
    }


    // this function check if the msg sender is the winner, the first user who check this function will trigger the find winner function and shall be rewarded with ether worth of 3 lottery tickets
    function amITheWinner() public validUser() returns(bool) {
        require(block.timestamp < poolLedger[currentPoolIndex.sub(1)].poolEndTime, "The pool does not end yet");
        

        if (poolLedger[currentPoolIndex.sub(1)].hasWinner == false) {
            findWinner();
            // reward the first caller
            (bool callSuccess, ) = payable(msg.sender).call{value: lotteryTicketPrice.mul(3)}("");
            require(callSuccess, "Call failed");
        }

        if (addressToUserInfo[msg.sender].isWinnerOfCurrentPool == false){
            return false;
        } else {
            return true;
        }

    }

    // this function return all lotteryTokens a user has bought
    function lotteryListView() public view validUser() returns(uint256[] memory){
        uint256 currentLen = (usersDataLedger[addressToUserInfo[msg.sender].userID].totalCostInEtherCurrentPool)/(lotteryTicketPrice);
        uint256[] memory result = new uint256[](currentLen);
        uint counter = 0;
        for(uint256 i = 0; i<currentPoolLotteries.length; i = i.add(1)) {
            if (userNameToAddress[currentPoolLotteries[i].ownerUserName] == msg.sender) {
                result[counter] = i;
                counter = counter.add(1);
            }
        }

        return result;
    }


}