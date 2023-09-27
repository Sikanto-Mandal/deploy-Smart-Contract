// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract Lottery{
    address public manager;
    address payable[] public participants;

    constructor (){
        manager = msg.sender; // global variable
    
    }
    receive() external payable {
        require (msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

    //view the manager balance
    function getBalance() public  view returns (uint){
        require (msg.sender == manager);
        return address(this).balance;
    }

    //create random number 
    function random() public view returns(uint) {
       return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));   //this is a hexing algoriths like sha256
    }

    //fatch the random index
    function selectWinner() public {
        require (msg.sender == manager);
        require (participants.length >=3);
        uint r = random();
        address payable winner;
        uint index = r % participants.length;
        winner = participants[index];
        winner.transfer(getBalance()); 
        participants = new address payable [](0); // participants value = 0



    }


} 