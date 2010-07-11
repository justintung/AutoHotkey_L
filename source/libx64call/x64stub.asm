;///////////////////////////////////////////////////////////////////////
;
;	Windows x64 RegisterCallback stub
;	written by fincs
;
;///////////////////////////////////////////////////////////////////////

.code

CallbackFunctionOffset = 8*3

RegisterCallbackAsmStub proc frame
	option prologue:none, epilogue:none
.allocstack 8*5
.endprolog

	; Save the parameters in the spill area for consistency
	mov qword ptr[rsp+8*1], rcx  ; 1 vs 0 to skip over the return address
	mov qword ptr[rsp+8*2], rdx
	mov qword ptr[rsp+8*3], r8
	mov qword ptr[rsp+8*4], r9

	; Set parameters for the upcoming function call
	mov rcx, rsp ; UINT_PTR* aParams
	mov rdx, rax ; RCCallbackFunc* cbAddress

	; Call callback stub function
	sub rsp, 8*5 ; padding+spill area
	call qword ptr[rax+CallbackFunctionOffset]
	add rsp, 8*5

	; Return
	ret
RegisterCallbackAsmStub endp

end
