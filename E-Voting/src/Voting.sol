// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Voting {
    string[] public candidates;
    address[] public voters;
    address public owner;

    mapping(uint => uint) private CandidateVotes;

    mapping(address => bool) public VotedOrNot;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyAdmin() {
        require(
            msg.sender == owner,
            "Only admin can add candidates and register voters!"
        );
        _;
    }

    modifier checkCandidateId(uint id) {
        require(id < candidates.length, "Candidate Id is invalid!");
        _;
    }

    modifier registeredVoter(address voter) {
        bool registered = false;
        for (uint i = 0; i < voters.length; i++) {
            if (voters[i] == msg.sender) {
                registered = true;
            }
        }
        require(registered == true, "Voter is not registered!");
        _;
    }

    function addCandidate(string memory name) public onlyAdmin {
        for (uint i = 0; i < candidates.length; i++) {
            require(
                keccak256(abi.encodePacked(candidates[i])) !=
                    keccak256(abi.encodePacked(name)),
                "Candidate is already added!"
            );
        }
        candidates.push(name);
    }

    function registerVoter(address voter) public onlyAdmin {
        for (uint i = 0; i < voters.length; i++) {
            require(voters[i] != voter, "Voter is already registered!");
        }
        voters.push(voter);
    }

    function vote(
        uint candidateId
    ) public registeredVoter(msg.sender) checkCandidateId(candidateId) {
        require(VotedOrNot[msg.sender] != true, "You have already voted!");
        CandidateVotes[candidateId] += 1;
        VotedOrNot[msg.sender] = true;
    }

    function getVoteCount(
        uint candidateId
    ) public view checkCandidateId(candidateId) returns (uint) {
        return CandidateVotes[candidateId];
    }

    function getWinner() public view returns (string memory) {
        require(candidates.length > 0, "No candidates available");

        uint winnerId = 0;
        bool isTie = false;

        for (uint i = 1; i < candidates.length; i++) {
            if (CandidateVotes[i] > CandidateVotes[winnerId]) {
                winnerId = i;
                isTie = false;
            } else if (CandidateVotes[i] == CandidateVotes[winnerId]) {
                isTie = true;
            }
        }

        require(!isTie, "There is a tie between candidates");

        return candidates[winnerId];
    }
}

