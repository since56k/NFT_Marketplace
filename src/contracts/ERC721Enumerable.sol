//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list[] of all owner tokens ids
    mapping(address => uint256[]) private _ownedTokens;

    // mapping from token ID to index of the owner tokens list    
    mapping(uint256 => uint256) private _ownedTokensIndex;
    
    function _mint(address to, uint256 tokenId) internal override(ERC721){
        //super for calling parent contract
        super._mint(to, tokenId);
        //add tokens to the owner
        //all tokens to our totalsupply - to allTokens
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }

    //add tokens to the _allTokens array and set the possition of the tokens indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    //add address and token id to the _owned Tokens
    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }

    // return tokenByIndex
    function tokenByIndex(uint256 index) public view returns(uint256) {
        // check index is not out of bound of the supply total
        require(index < totalSupply(), 'global index is out of bound');
        return _allTokens[index];
    }

    // return tokenOfOwnerByIndex
    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint256) {
         require(index < this.balanceOf(owner), 'owner index is out of bound');
         return _ownedTokens[owner][index];
    }

    // return the total supply of the _allTokens array
    function totalSupply() public view returns(uint256){
        return _allTokens.length;
    }

}
