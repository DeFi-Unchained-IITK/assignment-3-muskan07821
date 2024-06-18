# Voting Smart Contract

This repository contains a Solidity smart contract for a basic voting system. The contract allows an administrator to add candidates and register voters. Registered voters can then vote for their preferred candidate, and the system can tally and announce the winner.

## Contract Overview

### Contract: Voting

The `Voting` contract implements a simple voting system. Below are the primary features and functions of the contract:

- **Owner**: The contract deployer is set as the owner and has the ability to add candidates and register voters.
- **Candidates**: A list of candidates that voters can vote for.
- **Voters**: A list of addresses that are registered to vote.
- **Vote Tallying**: A mapping to keep track of votes for each candidate.
- **Voting Status**: A mapping to check if an address has already voted.

### Functions

1. **Constructor**
   - Sets the contract deployer as the owner.

2. **addCandidate(string memory name)** (onlyAdmin)
   - Allows the owner to add a new candidate.
   - Checks if the candidate is already added.

3. **registerVoter(address voter)** (onlyAdmin)
   - Allows the owner to register a new voter.
   - Checks if the voter is already registered.

4. **vote(uint candidateId)** (registeredVoter, checkCandidateId)
   - Allows a registered voter to vote for a candidate by ID.
   - Checks if the voter has already voted.

5. **getVoteCount(uint candidateId)** (view, checkCandidateId)
   - Returns the number of votes for a specific candidate.

6. **getWinner()** (view)
   - Returns the name of the winning candidate.
   - Ensures there is no tie.

### Modifiers

1. **onlyAdmin**
   - Restricts functions to be executed only by the owner.

2. **checkCandidateId(uint id)**
   - Checks if the candidate ID is valid.

3. **registeredVoter(address voter)**
   - Checks if the voter is registered.

## Challenges and Considerations

- **Double Voting**: Ensures that a voter can vote only once.
- **Duplicate Candidates**: Prevents the addition of duplicate candidates.
- **Registered Voters**: Ensures only registered voters can vote.
- **Valid Candidate ID**: Ensures that votes are cast for valid candidate IDs.
- **Winner Determination**: Handles ties in votes gracefully by not announcing a winner if there is a tie.

