// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract FCon{
    //i wanna make a comment section per user, they can comment,update,delete comments
    //create struct uder
    struct User{
        string name;
        uint serialNO;
        address UID;
        bool isCommented;
    }
    //store user
    mapping (address=>User) private users;
    //store UID's
    address[] private usersUID;
    //store comments
   mapping (address=>string[]) public CommentsOfAUser;
   function setUser(string memory _name,uint _sNo ,address _UID) public {
    User memory referenceUser=User({
        name:_name,
        serialNO:_sNo,
        UID:_UID,
        isCommented:false
    });
    users[_UID]=referenceUser;
    usersUID.push(_UID);
   }
   function CheckUser(address _UID)public view returns (string memory ,uint,address,bool){
    User memory ref=users[_UID];
    return (ref.name,ref.serialNO,ref.UID,ref.isCommented);
   }
   function makeComment(string memory _comment,address _UID)public returns (string memory){
    require(msg.sender==_UID,"enter your addres");
    CommentsOfAUser[msg.sender].push(_comment);
    users[msg.sender].isCommented=true;
    return "succes";
   }
   function updateComment(string memory _comment,uint index,address _UID)public {
    // require(index<CommentsOfAUser[msg.sender].length,"not a valid index");
    // if(index>=CommentsOfAUser[msg.sender].length){
    //     revert("not a valid index");
    // }
    require(msg.sender==_UID,"enter  valid address");
    CommentsOfAUser[msg.sender][index]=(_comment);
   }
   //del comment
   function deleteComment(address _UID,uint _indexOFComment)public {
    require(msg.sender==_UID);
    require(_indexOFComment<CommentsOfAUser[msg.sender].length);
    uint lastIndex=CommentsOfAUser[msg.sender].length-1;
    CommentsOfAUser[msg.sender][_indexOFComment]=CommentsOfAUser[msg.sender][lastIndex];
    CommentsOfAUser[msg.sender].pop();
   }

//to view
function vewComments(address _UID)public view returns (string[] memory){
require(msg.sender==_UID,"enter valid UID");
return CommentsOfAUser[msg.sender];

}
function getCommentCount() public view returns (uint) {
    return CommentsOfAUser[msg.sender].length;
}

}
