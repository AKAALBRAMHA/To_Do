# TodoList Smart Contract

This Solidity smart contract, `todolist`, facilitates managing a to-do list on the Ethereum blockchain. Users can create tasks, mark tasks as completed, and retrieve task details.

## Features

- **Task Creation**: Users can create tasks with a list of items.
- **Task Completion**: Tasks can be marked as completed.
- **Task Retrieval**: Users can retrieve task details by providing the task ID.
- **Owner Privileges**: Certain functions are restricted to the contract owner.

## Contract Structure

The contract consists of the following components:

- **Struct Definition**: Defines the structure of a to-do task.
- **Owner Address**: Stores the address of the contract owner.
- **Task Count**: Tracks the total number of tasks created.
- **Task Mapping**: Maps task IDs to to-do tasks.
- **Events**: Logs task-related actions.
- **Modifiers**: Restricts access to certain functions.
- **Constructor**: Initializes the contract owner.
- **Functions**:
  - `setlist`: Creates a new task with a list of items.
  - `getlist`: Retrieves the list of items and timestamp of a task by ID.
  - `markTaskdone`: Marks a task as completed.
  - `taskNotCompleted`: Retrieves the ID of the first incomplete task.
  - `taskcompleted`: Retrieves the ID of the first completed task.

## Usage

1. **Task Creation**: Call the `setlist` function to create a new task.
2. **Task Completion**: Use the `markTaskdone` function to mark a task as completed.
3. **Task Retrieval**: Retrieve task details using the `getlist` function.
4. **Owner Privileges**: Certain functions are restricted to the contract owner.

## License

This smart contract is licensed under the MIT License. See the SPDX-License-Identifier tag at the beginning of the code for details.
