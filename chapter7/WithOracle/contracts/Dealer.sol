pragma solidity >=0.6;


import "./OracleInterface.sol" as ointerface;

contract Dealer {
    //Current round of play 
    uint currentRound;
    //Counter of random number generations
    uint prevRandomRound;
    //Address of oracle contract
    address oracle;
    //Are new bets allowed right now?
    bool betsAllowed;
    uint myChoice;
    address owner;
    address winner;
    address[] players;
    mapping (address => bool) playerRegistered;
    mapping (address => uint) playerChoices;

    modifier onlyOwner() {
        require (msg.sender == owner, "Must be sent by owner");
        _;
    }
    
    modifier notLocked() {
        require (betsAllowed, "Bets are currently locked");
        _;
    }

    constructor() public {
        owner = msg.sender;
        winner = address(0); //initialize to all 0's
        currentRound = 0;
        betsAllowed = true;
    }
    
    //Notify participants that their bets have been locked
    event betsLocked(uint);

    function addPlayer(address newPlayer) public onlyOwner {
        if(playerRegistered[newPlayer])
            revert("This player has already been registered!");
        playerRegistered[newPlayer] = true;
        players.push(newPlayer);
        playerChoices[newPlayer] = 14; //Invalid choice at initialization
    }
    
    function addOracle(address addr) public onlyOwner {
        oracle = addr;
    }

    function makeBet(uint bet) public notLocked {
        if(!playerRegistered[msg.sender])
            revert("This player has not been registered");
        if(bet < 1 || bet > 13 )
            revert("This is an invalid bet");
        playerChoices[msg.sender] = bet;
    }

    function lockBets() public onlyOwner notLocked {
        currentRound ++;
        betsAllowed = false;
        //Lets oracle service know it's time to submit new random number
        emit betsLocked(currentRound); 
    }
    
    function chooseWinner() public onlyOwner {
        if (betsAllowed)
            revert("Bets haven't been locked yet!");
        uint rand;
        uint currRand;
        //Get random card from oracle
        (rand,currRand) = ointerface.OracleInterface(oracle).getRandom();
        if (prevRandomRound >= currRand)
            revert("Stale random number used!");
         //Check if it is a valid card; we cannot rely on just the oracle checking this
        if(rand < 1 || rand > 13)
            revert("Value submitted invalid");
        //Choose the winner as closest to rand value
        uint winMargin = 14;
        for(uint i = 0; i < players.length; i++) {
            uint temp = playerChoices[players[i]];
            if(temp >=14)
                continue;
            uint currentDiff = absoluteDifference(rand, temp);
            if(currentDiff < winMargin) {
                winMargin = currentDiff;
                winner = players[i];
            }
        }
        prevRandomRound = currRand;
        betsAllowed = true;
        //EXERCISE: emit the winner as an event and have it be automatically shown on players' webpages
    }

    function getWinner() public view returns(address, uint) {
        return (winner,currentRound);
    }

    function absoluteDifference(uint a, uint b) internal pure returns (uint) {
        if(a <= b)
            return (b-a);
        return (a-b);
    }

}