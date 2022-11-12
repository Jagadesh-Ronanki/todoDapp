// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.17;

// deployed at: 
contract Todo {
    mapping (uint256 => address) taskToOwner;

    struct Task {
        uint256 taskId;
        string taskText;
        bool isDone;
    }

    Task[] private taskList;

    function addTask(string memory _taskName) external {
        uint256 _taskId = taskList.length;
        taskList.push(
            Task(
                _taskId,
                _taskName,
                false
            )
        );
        taskToOwner[_taskId] = msg.sender;
    }

    function deleteTask(uint256 _taskId) external {
        if (taskToOwner[_taskId] == msg.sender) {
            taskList[_taskId].isDone = true;
        }
    }

    function getTasks() external view returns (Task[] memory) {
        Task[] memory temporary = new Task[](taskList.length);

        uint256 counter = 0;
        for(uint256 i; i<taskList.length; ++i) {
            if (taskToOwner[i] == msg.sender && !taskList[i].isDone) {
                temporary[counter] = taskList[i];
                ++counter;
            }
        }

        Task[] memory result = new Task[](counter);
        for(uint256 i; i < counter; i++) {
            result[i] = temporary[i];
        }

        return result;
    }
}