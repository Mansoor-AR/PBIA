pragma solidity >=0.6;


contract Dealer {
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

    constructor() public {
        owner = msg.sender;
        winner = address(0); //initialize to all 0's
    }

    function addPlayer(address newPlayer) public onlyOwner {
        if(playerRegistered[newPlayer])
            revert("This player has already been registered!");
        playerRegistered[newPlayer] = true;
        players.push(newPlayer);
        playerChoices[newPlayer] = 14; //Invalid choice at initialization
    }

    function chooseCard() internal view returns (uint) {
        uint counter = 0;
        for(uint i = 0; i < players.length; i++) {
            counter = counter + playerChoices[players[i]];
        }
        return (counter % 13);
    }

    function makeBet(uint bet) public {
        if(!playerRegistered[msg.sender])
            revert("This player has not been registered");
        if(bet < 1 || bet > 13 )
            revert("This is an invalid bet");
        playerChoices[msg.sender] = bet;
    }

    function chooseWinner() public onlyOwner {
        myChoice = chooseCard();
        uint winMargin = 14;
        for(uint i = 0; i < players.length; i++) {
            uint temp = playerChoices[players[i]];
            if(temp >=14)
                continue;
            uint currentDiff = absoluteDifference(myChoice, temp);
            if(currentDiff < winMargin) {
                winMargin = currentDiff;
                winner = players[i];
            }
        }
    }

    function getWinner() public view returns(address) {
        return winner;
    }

    function absoluteDifference(uint a, uint b) internal pure returns (uint) {
        if(a <= b)
            return (b-a);
        return (a-b);
    }
}