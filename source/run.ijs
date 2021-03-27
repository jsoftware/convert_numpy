NB. run

load '~Addons/convert/numpy/source/build.ijs'
load '~Addons/convert/numpy/numpy.ijs'

writenpy_pnumpy_ '~temp/w1.npy';i.3 4
readnpy_pnumpy_ '~temp/w1.npy'
