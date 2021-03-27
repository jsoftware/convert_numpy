NB. zip

NB. =========================================================
shellcmd=: 3 : 0
if. IFUNIX do.
  hostcmd_j_ y
else.
  spawn_jtask_ y
end.
)

NB. =========================================================
NB. unzip file into given subdirectory
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

NB. =========================================================
NB. zip npy files in directory to npz file
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
