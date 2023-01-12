//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Metadata.sol";

//Connect to carry the metadata info over

contract ERC721Connector is ERC721Metadata {

    constructor(string memory name, string memory symbol) ERC721Metadata(name, symbol) {}

}