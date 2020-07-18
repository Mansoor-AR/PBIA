pragma solidity >=0.4.22 <0.7.0;

/**
 * @title testStorage
 * @dev Store & retrieve values in an array and a boolaen
 */
contract testStorage {

    uint256 totalnums;
    bool testbool;
    uint256[] numbers;
    address admin;
    bool active;
    
    modifier isActive() {
        if(active == false)
            revert("Contract is not active");
        _;
    }
    
    function initialize() public {
        admin = msg.sender;
        active = true;
    }

    /**
     * @dev Store number in array
     * @param num value to store
     */
    function store(uint256 num) public isActive {
        numbers.push(num+1); //Intentional bug
    }
    
    function setbool() public {
        testbool = true;
    }
    
    function resetbool() public {
        testbool = false;
    }
    
    function getbool() public view returns (bool) {
        return testbool;
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