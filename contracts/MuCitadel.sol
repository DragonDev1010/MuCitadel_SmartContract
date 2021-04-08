// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MuCitadel is ERC1155 {
    // Token Owner List
    mapping(uint => address) private owner_list;
    // Token List
    // token_kind : owner_address : token_amount
    mapping(uint256 => mapping(address => uint256)) public token_balance_list; 
    // Token Kind List
    // token_id : token uri
    mapping (uint256 => string) public token_kind_list;

    constructor() public ERC1155("https://game.example/api/item/{id}.json") {

    }
    function set_token_id (string memory token_uri) {
        uint len = token_kind_list.length;
        token_kind_list[len] = token_uri;
    }
    function get_token_id (string memory token_uri) returns (uint) {
        uint token_kind_amount = token_kind_list.length;
        for( uint i = 0 ; i < token_kind_amount ; i++ ){
            if (token_kind_list[i] == token_uri) {
                return i;
            }
        }
        set_token_id(token_uri);
        return token_kind_amount;
    }
    function create_token (string memory token_uri, uint256 token_amount) public {
        // get token ID from token URI
        uint token_id = get_token_id(token_uri);
        token_balance_list[token_id][msg.sender] += token_amount; 
        _mint(msg.sender, token_id, token_amount, "");
    }
    function get_token_balance (address owner, string memory token_uri) public returns (uint) {
        uint token_id = get_token_id(token_uri);
        return token_balance_list[token_id][owner];
    }
    function get_token_list () public returns (string[] memory) {
        return token_kind_list;
    }
    function filter_token_list (address owner, uint page_amount, uint page_num) public returns (string[] memory) {
        uint length = token_kind_list[owner].length;
        string[] memory result;
        for (uint i = page_amount * (page_num - 1) ; i < length ; i++ ) {
            if( i < page_amount ) {
                result.push(token_kind_list[owner][i]);
            }
        }
        return result;
    }
}   