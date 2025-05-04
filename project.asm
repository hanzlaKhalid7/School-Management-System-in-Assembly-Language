.model small
.stack 100h
.data
     fname         db 'ffff',0
     handle        dw ?
     menue         db '                    ---------------------------------------------------',10,13
                   db '                    |              1.Write student data               |',10,13
                   db '                    |              2.Read student data                |',10,13
                   db '                    |              3.Update student data              |',10,13
                   db '                    |              4.Delete student data              |',10,13
                   db '                    |              5.Exit                             |',10,13
                   db '                    ---------------------------------------------------',10,13
                   db 'Enter option : $'
     strName       db 'Enter student name : $'
     strRoll       db 'Enter student roll number : $'
     strCgpa       db 'Enter student cgpa : $'
     name1         db 28 dup(' '),13,'$'
     roll          db 28 dup(' '),13,'$'
     cgpa          db 28 dup(' '),13,'$'
     nameU1        db 32 dup('$')
     rollU1        db 32 dup('$')
     cgpaU1        db 32 dup('$')
     nameU2        db 32 dup('$')
     rollU2        db 32 dup('$')
     cgpaU2        db 32 dup('$')
     nameU3        db 32 dup('$')
     rollU3        db 32 dup('$')
     cgpaU3        db 32 dup('$')
     nameU4        db 32 dup('$')
     rollU4        db 32 dup('$')
     cgpaU4        db 32 dup('$')
     strCheck      db 'Enter student roll number : $'
     rollCheck     db 28 dup(' '),13,'$'
     notFound      db 'Record not found$'
     allahHafiz    db 10,13,'************** THANK YOU FOR CHECKING PUCIT CMS *****************',10,13,'$'
     invalidChoice db 10,13,'************** INVALID CHOICE ****************',10,13,'$'
     star          db '--------------- RECORD OF STUDENT -------------------$'
     pucit         db 10,13,'           ///////////////////// WELCOME TO PUCIT CMS ///////////////////////',10,13,10,13,'$'
.code
main proc
                        mov  ax,@data
                        mov  ds,ax
                        lea  dx,pucit
                        call string_output
     ;displaying menue
     menu:              lea  dx,menue
                        call string_output
     ;taking menue input (option form user)
                        mov  ah,01h
                        int  21h
                        sub  al,30h

                        cmp  al,2
                        je   read_data

                        cmp  al,3
                        je   update_data

                        cmp  al,4
                        je   dlt

                        cmp  al,5
                        je   ext

                        cmp  al,1
                        je   wrt

                        lea  dx,invalidChoice
                        call string_output
                        jmp  menu

     ;read data from file
     read_data:         call new_line
                        call new_line
                        lea  dx,strCheck
                        call string_output
                        lea  di,rollCheck
                        call string_input

                        call new_line
                        lea  dx,star
                        call string_output
                        call new_line
                        call new_line
                        call reading_form_file
                        call new_line
                        call new_line
                        lea  dx,star
                        call string_output
                        call new_line

                        jmp  ext

     ;update data in a file
     update_data:       call new_line
                        call new_line
                        lea  dx,strCheck
                        call string_output
                        lea  di,rollCheck
                        call string_input
                        call updating_in_file
                        jmp  ext

     ;deleta data from file
     dlt:               call new_line
                        call new_line
                        lea  dx,strCheck
                        call string_output
                        lea  di,rollCheck
                        call string_input
                        call deleting_form_file
                        jmp  ext

     ;write existing data in a file
     wrt:               call writing_in_file

     ;printing end greetings
     ext:               lea  dx,allahHafiz
                        call string_output

     ;ending of main function
                        mov  ah,4ch
                        int  21h
main endp

     ;this function will take input in string from user****************************************

string_input proc
     aa:                mov  ah,01h
                        int  21h
                        cmp  al,13
                        je   exit
                        mov  [di],al
                        inc  di
                        jmp  aa
                       
     exit:              ret
string_input endp

     ;this function will display string on console********************************************

string_output proc
                        mov  ah,09h
                        int  21h
                        ret
string_output endp

     ;this function will store output in file****************************************************

file_output proc
                        mov  ah,40h
                        mov  bx,handle
                        int  21h
                        ret
file_output endp

     ;this function will take input from file**************************************************

file_input proc
                        mov  ah,3fh
                        mov  bx,handle
                        int  21h
                        ret
file_input endp

     ;this function will print new line***********************************************************

new_line proc
                        mov  dl,10
                        mov  ah,02h
                        int  21h
                        mov  dl,13
                        mov  ah,02h
                        int  21h
                        ret
new_line endp

     ;this function will read data from file and print specific data on console*******************************************

