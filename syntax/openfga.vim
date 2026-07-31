" Vim syntax file for OpenFGA DSL.
" SPDX-License-Identifier: Apache-2.0
" SPDX-FileCopyrightText: Copyright OpenFGA Authors.
"
" Adapted from the OpenFGA VS Code extension's TextMate grammar:
" https://github.com/openfga/vscode-ext
" Copyright OpenFGA Authors.
" Modified for Vim syntax and distributed under the Apache License, Version 2.0.
" See the repository's NOTICE and LICENSE files.

if exists('b:current_syntax')
  finish
endif

syn case match

" comment.openfga
syn match openfgaComment /^\s*#.*$/
syn match openfgaComment /\s\+#.*$/

" keyword.*.openfga
syn keyword openfgaKeyword as from model relations schema self and or with
syn match openfgaKeywordExclusion /\<but\>\s\+\<not\>/
syn keyword openfgaKeyword condition
syn keyword openfgaKeywordModule module
syn keyword openfgaKeywordType type
syn keyword openfgaKeywordExtend extend
syn keyword openfgaKeywordDefine define

" support.class.type.name.value.openfga
syn match openfgaTypeName /\<\%(extend\s\+\)\?type\s\+\zs[a-zA-Z0-9_-]\+/ containedin=ALLBUT,openfgaComment

" support.class.module.name.value.openfga
syn match openfgaModuleName /\<module\s\+\zs[a-zA-Z0-9_-]\+/ containedin=ALLBUT,openfgaComment

" support.class.entity.name.function.condition.openfga
syn match openfgaConditionName /\<condition\s\+\zs[_a-zA-Z][_a-zA-Z0-9]*/ containedin=ALLBUT,openfgaComment

" entity.name.function.variable.parameter.name.condition.openfga
syn match openfgaConditionParameter /\<[_a-zA-Z][_a-zA-Z0-9]*\>\s*:/ containedin=ALLBUT,openfgaComment
syn match openfgaConditionParameterType /:\s*\zs[_a-zA-Z][_a-zA-Z0-9]*/ containedin=ALLBUT,openfgaComment

" entity.name.function.member.relation.name.openfga
syn match openfgaDefineName /\<define\>\s\+\zs[a-zA-Z0-9_-]\+/ containedin=ALLBUT,openfgaComment

" colon.define.delimiter.openfga
syn match openfgaColon /:/ containedin=ALLBUT,openfgaComment

" type-restrictions.bracket.delimiter.openfga
syn match openfgaBracket /[\[\]]/ containedin=ALLBUT,openfgaComment

" variable.parameter.type-restrictions.openfga and
" support.class.type.reference.value.openfga
syn match openfgaTypeRestriction /\<[a-zA-Z0-9_-]\+\%(:\%(:\?[a-zA-Z0-9_* -]\+\)\?\)\?/ containedin=ALLBUT,openfgaComment
syn match openfgaTypeRestrictionModifier /\<with\>\s\+[a-zA-Z0-9_-]*/ containedin=ALLBUT,openfgaComment

" variable.parameter.computed.relation.value.openfga
syn match openfgaRelationReference /\<\%(define\s\+\)\@<![a-zA-Z_][a-zA-Z0-9_-]*\>/ containedin=ALLBUT,openfgaComment

" Keep comments visually dominant over the broad identifier matches above.
hi def link openfgaComment Comment
hi def link openfgaKeyword Keyword
hi def link openfgaKeywordExclusion Keyword
hi def link openfgaKeywordModule Keyword
hi def link openfgaKeywordType Keyword
hi def link openfgaKeywordExtend Keyword
hi def link openfgaKeywordDefine Keyword
hi def link openfgaTypeName Type
hi def link openfgaModuleName Type
hi def link openfgaConditionName Function
hi def link openfgaConditionParameter Identifier
hi def link openfgaConditionParameterType Type
hi def link openfgaDefineName Function
hi def link openfgaColon Delimiter
hi def link openfgaBracket Delimiter
hi def link openfgaTypeRestriction Type
hi def link openfgaTypeRestrictionModifier Keyword
hi def link openfgaRelationReference Identifier

let b:current_syntax = 'openfga'
