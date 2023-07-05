import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("bidToken", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployBidToken() {
    
    const [owner, account1, account2] = await ethers.getSigners();

    const BidToken = await ethers.getContractFactory("BidToken");
    const bid_token = await BidToken.deploy();

    return { bid_token, owner, account1, account2 };
  }

  describe("Deployment", function () {
    it("Should set the right name", async function () {
      const { bid_token, owner, account1 } = await loadFixture(deployBidToken);
      expect(await bid_token.name()).to.equal("BidToken");
    });

    it("Should set the right symbol", async function () {
        const { bid_token, owner, account1 } = await loadFixture(deployBidToken);
  
        expect(await bid_token.symbol()).to.equal("BTK");
    });
  });

describe("total supply", function () {
    it("Should mint the right supply", async function () {
        const { bid_token, owner, account1 } = await loadFixture(deployBidToken);
  
        expect(await bid_token.totalSupply()).to.eq(ethers.utils.parseEther("1000000"));
    });
});
});
