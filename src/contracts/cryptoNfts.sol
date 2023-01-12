//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

//initialize this contract to inherit name and symbol from erc721metadata 

contract Cryptonft is ERC721Connector {

    constructor() ERC721Connector('Cryptonft','CNFTS')
    
    {}

}

