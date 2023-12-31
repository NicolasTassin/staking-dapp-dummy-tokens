//const { artifacts } = require("truffle");

// eslint-disable-next-line no-undef
const staking_dapp = artifacts.require("staking_dapp");

module.exports = async function (callback) {
  let StakingDapp = await staking_dapp.deployed();
  await StakingDapp.issueReward();

  console.log("Reward issued");

  callback();
};
