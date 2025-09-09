//SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import {MyToken} from "../src/MyToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployToken is Script{

    uint256 public constant INITIAL_SUPPLY = 10e18;
    
    function run() external returns (MyToken) {
        vm.startBroadcast();
        MyToken myToken = new MyToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return myToken;
    }
}