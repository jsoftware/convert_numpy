NB. build

writesourcex_jp_ '~Addons/convert/numpy/source';'~Addons/convert/numpy/numpy.ijs'

(freads '~Addons/convert/numpy/source/demo.ijs') fwritenew '~Addons/convert/numpy/demo.ijs'

mkdir_j_ '~addons/convert/numpy'

f=. 3 : 0
('~addons/convert/numpy/',y) fcopynew '~Addons/convert/numpy/',y
)

f 'demo.ijs'
f 'manifest.ijs'
f 'numpy.ijs'
f 'README.md'
