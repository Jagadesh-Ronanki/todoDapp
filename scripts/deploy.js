const { ethers } = require("hardhat");

async function main() {
  // get contract
  const todoContract = await ethers.getContractFactory("Todo");
  // deploy contract
  const deployedTodo = await todoContract.deploy();
  // wait until contract deployed
  await deployedTodo.deployed();
  // address of deployed contract
  console.log("Todo contract deployed at: ", deployedTodo.address);
}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error);
  process.exit(1);
});