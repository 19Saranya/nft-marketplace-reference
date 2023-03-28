//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract DeltaChimp is ERC721Connector {
// How to run a minting function - call the minting function for market
//place specific for KBz. 
//By creating array to store nfts i.e KBz
      string[] public deltaChimpz;

      mapping(string => bool) _deltaChimpzExists;

      function mint(string memory _DeltaChimp) public {//this function is caled mint, for minting KBz
        // this is deprecated - uint _id = deltaChimpz.push(_DeltaChimp);
            require(!_deltaChimpzExists[_DeltaChimp],
            'Error _DeltaChimp already exists');
            deltaChimpz.push(_DeltaChimp);
            uint _id = deltaChimpz.length - 1;

        //.push no longer returns the length but a ref to the added element 
       // uint _id = deltaChimpz.push(_DeltaChimp);      for tracking KBz

            _mint(msg.sender, _id);//finally to run we have to use _mint(it will take 2 arguments -address(who is minting) &token id)
            _deltaChimpzExists[_DeltaChimp] = true;

      }

        // initialize this contract to inherit
        // name and symbol from erc721metadata so that
        // the name is DeltaChimp and the symbol is DCHIMPZ
      constructor() ERC721Connector ('DeltaChimp', 'DCHIMPZ')
      {
                
      }
}           