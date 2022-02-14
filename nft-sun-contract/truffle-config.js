// truffle-config.js

//const { inetherscanApiKey } = require('./secrets.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
const mnemonic = fs.readFileSync("./mnemonic.secret").toString().trim();
const prov = 'https://rinkeby.infura.io/v3/d6e836f1b58444189bab1f7028484051'

module.exports = {
  networks: {
    rinkeby: {
      provider: () => new HDWalletProvider(mnemonic, prov),
      network_id: 4,
      //gasPrice: 10e9,
      skipDryRun: true
    },
    ropsten: {
      provider: () => new HDWalletProvider(
        mnemonic, `https://ropsten.infura.io/v3/${infuraProjectId}`
      ),
      network_id: 3,
      gasPrice: 10e9,
      skipDryRun: true
    },
    kovan: {
      provider: () => new HDWalletProvider(
        mnemonic, `https://kovan.infura.io/v3/${infuraProjectId}`
      ),
      network_id: 42,
      gasPrice: 10e9,
      skipDryRun: true
    },
    goerli: {
      provider: () => new HDWalletProvider(
        mnemonic, `https://goerli.infura.io/v3/${infuraProjectId}`
      ),
      network_id: 5,
      gasPrice: 10e9,
      skipDryRun: true
    }
  },

  // Set default mocha options here, use special reporters etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "^0.8.0",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },
  plugins: [
    'truffle-plugin-verify'
  ],
  api_keys: {
    etherscan:'CIPAPA4HNESG85YWHQZK8EC11QJY4DE12Q'
  }
};
