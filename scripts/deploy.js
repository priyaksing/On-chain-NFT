const hre = require("hardhat");

// Deployed to : 0xbbc64cDF4a0347316453eA43c88628492769A8f3

async function main() {
    try {
        const OnChainNFT = await hre.ethers.getContractFactory("OnchainNFT");
        const onChainNFT = await OnChainNFT.deploy();
        await onChainNFT.waitForDeployment();
        console.log("Contract deployed to: ", await onChainNFT.getAddress());
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
}

main();