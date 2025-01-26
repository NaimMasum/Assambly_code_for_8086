
; Sorting : upto 5 digit  digit number 


include "source\bsort3.macro" ;contain the buble  sort macro
 
 
 
printstring macro msg
    ; Macro to print a string
    mov ah, 09h         ; Function to display string
    lea dx, msg         ; Load the address of the message
    int 21h             ; DOS interrupt
endm

_DATA segment


cr equ 0dh             ; Carriage return
lf equ 0ah
sm equ 1h
bip equ 7h             ; Line feed

msg1 db cr,lf,'Number of elements : $'  ; Message to prompt for number of elements
msg2 db cr, lf, 'Enter element : $'  ; Message to prompt for each element
msg3 db cr, lf,cr,lf, 'Elements in preferred order...',cr,lf,bip,bip,bip,bip,bip,'$'  ; Message for sorted output

order db 2
count db ?  
                   ; Variable to store the count of numbers
tabl dw 20 dup(0)             ; Array to store the numbers (max 20, word-sized for 3 digits)
tnum dw ?              ; Temporary variable for input
resdisp db 6 dup(0)    ; Buffer for displaying results  

warn db bip,bip,bip,sm,sm,sm,'Number should be with in 65000',cr,lf,lf,'$'

ask_order db cr,lf,lf, 'Enter 1 for Assending , 2 for dessending :', '$'




_DATA ends

_CODE segment
assume cs: _CODE, ds: _DATA

start:
    ; Initialize data segment
    mov ax, _DATA
    mov ds, ax 
    
    
    printstring warn

    printstring msg1         ; Prompt user for the number of elements
    lea si,count
    call readnum
    

    
    mov ch,00h
    mov cl, count
    mov bx, 0000h           ; Start storing numbers at tabl[0]
rdnxt:
    printstring msg2        ; Prompt for next number
    lea si,tnum       
    call readnum            ; Read the number (ensure proper size override) 
    mov ax, tnum            ; Load the value of tnum into AX
    mov tabl[bx], ax        ; Store the number in tabl 
    add bx, 2               ; Move to next index (word size)
    loop rdnxt              ; Repeat for all numbers
                            
    
    printstring ask_order
    mov ah,01h
    int 21h
    mov order,al
    ; Sort the numbers in ascending order using bubble sort
       
    bsort tabl,count,order
        
        
    
    mov ch,00h
    mov cl, count
    mov bx, 0000h                    ; Start displaying from tabl[0]
    mov si, offset resdisp
    printstring msg3
prnxt:
    mov ax, tabl[bx]              ; Get the number
    call hex2asc                  ; Convert to ASCII and store in resdisp
    printstring resdisp           ; Display the number
    add  bx, 2                     ; Move to next number
    loop prnxt                    ; Repeat for all numbers

    ; Exit program
    mov ah, 4ch
    mov al, 00h
    int 21h 
    

        ;contain the file for readnum and hex2asc procedure

  include "source\hex2asc2.proc"
  include "source\readnum.proc"     
          
        
           
        int 03h
_CODE ends
      end start  
      
























    



  






