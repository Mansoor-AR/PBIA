pragma solidity >=0.5 <0.6.0;

contract AddingContract {
    uint256 lastResult;

    function add(uint256 num1, uint256 num2) public returns (uint256) {
        lastResult = num1 + num2;
        require(lastResult >= num1, "Overflow has occurred!");
        return lastResult; 
    }
    
    function getPrevious() public view returns (uint256) {
        return lastResult;
    }
}
