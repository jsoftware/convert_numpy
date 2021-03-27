NB. object

NB. =========================================================
NB. this only handles a netlib object with mixed matrices defined in protocol 2
NB. as used in scipy for the netlib lp benchmarks
fromobject=: 3 : 0
dat=. y
if. -. 128 2 -: a.i.2{.dat do. 'unsupported protocol: ',a.i.1{dat return. end.
fail=. 'unsupported object'
if. -. 'numpy.core.multiarray' -: 3 }. LF taketo dat do. fail return. end.
dat=. LF takeafter dat
if. -. '_reconstruct' -: LF taketo dat do. fail return. end.
dat=. LF takeafter dat
if. -. 'numpy' -: 3 }. LF taketo dat do. fail return. end.
dat=. LF takeafter dat
if. -. 'ndarray' -: LF taketo dat do. fail return. end.
dat=. LF takeafter dat
ndx=. 81
dat=. ndx }. dat
res=. fromobject1 dat
)

NB. =========================================================
fromobject1=: 3 : 0
r=. ''
dat=. y
while. #dat do.
  op=. {.dat
  dat=. }.dat
  select. op
  case. 'G' do.
    r=. r,<_2 (3!:5)|.8{.dat
    dat=. 8 }. dat
  case. 'K' do.
    r=. r,<a.i.{.dat
    dat=. }.dat
  case. 'N' do.
    r=. r,<'None'
  case. 'e' do. break.
  case. do.
    echo 'unknown: ',op, ' ',":a.i.op
    echo r
    return.
  end.
end.
r
)