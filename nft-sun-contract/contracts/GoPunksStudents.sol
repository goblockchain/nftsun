// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract GoPunksStudents is ERC721, Ownable, ERC721Enumerable {
    using Strings for uint256;
    uint256 public constant MAX_PUNKSSTUDENTS = 2104;
    bool public hasSaleStarted = true;
    uint256 public constant PUNKSSTUDENTS_PRICE = 10000000000000000;
    string public baseURI = "ipfs://Qmb2CYTVT3FFur6S723encVKkJVsY2K9xRkFn6mTPtnyKe/";
    uint16 public available;

    constructor() ERC721("GoPunksStudents", "GPS"){
    }

    function tokensOfOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256 tokenCount = balanceOf(_owner);
        if (tokenCount == 0) {
            // Return an empty array
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](tokenCount);
            uint256 index;
            for (index = 0; index < tokenCount; index++) {
                result[index] = tokenOfOwnerByIndex(_owner, index);
            }
            return result;
        }
    }

    function setBaseURI(string memory baseURI_) external onlyOwner {
        baseURI = baseURI_;
    }

    function setAvailability(uint16 _available) public onlyOwner {
        available = _available;
    }

    function buy(uint256 numPunks) public payable {
        require(available >= 1, "There are no more NFTs available.");
        require(totalSupply() < MAX_PUNKSSTUDENTS, "Sale has already ended");
        require(
            numPunks > 0 && numPunks <= 2,
            "You can adopt minimum 1, maximum 2 Punks Students GBC"
        );
        require(
            totalSupply() + (numPunks) <= MAX_PUNKSSTUDENTS,
            "Exceeds MAX_PUNKSSTUDENTS"
        );
        require(
            msg.value >= PUNKSSTUDENTS_PRICE * (numPunks),
            "Ether value sent is below the price"
        );

        available = available - uint16(numPunks);

        for (uint256 i = 0; i < numPunks; i++) {
            uint256 mintIndex = totalSupply();
            _safeMint(msg.sender, mintIndex);
        }
    }

    function giveGift(address _address, uint256 numPunks) public onlyOwner {
        uint256 mintIndex = totalSupply();
        require(mintIndex < 240);
        require(
            totalSupply() + (numPunks) <= 240,
            "Exceeds MAX_PUNKSSTUDENTS"
        );
        for (uint256 i = 0; i < numPunks; i++) {
            _safeMint(_address, mintIndex + i);
        }
    }

    function startDrop() public onlyOwner {
        hasSaleStarted = true;
    }

    function pauseDrop() public onlyOwner {
        hasSaleStarted = false;
    }

    function withdraw() public payable onlyOwner {
        require(payable(msg.sender).send(address(this).balance));
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function getPrice(uint256 _count) public view returns (uint256) {
        uint256 returnVal = 0;
        if (totalSupply() <= MAX_PUNKSSTUDENTS) {
            returnVal = PUNKSSTUDENTS_PRICE * _count; // 0.01 ETH
        }

        return returnVal;
    }


    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : "";
    }

    
    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    

}

// cloned by United CryptoPunks Smart Contract "United Punks Union"
// Punks not dead!
// Special thanks to @berkozdemir @mmtiglioglu @caiosapy
// goBlockchain

