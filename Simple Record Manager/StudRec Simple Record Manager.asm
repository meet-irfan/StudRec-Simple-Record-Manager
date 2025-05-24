.model small
.stack 100h
.data
    msg_menu db 13,10, "STUDENT RECORD SYSTEM", 13,10, "1. Add Record", 13,10, "2. View Record", 13,10, "3. Exit", 13,10, "Enter choice: $"
    msg_name db 13,10, "Enter Name: $"
    msg_roll db 13,10, "Enter Roll No: $"
    msg_marks db 13,10, "Enter Marks: $"
    msg_view db 13,10, "Student Details", 13,10, "$"
    msg_disp_name db "Name: $"
    msg_disp_roll db 13,10, "Roll No: $"
    msg_disp_marks db 13,10, "Marks: $"

    ; input buffers (max size, chars read, buffer)
    name_buf db 20,0,20 dup(0)
    roll_buf db 6,0,6 dup(0)
    marks_buf db 4,0,4 dup(0)

    choice db ?

.code
main:
    mov ax, @data
    mov ds, ax

menu:
    lea dx, msg_menu
    mov ah, 09h
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov choice, al

    cmp choice, 1
    je add_record

    cmp choice, 2
    je view_record

    cmp choice, 3
    je exit_program

    jmp menu

add_record:
    ; Get Name
    lea dx, msg_name
    mov ah, 09h
    int 21h

    lea dx, name_buf
    mov ah, 0Ah
    int 21h

    ; Get Roll No
    lea dx, msg_roll
    mov ah, 09h
    int 21h

    lea dx, roll_buf
    mov ah, 0Ah
    int 21h

    ; Get Marks
    lea dx, msg_marks
    mov ah, 09h
    int 21h

    lea dx, marks_buf
    mov ah, 0Ah
    int 21h

    jmp menu

view_record:
    lea dx, msg_view
    mov ah, 09h
    int 21h

    ; Show Name
    lea dx, msg_disp_name
    mov ah, 09h
    int 21h

    mov cl, [name_buf + 1]  ; number of chars entered (byte)
xor ch, ch              ; clear upper byte
mov si, offset name_buf + 2


print_name_loop:
    cmp cx, 0
    je print_name_done

    mov al, [si]
    mov dl, al
    mov ah, 02h
    int 21h

    inc si
    dec cx
    jmp print_name_loop

print_name_done:

    ; Show Roll No
    lea dx, msg_disp_roll
    mov ah, 09h
    int 21h

  mov cl, [roll_buf + 1]  ; load the byte count into lower 8 bits of cx
xor ch, ch              ; clear upper 8 bits of cx


print_roll_loop:
    cmp cx, 0
    je print_roll_done

    mov al, [si]
    mov dl, al
    mov ah, 02h
    int 21h

    inc si
    dec cx
    jmp print_roll_loop

print_roll_done:

    ; Show Marks
    lea dx, msg_disp_marks
    mov ah, 09h
    int 21h   
    
     mov al, [name_buf + 1]
mov cl, al
xor ch, ch


print_marks_loop:
    cmp cx, 0
    je print_marks_done

    mov al, [si]
    mov dl, al
    mov ah, 02h
    int 21h

    inc si
    dec cx
    jmp print_marks_loop

print_marks_done:

    jmp menu

exit_program:
    mov ah, 4Ch
    int 21h
end main
