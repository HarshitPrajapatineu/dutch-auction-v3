import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";


describe("NFTDutch", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployNFTDutch() {
    
    const [owner, account1, account2] = await ethers.getSigners();

    const NFTDutch = await ethers.getContractFactory("NFTDutch");
    const dutch_nft = await NFTDutch.deploy();

    return { dutch_nft, owner, account1, account2 };
  }

  describe("Deployment", function () {
    it("Should set the right name", async function () {
      const { dutch_nft, owner, account1 } = await loadFixture(deployNFTDutch);
      expect(await dutch_nft.name()).to.equal("NFTDutch");
    });

    it("Should set the right symbol", async function () {
        const { dutch_nft, owner, account1 } = await loadFixture(deployNFTDutch);
  
        expect(await dutch_nft.symbol()).to.equal("DNT");
    });
  });

describe("Minting", function () {
    it("Mint NFTs", async function () {
        const { dutch_nft, owner, account1,account2 } = await loadFixture(deployNFTDutch);
        const mint1 = await dutch_nft.connect(account1).safeMint(account1.address);
        const mint2 = await dutch_nft.connect(account2).safeMint(account2.address);
        expect(await dutch_nft.ownerOf(1)).to.eq(account1.address)
        expect(await dutch_nft.ownerOf(2)).to.eq(account2.address)
        expect(await dutch_nft.symbol()).to.equal("DNT");
    });
});
});
