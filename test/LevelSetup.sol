pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import {Ethernaut} from "src/Ethernaut.sol";
import {Level} from "src/BaseLevel.sol";

abstract contract LevelSetup is Test {
    Ethernaut ethernaut;
    address internal eoaAddress = address(100);
    address internal levelAddress;

    function setUp() virtual public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    modifier createLevelContractAddress(Level level) {
        ethernaut.registerLevel(level);
        vm.startPrank(eoaAddress);
        levelAddress = ethernaut.createLevelInstance(level);
        _;
    }

    modifier submitLevelAfterwards() {
        _;
        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);
    }

}
