syntax keyword fgaDeclaration type
" syntax keyword fgaModel       model schema
" syntax keyword fgaRelations   relations
syntax keyword fgaDefine      define
" syntax keyword fgaOperator    and or from
"
" " " - + % < > ! & | ^ * =
syntax    match   fgaOperator    /[-+%<>!&|^*=]=\?/
" syntax    match   fgaFunction    /\w\+\s*(/
syntax    keyword fgaConditional condition
" syntax    keyword fgaType        timestamp duration

syntax match fgaFuncName /\w\+\ze(/
syntax match fgaParamName /\w\+\ze\s*:/
syntax match fgaParamType /:\s*\zs\w\+/
highlight def link fgaFuncName Function

highlight def link fgaDeclaration Keyword
highlight def link fgaModel       Keyword
highlight def link fgaRelations   Keyword
highlight def link fgaDefine      Keyword
highlight def link fgaComment     Comment
highlight def link fgaOperator    Operator
highlight def link fgaConditional Conditional
highlight def link fgaParamName Identifier
highlight def link fgaParamType Type

" コメント
syntax match openfgaComment /^\s*#.*$/ containedin=ALL
syntax match openfgaComment /\s\+#.*$/ containedin=ALL
highlight link openfgaComment Comment

" キーワード
syntax keyword openfgaKeywordAs as
syntax keyword openfgaKeywordFrom from
syntax keyword openfgaKeywordModel model
syntax keyword openfgaKeywordRelations relations
syntax keyword openfgaKeywordSchema schema
syntax keyword openfgaKeywordSelf self
syntax keyword openfgaKeywordAnd and
syntax keyword openfgaKeywordOr or
" 特殊キーワード: but not (複数単語なのでmatchで対応)
syntax match openfgaKeywordExclusion /\v\bbut\s+not\b/
highlight link openfgaKeywordAs Keyword
highlight link openfgaKeywordFrom Keyword
highlight link openfgaKeywordModel Keyword
highlight link openfgaKeywordRelations Keyword
highlight link openfgaKeywordSchema Keyword
highlight link openfgaKeywordSelf Keyword
highlight link openfgaKeywordAnd Keyword
highlight link openfgaKeywordOr Keyword
highlight link openfgaKeywordExclusion Keyword

" identifiers: (extend)? type <name>
" extendはオプション、type必須、名前は単語文字
syntax match openfgaKeywordExtend /\v^(\s*)extend\s+/ contained
syntax match openfgaKeywordType /\v\stype\s+/ contained
syntax match openfgaTypeName /\v[a-zA-Z0-9-_]+/ contained

" まとめてグループ化
syntax region openfgaTypeBlock start=/\v^(extend\s+)?type\s+/ end=/\v$/ contains=openfgaKeywordExtend,openfgaKeywordType,openfgaTypeName

highlight link openfgaKeywordExtend Keyword
highlight link openfgaKeywordType Keyword
highlight link openfgaTypeName Type

" module
syntax match openfgaKeywordModule /\bmodule\b/
syntax match openfgaModuleName /\v\bmodule\s+([a-zA-Z0-9-_]+)\b/ contained
highlight link openfgaKeywordModule Keyword
highlight link openfgaModuleName Type

" define 文
" define <name> : <value...>
syntax match openfgaKeywordDefine /\bdefine\b/
syntax match openfgaDefineName /\v\bdefine\s+([a-zA-Z0-9-_]+)/
syntax match openfgaColon /:/
highlight link openfgaKeywordDefine Keyword
highlight link openfgaDefineName Function
highlight link openfgaColon Delimiter

" condition
" condition <name>(params)
syntax match openfgaKeywordCondition /\bcondition\b/
syntax match openfgaConditionName /\v\bcondition\s+([_a-zA-Z][_a-zA-Z0-9]+)/
" paramsは複雑なのでここでは簡易的に括弧内をstringとして扱う
syntax region openfgaConditionParams start=/(\zs/ end=/\ze)/ contained
highlight link openfgaKeywordCondition Keyword
highlight link openfgaConditionName Function
highlight link openfgaConditionParams Identifier

" relationの角括弧
syntax match openfgaBracketOpen /\[/
syntax match openfgaBracketClose /\]/
highlight link openfgaBracketOpen Delimiter
highlight link openfgaBracketClose Delimiter
