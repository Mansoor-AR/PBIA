pragma solidity ^0.6;

contract EternalStorage {

    mapping(string => uint) uIntStorage;
    mapping(string => string) stringStorage;
    mapping(string => address) addressStorage;
    mapping(string => bytes) bytesStorage;
    mapping(string => bool) boolStorage;
    mapping(string => int) intStorage;

    // *** Getter Methods ***
    function getUint(string memory _key) public view returns(uint) {
        return uIntStorage[_key];
    }

    function getString(string memory _key) public view returns(string memory) {
        return stringStorage[_key];
    }

    function getAddress(string memory _key) public view returns(address) {
        return addressStorage[_key];
    }

    function getBytes(string memory _key) public view returns(bytes memory) {
        return bytesStorage[_key];
    }

    function getBool(string memory _key) public view returns(bool) {
        return boolStorage[_key];
    }

    function getInt(string memory _key) public view returns(int) {
        return intStorage[_key];
    }

    // *** Setter Methods ***
    function setUint(string memory _key, uint _value)  public {
        uIntStorage[_key] = _value;
    }

    function setString(string memory _key, string memory _value)  public {
        stringStorage[_key] = _value;
    }

    function setAddress(string memory _key, address _value)  public {
        addressStorage[_key] = _value;
    }

    function setBytes(string memory _key, bytes memory _value)  public {
        bytesStorage[_key] = _value;
    }

    function setBool(string memory _key, bool _value)  public {
        boolStorage[_key] = _value;
    }

    function setInt(string memory _key, int _value)  public {
        intStorage[_key] = _value;
    }
}