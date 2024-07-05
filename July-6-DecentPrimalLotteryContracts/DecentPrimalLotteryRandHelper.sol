// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    @author: ES_TAKASUGI
*/

import "./SafeMath.sol";
import "./Ownable.sol";
import "./DecentPrimalLottery.sol";

contract DecentPrimalLotteryRandHelper is DecentPrimalLottery{

    // use the safe math library
    using SafeMath32 for uint32;
    using SafeMath for uint256;

    mapping (uint256 => bool) private winnerMap;

    function findWinner() public{

        // Genrate rand winning numbers, for testing purpose, make them hard coded
        uint256 num1 = 7;
        uint256 num2 = 7;
        uint256 num3 = 7;
        uint256 num4 = 7;
        uint256 num5 = 7;
        uint256 goldOneGen = 12;


        //push them into a winner map for seraching winners
        winnerMap[num1] = true;
        winnerMap[num2] = true;
        winnerMap[num3] = true;
        winnerMap[num4] = true;
        winnerMap[num5] = true;

        for (uint256 i = 0; i<currentPoolLotteries.length; i = i.add(1) ){
            
            // count how many number is the winning number
            uint32 currentLotteryWinningCounter = 0;
            
            // regular 5 number
            for (uint256 j = 0; j<5; j = j.add(1)) {
                if (winnerMap[currentPoolLotteries[i].firstFive[j]] == true) {
                    currentLotteryWinningCounter = currentLotteryWinningCounter.add(1);
                } 
            }
            
            // the gold one, later will add rule to convert that to a more specific reward
            if (currentPoolLotteries[i].goldOne == goldOneGen) {
                currentLotteryWinningCounter = currentLotteryWinningCounter.add(772);
            }
            
            // will further add rules to convert currentlotteryWining to is worth Ether
            currentPoolLotteries[i].isWorthInEther = currentLotteryWinningCounter;

            //pool's winner appear if currentLotteryWinningCounter > 3
            if (currentLotteryWinningCounter > 3) {
                poolLedger[currentPoolIndex.sub(1)].hasWinner == true;
            }

        }
        
        //return _GeneratePsedoRand25();
        //distributeReward();
    }


    function distributeReward() internal {

    }

    function _GeneratePsedoRand70() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp))) % 70 + 1;
    }

    function _GeneratePsedoRand25() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.timestamp))) % 25 + 1;
    }

}