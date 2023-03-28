    //SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;

contract ERC721{

    event Transfer(address indexed from,  address indexed to, uint256 indexed tokenId);

    /*
    THE MINTING NFT FUNCTIONS
    building out the minting function:
    a.nft to point to a address(track of the address who is minting the NFT'S which address)
    b.keep track of the token ids(each nft's is a token right)
    c.keep track of token owner addresses to token ids(we have to keep track of whose got which nft's 
    somebody makes nfts should belong to them)
    d.keep track of how many tokens an owner address has (what somebody makes multiple NFT's    )   
    e.create an event that emits a transfer log - contract address, where it is being minted to, the id (logs of info that tracks)

    */ 
    //mapping in solidity creats a  hash table of key pair values

    //mapping from token id to the owner
     mapping(uint256 => address) private _tokenOwner;
     // mapping from owner to number of owned tokens
     mapping(address => uint256) private _OwnedTokensCount;

     //mapping from token id to approved addresses
     mapping(uint256 => address) private _tokenApprovals;
// @notice count all NFTs assigned to an owner
//@dev NFTS assigned to the zero are considered invalid, and this
//function throws for queries about the zero address.
//@param _owner An address for whom to query the balance
//return the number of NFTs owned by '_owner' possibily zero 

      function balanceof(address _owner) public view returns (uint256){
        require(_owner != address(0),'owner query for non-existent');
        return _OwnedTokensCount[_owner];
        }
     // @notice Find the owner of an NFT
    // @dev NFTs assigned to zero address are considered invalid, and queries
    // about them do throw.
    // @param _tokenId The identifier for an NFT
    // @return The address of the owner of the NFT
      function ownerOf(uint256 _tokenId)public view returns(address){
         address owner = _tokenOwner[_tokenId];
         require(owner != address(0),'owner query for non-existent');
        return owner;
      }

/*
//EXERCISE:
1. Write a function called _mint that takes two arguments an address called to and an integer tokenId.
2. add internal visibility to the signature
3. set the   tokenOwner of the  tokenId to the address argument 'to'.
4. increase the owner token count by 1 each time the function is called
BONUS:
Create two requirements -
5. Require that the mint address isn't 0
6. Require that the  token has not already been minted
*/
    function _exists(uint256 tokenId) internal view returns(bool){
        // setting the address of nft owner to check the mapping
        //of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return truthiness the address is not zero
        return owner  != address(0);   
    }   

    function _mint(address to, uint256 tokenId) internal virtual{
        //require that the address isn't zero
        require(to != address(0), 'ERC721: minting to the zero address');
        //requires that the token does not already exist
        require(!_exists(tokenId), 'ERC721: token already minted');
        // we are adding  a new address with a token id for minting
         _tokenOwner[tokenId] = to; 
         // keeping track of each address that is minting and adding one to the count
         _OwnedTokensCount[to] += 1;
        emit Transfer(address(0), to,  tokenId);

    }

    // @notice Change or reaffirm the approved address for an NFT
    // @dev The zero address indicates there is no approved address.
    //  Throws unless `msg.sender` is the current NFT owner, or an authorized
    //  operator of the current owner.
    //@param _approved The new approved NFT controller
    //de @param _tokenId The NFT to approve

     function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
      require (_to != address(0),'Error - ERC721 Transfer to the zero address');
      require(ownerOf(_tokenId) == _from, 'Trying to transfer a token the address does not own');
      _OwnedTokensCount[_from] -= 1;
      _OwnedTokensCount[_to] += 1;
      _tokenOwner[_tokenId] = _to;
       emit Transfer(_from, _to,  _tokenId);
     }
      function transferFrom(address _from, address _to, uint256 _tokenId) public{
        _transferFrom( _from, _to, _tokenId);
      
      }
}

