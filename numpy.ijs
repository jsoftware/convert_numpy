cocurrent 'pnumpy'
fromdbl8=: 4 : '_2 (3!:5) 8 reverse^:x y'
fromint4=: 4 : '_2 (3!:4) 4 reverse^:x y'
fromint8=: 4 : '_3 (3!:4) 8 reverse^:x y'
reverse=: 4 : ', |."1 (-x) [\ y'
readnpy=: 3 : 0
dat=. fread y
if. _1 -: dat do. 'not found: ',y return. end.
if. 64 > #dat do. 'not a numpy file: ',y return. end.
if. -. ((147{a.),'NUMPY') -: 6{.dat do. 'not a numpy file: ',y return. end.
ver=. 0 ". ,',p<.>' 8!:2 a.i.6 7 { dat
if. 2 <: ver do. 'version not supported: ',": ver return. end.
len=. 256 #. a.i.9 8 { dat
fmt=. len {. 10 }. dat
ndx=. 1 i.~ 'descr' E. fmt
descr=. ' :''' -.~ ',' taketo (ndx+6) }. fmt
bigendian=. '>' = {.descr
type=. }.descr
ndx=. 1 i.~ 'fortran_order' E. fmt
fortran=. 'true' -: tolower ' :''' -.~ ',' taketo (ndx+14) }. fmt
ndx=. 1 i.~ 'shape' E. fmt
t=. ':(L' -.~ ')' taketo (ndx+6) }. fmt
shape=. ". t rplc ', '
dat=. (len + 10) }. dat
select. type
case. 'b1' do. num=. a.i.dat
case. 'i4' do. num=. bigendian fromint4 dat
case. 'i8' do. num=. bigendian fromint8 dat
case. 'f8' do. num=. bigendian fromdbl8 dat
case. do. 'type not supported: ',type return.
end.
shape $ |:^:fortran num
)
readnpz=: 3 : 0
t=. jpath '~temp/npz'
mkdir_j_ t
ferase 1 dir t
unzip y;t
d=. {."1 [ 2 dir t
d=. d #~ (<'.npy') = _4 {.each d
if. 0=#d do. i.0 0 return. end.
n=. _4 }. each d
p=. (t,'/')&, each d
r=. n,.readnpy_pnumpy_ each p
ferase 1 dir t
ferase t
r
)
todbl8=: 3 : '2 (3!:5) y'
toint8=: 3 : '3 (3!:4) y'
writenpy=: 3 : 0
'file dat'=. y
if. -. '.' e. file do. file=. file,'.npy' end.
type=. 3!:0 dat
if. -. type e. 1 4 8 do. 'type not supported: ',":type return. end.
shape=. $dat
dat=. ,dat
len=. 118
r=. (147{a.),'NUMPY'
r=. r,(1 0,len,0){a.
ftype=. (1 4 8 i. type) pick '|b1';'<i8';'<f8'
fshape=. writeshape shape
fmt=. '{"descr": "',ftype,'", "fortran_order": False, "shape": (',fshape,'), }'
fmt=. '''' (I.fmt='"')} fmt
r=. r, ((len-1) {. fmt), LF
select. type
case. 1 do. r=. r,dat { a.
case. 4 do. r=. r,toint8 dat
case. 8 do. r=. r,todbl8 dat
end.
r fwrite file
)
writenpz=: 3 : 0
'file dat'=. y
b=. -. (1 = L. dat) *. (2 = #$dat) *. 2 = {:$dat
if. b do. 'data should be a boxed matrix of names and values' return. end.
t=. jpath '~temp/npz'
mkdir_j_ t
ferase 1 dir t
for_r. dat do.
  'name val'=. r
  writenpy (t,'/',name,'.npy');val
end.
zip file;t
ferase 1 dir t
ferase t
)
writeshape=: 3 : 0
if. 0=#y do. '' return. end.
if. 1=#y do. (":y),',' return. end.
2 }. ; ', '&, each ": each y
)
shellcmd=: 3 : 0
if. IFUNIX do.
  hostcmd_j_ y
else.
  spawn_jtask_ y
end.
)
unzip=: 3 : 0
'file dir'=. dquote each jpath each y
e=. 'Unexpected unzip error'
if. IFUNIX do.
  e=. shellcmd 'unzip ',file,' -d ',dir
else.
  unzip=. '"','"',~jpath '~tools/zip/unzip.exe'
  dir=. (_2&}. , '/' -.~ _2&{.) dir
  e=. shellcmd unzip,' ',file,' -d ',dir
end.
e
)
zip=: 3 : 0
'target dir'=. dquote each jpath each y
e=. 'Unexpected unzip error'
if. IFUNIX do.
  e=. shellcmd 'cd ',dir,'; zip -D ',target,' *.npy'
else.
  zip=. '"','"',~jpath '~tools/zip/zip.exe'
  dir=. (_2&}. , '/' -.~ _2&{.) dir
  e=. shell_jtask_ 'cd ',dir,' && ',zip,' ',,target,' *.npy'
end.
e
)

cocurrent 'base'