reading_form_file proc

     ;opening existing file
                        lea  dx,fname
                        mov  ah,3dh
                        mov  al,0
                        int  21h
                        mov  handle,ax

     ;student1-----------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU1
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_input

     ;student2-----------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_input

     ;student3----------------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_input

     ;student4-------------------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_input

     ;comparing each roll number;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

     ;student1---------------------------------------------------------

                        lea  si,rollCheck
                        lea  di,rollU1
                        jmp  blo1
     az1:               dec  cx
                        inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eqi1
     blo1:              mov  al,[si]
                        cmp  al,[di]
                        je   az1
                        jmp  neq2
     eqi1:              lea  dx,rollU1
                        call string_output
                        call new_line
                        lea  dx,nameU1
                        call string_output
                        call new_line
                        lea  dx,cgpaU1
                        call string_output
                        jmp  eeee

     ;comparing second roll number---------------------------------------------------------

     neq2:              lea  si,rollCheck
                        lea  di,rollU2
                        jmp  blo2
     az2:               dec  cx
                        inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eqi2
     blo2:              mov  al,[si]
                        cmp  al,[di]
                        je   az2
                        jmp  neq3
     eqi2:              lea  dx,rollU2
                        call string_output
                        call new_line
                        lea  dx,nameU2
                        call string_output
                        call new_line
                        lea  dx,cgpaU2
                        call string_output
                        jmp  eeee

     ;comparing third roll number-------------------------------------------------------------

     neq3:              lea  si,rollCheck
                        lea  di,rollU3
                        jmp  blo3
     az3:               dec  cx
                        inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eqi3
     blo3:              mov  al,[si]
                        cmp  al,[di]
                        je   az3
                        jmp  neq4
     eqi3:              lea  dx,rollU3
                        call string_output
                        call new_line
                        lea  dx,nameU3
                        call string_output
                        call new_line
                        lea  dx,cgpaU3
                        call string_output
                        jmp  eeee

     ;comparing fourth roll number------------------------------------------------------------------

     neq4:              lea  si,rollCheck
                        lea  di,rollU4
                        jmp  blo4
     az4:               dec  cx
                        inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eqi4
     blo4:              mov  al,[si]
                        cmp  al,[di]
                        je   az4
                        jmp  neql

     eqi4:              lea  dx,rollU4
                        call string_output
                        call new_line
                        lea  dx,nameU4
                        call string_output
                        call new_line
                        lea  dx,cgpaU4
                        call string_output
                        jmp  eeee
     neql:              
                        lea  dx,notFound
                        call string_output

     ;closing of file
     eeee:              mov  dx,handle
                        mov  ah,3eh
                        int  21h
                        ret
reading_form_file endp

     ;this function will delete specific record from file*******************************************************

deleting_form_file proc

     ;opening existing file
                        lea  dx,fname
                        mov  ah,3dh
                        mov  al,0
                        int  21h
                        mov  handle,ax

     ;student1--------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU1
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_input

     ;student2-----------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_input

     ;student3--------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_input

     ;student4---------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_input
     ;closing file
                        mov  dx,handle
                        mov  ah,3eh
                        int  21h

     ;creating new file to delete a record;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                        lea  dx,fname
                        mov  ah,3ch
                        mov  cl,1
                        int  21h
                        mov  handle,ax

     ;checking first roll number----------------------------------------------------------

                        lea  si,rollCheck
                        lea  di,rollU1
                        jmp  blo11
     az11:              inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   neq22
     blo11:             mov  al,[si]
                        cmp  al,[di]
                        je   az11
     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU1
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_output

     ;comparing second roll number-----------------------------------------------------------

     neq22:             lea  si,rollCheck
                        lea  di,rollU2
                        jmp  blo22
     az22:              inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   neq33
     blo22:             mov  al,[si]
                        cmp  al,[di]
                        je   az22
     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_output

     ;comparing third roll number----------------------------------------------------------

     neq33:             lea  si,rollCheck
                        lea  di,rollU3
                        jmp  blo33
     az33:              inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   neq44
     blo33:             mov  al,[si]
                        cmp  al,[di]
                        je   az33
     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_output

     ;comparing fourth roll number-------------------------------------------------------

     neq44:             lea  si,rollCheck
                        lea  di,rollU4
                        jmp  blo44
     az44:              inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eeeee
     blo44:             mov  al,[si]
                        cmp  al,[di]
                        je   az44
     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_output
                              
     ;closing of file
     eeeee:             mov  dx,handle
                        mov  ah,3eh
                        int  21h
                        ret
deleting_form_file endp

     ;this function will update specific record in the file******************************************************

