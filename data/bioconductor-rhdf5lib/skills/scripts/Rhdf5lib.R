# Code example from 'Rhdf5lib' vignette. See references/ for full tutorial.

## ----headers------------------------------------------------------------------
system.file(package="Rhdf5lib", "include")

## ----zlib-path, eval = FALSE--------------------------------------------------
# BiocManager::install('Rhdf5lib', configure.args = "--with-zlib='/path/to/zlib/'")

## ----disable-lto, eval = FALSE------------------------------------------------
# BiocManager::install('Rhdf5lib', INSTALL_opts="--no-use-LTO", configure.args = "--disable-lto")

## ----disable-rpath, eval = FALSE----------------------------------------------
# BiocManager::install('Rhdf5lib', configure.args = "--disable-sharedlib-rath")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

