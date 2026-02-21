# Managing expiration of versioned subdirectories

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: September 4, 2022

#### Package

dir.expiry 1.18.0

# 1 Background

Several Bioconductor packages (e.g., *[basilisk](https://bioconductor.org/packages/3.22/basilisk)*, *[rebook](https://bioconductor.org/packages/3.22/rebook)*) use external cache directories to manage its resources.
This typically involves creating a package cache directory in which versioned directories are created:

```
~/.cache/
  basilisk/  # package cache directory
    0.99.0/  # versioned directory
    1.0.1/
    1.1.3/
```

The use of separate versioned caches allows the simultaneous use of multiple R installations with different versions of the same package.
However, it requires some housekeeping to remove stale caches and avoid an large increase in disk usage - especially for packages with frequent version updates.

One might think of using POSIX access time but this is not a reliable indicator of whether a cache is truly being used by the package.
For example, external processes like virus scans, `find -exec grep` and so on can update the last access time without actually using the cache’s contents.
Some filesystem administrators may even turn off access time tracking for performance.

# 2 Setting the access time

*[dir.expiry](https://bioconductor.org/packages/3.22/dir.expiry)* implements its own tracker to monitor the last access time for a particular cache version.
To illustrate, let’s set up a versioned cache directory.

```
cache.path <- tempfile(pattern="expired_demo")
dir.create(cache.path)

version <- package_version("1.0.0")
version.dir <- file.path(cache.path, version)
dir.create(version.dir)
```

The path to this versioned directory should contain the version number as the `basename` and the package cache directory as the `dirname`.
The expectation is that there may be multiple versioned directories nested within a single package’s cache directory.

```
version.dir
```

```
## [1] "/tmp/Rtmplcjmzr/expired_demo15b7a651e5040/1.0.0"
```

Assume that we successfully accessed the versioned directory (for some arbitrary definition of success).
We can then update the last access time by calling the `touchDirectory()` function with the path to the versioned directory:

```
library(dir.expiry)
touchDirectory(version.dir)
```

Doing so creates or updates an `*_dir.expiry` file containing the last access date as an integer.
(This implies that the process creating the cache should not make any of its own files ending with `*_dir.expiry-info`, lest they be confused with *[dir.expiry](https://bioconductor.org/packages/3.22/dir.expiry)*’s files.)
Only directories with Bioconductor-style versions should be present in the package cache directory.

```
list.files(cache.path)
```

```
## [1] "1.0.0"                   "1.0.0_dir.expiry"
## [3] "1.0.0_dir.expiry-00LOCK"
```

```
cat(readLines(file.path(cache.path, "1.0.0_dir.expiry")), sep="\n")
```

```
## ExpiryVersion: 1.18.0
## AccessDate: 20390
```

# 3 Maintaining thread safety

*[dir.expiry](https://bioconductor.org/packages/3.22/dir.expiry)* makes extensive use of file locks (via the *[filelock](https://CRAN.R-project.org/package%3Dfilelock)* package) to avoid deleting caches that might be in use by other R processes.
Developers are strongly advised to lock their directories of interest before doing anything with them, including any calls to `touchDirectory()`.
This should be done using the `lockDirectory()` function:

```
v <- package_version("1.0.0")
v.dir <- file.path(cache.path, v)

lock <- lockDirectory(v.dir)
# on.exit(unlockDirectory(lock)), in a function context.

# Do stuff with the versioned cache 'v.dir' here...
dir.create(v.dir, showWarnings=FALSE)

# Finally, touch the directory on successful completion.
touchDirectory(v.dir)
```

In real functions, `on.exit()` is the preferred approach for releasing the locks created by `lockDirectory()`.
In this vignette, though, we will just call this function manually.

```
unlockDirectory(lock)
```

For read-only applications, developers may wish to set `exclusive=FALSE` in `lockDirectory()`.
This allows multiple processes to read from the versioned cache at the same time, only being blocked when one process needs to perform a write operation.

# 4 Deleting old caches

`unlockDirectory()` will automatically delete all expired versions that it finds in the package cache directory.
By default, this is defined as all directories that were last touched more than 30 days ago.
To illustrate, let’s create another versioned directories and pretend it was created 100 days ago:

```
cache.path <- tempfile(pattern="expired_demo")

old.version <- package_version("0.99.0")
old.version.dir <- file.path(cache.path, old.version)

lck <- lockDirectory(old.version.dir)
dir.create(old.version.dir)
touchDirectory(old.version.dir, date=Sys.Date() - 100)
unlockDirectory(lck, clear=FALSE)

list.files(cache.path)
```

```
## [1] "0.99.0"                   "0.99.0-00LOCK"
## [3] "0.99.0_dir.expiry"        "0.99.0_dir.expiry-00LOCK"
## [5] "central-00LOCK"
```

Locking and unlocking a more recent versioned directory will delete the files associated with the older version.
This includes the versioned directory itself as well as any lock and expiry files.

```
new.version <- package_version("1.0.0")
new.version.dir <- file.path(cache.path, new.version)

lck <- lockDirectory(new.version.dir)
dir.create(new.version.dir)
touchDirectory(new.version.dir)
unlockDirectory(lck)

list.files(cache.path)
```

```
## [1] "1.0.0"                   "1.0.0-00LOCK"
## [3] "1.0.0_dir.expiry"        "1.0.0_dir.expiry-00LOCK"
## [5] "central-00LOCK"
```

However, the converse is not true; locking/unlocking the older version will never delete files associated with a newer version.
This favors retention of caches corresponding to later versions, which is generally a reasonable outcome.

```
new.version2 <- package_version("1.0.1")
new.version.dir2 <- file.path(cache.path, new.version2)

# Newer version but earlier access.
lck2 <- lockDirectory(new.version.dir2)
dir.create(new.version.dir2)
touchDirectory(new.version.dir2, date=Sys.Date() - 100)
unlockDirectory(lck2)

# Re-accessing the older version.
lck <- lockDirectory(new.version.dir)
touchDirectory(new.version.dir)
unlockDirectory(lck)

list.files(cache.path)
```

```
## [1] "1.0.0"                   "1.0.0-00LOCK"
## [3] "1.0.0_dir.expiry"        "1.0.0_dir.expiry-00LOCK"
## [5] "1.0.1"                   "1.0.1-00LOCK"
## [7] "1.0.1_dir.expiry"        "1.0.1_dir.expiry-00LOCK"
## [9] "central-00LOCK"
```

Under the hood, `unlockDirectory()` calls `clearDirectories()` to destroy the expired versioned directories.
Users can tune the expiration threshold by setting the number of days in the `limit=` argument or the `BIOC_DIR_EXPIRY_LIMIT` environment variable.

When deleting old versions, `clearDirectories()` will attempt to acquire an exclusive lock on the corresponding directories.
As long as other processes call `lockDirectory()` before working on them,
we ensure that `clearDirectories()` does not inadvertently delete a versioned directory that another process is simultaneously operating on.

# Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] dir.expiry_1.18.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] filelock_1.0.3      knitr_1.50          htmltools_0.5.8.1
## [10] rmarkdown_2.30      lifecycle_1.0.4     cli_3.6.5
## [13] sass_0.4.10         jquerylib_0.1.4     compiler_4.5.1
## [16] tools_4.5.1         evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
## [22] rlang_1.1.6
```