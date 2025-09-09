//SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract ManualToken {

    error ManualToken__TransferFailed();

    mapping(address => uint256) private s_balances;

function name() public pure returns (string memory){
    return "Manuelo";
}
function symbol() public pure returns (string memory){
    return "MNL";

}

function decimals() public pure returns (uint8){
    return 18;
}

function totalSupply() public pure returns (uint256){
    return 10e18;
}

function balanceOf(address _owner) public view returns (uint256 balance){
    return s_balances[_owner];
}

function transfer(address _to, uint256 _value) public {
    uint256 entireBalanceofToken = balanceOf(msg.sender) + balanceOf(_to);
    s_balances[msg.sender] -= _value;
    s_balances[_to] += _value;

    if(entireBalanceofToken != balanceOf(msg.sender) + balanceOf(_to)){
        revert ManualToken__TransferFailed();
    }


}

}