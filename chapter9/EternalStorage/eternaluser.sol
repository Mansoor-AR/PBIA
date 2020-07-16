pragma solidity ^0.6;

import "./eternalstore.sol" as etst;

contract LogicContract {

    address admin;
    address storageAddr;
    bool active;
    
    modifier isActive() {
        if(active == false)
            revert("Contract is not active");
        _;
    }
    
    constructor(address _storageAddr) public {
        admin = msg.sender;
        active = true;
        storageAddr = _storageAddr;
    }

    function store(string memory _key, uint256 num) public isActive {
        etst.EternalStorage(storageAddr).setUint(_key, num);
    }
    
    function retrieveNum(string memory _key) public view returns (uint256){
        return  etst.EternalStorage(storageAddr).getUint(_key); //WARNING: Will return 0 if no number with key exists
    }
    
    function disableContract() public{
        if(msg.sender != admin)
            revert("Can only be called by admin");
        active = false;
    }
}