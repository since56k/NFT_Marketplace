//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC721Connector.sol";

//initialize this contract to inherit name and symbol from erc721metadata 

contract CryptoNft is ERC721Connector {

    //array to store nfts
    string[] public cryptoNfts;

    mapping(string => bool) _cryptoNftsExists;

    function mint(string memory _cryptoNft) public {
        require(!_cryptoNftsExists[_cryptoNft], 'Error - Cryptonft already exist');
        cryptoNfts.push(_cryptoNft);
        uint _id = cryptoNfts.length - 1;

        _mint(msg.sender, _id);

        _cryptoNftsExists[_cryptoNft] = true;
    }

    constructor() ERC721Connector('Cryptonft','CNFTS')
    
    {}

}

