pragma solidity ^0.8.0;
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

//Created by @mis4nthr0pic & @EthnicalInfo.
contract MevSecNFT is ERC721 {
    //Will you succeed to mint to a The MevSec NFT?
    mapping(address => bool) public whitelistedAddresses;

    modifier IsWhitelisted(address addr) {
        require(whitelistedAddresses[addr] == true);
        _;
    }

    constructor() ERC721("MevSecNFT", "MEV") {}
    // Add an address to the whitelist.
    function addToWhitelist(address _address) external {
        require((tx.origin == msg.sender) && !isContract(_address), "Only humans allowed!");
        whitelistedAddresses[_address] = true;
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    function mint(address receiver) external IsWhitelisted(receiver) {
        require(isContract(receiver), "Only frens with contract can mint here!");
        _mint(receiver, 1337);
    }
}
