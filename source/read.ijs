NB. read numpy files

NB. =========================================================
fromdbl8=: 4 : '_2 (3!:5) 8 reverse^:x y'
fromint4=: 4 : '_2 (3!:4) 4 reverse^:x y'
fromint8=: 4 : '_3 (3!:4) 8 reverse^:x y'
reverse=: 4 : ', |."1 (-x) [\ y'

NB. =========================================================
NB. read npy file with non-nested array
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
NB. unused object format
NB. case. ,'O' do. if. ischar num=. fromobject dat do. num return. end.
case. do. 'type not supported: ',type return.
end.
shape $ |:^:fortran num
)

NB. =========================================================
NB. read npz file = zip of npy files
NB. returns names ,. values
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
