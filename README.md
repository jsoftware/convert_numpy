## convert_numpy

A J addon for reading npy and npz files.

The npy files should contain a single unnested array. The result of reading an npy file is a J noun.

The npz files are zips of one or more npy files. Data for reading and writing npz files should be a 2 column boxed matrix of names and values.

See the demo.ijs script in the addon.

Numpy docs are at [NPY format](https://numpy.org/doc/stable/reference/generated/numpy.lib.format.html) .

Note: npy files may contain python object arrays, stored as pickles. This is an internal python format that is not well documented for use by external programs. The J addon does not support reading or writing pickles. However, in some cases it should be possible to at least read such data. For example, the object.ijs script in the source was used to read pickles with a mixed matrix of numbers and characters from npy files in the scipy benchmarks suite.