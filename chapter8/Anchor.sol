pragma solidity >=0.6.0;

/**
 * @title Anchor
 * @dev Store & retreive hash corresponding to value for a variable
 */
contract AnchoredReceipts {
    address sender;
    address approver;
    string secretValueHash; //This will store the hash of the secret number
    bool approved;

    constructor() public {
        sender = msg.sender;
        approved = false;
        secretValueHash = "";
    }

    modifier onlySender {
        if(msg.sender != sender)
            revert("Invalid Sender!");
        _;
    }

    modifier onlyApprover {
        if(msg.sender != approver)
            revert("Invalid Approver!");
        _;
    }

    function setApprover(address app) public onlySender {
        approver = app;
    }

    function setVal(string memory secHash) public onlySender{
        secretValueHash = secHash;
    }

    function approve(bool approval) public onlyApprover {
        approved = approval;
    }

    function retreiveHash() public view returns (string memory){
        return secretValueHash;
    }

    function retreiveStatus() public view returns (bool){
        return approved;
    }
}