const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const CertificateIssuance = await hre.ethers.getContractFactory("CertificateIssuance");
  const certificateIssuance = await CertificateIssuance.deploy();

  await certificateIssuance.deployed();

  console.log("CertificateIssuance deployed to:", certificateIssuance.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
