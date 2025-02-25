// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    @author: ES_TAKASUGI
*/

import "./DecentPrimalLotteryPool.sol";
import "./DecentPrimalLotteryUser.sol";
import "./SafeMath.sol";

contract DecentPrimalLottery is DecentPrimalLotteryPool, DecentPrimalLotteryUser {
    
    using SafeMath for uint256;
    using SafeMath32 for uint32;

    // unit ticket price of a lottery
    uint256 lotteryTicketPrice = 0.0005 ether;

    // id of lotteryTickets
    uint256 lotteryTicketCount = 0;

    // data structure for lottery ticket
    struct LotteryToken {
        uint8[5] firstFive;
        uint8 goldOne;
        string ownerUserName;
        uint32 isWorthInEther;
        uint32 poolNumber;
        uint256 lotteryID;
    }

    //data base for lotteries in the current pool
    LotteryToken[] public currentPoolLotteries;

    //this function allow registered user to purchase lottery ticket
    function buyLotteryToken(uint8 _firstFive_one, uint8 _firstFive_two, 
                             uint8 _firstFive_three, uint8 _firstFive_four, 
                             uint8 _firstFive_five, uint8 _goldOne) public payable validUser() {
        
        // requrie number check
        require((_firstFive_one >= 1) && (_firstFive_one <= 70), "first five number should be between 1 and 70 (include both)");
        require((_firstFive_two >= 1) && (_firstFive_two <= 70), "first five number should be between 1 and 70 (include both)");
        require((_firstFive_three >= 1) && (_firstFive_three <= 70), "first five number should be between 1 and 70 (include both)");
        require((_firstFive_four >= 1) && (_firstFive_four <= 70), "first five number should be between 1 and 70 (include both)");
        require((_firstFive_five >= 1) && (_firstFive_five <= 70), "first five number should be between 1 and 70 (include both)");
        require((_goldOne >= 1) && (_goldOne <= 25), "gold number should be between 1 and 25 (include both)");
        
        // check if amount of paying is correct
        require(msg.value == lotteryTicketPrice, "Please pay the lottery ticket amount, 0.0005 ether");
        
        uint8[5] memory firstFiveArray = [_firstFive_one, _firstFive_two, _firstFive_three, _firstFive_four, _firstFive_five];
        
        // create a lottery ticket, and push it to the lottery pool
        // after creation, the currentPoolIndex will increase by one for the creation of the next pool. To access the current one, simply do currentPoolIndex -1, the next one, currentPoolIndex
        currentPoolLotteries.push(LotteryToken(firstFiveArray, _goldOne, addressToUserInfo[msg.sender].userName, 0, currentPoolIndex.sub(1), lotteryTicketCount)); 
        
        // 1 more ticket was sold
        lotteryTicketCount = lotteryTicketCount.add(1);

        //user's total cost in ether increasing
        // addressToUserInfo[msg.sender].totalCostInEtherCurrentPool = addressToUserInfo[msg.sender].totalCostInEtherCurrentPool.add(lotteryTicketPrice);
        usersDataLedger[addressToUserInfo[msg.sender].userID].totalCostInEtherCurrentPool = usersDataLedger[addressToUserInfo[msg.sender].userID].totalCostInEtherCurrentPool.add(lotteryTicketPrice);

        //pool's total accumulation increasing
        poolLedger[currentPoolIndex.sub(1)].poolAccumulateInEther = poolLedger[currentPoolIndex.sub(1)].poolAccumulateInEther.add(lotteryTicketPrice);

        //check if current pool's accumulate greater than 3 times of max user pay, if so, startpool
        uint256 maxAmountFromUser = findMaxCostInEtherAmongUsers();
        if ( poolLedger[currentPoolIndex.sub(1)].poolAccumulateInEther > maxAmountFromUser.mul(3) ){
            poolStart();
        }
        
    }
    uint256 public currentPoolLotteriesLength =  currentPoolLotteries.length;

    // this function returns all lotteryTokens a user has bought
    
    // function checkAllMyLottery() public view validUser() returns(uint256[] memory) {       

    //     // create a dynamic array to store the lottery IDs
    //     uint256[] memory result;
    //     uint256 counter = 0;

    //     // iterate over all lottery tickets in the current pool
    //     for(uint256 i = 0; i < currentPoolLotteries.length; i++) {
    //         // if the owner of the lottery ticket is the message sender
    //         if (keccak256(abi.encodePacked(currentPoolLotteries[i].ownerUserName)) == keccak256(abi.encodePacked(addressToUserInfo[msg.sender].userName))) {
    //             // add the lottery ID to the result array
    //             result[counter] = currentPoolLotteries[i].lotteryID;
    //             counter++;
    //         }
    //     }
    //     return result;
    // }


    // // this function return all lotteryTokens a user has bought // deleted valid user
    // function checkAllMyLottery() public view validUser() returns(uint256[] memory) {       

    //     //uint[] memory result = new uint[]((addressToUserInfo[msg.sender].totalCostInEtherCurrentPool).div(lotteryTicketPrice));
    //     uint[] memory result = new uint[](1);
    //     uint counter = 0;
    //     for(uint256 i = 0; i<currentPoolLotteries.length; i = i.add(1)) {
    //         if (userNameToAddress[currentPoolLotteries[i].ownerUserName] == msg.sender) {
    //             result[counter] = i;
    //             counter++;
    //         }
    //     }
    //     return result;
    
    // }

    //check lottery by id
    function checkLotteryByID(uint256 _Id) public view validUser() returns(LotteryToken memory) {
        return currentPoolLotteries[_Id];
    }



}