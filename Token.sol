// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IERC20.sol"; // Import the ERC20 interface

contract Stablecoin is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowances;
    uint256 public exchangeRate; // The exchange rate of the stablecoin to the USD, with 18 decimals of precision
    address public asset; // The address of the asset or basket of assets that the stablecoin is pegged to

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply, uint256 _exchangeRate, address _asset) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        exchangeRate = _exchangeRate;
        asset = _asset;
        balances[msg.sender] = _initialSupply;
    }

    // Define the ERC20 functions
    function transfer(address recipient, uint256 amount) external override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(amount <= allowances[sender][msg.sender], "Insufficient allowance");
        allowances[sender][msg.sender] -= amount;
        _transfer(sender, recipient, amount);
        return true;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return allowances[owner][spender];
    }

    // Define the functions for buying and redeeming the stablecoin with the underlying asset
    function buyStablecoin(uint256 assetAmount) external {
        // Transfer the underlying asset to the contract
        require(IERC20(asset).transferFrom(msg.sender, address(this), assetAmount), "Failed to transfer asset");

        // Calculate the corresponding stablecoin amount based on the exchange rate
        uint256 stablecoinAmount = assetAmount * 1e18 / exchangeRate;
        require(stablecoinAmount <= balances[address(this)], "Insufficient stablecoin balance");

        // Transfer the stablecoin to the buyer
        _transfer(address(this), msg.sender, stablecoinAmount);
    }

    function redeemStablecoin(uint256 stablecoinAmount) external {
        // Calculate the corresponding asset amount based on the exchange rate
        uint256 assetAmount = stablecoinAmount * exchangeRate / 1e18;
        require(assetAmount <= IERC20(asset).balanceOf(address(this)), "Insufficient asset balance");

        // Transfer the underlying asset to the redeemer
        require(IERC20(asset).transfer(msg.sender, assetAmount), "Failed to transfer asset");

        // Burn the redeemed stablecoin
        _burn(msg.sender, stablecoinAmount);
    }

    // Define the internal transfer and burn functions
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(amount <= balances[sender], "Balance low");
        // Update the balances of the sender and recipient
        balances[sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
}

    function _burn(address account, uint256 amount) internal {
    require(account != address(0), "Burn from the zero address");
    require(amount <= balances[account], "Insufficient balance");
    balances[account] -= amount;
    totalSupply -= amount;
    emit Transfer(account, address(0), amount);
}
}
