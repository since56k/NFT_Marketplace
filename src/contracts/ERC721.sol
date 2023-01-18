//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
  Minting function
- NFT to point to an address
- Keep track of token ids
- Keep track of token owner with token ids
- Keep track on how many tokens an address has
- create an events that emits a transfer log, contract address where it is being minted to the id

*/

contract ERC721 {

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    //mapping from token id to the owner
    //everything should be private
    mapping(uint256 => address) private _tokenOwner; 

    //mapping from owner to number of owned token
    mapping(address => uint256) private _ownedTokensCount; 


    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256) {
        require (_owner != address(0), 'owner query for non existent token'); 
        return _ownedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address){
        address owner = _tokenOwner[_tokenId];
        require (owner != address(0), 'owner query for non existent token');
        return owner;
    }
   
    function _exists(uint256 tokenId) internal view returns(bool){
    // setting the address of nft owner to check the mapping of the address from tokenOwner at the token Id
        address owner = _tokenOwner[tokenId];
    //return truthiness that address is not zero
        return owner != address(0);  
    }
    
    function _mint(address to, uint256 tokenId) internal {
    // require that address isn't zero
        require(to != address(0), 'ERC721: minting to the zero address'); 
    // requires that the token does not already exist
        require(!_exists(tokenId), 'ERC721: token already minted');
    // adding new address with a token id for minting
        _tokenOwner[tokenId] = to;
    // keeping track of each address that is minting and adding one to the count 
        _ownedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }

}