pragma solidity >=0.6;

interface OracleInterface {
    function setRandom(uint) external;
    function getRandom() external view returns (uint, uint);
}