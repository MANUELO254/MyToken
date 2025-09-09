//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract TokenTest is Test {
    MyToken public myToken;

    uint256 public constant STARTING_BALANCE = 10e18;

    address Alice = makeAddr("Alice");
    address Bob = makeAddr("Bob");

    function setUp() public {
        myToken = new MyToken(100e18);

        // Assign balances directly
        deal(address(myToken), Bob, STARTING_BALANCE);
        deal(address(myToken), address(this), STARTING_BALANCE);
    }

    function testBobsBalance() public view {
        assertEq(myToken.balanceOf(Bob), STARTING_BALANCE);
    }

    function testAllowances() public {
        uint256 initialAllowance = 100e18;

        vm.prank(Bob);
        myToken.approve(Alice, initialAllowance);

        uint256 transferAmount = 2e18;

        vm.prank(Alice);
        myToken.transferFrom(Bob, Alice, transferAmount);

        assertEq(myToken.balanceOf(Alice), transferAmount);
        assertEq(myToken.balanceOf(Bob), STARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
        uint256 amount = 10e18;
        address receiver = address(0x1);

        myToken.transfer(receiver, amount);

        assertEq(myToken.balanceOf(receiver), amount);
    }

    function testBalanceAfterTransfer() public {
        uint256 amount = 10e18;
        address receiver = address(0x1);

        uint256 initialBalance = myToken.balanceOf(address(this));
        myToken.transfer(receiver, amount);

        assertEq(myToken.balanceOf(address(this)), initialBalance - amount);
    }

    function testTransferFrom() public {
        uint256 amount = 5e18;
        address receiver = address(0x2);

        myToken.approve(address(this), amount);
        myToken.transferFrom(address(this), receiver, amount);

        assertEq(myToken.balanceOf(receiver), amount);
    }
}
