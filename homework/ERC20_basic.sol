// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Kevin's Token", "KKT") {
        _mint(msg.sender, initialSupply);
    }
    // 觀察 openzeppelin ERC20 內的 transfer 怎麼寫的，才能正確 override
    function transfer(address _to, uint256 _amount) override public returns(bool){
        _transfer(msg.sender, _to, _amount);
        return true;
    }
}
