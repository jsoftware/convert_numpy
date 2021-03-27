NB. demo

load 'convert/numpy'

D=. jpath '~temp/'

ferase D,'/wdata.npz'

wint=. i.3 4
wbool=. 0 = 3 | wint
wfloat=. 1.1 * p: i.2 5

writenpy_pnumpy_ (D,'wbool.npy');wbool
writenpy_pnumpy_ (D,'wfloat.npy');wfloat
writenpy_pnumpy_ (D,'wint.npy');wint

wbool -: readnpy_pnumpy_ D,'wbool.npy'
wfloat -: readnpy_pnumpy_ D,'wfloat.npy'
wint -: readnpy_pnumpy_ D,'wint.npy'

nms=. ;: 'wbool wfloat wint'
dat=. nms,.".each nms

writenpz_pnumpy_ (D,'wdata.npz');<dat

dat -: readnpz_pnumpy_ D,'wdata.npz'
