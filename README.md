# Todo Dapp

To build the smart contract we would be using Hardhat. Hardhat is an Ethereum development environment and framework designed for full stack development.

---

To setup a Hardhat project, Open up a terminal and execute these commands

```bash
mkdir todoDapp
cd  todoDapp
npm init --yes
npm install --save-dev hardhat
```
In the same directory where you installed Hardhat run:

```bash
npx hardhat
```

Select Create a Javascript Project and follow the steps. At the end, you will have a new Hardhat project ready to go!

---

**Stages of Development**
1. Develop smart contract
2. Compile using hardhat
3. Write deploy script
4. Configuring Deployment
5. Deploy
6. Interact

---

**Develop smart contract**
* `addTask` - add task to the tasklist
* `deleteTask` - delete task from tasklist
* `getTasks` - get caller (msg.sender) tasks

Code: `contracts/todo.sol`

---

**Compile using hardhat**

```bash
npx hardhat compile
```

if successfully executes without errors you are good to go :)

---

**Write deploy script**

get contract using `ethers.getContractFactory()`\
deploy it `contract.deploy()`\
wait for deployment `deployedContract.deployed()`\
get deployed contract address `deployedContract.address`

---

**Configuring Deployment**

Go to **Quicknode** and sign up for an account.\

> Quicknode is a node provider that lets you connect to various different blockchains.

After creating an account, Create an endpoint on Quicknode, select Ethereum, and then select the Goerli network. Click Continue in the bottom right and then click on Create Endpoint. Copy the link given to you in HTTP Provider and add it to the .env file below for `QUICKNODE_HTTP_URL`

To get your private key, you need to export it from Metamask. Open Metamask, click on the three dots, click on Account Details and then Export Private Key. MAKE SURE YOU ARE USING A TEST ACCOUNT THAT DOES NOT HAVE MAINNET FUNDS FOR THIS. Add this Private Key below in your .env file for `PRIVATE_KEY` variable.

Now create a .env file in the todoDapp folder and add the following lines. 

```
QUICKNODE_HTTP_URL="http-provider-url"
PRIVATE_KEY="add-the-private-key-here-of-wallet"
```

Your Hardhat application will take your smart contract and send it to the Ethereum node given to us by Quicknode so it can be deployed on the Goerli network.

To import the env file and use it in our config we install `dotenv` package

```bash
npm install dotenv
```

Now open the `hardhat.config.js` file, we would add the `goerli` network here so that we can deploy our contract to the Goerli network.

```javascript
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({ path: ".env" });

const QUICKNODE_HTTP_URL = process.env.QUICKNODE_HTTP_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.9",
  networks: {
    goerli: {
      url: QUICKNODE_HTTP_URL,
      accounts: [PRIVATE_KEY],
    },
  },
};
```

All set to deploy

---

**Deploy**

Run the command from the directory todoDapp

```bash
npx hardhat run scripts/deploy.js --network goerli
```

It will return deployed contract address. Add it to the `.env` file so that it is helpful to look back when we want to interact with

```javascript
CONTRACT_ADDRESS = "your-deployed-contract-address"
```

---

**Interact**

> Make sure you have enough transaction fees on goerli network

In terminal run

```bash
npx hardhat console --network goerli
```

This will give an interactive console to interact with our deployed smart contract.

```bash
const todoContract = await ethers.getContractFactory('Todo');
const todo = await todoContract.attach('deployed-contract-address-here')
```

Now you can call functions. Run and observe output for the following commands

```bash
await todo.addTask("Task1")
await todo.addTask("Task2")
await todo.getTasks()
await todoTasks.deleteTask(0)
await todo.getTasks()
```

There are lot more ways to interact with a deployed smart contract.
Refer: https://docs.openzeppelin.com/learn/deploying-and-interacting#interacting-programmatically

---

Follow me on 
[twitter](https://twitter.com/JagadeshRonanki) 🚀 