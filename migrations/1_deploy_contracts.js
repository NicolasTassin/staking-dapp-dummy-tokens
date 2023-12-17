/* eslint-disable no-undef */

const dummy_token = artifacts.require("dummy");
const Tether_token = artifacts.require("Tether");
const staking_dapp = artifacts.require("Staking_dapp");

module.exports = async function (deployer, network, account) {
  try {
    await deployer.deploy(Tether_token);
    const thether_token = await Tether_token.deployed();

    await deployer.deploy(dummy_token);
    const dummyToken = await dummy_token.deployed();

    await deployer.deploy(
      staking_dapp,
      thether_token.address,
      dummyToken.address
    );
    const stakingDapp = await staking_dapp.deployed();

    await dummyToken.transfer(stakingDapp.address, "1000000000000000");
    await thether_token.transfer(account[1], "1000000000000000");
        console.log(stakingDapp.address, "<------------dummytoken")
  } catch (error) {
    console.log("errorin deployment:", error);
  }
};