updating_in_file proc

     ;opening existing file
                        lea  dx,fname
                        mov  ah,3dh
                        mov  al,0
                        int  21h
                        mov  handle,ax

     ;student1--------------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU1
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_input

     ;student2---------------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_input

     ;student3-----------------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_input

     ;student4-------------------------------------------------------------------------

     ;reading roll number from file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_input
     ;reading name from file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_input
     ;reading gpa from file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_input
     ;closing file
                        mov  dx,handle
                        mov  ah,3eh
                        int  21h

     ;creating new file to update a record;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                        lea  dx,fname
                        mov  ah,3ch
                        mov  cl,1
                        int  21h
                        mov  handle,ax

     ;input name from user
                        lea  dx,strName
                        call string_output
                        lea  di,name1
                        call string_input
     ;input cgpa from user
                        lea  dx,strCgpa
                        call string_output
                        lea  di,cgpa
                        call string_input

     ;checking first roll number/////////////////////////////////////////////////////////////

                        lea  si,rollCheck
                        lea  di,rollU1
                        jmp  blo111
     az111:             inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eql1
     blo111:            mov  al,[si]
                        cmp  al,[di]
                        je   az111
                        jmp  neq222

     ;student 1--------------------------------------------------------------------------------

     ;writing roll number in file
     eql1:              mov  cx,29d
                        lea  dx,rollCheck
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,name1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpa
                        call file_output

     ;student2----------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_output

     ;student3-------------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_output

     ;student4-----------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_output

     ;comparing second roll number//////////////////////////////////////////////////////////////

     neq222:            lea  si,rollCheck
                        lea  di,rollU2
                        jmp  blo222
     az222:             inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eql2
     blo222:            mov  al,[si]
                        cmp  al,[di]
                        je   az222
                        jmp  neq333

     ;student1-----------------------------------------------------------------------------------

     ;writing roll number in file
     eql2:              mov  cx,29d
                        lea  dx,rollU1
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_output

     ;sudent2------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollCheck
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,name1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpa
                        call file_output

     ;student3-----------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_output

     ;student4--------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_output

     ;comparing third roll number//////////////////////////////////////////////////////////////

     neq333:            lea  si,rollCheck
                        lea  di,rollU3
                        jmp  blo333
     az333:             inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eql3
     blo333:            mov  al,[si]
                        cmp  al,[di]
                        je   az333
                        jmp  neq444

     ;student1-------------------------------------------------------------------------------

     ;writing roll number in file
     eql3:              mov  cx,29d
                        lea  dx,rollU1
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_output

     ;student2----------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_output

     ;student3------------------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollCheck
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,name1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpa
                        call file_output

     ;student4----------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU4
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU4
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU4
                        call file_output

     ;comparing fourth roll number//////////////////////////////////////////////////////////////

     neq444:            lea  si,rollCheck
                        lea  di,rollU4
                        jmp  blo444
     az444:             inc  si
                        inc  di
                        mov  al,32
                        cmp  al,[si]
                        je   eql4
     blo444:            mov  al,[si]
                        cmp  al,[di]
                        je   az444
                        jmp  eeeeee
     
     ;student1----------------------------------------------------------------------------

     ;writing roll number in file
     eql4:              mov  cx,29d
                        lea  dx,rollU1
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU1
                        call file_output

     ;student2---------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU2
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU2
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU2
                        call file_output

     ;student3------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollU3
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,nameU3
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpaU3
                        call file_output

     ;student4---------------------------------------------------------------------------

     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,rollCheck
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,name1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpa
                        call file_output
                        
     ;closing of file
     eeeeee:            mov  dx,handle
                        mov  ah,3eh
                        int  21h
                        ret
updating_in_file endp

     ;this function will take input from console*****************************************************

input_form_user proc
                        call new_line
                        call new_line
     ;input roll number form user
                        lea  dx,strRoll
                        call string_output
                        lea  di,roll
                        call string_input
     ;input name from user
                        lea  dx,strName
                        call string_output
                        lea  dx,name1
                        mov  di,dx
                        call string_input
     ;input cgpa from user
                        lea  dx,strCgpa
                        call string_output
                        lea  di,cgpa
                        call string_input
                        ret
input_form_user endp

     ;this fucntion will write data in file***********************************************************

writing_in_file proc
                        call input_form_user
     ;opening existing file
                        lea  dx,fname
                        mov  ah,3dh
                        mov  al,1
                        int  21h
                        mov  handle,ax
     ;opening in append mode
                        mov  bx,handle
                        mov  ah,42h
                        xor  cx,cx
                        xor  dx,dx
                        mov  al,2
                        int  21h
     ;writing roll number in file
                        mov  cx,29d
                        lea  dx,roll
                        call file_output
     ;writing name in file
                        mov  cx,29d
                        lea  dx,name1
                        call file_output
     ;writing gpa in file
                        mov  cx,29d
                        lea  dx,cgpa
                        call file_output
     ;closing of file
                        mov  dx,handle
                        mov  ah,3eh
                        int  21h
                        ret
writing_in_file endp

end main