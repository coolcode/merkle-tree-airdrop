// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract MerkleTreeAirdrop {
    // --- PROPERTIES ---- //

    // Calculated from `merkle_tree.js`
    bytes32 public merkleRoot = 0x2e35b61278fbcec3f3b0bb361d928e373e089a61758af09690ce0a5391078ff2;

    mapping(address => bool) public claimed;

    // --- FUNCTIONS ---- //

    function claim(bytes32[] calldata _merkleProof) public {
        require(!claimed[msg.sender], "Address already claimed");
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Invalid Merkle Proof.");
        claimed[msg.sender] = true;
        // do sth...
    }
}

/*
    Pass this array in for 'bytes32[] calldata _merkleProof' to claim() 

    [
        "0x702d0f86c1baf15ac2b8aae489113b59d27419b751fbf7da0ef0bae4688abc7a",
        "0xb159efe4c3ee94e91cc5740b9dbb26fc5ef48a14b53ad84d591d0eb3d65891ab"
    ]

*/
