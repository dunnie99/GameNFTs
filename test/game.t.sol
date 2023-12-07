// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {MyGame} from "../src/game.sol";

contract GameTest is Test {
    MyGame public game;

    address Bob = vm.addr(0x1);
    address Alice = vm.addr(0x2);
    address Bisola = vm.addr(0x3);

    function setUp() public {
        game = new MyGame(Bob);
    }

    function testmintMainToken() public {
        vm.deal(Alice, 100);
        vm.startPrank(Alice);
        game.mintMainToken{value: 20}();
    }

    function testmintItemToken() public returns (uint256) {
        testmintMainToken();
        vm.deal(Bisola, 100);
        // vm.prank(Bisola);//Invalid caller error
        // game.mintItemToken{value: 29}(32, 20);
        //vm.prank( Alice); //Invalid token error
        //game.mintItemToken{value: 29}(32, 20);
        game.mintItemToken{value: 29}(100, 20);
        game.balanceOf(Alice, 1);
        game.balanceOf(Alice, 100);
        uint256 bal = address(game).balance;
        vm.stopPrank();
        return bal;
    }

    function testmintBatch() public {
        vm.deal(Bisola, 100);
        //vm.deal(Bob, 100);
        vm.prank(Bisola);
        game.mintMainToken{value: 20}();
        uint256[3] memory _ids = [uint256(199), uint256(230), uint256(110)];
        uint256[] memory ids = new uint256[](_ids.length);
        uint256[3] memory _amount = [uint256(34), uint256(20), uint256(10)];
        uint256[] memory amount = new uint256[](_amount.length);
        vm.prank(Bob);
        game.mintItemBatch(Bisola, ids, amount);
    }

    function testsafeTransferFrom() public returns (uint256, uint256) {
        testmintItemToken();
        testmintBatch();
        vm.startPrank(Alice);
        game.setApprovalForAll(Bisola, true);
        bytes memory data = game.encodeData("With love from Alice");
        game.safeTransferFrom(Alice, Bisola, 100, 10, data);
        game.creditOwner();
        uint256 ownerBal = Bob.balance;
        uint256 bal = address(game).balance;
        return (bal, ownerBal);
    }









}
