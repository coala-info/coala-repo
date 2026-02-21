# Interacting with the gypsum REST API

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: April 2, 2024

#### Package

gypsum 1.6.0

# Contents

* [1 Introduction](#introduction)
* [2 Reading files](#reading-files)
* [3 Uploading files](#uploading-files)
  + [3.1 Basic usage](#basic-usage)
  + [3.2 Link generation](#link-generation)
* [4 Changing permissions](#changing-permissions)
* [5 Probational uploads](#probational-uploads)
* [6 Inspecting the quota](#inspecting-the-quota)
* [7 Validating metadata](#validating-metadata)
* [8 Administration](#administration)
* [Session information](#session-information)

# 1 Introduction

The *[gypsum](https://bioconductor.org/packages/3.22/gypsum)* package implements an R client for the [API of the same name](https://gypsum-test.aaron-lun.workers.dev).
This allows Bioconductor packages to easily store and retrieve data from the **gypsum** backend.
It also provides mechanisms to allow package maintainers to easily manage upload authorizations and third-party contributions.
Readers are referred to [API’s documentation](https://github.com/ArtifactDB/gypsum-worker) for a description of the concepts;
this guide will strictly focus on the usage of the *[gypsum](https://bioconductor.org/packages/3.22/gypsum)* package.

# 2 Reading files

*[gypsum](https://bioconductor.org/packages/3.22/gypsum)* provides several convenience methods for reading from the **gypsum** bucket:

```
library(gypsum)
listAssets("test-R")
```

```
## [1] "basic"      "upload-dir"
```

```
listVersions("test-R", "basic")
```

```
## [1] "v1" "v2" "v3"
```

```
listFiles("test-R", "basic", "v1")
```

```
## [1] "..manifest"  "..summary"   "blah.txt"    "foo/bar.txt"
```

```
out <- saveFile("test-R", "basic", "v1", "blah.txt")
readLines(out)
```

```
##  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S"
## [20] "T" "U" "V" "W" "X" "Y" "Z"
```

```
dir <- saveVersion("test-R", "basic", "v1")
list.files(dir, all.files=TRUE, recursive=TRUE)
```

```
## [1] "..manifest"  "..summary"   "blah.txt"    "foo/bar.txt"
```

We can fetch the summaries and manifests for each version of a project’s assets.

```
fetchManifest("test-R", "basic", "v1")
```

```
## $blah.txt
## $blah.txt$size
## [1] 52
##
## $blah.txt$md5sum
## [1] "0eb827652a5c272e1c82002f1c972018"
##
##
## $`foo/bar.txt`
## $`foo/bar.txt`$size
## [1] 21
##
## $`foo/bar.txt`$md5sum
## [1] "c34bcea9f2263deb3379103c9f10c130"
```

```
fetchSummary("test-R", "basic", "v1")
```

```
## $upload_user_id
## [1] "LTLA"
##
## $upload_start
## [1] "2024-02-23 02:17:24 EST"
##
## $upload_finish
## [1] "2024-02-23 02:17:26 EST"
```

We can get the latest version of an asset:

```
fetchLatest("test-R", "basic")
```

```
## [1] "v3"
```

All read operations involve a publicly accessible bucket so no authentication is required.

# 3 Uploading files

## 3.1 Basic usage

To demonstrate, let’s say we have a directory of files that we wish to upload to the backend.

```
tmp <- tempfile()
dir.create(tmp)
write(file=file.path(tmp, "foo"), letters)
write(file=file.path(tmp, "bar"), LETTERS)
write(file=file.path(tmp, "whee"), 1:10)
```

We run the upload sequence of `startUpload()`, `uploadFiles()` and `completeUpload()`.
This requires authentication via GitHub, which is usually prompted but can also be set beforehand via `setAccessToken()` (e.g., for batch jobs).

```
init <- startUpload(
    project=project_name,
    asset=asset_name,
    version=version_name,
    files=list.files(tmp, recursive=TRUE),
    directory=tmp
)

tryCatch({
    uploadFiles(init, directory=tmp)
    completeUpload(init)
}, error=function(e) {
    abortUpload(init) # clean up if the upload fails.
    stop(e)
})
```

We can also set `concurrent=` to parallelize the uploads in `uploadFiles()`.

## 3.2 Link generation

More advanced developers can use `links=` in `startUpload()` to improve efficiency by deduplicating redundant files on the **gypsum** backend.
For example, if we wanted to link to some files in our `test-R` project, we might do:

```
# Creates links from lun/aaron.txt ==> test-R/basic/v1/foo/bar.txt
# and kancherla/jayaram ==> test-R/basic/v1/blah.txt
init <- startUpload(
    project=project_name,
    asset=asset_name,
    version=version_name,
    files=character(0),
    links=data.frame(
        from.path=c("lun/aaron.txt", "kancherla/jayaram.txt"),
        to.project=c("test-R", "test-R"),
        to.asset=c("basic", "basic"),
        to.version=c("v1", "v1"),
        to.path=c("foo/bar.txt", "blah.txt")
    ),
    directory=tmp
)
```

This functionality is particularly useful when creating new versions of existing assets.
Only the modified files need to be uploaded, while the rest of the files can be linked to their counterparts in the previous version.
In fact, this pattern is so common that it can be expedited via `cloneVersion()` and `prepareDirectoryUpload()`:

```
dest <- tempfile()
cloneVersion("test-R", "basic", "v1", destination=dest)

# Do some modifications in 'dest' to create a new version, e.g., add a file.
# However, users should treat symlinks as read-only - so if you want to modify
# a file, instead delete the symlink and replace it with a new file.
write(file=file.path(dest, "BFFs"), c("Aaron", "Jayaram"))

to.upload <- prepareDirectoryUpload(dest)
to.upload
```

```
## $files
## [1] "BFFs"
##
## $links
##     from.path to.project to.asset to.version     to.path
## 1    blah.txt     test-R    basic         v1    blah.txt
## 2 foo/bar.txt     test-R    basic         v1 foo/bar.txt
```

Then we can just pass these values along to `startUpload()` to take advantage of the upload links:

```
init <- startUpload(
    project=project_name,
    asset=asset_name,
    version=version_name,
    files=to.upload$files,
    links=to.upload$links,
    directory=dest
)
```

# 4 Changing permissions

Upload authorization is determined by each project’s permissions, which are controlled by project owners.
Both uploaders and owners are identified based on their GitHub logins:

```
fetchPermissions("test-R")
```

```
## $owners
## $owners[[1]]
## [1] "LTLA"
##
##
## $uploaders
## $uploaders[[1]]
## $uploaders[[1]]$id
## [1] "ArtifactDB-bot"
```

Owners can add more uploaders (or owners) via the `setPermissions()` function.
Uploaders can be scoped to individual assets or versions, and an expiry date may be attached to each authorization:

```
setPermissions("test-R",
    uploaders=list(
        list(
            id="jkanche",
            until=Sys.time() + 24 * 60 * 60,
            asset="jays-happy-fun-time",
            version="1"
        )
    )
)
```

Organizations may also be added in the permissions, in which case the authorization extends to all members of that organization.

# 5 Probational uploads

Unless specified otherwise, all uploaders are considered to be “untrusted”.
Any uploads from such untrusted users are considered “probational” and must be approved by the project owners before they are considered complete.
Alternatively, an owner may reject an upload, which deletes all the uploaded files from the backend.

```
approveProbation("test-R", "third-party-upload", "good")
rejectProbation("test-R", "third-party-upload", "bad")
```

An uploader can be trusted by setting `trusted=TRUE` in `setPermissions()`.
Owners and trusted uploaders may still perform probational uploads (e.g., for testing) by setting `probation=TRUE` in `startUpload()`.

# 6 Inspecting the quota

Each project has a quota that specifies how much storage space is available for uploaders.
The quota is computed as a linear function of `baseline + growth_rate * (NOW - year)`,
which provides some baseline storage that grows over time.

```
fetchQuota("test-R")
```

```
## $baseline
## [1] 1e+10
##
## $growth_rate
## [1] 2e+10
##
## $year
## [1] 2024
```

Once the project’s contents exceed this quota, all uploads are blocked.
The current usage of the project can be easily inspected:

```
fetchUsage("test-R")
```

```
## [1] 146
```

Changes to the quota must be performed by administrators, see [below](#administration).

# 7 Validating metadata

Databases can operate downstream of the **gypsum** backend to create performant search indices, usually based on special metadata files.
*[gypsum](https://bioconductor.org/packages/3.22/gypsum)* provides some utilities to check that metadata follows the JSON schema of some known downstream databases.

```
schema <- fetchMetadataSchema()
cat(head(readLines(schema)), sep="\n")
```

```
## {
##     "$schema": "http://json-schema.org/draft-07/schema",
##     "$id": "bioconductor.json",
##     "type": "object",
##     "title": "Bioconductor metadata standards",
##     "properties": {
```

Uploaders can verify that their metadata respects this schema via the `validateMetadata()` function.
This ensures that the uploaded files can be successfully indexed by the database, given that the **gypsum** backend itself applies no such checks.

```
metadata <- list(
    title="Fatherhood",
    description="Luke ich bin dein Vater.",
    sources=list(
       list(provider="GEO", id="GSE12345")
    ),
    taxonomy_id=list("9606"),
    genome=list("GRCm38"),
    maintainer_name="Darth Vader",
    maintainer_email="vader@empire.gov",
    bioconductor_version="3.10"
)

validateMetadata(metadata, schema)
```

# 8 Administration

Administrators of the **gypsum** instance can create projects with new permissions:

```
createProject("my-new-project",
    owners="jkanche",
    uploaders=list(
        list(
            id="LTLA",
            asset="aarons-stuff"
        )
    )
)
```

They can alter the quota parameters for a project:

```
setQuota("my-new-project",
    baseline=10 * 2^30,
    growth=5 * 2^30,
    year=2019
)
```

They can manually refresh the latest version for an asset and the quota usage for a project.
This is only required on very rare occasions where there are simultaneous uploads to the same project.

```
refreshLatest("test-R", "basic")
refreshUsage("test-R")
```

Administrators may also delete projects, assets or versions, though this should be done sparingly as it violates **gypsum**’s expectations of immutability.

```
removeProject("my-new_project")
```

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
## [1] gypsum_1.6.0     BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           jsonlite_2.0.0      glue_1.8.0
##  [7] V8_8.0.1            htmltools_0.5.8.1   sass_0.4.10
## [10] rmarkdown_2.30      rappdirs_0.3.3      evaluate_1.0.5
## [13] jquerylib_0.1.4     filelock_1.0.3      fastmap_1.2.0
## [16] yaml_2.3.10         lifecycle_1.0.4     httr2_1.2.1
## [19] bookdown_0.45       jsonvalidate_1.5.0  BiocManager_1.30.26
## [22] compiler_4.5.1      Rcpp_1.1.0          digest_0.6.37
## [25] R6_2.6.1            curl_7.0.0          parallel_4.5.1
## [28] magrittr_2.0.4      bslib_0.9.0         tools_4.5.1
## [31] cachem_1.1.0
```