const CryptoNft = artifacts.require("CryptoNft");

module.exports = function(deployer) {
  deployer.deploy(CryptoNft);
};
