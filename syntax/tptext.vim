" VIM Syntax File
" Language:	ICL/Fujitsu TPMS Parameter files
" Maintainer:	Andy Long (Andrew.Long@Yahoo.com)
" LastChange:	$Date$
" Version:	$Revision$
" Remarks:	TPMS is the Transaction Processing system for VME mainframe
"		systems. TPTEXT is the utility that prints input and output
"		messages from the Audit Trail
" $Log: tptext.vim,v $
"
if version<600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syntax	case	ignore

syntax	match	tptextError
	\	/\S*/

syntax	match	tptextConstant
	\	contained
	\	/\S*/

syntax	match	tptextFileName
	\	/[\*:]\=[A-Za-z]\=\S*/

syntax	match	tptextNumber
	\	contained
	\	/\<\d\+\>/

syntax	match	tptextPageNumber
	\	contained skipwhite nextgroup=tptextNumber,tptextError
	\	/\<page\>\s*/

syntax	match	tptextRunDate
	\	contained skipwhite nextgroup=tptextDateAndTime,tptextError
	\	/\<run\: /

syntax	match	tptextDateAndTime
	\	contained contains=tptextDate,tptextTime
	\	/\<\d\+\/\d\+\/\d\+\>\s\+\<\d\d:\d\d:\d\d\>/

syntax	match	tptextDate
	\	contained skipwhite nextgroup=tptextTime
	\	/\<\d\+\/\d\+\/\d\+\>/

syntax	match	tptextTime
	\	contained
	\	/\<\d\d:\d\d:\d\d/

syntax	match	tptextAvmName
	\	contained
	\	/\<\a\k\{0,11}\>/

syntax	match	tptextAvmName
	\	contained
	\	/\*\*\* system reply \*\*\*/

syntax	match	tptextTerminalName
	\	contained
	\	/\<\a\k\{0,11}\>/

syntax	match	tptextStatement
	\	skipwhite nextgroup=tptextTime,tptextError
	\	/^iptime :\s*/

syntax	match	tptextStatement
	\	skipwhite nextgroup==tptextConstant
	\	/^iptext :\s*/

syntax	match	tptextStatement
	\	skipwhite nextgroup=tptextConstant
	\	/^optext :\s*/

syntax	match	tptextStatement
	\	skipwhite nextgroup=tptextTerminalName,tptextError
	\	/\<terminal :\s*/

syntax	match	tptextStatement
	\	skipwhite nextgroup=tptextAvmName,tptextError
	\	/\<avm :\s*/

syntax	match	tptextStatement
	\	skipwhite nextgroup=tptextAvmName,tptextError
	\	/\<dest :\s*/

syntax	match	tptextAnalysisStart
	\	contained skipwhite nextgroup=tptextDateAndTime,tptextError
	\	/\<start:\s*/

syntax	match	tptextAnalysisEnd
	\	contained skipwhite nextgroup=tptextDateAndTime,tptextError
	\	/\<end:\s*/

syntax	match	tptextStatement
	\	/^final reply\>/

syntax	match	tptextStatement
	\	/^unsolicited reply\>/

syntax	match	tptextComment
	\	/^end time or end of file or session start found$/

syntax	match	tptextComment
	\	/^any requested unterminated messages now printed$/

syntax	match	tptextComment
	\	/\<audit file processing now starts$/

syntax	match	tptextComment
	\	/\<end of audit file processing$/

syntax	region	tptextComment keepend
	\	contains=tptextRunDate,tptextPageNumber
	\	matchgroup=tptextComment start=/\%^\_.\{-}tptext analysis parameters\>/ end=/^end of command file processing\>/

syntax	region	tptextComment keepend
	\	skipwhite nextgroup=tptextFileName contains=tptextAnalysisStart,tptextAnalysisEnd,tptextRunDate, tptextPageNumber
	\	matchgroup=tptextComment start=/^.\{-}tptext analysis list of message texts/ end=/^\s\+audit file:/ 

syntax	sync	fromstart

if version >= 508 || !exists("did_c_syn_inits")
	if version < 508
		let did_c_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink	tptextIdentifier		Identifier

	HiLink	tptextNumber		Number
	HiLink	tptextHexNumber		Number
	HiLink	tptextOneHour		Number

	HiLink	tptextComment		Comment

	HiLink	tptextConstant		Constant
	HiLink	tptextFileName		Constant
	HiLink	tptextDateAndTime	Constant
	HiLink	tptextDate		Constant
	HiLink	tptextTime		Constant
	HiLink	tptextAvmName		Constant
	HiLink	tptextTerminalName	Constant

	HiLink	tptextStringConst	String

	HiLink	tptextStatement		Statement
	HiLink	tptextAnalysisStart	Statement
	HiLink	tptextAnalysisEnd	Statement
	HiLink	tptextPageNumber	Statement
	HiLink	tptextRunDate		Statement

	HiLink	tptextReservedWords	Function

	HiLink	tptextSpecial		Special
	HiLink	tptextSpecialChar	SpecialChar
	HiLink	tptextStringEsc		Special
	HiLink	tptextStringEsc		Special
	HiLink	tptextTag		Tag
	HiLink	tptextDelimiter		Delimiter
	HiLink	tptextComma		Delimiter
	HiLink	tptextEquals		Delimiter
	HiLink	tptextAmpersand		Delimiter
	HiLink	tptextSpecialComment	SpecialComment
	HiLink	tptextDebug		Debug

	HiLink	tptextUnderlined	Underlined

	HiLink	tptextIgnore		Ignore

	HiLink	tptextError		Error

	HiLink	tptextTodo		Todo

	delcommand HiLink
endif

let b:current_syntax = "tptext"

