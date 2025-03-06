// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract FC{
    struct Transaction{
string senderName;
string receiverName;
string tokenName;
uint amount;
address to;
}
mapping (bytes32=>Transaction) transactions;
mapping (address=>bytes32[]) allTransactionsPerOwner;
event Tran(bytes32 _hash);
function makeTransaction(string memory _senderName,string memory _receiverName,string memory _tokenName, uint amount,address to) public returns (bytes32){
    Transaction memory newT=Transaction({
        senderName:_senderName,
        receiverName:_receiverName,
        tokenName:_tokenName,
        amount:amount,
        to:to
    });
    bytes32 hash = keccak256(abi.encodePacked(_senderName,_receiverName,_tokenName,amount,to,msg.sender,block.timestamp,block.number));
    transactions[hash]=newT;
    allTransactionsPerOwner[msg.sender].push(hash);
    emit Tran(hash);
    return hash;
}
//In Solidity, state-changing functions do not return values when called via a transaction (because transactions do not return data; they execute changes in the blockchain).
//to solve this we used event 
}
