//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721.sol';

contract ERC721Enumerable is ERC721 {


    uint256[] private _allTokens;
    // mapping   from   tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokensIndex;        

    //mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;  

    // mapping from token ID index of the owner tokens list
    mapping (uint256 => uint256) private _ownedTokensIndex;

    //@notice Count NFTs tracked by this contract
    // @return A count of valid NFTs tracked by this contract, where each one of
    //  them has an assigned and queryable owner not equal to the zero address
    //@notice Enumerate valid NFTs
    //@dev Throws if `_index` >= `totalSupply()`.
    // @param _index A counter less than `totalSupply()`
    // @return The token identifier for the `_index`th NFT,
    //  (sort order not specified)
    //function tokenByIndex(uint256 _index) external view returns (uint256);

    // @notice Enumerate NFTs assigned to an owner
    // @dev Throws if `_index` >= `balanceOf(_owner)` or if
    //  `_owner` is the zero address, representing invalid NFTs.
    // @param _owner An address where we are interested in NFTs owned by them
    // @param _index A counter less than `balanceOf(_owner)`
    // @return The token identifier for the `_index`th NFT assigned to `_owner`,
    //   (sort order not specified)
    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    function _mint(address to, uint256 tokenId)internal override(ERC721){
        super._mint(to, tokenId); 
        //Two thhings! a) Add tokens to the owner
        //B) all     tokens to our totalsupply - to allTokens 
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    } 
    //add tokens to the _alltokens array and set the position of the tokens indexes
    function  _addTokensToAllTokenEnumeration(uint256 tokenId) private{
        _allTokensIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to,uint256 tokenId) private{

        //EXERCISE- CHALLENGE
        //1.add address and token id to the ownedTokens
        //2. ownedTokensIndex tokenId set to address of ownedToken position
        //2. we want to execute the function with minting
        _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
        _ownedTokens[to].push(tokenId);
    }
//two functions - one tat returns tokenByIndex and
//another one that returns tokenOfOwnerByIndex
     function tokenByIndex(uint256 index)view public returns (uint256){
        //make sure that the index is not out of bounds of the total supply
        require(index < totalSupply(),'global index is out of bound');
        return _allTokens[index];
     }

     function tokenOfOwnerByIndex(address owner, uint index)view public returns(uint256){
        require(index < balanceof(owner),'owner index is out of bound');
        return _ownedTokens[owner][index];
     }
    //return the total supply of  the _allTokens array
    function totalSupply()view public returns (uint256) {
        return _allTokens.length;
        
    }
    
}    
