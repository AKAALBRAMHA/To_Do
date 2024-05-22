// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

contract CrowdFund {

    struct Proposal {
        address proposer;
        string proposalInfo;
        uint256 totalFunding;
        mapping(address => uint256) funders;
        address[] proposalFunder;
    }

    mapping(uint256 => Proposal) public proposals;

    function fundMe(uint256 id, string memory info) public {
        Proposal storage newProposal = proposals[id];
        newProposal.proposer = msg.sender;
        newProposal.proposalInfo = info;
    }

    function fundProject(uint256 id) public payable {
        require(msg.value > 0, "Fund must be more than zero.");
        Proposal storage proposal = proposals[id];
        proposal.totalFunding += msg.value;
        
        if (proposal.funders[msg.sender] == 0) {
            proposal.proposalFunder.push(msg.sender);
        }
        proposal.funders[msg.sender] += msg.value;
    }

    function withdraw(uint256 id) external {
        Proposal storage proposal = proposals[id];
        require(proposal.proposer == msg.sender, "Only proposer can withdraw.");
        require(proposal.totalFunding > 0, "No funds available for withdrawal.");

        uint256 amount = proposal.totalFunding;
        proposal.totalFunding = 0;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed.");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}

    fallback() external payable {}
}
