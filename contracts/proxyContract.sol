pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "./NFTDutchAuction_ERC20bids.sol";

contract proxy is Initializable, DutchAuction, OwnableUpgradeable, UUPSUpgradeable {
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }
    function initialize(address erc20TokenAddress, address erc721TokenAddress, uint256 _nftTokenId,uint256 _reservePrice, uint256 _numBlocksAuctionOpen, uint256 _offerPriceDecrement) initializer public {
        set_values(erc20TokenAddress, erc721TokenAddress, _nftTokenId, _reservePrice, _numBlocksAuctionOpen, _offerPriceDecrement);
        __Ownable_init();
        __UUPSUpgradeable_init();

        // _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
    

}
