// contracts/GameItem.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyNFT is ERC721 {
    // 加上以下兩行才可使用 tokenId
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // name = 代幣全名 symbol = 代幣縮寫
    address private owner;
    constructor() ERC721("Kevin's NFT", "KKNFT") {
        owner = msg.sender;
    }

    // amount 表示要 mint 給自己幾次
    function mint(uint256 amount) public {
        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = _tokenIds.current();
            _mint(msg.sender, tokenId);
            _tokenIds.increment();
        }
    }
    // to 是要轉給哪個地址，amount 是要轉多少
    function mintToken(address to, uint amount) public {
        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = _tokenIds.current();
            _mint(to, tokenId);
            _tokenIds.increment();
        }
    }
    // 新增燃燒、退款、鑄造購買時可以自動退款多餘
    modifier onlyContractOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier onlyNFTOwner {
        uint256 tokenId = _tokenIds.current();
        require(msg.sender == ownerOf(tokenId));
        _;
    }

    function burn(uint256 _tokenId) public onlyNFTOwner {
        _burn(_tokenId);
    }

    uint256 mintPrice = 0.03 ether;

    // 記得加上 payable 才能用 msg.value or callvalue
    function mint_refund(uint256 amount) public payable {
        require(msg.value >= (mintPrice * amount), "Not enough Ether");
        mint(amount);

        if (msg.value > mintPrice * amount) {
            uint256 refund = msg.value - mintPrice * amount;
            (bool sent, ) = msg.sender.call{value: refund}("");
            require(sent, "Failed to refund Ether"); // 若 sent 為 false 則回傳錯誤訊息
        }
    }
    // uint256 tokenId = _tokenIds.current();
    // _tokenIds.increment();
}
