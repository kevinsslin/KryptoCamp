// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract myERC20 {
    string private _name;
    string private _symbol;
    address private _owner;
    uint256 private _totalSupply;

     constructor
     (uint256 totalSupply_,
      string memory name_,
      string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _owner = msg.sender;
        _totalSupply = totalSupply_;
        _balances[msg.sender] = totalSupply_;
    }

    function name() public view returns(string memory){
        return _name;
    }

    function symbol() public view returns(string memory) {
        return _symbol;
    }

    // 需要 totalSupply, balanceOf, transfer 的功能
    function totalSupply() public view returns(uint256) {
        return _totalSupply;
    }
    mapping(address => uint256) private _balances;
    function balanceOf(address _account) public view returns(uint256) {
        return _balances[_account];
    }

    function transfer(address _from, address _to, uint256 _amount) public {
        require(_balances[_from] >= _amount, "no have enough money");
        _balances[_from] -= _amount;
        _balances[_to] += _amount;
    }
}
