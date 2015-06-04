SECTION .data

a DD 1235151233         ; Variable a
b DD -24                ; Variable b
d DD 1560               ; Variable d              

SECTION .text

global main

main:

push ebp
mov ebp, esp

mov ebx, [b]            ; b in ebx kopieren
mov eax, [a]            ; a in eax kopieren
mov edx, [d]            ; d in edx kopieren

push dword edx          ; Inhalt von edx auf Stack sichern
imul ebx                ; a*b in eax und edx, signed Multiplikation
jc carry                ; jump, wenn carryflag gesetzt ist 
pop edx                 ; Falls carryflag nicht gesetzt ist, edx = 0 und Ergebnis der Multiplikation
                        ; nur in eax. Also gesichertes edx wiederherstellen.
                        ; eax enthält Ergebnis, edx enthält gesicherten Wert.
jmp end                 ; Zum Ende


carry:
push dword edx          ; Zweite Hälfte der Multiplikation auf Stack sichern
push dword eax          ; Erste Hälfte sichern
add esp, dword 8        ; esp auf gesichertes edx zeigen lassen
pop edx                 ; Gesichertes edx in edx kopieren
sub esp, dword 12       ; Stackpointer wieder auf letztes Element zeigen lassen
                        ; edx enthält Inhalt von vor der Multiplikation,
                        ; Ergebnis der Multiplikation liegt auf dem Stack
jmp end                 ; Zum Ende                        
                         
end:

mov esp, ebp
pop ebp
mov ebx, 0
mov eax, 1 
int 0x80
