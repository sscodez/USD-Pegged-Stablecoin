<h1> USD-Pegged Stablecoin Smart Contract </h1>
This Solidity smart contract implements a USD-pegged stablecoin that is designed to maintain a stable value by being backed by a reserve of a single asset or a basket of assets. The contract follows the ERC20 token standard and includes additional functions for buying and redeeming the stablecoin with the underlying asset(s).

<h2>Features</h2>
<ul>
<li>Implements the ERC20 token standard with additional functions for buying and redeeming the stablecoin.</li>
<li>Maintains a fixed exchange rate of 1 stablecoin to 1 USD, with 18 decimals of precision.</li>
<li>Can be backed by a single asset or a basket of assets.</li>
<li>Supports the transfer and approval of stablecoins between addresses.</li>
<li>Includes basic security measures such as input validation and access control.</li>
</ul>
<h2>Usage</h2>
<ol>
<li>
Deploy the stablecoin contract to the Ethereum network with the desired asset or basket of assets as the reserve.</li>
<li>Use the buyStablecoin function to purchase stablecoins by transferring the corresponding amount of the reserve asset(s) to the contract.</li>
<li>Use the redeemStablecoin function to redeem stablecoins for the underlying asset(s).</li>
<li>Use the standard ERC20 functions such as transfer, transferFrom, and approve to send and receive stablecoins between addresses.</li>
</ol>
<h2>Requirements</h2>
<ol>
<li>Solidity 0.8.0 or higher</li>
<li>Truffle 5.4.0 or higher (optional, for testing and deployment)</li>
<li>A compatible Ethereum client such as Ganache or Infura (optional, for testing and deployment)</li>
</ol> 
<h2>Deployment</h2>
Install the required dependencies by running npm install in the project directory.
Edit the exchangeRate and asset variables in the Stablecoin.sol file to reflect the desired exchange rate and asset(s) for the stablecoin.
Compile the contract by running truffle compile.
Deploy the contract to the desired Ethereum network by running truffle migrate. Make sure to specify the correct network in the truffle-config.js file.
Interact with the deployed contract using a web3 provider such as MetaMask or a custom client.
<h2>Testing</h2>
Make sure the required dependencies are installed by running npm install in the project directory.
Start a local Ethereum client such as Ganache by running ganache-cli.
Run the test suite by running truffle test.
