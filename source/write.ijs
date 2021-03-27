NB. write

NB. =========================================================
todbl8=: 3 : '2 (3!:5) y'
toint8=: 3 : '3 (3!:4) y'

NB. =========================================================
NB. write npy file with non-nested array
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

NB. =========================================================
NB. write npz file = zip of npy files
NB. argument should be a 2 column boxed matrix of names and values
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

NB. =========================================================
writeshape=: 3 : 0
if. 0=#y do. '' return. end.
if. 1=#y do. (":y),',' return. end.
2 }. ; ', '&, each ": each y
)
