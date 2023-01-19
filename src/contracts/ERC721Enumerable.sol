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

   
    ///  (sort order not specified)
    //function tokenByIndex(uint256 _index) external view returns (uint256){}

    
    ///   (sort order not specified)
    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){}

    function _mint(address to, uint256 tokenId) internal override(ERC721){
        //super for calling parent contract
        super._mint(to, tokenId);

        //add tokens to the owner
        //all tokens to our totalsupply - to allTokens

        _addTokensToTotalSupply(tokenId);

    }

    function _addTokensToTotalSupply(uint256 tokenId) private {
        _allTokens.push(tokenId);
    }

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() public view returns(uint256){
        return _allTokens.length;
    }

}
