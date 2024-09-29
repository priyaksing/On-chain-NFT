require("@nomicfoundation/hardhat-toolbox");
// require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();


module.exports = {
  solidity: "0.8.24",
  networks: {
    amoy: {
      url: process.env.TESTNET_RPC,
      accounts: [process.env.PRIVATE_KEY]
    }
  },

  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY
  }
};
