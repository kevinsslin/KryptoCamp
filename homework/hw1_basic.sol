// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721 {
    // 加上以下兩行才可使用 tokenId
    // using Counters for Counters.Counter;
    // Counters.Counter private _tokenIds;

    // name = 代幣全名 symbol = 代幣縮寫
    constructor() ERC721("Kevin's NFT", "KKNFT") {}

    // amount 表示要 mint 給自己幾次
    function mint(uint256 tokenId, uint256 amount) public {
        for (uint256 i = 0; i < amount; i++) {
            // uint256 tokenId = _tokenIds.current();
            _mint(msg.sender, tokenId);
            tokenId += 1;
            // _tokenIds.increment();
        }
    }
    // to 是要轉給哪個地址，amount 是要轉多少
    function mintToken(uint256 tokenId, address to, uint amount) public {
        for (uint256 i = 0; i < amount; i++) {
            _mint(to, tokenId);
            tokenId += 1;
        }
    }
}
