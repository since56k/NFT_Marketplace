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

    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

    //mapping from token id to the owner
    //everything should be private
    mapping(uint256 => address) private _tokenOwner; 

    //mapping from owner to number of owned token
    mapping(address => uint256) private _ownedTokensCount; 

    //mapping from token Id to approved address
    mapping(uint256 => address) private _tokenApprovals;


    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns (uint256) {
        require (_owner != address(0), 'owner query for non existent token'); 
        return _ownedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns (address){
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
    
    function _mint(address to, uint256 tokenId) internal virtual {
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

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    /// Iternal for private informations
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        //require address receving the token is not zero
        require(_to != address(0), 'error - ERC7211 transfer to the zero addresss');

        //require address trasfering the token actually owns the token
        require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own');

        //update the balance of the address _from token
        _ownedTokensCount[_from] -=1;

        //update the balance of the address _to
        _ownedTokensCount[_to] +=1;

        //add tokenId to the address receiving the token
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public {
        require(isApprovedOrOwner(msg.sender, _tokenId));
        _transferFrom(_from, _to, _tokenId);

    }

    function approve(address _to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, 'Error - approval to current owner');
        require(msg.sender == owner, 'Current caller is not the owner of the token');
        _tokenApprovals[tokenId] = _to;
        emit Approval(owner, _to, tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool){
        require(_exists(tokenId), 'token does not exist');
        address owner = ownerOf(tokenId);
        return(spender == owner);
    }

}