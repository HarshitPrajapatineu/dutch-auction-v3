//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./NFTDutch.sol";
import "./bidToken.sol";

contract DutchAuction {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    NFTDutch public NFT_address;
    BidToken public token_address;
    uint256 public NFT_id;
    uint256 public auctionStartBlock;
    uint256 public reservePrice;
    uint256 public numBlocksAuctionOpen;
    uint256 public offerPriceDecrement;
    uint256 public initialPrice;
    uint256 public auctionEndBlock;
    address payable public owner;
    bool public ended;

    modifier isAuctionValid() {
        require(msg.sender != owner, "owner can't bid");
        require(ended == false, "auction is ended");
        require(block.timestamp > auctionStartBlock, "auction is not started yet");
        require(block.timestamp < auctionEndBlock, "auction is ended");
        _;
    }

    modifier isValidBid(uint256 _amount){
        uint256 blockPassed = block.timestamp.sub(auctionStartBlock);
        uint256 currentPrice = initialPrice.sub(blockPassed.mul(offerPriceDecrement));
        require(_amount >= currentPrice,"not enough amount of bid");
        _;
    }
    constructor(address erc20TokenAddress, address erc721TokenAddress, uint256 _nftTokenId,uint256 _reservePrice, uint256 _numBlocksAuctionOpen, uint256 _offerPriceDecrement) {
        NFT_address = NFTDutch(erc721TokenAddress);
        token_address = BidToken(erc20TokenAddress);
        NFT_id = _nftTokenId;
        reservePrice = _reservePrice;
        numBlocksAuctionOpen = _numBlocksAuctionOpen;
        offerPriceDecrement = _offerPriceDecrement;
        initialPrice = reservePrice.add(numBlocksAuctionOpen.mul(offerPriceDecrement));
        auctionStartBlock = block.timestamp;
        auctionEndBlock = block.timestamp.add(_numBlocksAuctionOpen);
        owner = payable(msg.sender);
        ended = false;

    }

    function bid(uint256 _amount) isAuctionValid isValidBid(_amount) public payable returns(address)  {
        token_address.transferFrom(msg.sender,owner,_amount);
        NFT_address.safeTransferFrom(owner,msg.sender,NFT_id);
        ended = true;
        return msg.sender;
    }
}
