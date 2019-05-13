
;INSTITUTO TECNOLOGICO SUPERIOR DE VALLADOLID 
;LENGUAJES Y AUTOMATAS 2 
;6-B
;ELABORADO POR: JOSE GUSTAVO POMOL COUOH 
;FECHA: 8/05/2019


.MODEL SMALL


.DATA 

    mj1 db "MENU DE OPERACIONES","$"
    mj2 db "[1] OPERACIONES BASICAS","$"
    mj3 db "[2] ENCUEBTRA EL MAYOR DE 3 NUMEROS","$"
    mj5 db "SELECCIONE UNA OPCION:","$"  
    
    c1 db "OPERACIONES BASICAS","$"
    c2 db "ENCUENTRE EL MAYOR DE 3 DIGITOS$"
     
  

.CODE 
     
     MOV AX,@DATA
     MOV DS,AX  
      
     inicio:
     
     
     MOV AX,0600H   
     MOV BH,2FH   
     MOV CX,0000H                                   
     MOV DX,184FH
     INT 10H
     

;    ------------

   

;    ------------   ( FONDO NEGRO )
     
     MOV AX,0600H   
     MOV BH,0FH   
     MOV CX,030AH                                   
     MOV DX,0446H
     INT 10H  
;    ------------   ( FONDO AZUL )     
     
     MOV AX,0600H   
     MOV BH,1FH   
     MOV CX,060AH                                   
     MOV DX,1446H
     INT 10H
     
     

;    ------------  CURSOR MJ1
     
     MOV AH,02H
     MOV BH,0   ;   
     MOV DH,04H
     MOV DL,20H
     INT 10H 
  
     
     MOV AH,09H
     MOV DX,offset mj1
     INT 21H 
     
;    ------------  CURSOR MJ2
     
     MOV AH,02H
     MOV BH,0   ;   
     MOV DH,07H
     MOV DL,0DH
     INT 10H 
  
     
     MOV AH,09H
     MOV DX,offset mj2
     INT 21H 

;    ------------  CURSOR MJ3 

     MOV AH,02H
     MOV BH,0   ;   
     MOV DH,0AH
     MOV DL,0DH
     INT 10H 
  
     
     MOV AH,09H
     MOV DX,offset mj3
     INT 21H


;    ------------  CURSOR MJ5  

     MOV AH,02H
     MOV BH,0   ;   
     MOV DH,10H
     MOV DL,0DH
     INT 10H 
  
     
     MOV AH,09H
     MOV DX,offset mj5
     INT 21H
     

     

     
     
;----------------------------


     MOV AH,0H
     INT 16H   
     
     CMP AL,49
     JE SUMA
     
     CMP AL,50
     JE RESTA 
     
     
         
     fin:
     mov ax,4c00h       ;funcion que termina el programa
     int 21h
     
     SUMA:
     
     MOV AH,05H
     MOV AL,0
     INT 10H
     
     MOV AX,0600H   
     MOV BH,5FH   
     MOV CX,0000H                                   
     MOV DX,184FH
     INT 10H
     
     MOV AH,09H
     MOV DX,offset c1
     INT 21H
     
     MOV AH,0H
     INT 16H
     
     CMP AL,08 
     
     ;SIMPLES MENSAJES
MSJ1 DB 0AH,0DH, "INGRESE TRES DIGITO DEL 0 AL 9 : ", "$"
MSJ2 DB 0AH,0DH, "PRIMER DIGITO: ", "$"
MSJ3 DB 0AH,0DH, "SEGUNDO DIGITO: ", "$"
MSJ4 DB 0AH,0DH, "TERCER DIGITO: ", "$"
MAYOR DB 0AH,0DH, "EL DIGITO MAYOR ES: ", "$"


DIGITO1 DB 100 DUP("$")
DIGITO2 DB 100 DUP("$")
DIGITO3 DB 100 DUP("$")


SALTO DB 13,10,,13,10,"$" ;SALTO DE LINEA


