pragma solidity >=0.5.0 <0.6.0;
/*
        * This is a simple solidity smart contrant for  University Student's registration and report card in which only
           university can register and set Marks(only done through university address "0x6ac176B4B406Ee03F4CCDA3e791C64DEF49060ec") 
        * The contract is deployed on repsten test network .(Link :- https://ropsten.etherscan.io/address/0xeaf78c3d6edb83d2d72064acdcd82119c3d1d2b4)
                *Contratct Address :-  0xEaF78c3D6EDb83D2D72064AcDCd82119c3D1D2b4
        * I registered and set Marks  of three students with following addresses -
                 *  Pranav Verma   :- 0x39BfD311149DD4C40f6e345A497bF9834980e11E
                 *  Harshit Sharma :- 0x33317D5Df12595D7C379B7128855fca20CFBD526
                 *  Sawan Kag      :- 0x1b47303d2243E076C0573FD52A47E3813aeD13f5
*/


contract University {
    
    struct Students{
        
        string name;
        string batch;
        address studentAddress; // "we are using studentAddress as rollNO."
        string status;
    
    }
    
    
    uint public stdcount;
    Students[] private student;
    mapping (address => uint ) stdAdd ; //"mapping" create key-value pairs 
    
    //"registerStudent" function can only used by the University
    function  registerStudent(string memory _name, string memory _batch, address _studentAddress, string memory _status) public {
        
        //"require" checks weather the function call is made by University's address or not
        require(msg.sender == 0x6ac176B4B406Ee03F4CCDA3e791C64DEF49060ec, "Only University can register student" );
        stdcount =student.push(Students(_name, _batch,  _studentAddress, _status));
        uint _count =stdcount-1;
        stdAdd[_studentAddress] = _count; //student's address mapped with student's count -1(because array indexing starts with 0)
     
    }
    
    
    //"getStudentDetails" function can be called by anyone 
    function getStudentDetails(address _studentAddress) public view returns( string  memory , string memory,string memory  ) {
        
        return  (student[stdAdd[_studentAddress]].name, student[stdAdd[_studentAddress]].batch, student[stdAdd[_studentAddress]].status);
        
    }
     
     struct ReportCards {
         
         uint sub1Marks;
         uint sub2Marks;
         uint sub3Marks;
         uint sub4Marks;
         
         }
         
         ReportCards[100] private reportCard;
         
         //"setMarks" function can only used by University'address
         function setMarks(address _studentAddress, uint _mark1, uint _mark2, uint _mark3, uint _mark4) public  {
            
          //"require" checks weather the function call is made by University's address or not   
             require(msg.sender == 0x6ac176B4B406Ee03F4CCDA3e791C64DEF49060ec, "Only University can set students marks" );
            reportCard[stdAdd[_studentAddress]]=(ReportCards( _mark1, _mark2, _mark3, _mark4 )); 
             uint percentage = (reportCard[stdAdd[_studentAddress]].sub1Marks +reportCard[stdAdd[_studentAddress]].sub2Marks +reportCard[stdAdd[_studentAddress]].sub3Marks +reportCard[stdAdd[_studentAddress]].sub4Marks) /4;
             if( percentage <33){
                 student[stdAdd[_studentAddress]].status = "FAIL";
                  }
             
         }
         
         
         //"getResult" can be called by anyone
         function getResult(address _studentAddress) public  view returns( string memory, uint, uint, uint ,uint, string memory){
             
              return (student[stdAdd[_studentAddress]].name, reportCard[stdAdd[_studentAddress]].sub1Marks, reportCard[stdAdd[_studentAddress]].sub2Marks, reportCard[stdAdd[_studentAddress]].sub3Marks, reportCard[stdAdd[_studentAddress]].sub4Marks, student[stdAdd[_studentAddress]].status);
         }    
         
    
    
}
