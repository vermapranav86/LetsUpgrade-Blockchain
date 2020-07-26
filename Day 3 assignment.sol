pragma solidity >=0.4.25 <0.7.0;

contract  Day3{
    
    uint idModulus = 10 **5;
    
    struct Student {
        
        string name;
       uint id;
       
        
    }
    
    Student s1;

function setData(string _name , uint _id) private {
    
    s1.name = _name;
    s1.id = _id;
   
}
 
 function _createId(string strname) private returns(uint){
     
     uint uniqId = uint(keccak256(abi.encodePacked(strname)));
     return (uniqId % idModulus);
     
 }

function getId(string stdName) public view returns(uint){
    
 uint stdId = _createId(stdName);
 setData( stdName , stdId);
 return stdId;
    
}
}
    
    
    
    