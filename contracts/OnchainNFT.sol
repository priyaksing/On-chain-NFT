// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
// import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract OnchainNFT is ERC721URIStorage {
    using Strings for uint256;
    uint256 private _tokenId;
    mapping(uint256 => uint256) public tokenIdtoLevels;

    constructor() ERC721("On-chain NFT", "OCNFT") {}

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Girl Boss #',
            tokenId.toString(),
            '",',
            '"description": "Boss level on chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function generateCharacter(
        uint256 tokenId
    ) public view returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: magenta; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="light pink" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Girl Boss",
            "</text>",
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Level: ",
            getLevel(tokenId),
            "</text>",
            "</svg>"
        );

        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getLevel(uint256 tokenId) public view returns (string memory) {
        return tokenIdtoLevels[tokenId].toString();
    }

    function mint() public {
        _tokenId++;
        uint256 newTokenId = _tokenId;
        _safeMint(msg.sender, newTokenId);
        tokenIdtoLevels[newTokenId] = 0;
        _setTokenURI(newTokenId, getTokenURI(newTokenId));
    }

    function train(uint256 tokenId) public {
        // require(_exists(tokenId), "Please use an existing token");
        require(ownerOf(tokenId) == msg.sender, "You must own this token");
        tokenIdtoLevels[tokenId]++;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
