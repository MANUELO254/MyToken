//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {DeployToken} from "../script/DeployToken.s.sol";

contract TokenTest is Test{

    MyToken public myToken;
    DeployToken public deployer;

    uint256 public constant SRARTING_BALANCE = 10e18;

    address Alice = makeAddr("Alice");
    address Bob = makeAddr("Bob");

    function setUp() public{
        deployer = new DeployToken();
        myToken = deployer.run();

        vm.prank(msg.sender);
        myToken.transfer(Bob, SRARTING_BALANCE);
    }

    function testBobsBalance () public view{
        assertEq(myToken.balanceOf(Bob), SRARTING_BALANCE);
    }

    function testAllowances() public {
        uint256 initialAllowance = 100e18;

        vm.prank(Bob);
        myToken.approve(Alice, initialAllowance);

        uint256 transferAmount = 20e18;

        vm.prank(Alice);
        myToken.transferFrom(Bob, Alice, transferAmount);

        assertEq(myToken.balanceOf(Alice), transferAmount);
        assertEq(myToken.balanceOf(Bob), SRARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
        uint256 amount = 10e18;
        address receiver = address(0x1);
        vm.prank(msg.sender);
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

    function testTransferFrom () public {
        uint256 amount = 5e18;
        address receiver = address(0x2);
        myToken.approve(address(this), amount);
        myToken.transferFrom(address(this), receiver, amount);
        assertEq(myToken.balanceOf(receiver), amount);          
    }
}