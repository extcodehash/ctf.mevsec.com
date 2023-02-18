pragma solidity ^0.8.0;
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
//Created by @mis4nthr0pic
contract ImpossibleNFT is ERC721 {
    // Only hackers can mint the ImpossibleNFT, Are you a hacker?
    bool public isSolved;
    uint256 lastId;

    modifier onlyHackers() {
        require(tx.origin != msg.sender, "Humans not allowed");
        require(!isContract(msg.sender), "Contracts not allowed");
        _;
    }

    constructor() public ERC721("ImpossibleNFT", "INFT") {}

    function mint() public onlyHackers {
        isSolved = true;
        lastId += lastId;
        _safeMint(msg.sender, lastId);
        emit Transfer(address(0), msg.sender, lastId);
    }

    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
}