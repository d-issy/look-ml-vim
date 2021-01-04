" Looker 7.20

if exists('b:current_syntax')
  finish
endif

let b:current_syntax = 'lookml'
syntax sync fromstart


" Comment
setlocal commentstring =#\ %s
syntax match lkmlComment /\v#[^\n\r]*$/
hi link lkmlComment Comment

" String
syn region lkmlString contained start=+\v"+ skip=+\v\\.+ end=+\v"+
hi link lkmlString String

" Keyword
syn keyword lkmlKeyword contained dimension dimension_group measure
syn keyword lkmlKeyword contained drill_fields extends extension include test set view access_grant
syn keyword lkmlKeyword contained suggestions required_access_grants sql_table_name
syn keyword lkmlKeyword contained label case_sensitive map_layer named_format
syn keyword lkmlKeyword contained connection datagroup fiscal_month_offset persist_for persist_with week_start_day
hi link lkmlKeyword Keyword

" Constant
syn match lkmlNumeric contained /\v[0-9]+/
hi link lkmlNumeric Number

syn keyword lkmlBool contained yes no
hi link lkmlBool Boolean

syn keyword lkmlRequired contained required
hi link lkmlRequired Constant

syn keyword lkmlWeek contained monday tuesday wednesday thursday friday saturday sunday
hi link lkmlWeek Constant

" Common Parameters
syn match   lkmlLabel contained +label:+ contains=lkmlKeyword nextgroup=lkmlString skipwhite

" {{{ View
syn keyword lkmlViewIdent view              skipwhite nextgroup=lkmlViewSep
syn match   lkmlViewSep   contained +:+     skipwhite nextgroup=lkmlViewName
syn match   lkmlViewName  contained /\v\w+/ skipwhite nextgroup=lkmlViewParen
syn region  lkmlViewParen contained start=+{+ skip=+\v\{[^{]*\}+ end=+}+ contains=@lkmlViewParams

syn match   lkmlViewParam  +\v(suggestions):+ contains=lkmlKeyword nextgroup=lkmlBool skipwhite
syn match   lkmlViewParam  +\v(extension):+   contains=lkmlKeyword nextgroup=lkmlRequired skipwhite

syn cluster lkmlViewParams contains=lkmlComment,lkmlLabel,lkmlViewParam,lkmlDimension,lkmlDimensionGroup,lkmlMeasure

hi link lkmlViewIdent Keyword
" }}}

" {{{ - Dimension
syn match lkmlDimension +\v(dimension:)+ contains=lkmlKeyword
" }}}

" {{{ - Dimension Group
syn match lkmlDimensionGroup +\v(dimension_group:)+ contains=lkmlKeyword
" }}}
"
" {{{ - measure
syn match lkmlMeasure +\v(measure:)+ contains=lkmlKeyword
" }}}

" Explore {{{
syn keyword lkmlExploreIdent explore           skipwhite nextgroup=lkmlExploreSep
syn match   lkmlExploreSep   contained +:+     skipwhite nextgroup=lkmlExploreName
syn match   lkmlExploreName  contained /\v\w+/ skipwhite nextgroup=lkmlExploreParen
syn region  lkmlExploreParen contained start=+{+ end=+}+ contains=@lkmlExploreParams

syn cluster lkmlExploreParams contains=lkmlComment,lkmlLabel
hi link lkmlExploreIdent Keyword
" }}}

" Model {{{
syn match lkmlModelParams +\v(label|connection|include|persist_for):+ contains=lkmlKeyword nextgroup=lkmlString skipwhite
syn match lkmlModelParams +fiscal_month_offset:+ contains=lkmlKeyword nextgroup=lkmlNumeric skipwhite
syn match lkmlModelParams +case_sensitive:+ contains=lkmlKeyword nextgroup=lkmlBool   skipwhite
syn match lkmlModelParams +week_start_day:+ contains=lkmlKeyword nextgroup=lkmlWeek   skipwhite
syn match lkmlModelParams +persist_with:+ contains=lkmlKeyword skipwhite
" }}}
