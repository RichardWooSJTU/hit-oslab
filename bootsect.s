ROOT_DEV = 0x306
entry _start
_start:
    mov ax, #0x07c0
    mov es, ax          ! init es
    mov	ah,#0x03		! read cursor pos
    xor	bh,bh
    int	0x10
    
    mov	cx,#30
    mov	bx,#0x0083		! page 0, attribute qingse 0011(red + blue)
    ! we may test if spark by setting the first bit to 1
    mov	bp,#msg1
    mov	ax,#0x1301		! write string, move cursor
    int	0x10

load_setup:
    !how int13 works
    mov ax, #0x0200+2 !ah = option and al=section nums
    mov cx, #0x0002 !ch = zhumian and cl = section
    mov dx, #0x0000 !dh = citou and dl = driver while sd 00h-7fh hd 80h-ffh
    mov bx, #0x0200 !es:bx is target address
    int 0x13
    jnc ok_load_setup
    mov dx, #0x0000
    mov ax, #0x0000
    int 0x13
    jmp load_setup

ok_load_setup:
    jmpi 0, 0x07e0
msg1:
    .byte 13,10
    .ascii "Welcome to HarmonyOS 2.0"
    .byte 13,10,13,10

.org 508
root_dev:
    .word ROOT_DEV
boot_flag:
    .word 0xAA55
