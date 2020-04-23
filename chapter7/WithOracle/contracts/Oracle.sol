pragma solidity >=0.6;

import "./OracleInterface.sol" as ointerface;

contract Oracle is ointerface.OracleInterface{
    address owner;
    //The number that we receive from the oracle service
    uint randomNumber;
    uint randomRound;

    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require (msg.sender == owner, "Must be sent by owner");
        _;
    }
    
    //Let participants know number has been submitted for round
    event numberSubmitted(uint);

    function setRandom(uint rand) public onlyOwner override {
        //Check if it is a valid card
        if(rand < 1 || rand > 13)
            revert("Value submitted invalid");
        randomNumber = rand;
        //Increment round number
        randomRound++;
        emit numberSubmitted(randomRound);
    }
    
    function getRandom() public view override returns (uint, uint) {
        return (randomNumber,randomRound);
    }
}
