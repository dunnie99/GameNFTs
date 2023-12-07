# MyGame Smart Contract: A Comprehensive Overview

**The primary purpose of the MyGame contract is to manage game assets in a decentralized manner. It leverages the Ethereum blockchain to create, manage, and transfer game tokens. These tokens can represent a variety of in-game assets, ranging from in-game currency to unique items or characters.**

### Structure of the MyGame Contract
The MyGame contract is built on two Ethereum standards: ERC-1155 and Ownable.

**ERC-1155** is a standard for multi-token contracts, allowing the MyGame contract to manage multiple types of tokens simultaneously. For instance, it could manage both a fungible token (like an in-game currency where each unit is identical to every other unit) and a non-fungible token (like a unique item or character, where each unit is distinct).

**Ownable** is a standard that restricts certain functions to the owner of the contract. In the context of MyGame, the owner is the address that deploys the contract to the Ethereum blockchain.

Key Features of MyGame Contract:

-   **VIP**: An address variable set to the initial owner of the contract. This could be used to grant special privileges to this address.
-   **MAIN_TOKEN_ID and ITEM_TOKEN_START_ID**: Constants that define the IDs for the main token and the starting ID for item tokens.
-   **soulboundToken**: A mapping that links addresses to a boolean value. This could be used to verify certain addresses as "soulbound", meaning they own a token that cannot be transferred to another address.
-   **setURI**: A function that allows the owner of the contract to set or change the URI for the contract. The URI is a link to a resource that describes the tokens.

-   **mintMainToken**: A function that allows anyone to create new main tokens by sending Ether to the contract.

# Documentation

 A step-by-step process on how to use the MyGame contract from a developer's perspective.
 ### Requirements

- **Development Environment** :
        VScode, and Foundry are some of the tools that can be used to write,test and deploy smart contracts on Ethereum Mainnet or Testnet(e.g mumbai, sepolia),.
### STEP 1 - Set up Foundry Project
To begin setting up the environment for the smart contract implementation, you will first need to create a new folder on your system. You can do this by using the ‘mkdir’ command in your terminal followed by the desired name of your folder. For example:

    ```
    mkdir GameNFTs
    ```
Next, navigate to your project folder using the ‘cd’ command, like below:

    ```
    cd  GameNFTs
    ```
Once you have cd into the folder, you can clone the project inside it by running the following command:

    ```
    git clone https://github.com/dunnie99/GameNFTs.git
    ```

This will clone the project folder, and then install the project dependencies by running;

    ```
    forge install
    ```

Finally, open your project folder in VScode by running this command in your terminal:

    ```
    code .
    ```
This will open up your project folder in Visual Studio Code, where you can use the following foundry commands.

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Deploy

```shell
$ forge create --rpc-url <rpc url> \
    --constructor-args <constructor args>\
    --private-key <private key> \
    --etherscan-api-key <API-KEY> \
    --verify \
    src/game.sol:MyGame
```

### Help

```shell
$ forge --help
```
https://book.getfoundry.sh/

## Usage

**Mint Game Assets**

Call the mint function to create new game assets. This function requires the address of the owner and the token ID of the new asset. The token ID must be unique and not currently in use.

**Transfer Game Assets**

Game assets can be transferred between addresses using the transferFrom function. This function requires the address of the current owner, the address of the new owner, and the token ID of the asset.

**Approve Game Asset Management**

The approve function allows an address to manage a game asset on behalf of its owner. This function requires the address of the approved manager and the token ID of the asset.

**Check Game Asset Ownership**

The ownerOf function can be used to check the ownership of a game asset. This function requires the token ID of the asset.

**Check Game Asset Approval**

The getApproved function can be used to check if an address is approved to manage a game asset. This function requires the token ID of the asset.

**Additional Functions**
The MyGame contract also includes additional functions for managing game assets, such as ````setApprovalForAll```` for approving an address to manage all assets of an owner, ````isApprovedForAll```` for checking if an address is approved to manage all assets of an owner, and ````totalSupply```` for getting the total number of game assets.

**Events**
The MyGame contract emits events when certain actions are performed. These events include ````Transfer```` when a game asset is transferred, ````Approval```` when an address is approved to manage a game asset, and ````ApprovalForAll```` when an address is approved to manage all assets of an owner.

### Links
https://mumbai.polygonscan.com/address/0x539af443df0a43bff4f2421d45e5d8a7daa3666e#code

### Conclusion
In summary, the MyGame contract can be used for creating and managing game assets on the Ethereum blockchain. It harnesses the security and decentralization of blockchain technology to provide a flexible platform for game development. Whether you're a game developer or a player, the MyGame contract offers a new and exciting way to interact with in-game assets.