MOV SI,0
MOV AX,@DATA
MOV DS,AX
MOV AH,09
MOV DX,OFFSET MSJ1 ;IMPRIMIMOS EL MSJ1
INT 21H

CALL SALTODELINEA;LLAMAMOS EL METODO SALTODELINEA.

CALL PEDIRCARACTER ;LLAMAMOS AL METODO

MOV DIGITO1,AL ;LO GUARDADO EN AL A DIGITO1

CALL SALTODELINEA

CALL PEDIRCARACTER

MOV DIGITO2,AL

CALL SALTODELINEA

CALL PEDIRCARACTER

MOV DIGITO3,AL

CALL SALTODELINEA

;*******************************COMPARAR*****************************************

MOV AH,DIGITO1
MOV AL,DIGITO2
CMP AH,AL ;COMPARA PRIMERO CON EL SEGUNDO
JA COMPARA-1-3 ;SI ES MAYOR EL PRIMERO, AHORA LO COMPARA CON EL TERCERO
JMP COMPARA-2-3 ;SI EL PRIMERO NO ES MAYOR,AHORA COMPARA EL 2 Y 3 DIGITO
COMPARA-1-3:
MOV AL,DIGITO3 ;AH=PRIMER DIGITO, AL=TERCER DIGITO
CMP AH,AL ;COMPARA PRIMERO CON TERCERO
JA MAYOR1 ;SI ES MAYOR QUE EL TERCERO, ENTONCES EL PRIMERO ES MAYOR QUE LOS 3

COMPARA-2-3:
MOV AH,DIGITO2
MOV AL,DIGITO3
CMP AH,AL ;COMPARA 2 Y 3, YA NO ES NECESARIO COMPARARLO CON EL 1,PORQUE YA SABEMOS QUE EL 1 NO ES MAYOR QUE EL 2
JA MAYOR2 ;SI ES MAYOR EL 2,NOS VAMOS AL METODO PARA IMPRIMIRLO
JMP MAYOR3 ;SI EL 2 NO ES MAYOR, OBVIO EL 3 ES EL MAYOR

 
MAYOR1:

CALL MENSAJEMAYOR ;LLAMA AL METODO QUE DICE: EL DIGITO MAYOR ES:

MOV DX, OFFSET DIGITO1 ;IMPRIR EL DIGITO 1 ES MAYOR
MOV AH, 9
INT 21H
JMP EXIT

MAYOR2:
CALL MENSAJEMAYOR

MOV DX, OFFSET DIGITO2 ;SALTO DE LINEA
MOV AH, 9
INT 21H
JMP EXIT

MAYOR3:
CALL MENSAJEMAYOR

MOV DX, OFFSET DIGITO3 ;SALTO DE LINEA
MOV AH, 9
INT 21H
JMP EXIT

;********************************METODOS*****************************************

MENSAJEMAYOR:
MOV DX, OFFSET MAYOR ;EL DIGITO MAYOR ES:
MOV AH, 9
INT 21H

RET
PEDIRCARACTER:
MOV AH,01H; PEDIMOS PRIMER DIGITO
INT 21H
RET

SALTODELINEA:
MOV DX, OFFSET SALTO ;SALTO DE LINEA
MOV AH, 9
INT 21H
RET

EXIT:
MOV AX, 4C00H;UTILIZAMOS EL SERVICIO 4C DE LA INTERRUPCION 21H
INT 21H ;PARA TERMIANR EL PROGRAMA
     JE inicio 
     
     JMP fin
     
     
     RESTA:
     
     MOV AH,05H
     MOV AL,0
     INT 10H
     
     MOV AX,0600H   
     MOV BH,4FH   
     MOV CX,0000H                                   
     MOV DX,184FH
     INT 10H 
     
     MOV AH,09H
     MOV DX,offset c2
     INT 21H
     
     MOV AH,0H
     INT 16H
     
     CMP AL,08
     JE inicio 

     JMP fin    
         
     
     ;MOV AH,4CH
     ;INT 21H        
    

END