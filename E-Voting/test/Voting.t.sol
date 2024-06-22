// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/Voting.sol";

contract VotingTest is Test {
    Voting public voting;

    function setUp() public {
        voting = new Voting();
    }

    function testAddCandidate() public {
        voting.addCandidate("muskan");
        assertEq(voting.candidates(0), "muskan");
    }

    function testRevertofAddCandidate() public {
        vm.expectRevert("Only admin can add candidates and register voters!");
        vm.prank(address(0));
        voting.addCandidate("muskan");
    }

    function testRevert_2_ofAddCandidate() public {
        voting.addCandidate("muskan");
        vm.expectRevert("Candidate is already added!");
        voting.addCandidate("muskan");
    }

    function testRegisterVoter() public {
        voting.registerVoter(address(0x123));
        assertEq(voting.voters(0), address(0x123));
    }

    function testRevertofRegisterVoter() public {
        vm.expectRevert("Only admin can add candidates and register voters!");
        vm.prank(address(0));
        voting.registerVoter(address(0x123));
    }

    function testRevert_2_ofRegisterVoter() public {
        voting.registerVoter(address(0x123));
        vm.expectRevert("Voter is already registered!");
        voting.registerVoter(address(0x123));
    }

    function testVote() public {
        voting.addCandidate("muskan");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        voting.vote(0);
        assertEq(voting.VotedOrNot(address(0)), true);
    }

    function testRevertofVote() public {
        voting.addCandidate("muskan");
        vm.prank(address(0));
        vm.expectRevert("Voter is not registered!");
        voting.vote(0);
    }

    function testRevert_2_ofVote() public {
        voting.addCandidate("muskan");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        vm.expectRevert("Candidate Id is invalid!");
        voting.vote(1);
    }

    function testRevert_3_ofVote() public {
        voting.addCandidate("muskan");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        voting.vote(0);
        vm.expectRevert("You have already voted!");
        vm.prank(address(0));
        voting.vote(0);
    }

    function testGetVoteCount() public {
        voting.addCandidate("muskan");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        voting.vote(0);
        assertEq(voting.getVoteCount(0), 1);
    }

    function testRevertofGetVoteCount() public {
        voting.addCandidate("muskan");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        voting.vote(0);
        vm.expectRevert("Candidate Id is invalid!");
        voting.getVoteCount(1);
    }

    function testGetWinner() public {
        voting.addCandidate("muskan");
        voting.addCandidate("alia");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        voting.vote(0);
        voting.registerVoter(address(1));
        vm.prank(address(1));
        voting.vote(0);
        assertEq(voting.getWinner(), "muskan");
    }

    function testRevertofGetWinner() public {
        vm.expectRevert("No candidates available");
        voting.getWinner();
    }

    function testRevert_2_ofGetWinner() public {
        voting.addCandidate("muskan");
        voting.addCandidate("alia");
        voting.registerVoter(address(0));
        vm.prank(address(0));
        voting.vote(0);
        voting.registerVoter(address(1));
        vm.prank(address(1));
        voting.vote(1);
        vm.expectRevert("There is a tie between candidates");
        voting.getWinner();
    }
}
