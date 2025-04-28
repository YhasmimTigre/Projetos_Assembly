.686
.model flat, stdcall
option casemap :none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib
include \masm32\macros\macros.asm

.data
    
    nota1 dd 0
    nota2 dd 0
    nota3 dd 0
    media dd 7
    provaFinal dd 4
    format db "%d", 0 

.code
start:  
    printf("*************************** \n")
    printf("Situacao Academica do Aluno \n")
    printf("*************************** \n")
    
    printf("Digite a primeira nota: \n")
    invoke crt_scanf, addr format, addr nota1

    printf("Digite a segunda nota: \n")
    invoke crt_scanf, addr format, addr nota2

    printf("Digite a terceira nota: \n")
    invoke crt_scanf, addr format, addr nota3
    
    ;media das notas
    xor edx, edx 
    mov eax, nota1  
    add eax, nota2  
    add eax, nota3    
    mov ebx, 3        
    div ebx  
    
    mov esi, eax

    cmp esi, 10
    jg _Erro
    
    cmp esi, media
    jge _Aprovado

    cmp esi, provaFinal
    jge _Final


    printf("Situacao: Reprovado!\n")
    printf("media: %d", esi)
    jmp _EncerraCodigo

_Final:
    printf("Situacao: Em prova final!\n")
    printf("media: %d \n", esi)

    ; Calcula a nota necessaria na final
    ; Formula: nota_final = (5 * 2) - media_atual
    
    mov eax, 10
    sub eax, esi

    mov esi, eax

    printf("Voce precisa de %d para passar na final \n", esi)
    
    jmp _EncerraCodigo
    
    
_Aprovado:
    printf("Situacao: Aprovado por media!\n")
    printf("media: %d", esi)
    jmp _EncerraCodigo

_Erro:
    printf("Media maior que 10, digite os valores novamente \n")
    jmp start
    
_EncerraCodigo:
    invoke ExitProcess, 0
    
end start

