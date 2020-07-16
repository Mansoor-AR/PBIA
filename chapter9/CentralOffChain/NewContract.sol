pragma solidity >=0.4.22 <0.7.0;

/**
 * @title Storage
 * @dev Store & retrieve values in an array
 */
contract Storage {

    uint256 totalnums;
    uint256[] numbers;
    address admin;
    bool active;
    
    modifier isActive() {
        if(active == false)
            revert("Contract is not active");
        _;
    }
    
    constructor() public {
        admin = msg.sender;
        active = true;
    }

    /**
     * @dev Store number in array
     * @param num value to store
     */
    function store(uint256 num) public isActive {
        numbers.push(num); //Bug fixed
    }

    /**
     * @dev Return length 
     * @return length of 'numbers'
     */
    function retrieveLen() public view returns (uint256){
        return numbers.length;
    }
    
    /**
     * @dev Return value at index 
     * @return length of 'numbers'
     */
    function retrieveNum(uint256 index) public view returns (uint256){
        if(index >= numbers.length)
            revert("Index out of bounds");
        return numbers[index];
    }
    
    function disableContract() public{
        if(msg.sender != admin)
            revert("Can only be called by admin");
        active = false;
    }
}