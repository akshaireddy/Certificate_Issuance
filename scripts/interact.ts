import { ethers } from "hardhat";
const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  const certificateIssuanceFactory = await hre.ethers.getContractFactory("CertificateIssuance");
  const certificateIssuance = await certificateIssuanceFactory.attach("0x16b862bd22947639c8dE9b30C608925E705E96F8");

  console.log("Owner:", await certificateIssuance.owner());

  const issueTx = await certificateIssuance.issueCertificate(deployer.address, "Sample Course");
  await issueTx.wait();

  console.log("Certificate issued!");

  const verifyResult = await certificateIssuance.verifyCertificate(1);
  console.log("Certificate is valid:", verifyResult);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
