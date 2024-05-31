// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

contract todolist {
    // Define Struct for the to-do task
    struct to_do {
        bool isdone; // Status of the task: done or not done
        uint256 ID; // Unique identifier for the task
        string[] list; // List of items in the task
        uint256 lasttimestamp; // Timestamp of when the task was last updated
    }

    address owner; // Address of the contract owner

    // Tracking count of tasks created
    uint256 taskcount;

    // Mapping of task ID to to-do task
    mapping(uint256 => to_do) to_do_List;

    // Events for logging task actions
    event Taskset(uint256 ID, string[] indexed list);
    event TaskDone(uint256 ID);

    // Modifier to restrict access to the owner
    modifier onlyowner {
        require(owner == msg.sender, "Request not done by owner");
        _;
    }

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function to set a new task list
    function setlist(string[] memory _list) public onlyowner {
        uint256 _ID = taskcount++; // Generate new task ID
        to_do storage newTo_Do = to_do_List[_ID]; // Create a new task
        newTo_Do.list = _list; // Set the task list
        newTo_Do.lasttimestamp = block.timestamp; // Set the current timestamp
        newTo_Do.isdone = true; // Mark the task as done
        emit Taskset(_ID, _list); // Emit an event for the new task
    }

    // Function to get the task list by ID
    function getlist(uint256 _ID) public view onlyowner returns (string[] memory, uint256) {
        require(_ID < taskcount, "Task does not exist"); // Check if the task exists
        return (to_do_List[_ID].list,
                to_do_List[_ID].lasttimestamp); // Return the task list and timestamp
    }

    // Function to mark a task as not done
    function markTaskdone(uint256 _ID) public onlyowner {
        require(_ID < taskcount, "Task does not exist"); // Check if the task exists
        to_do_List[_ID].isdone = false; // Mark the task as not done
        emit TaskDone(_ID); // Emit an event for marking the task done
    }

    // Function to get the ID of the first task that is not completed
    function taskNotCompleted() public view onlyowner returns (uint256 notdone) {
        for (uint256 i = 0; i < taskcount; i++) {
            if (!to_do_List[i].isdone) {
                notdone = to_do_List[i].ID; // Set the ID of the not done task
                return notdone; // Return the ID
            }
        }
    }

    // Function to get the ID of the first task that is completed
    function taskcompleted() public view onlyowner returns (uint256 notdone) {
        for (uint256 i = 0; i < taskcount; i++) {
            if (to_do_List[i].isdone) {
                notdone = to_do_List[i].ID; // Set the ID of the done task
                return notdone; // Return the ID
            }
        }
    }
}
