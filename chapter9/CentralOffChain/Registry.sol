pragma solidity >=0.4.22 <0.7.0;


contract Registry {

    mapping (string => address) nameToAddress;
    address admin;
 
    constructor() public {
        admin = msg.sender;
    }

    function storeAddress(string memory name, address addr) public {
        if(msg.sender != admin)
            revert("Can only be called by admin");
        nameToAddress[name] = addr;
    }
    
    /**
     * @dev Return current address associated with name 
     * @return smart contract address
     */
    function retrieveAddress(string memory name) public view returns (address){
        return nameToAddress[name];
    }
}