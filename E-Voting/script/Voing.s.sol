// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/Voting.sol";

contract VotingScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        // deploy voting contract
      new Voting();
        vm.stopBroadcast();
    }
}
