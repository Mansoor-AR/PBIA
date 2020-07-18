pragma solidity ^0.6;
contract Proxy {

    address delegateAddr;
    address owner = msg.sender;

    function upgradeAddress(address newDelegateAddress) public {
        require(msg.sender == owner);
        delegateAddr = newDelegateAddress;
    }

   fallback() external  {
        address addr = delegateAddr;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), addr, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}