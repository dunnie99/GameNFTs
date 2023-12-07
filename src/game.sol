// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract MyGame is ERC1155, Ownable {
    /**
     * @notice STATE VARIABLES
     */
    address VIP;
    uint256 public constant MAIN_TOKEN_ID = 1;
    uint256 public constant ITEM_TOKEN_START_ID = 100;
    mapping(address => bool) private soulboundToken;

    constructor(address initialOwner) ERC1155("") Ownable(initialOwner) {
        VIP = initialOwner;
    }

    /**
     *
     * @param newuri set a URI or change an existing one
     */
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    /**
     * @dev func to mint soulbound tokens
     * @notice payable (send any amount of ETH)
     */
    function mintMainToken() public payable {
        address caller = msg.sender;
        require(
            balanceOf(caller, MAIN_TOKEN_ID) == 0,
            "Address already soulbounded"
        );
        soulboundToken[caller] = true;
        _mint(caller, MAIN_TOKEN_ID, 1, "");
    }

    /**
     *
     * @param id >= 100
     * @param amount in quantity
     */
    function mintItemToken(uint256 id, uint256 amount) public payable {
        address caller = msg.sender;
        require(balanceOf(caller, MAIN_TOKEN_ID) == 1, "Invalid Caller");
        require(id >= ITEM_TOKEN_START_ID, "Invalid Token ID");
        _mint(caller, id, amount, "");
    }

    /**
     * @notice onlyOwner
     * @param to destination address
     * @param ids of all tokens to be minted
     * @param amounts in quantity
     */
    function mintItemBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts
    ) public onlyOwner {
        require(
            soulboundToken[to],
            "Tokens can only be transacted between soulbounded addresses"
        );
        _mintBatch(to, ids, amounts, "");
    }

    /**
     *
     * @param from sender address
     * @param to destination address
     * @param id of token to transfer
     * @param amount in quantity
     * @param data to be sent along transaction
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public override {
        require(
            soulboundToken[from] && soulboundToken[to],
            "Tokens can only be transacted between soulbounded addresses"
        );
        require(id >= ITEM_TOKEN_START_ID, "Invalid Token ID");

        super.safeTransferFrom(from, to, id, amount, data);
    }

    /**
     *
     * @notice this encodes strings that needs to be passed as params @safeTransferFrom
     * @param _data string (metadata, name or details)
     */
    function encodeData(
        string memory _data
    ) public pure returns (bytes memory) {
        return abi.encode(_data);
    }

    function creditOwner() public {
        payable(VIP).transfer(address(this).balance);
    }

    /**
     * @dev fallback func
     */
    receive() external payable {}
}
