.syntax unified
.cpu cortex-a7

.text
.global caesar
caesar:
    @epilogus
    push {r4-r11 , lr}


    @ 1. argumentum : r0 = > input array
    @ 2. argumentum : r1 = > shift
    @ 3. argumentum : r2 = > output array

    mov r4 , #0 @ r4 => i=0
    mov r5 , #1
    

forloop:
    @ r0[r4] betu másolása r7-be
    ldrb r7 , [r0 , r4]

    @ ha r7=='\0' akkor vegere megy
    cmp r7 , #0
    beq end
 
    @ha r7 >= 65 --> lesse90 else write
    cmp r7 , #65
    bge lesse90
    blt write

    b forloop
write:
    @ index kiszámolása r6ba
    mul r6 , r4 , r5
    @ r2[r6]=r7
    str r7, [r2 , r6]

    @ r4+=1
    add r4, r4, #1
    b forloop
lesse90:
    @ ha r7<=90 --> shiftcheck else write
    cmp r7 , #90
    ble shiftcheck
    bgt write 

    b forloop
shiftcheck:
    @ r7-hez hozzáadjuk a shifet és ha r7<=90 -->write
    add r7, r7 , r1
    cmp r7 , #90
    ble write
    @ ha r7>90 akkor shiftloop
    bgt shiftloop

    b write

shiftloop:
    @ ha r7<=90 akkor --> write amúgy meg kivonunk belőle egy ABC-nyi távolságot
    cmp r7, #90
    ble write

    sub r7, #26

    b shiftloop
end:
    @ beleírjuk még a tömbe a '\0' karaktert is
    mul r6 , r4 , r5
    str r7, [r2 , r6]
    @prologus
    pop {r4-r11 , pc}
