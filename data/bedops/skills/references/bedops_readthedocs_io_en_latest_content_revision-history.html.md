# [BEDOPS v2.4.41](../index.html%20)

* ←
  [2. Installation](installation.html "Previous document")
* [4. Usage examples](usage-examples.html "Next document")
  →

* [Home](../index.html)

# 3. Revision history[¶](#revision-history "Permalink to this headline")

This page summarizes some of the more important changes between releases.

## 3.1. Current version[¶](#current-version "Permalink to this headline")

### 3.1.1. v2.4.41[¶](#v2-4-41 "Permalink to this headline")

Released: **July 13, 2022**

* [bedmap](reference/statistics/bedmap.html#bedmap)
  + Patched [issue 267](https://github.com/bedops/bedops/issues/267) to remove unneeded `const` property from member functions, where it caused compilation problems with newer versions of Clang toolkit. Thanks to John Marshall and Shane Neph for feedback.
* [closest-features](reference/set-operations/closest-features.html#closest-features)
  + Added `--no-query` option to suppress printing “left” or “right” (or both) query regions to output. When combined with `--no-refs` the output will report raw distance values.
* [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed)
  + Patched `gtf2bed` and `gtf2starch` wrapper scripts to support `--attribute-key=foo` option, which previously only worked with `convert2bed --input=gtf --attribute-key=foo`.
  + Addressed [issue 255](https://github.com/bedops/bedops/issues/255) by printing a warning to standard error, which suggests using `--max-mem` and `--sort-tmpdir`, or `--do-not-sort`, to manage post-conversion sort order for inputs larger than half of system memory.
  + Addressed [issue 239](https://github.com/bedops/bedops/issues/239) by printing a warning to standard error, which suggests using `--multisplit=...` if Wiggle input contains multiple sections.
  + Modified CIGAR string output of `bam2*` and `sam2*` conversion when used with the `--split` option, addressing [issue 268](https://github.com/bedops/bedops/issues/268). Thanks to Lalit Mudgal for the bug report.
* [sort-bed](reference/file-management/sorting/sort-bed.html#sort-bed)
  + Resolved [issue 265](https://github.com/bedops/bedops/issues/265) leading to overflow and early failure in sorting inputs with more than `MAX_INT` per-chromosome lines.
* General
  + Updated Ubuntu `main.yaml` test run on to `ubuntu-latest` image. Thanks to John Marshall for the advice.
  + Modified `symlink_*` targets in `Makefile` to cull `xargs` warnings on Linux hosts. Thanks to Shane Neph for the report and fix.
  + Removed C++11-deprecated calls to `binary_function<>` from utility library. Thanks to Shane Neph for the report and fix.
  + Modified `switch-BEDOPS-binary-type` helper script to cull useless error messages.

## 3.2. Previous versions[¶](#previous-versions "Permalink to this headline")

### 3.2.1. v2.4.40[¶](#v2-4-40 "Permalink to this headline")

Released: **July 21, 2021**

* General
  + Migrated from Travis CI to Github Actions for CI testing. Refer to [main.yml](https://github.com/bedops/bedops/actions/workflows/main.yml) for build logs.
  + Modified Linux and Darwin makefiles to allow user-specified build flags (CXXFLAGS and CFLAGS) in conjunction with our preset values. Resolves [issue 242](https://github.com/bedops/bedops/issues/242) for OS X and Linux targets.
* [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed)
  + Resolved [issue 253](https://github.com/bedops/bedops/issues/253) preventing conversion of Wiggle-formatted data that use non-UCSC chromosome naming scheme.
  + Modified wig2bed start and end shift arithmetic to ensure conversion from 1-based, fully-closed indexing to 0-based, half-open indexing.
  + Added wig2bed integration tests. See tests/conversion/Makefile and wig2bed\_\* targets for more detail.
  + In resolution of [issue 244](https://github.com/bedops/bedops/issues/244) the `gtf2bed` and `gff2bed` conversion scripts now support copying a subset of reserved attributes to the ID field by keyname. By default, `gtf2bed` and `gff2bed` will parse the attributes string and copy the `gene_id` value to the output ID field (i.e., fourth column). The `--attribute-key` option can be used to copy over `gene_name`, `transcript_name`, and several other attributes. See `gtf2bed --help`, `gff2bed --help`, or the online documentation for more information.
  + Documentation updates for `gtf2bed` and `gff2bed`.
  + Sample input updated for `gtf2bed` and `gff2bed` online documentation to resolve [issue 240](https://github.com/bedops/bedops/issues/240).
  + Conversion of GTF to BED would fail with an error where one of either the `gene_id` or `transcript_id` attribute is missing, such as in Ensembl-sourced GTF. This behavior has been changed to a warning.
  + Application parameters that require strings are checked for `NULL` string values, returning with an error when a required parameter is missing. Resolves [issue 256](https://github.com/bedops/bedops/issues/256) and more generally for other options.
* [starch](reference/file-management/compression/starch.html#starch)
  + Patched metadata generation function to resolve [issue 248](https://github.com/bedops/bedops/issues/248), where the chromosome name would previously be truncated on a period character when creating a Starch archive.
* [bedmap](reference/statistics/bedmap.html#bedmap)
  + Patched C++11-deprecated calls to `std::mem_fun` and `std::bind2nd` in `MultiVisitor.hpp` and `MedianAbsoluteDeviationVisitor.hpp` visitors to reduce compile-time warnings and improve C++11 compatibility.

### 3.2.2. v2.4.39[¶](#v2-4-39 "Permalink to this headline")

Released: **April 6, 2020**

* [sort-bed](reference/file-management/sorting/sort-bed.html#sort-bed)
  + Patched `--unique` to report output identical to `sort -u`, in order to resolve [Issue 236](https://github.com/bedops/bedops/issues/236).
* [unstarch](reference/file-management/compression/unstarch.html#unstarch)
  + Patched `--is-starch` test option to read only up to, at most, 8kb to check for v2 or v1 (legacy) Starch archive data, to resolve [Issue 209](https://github.com/bedops/bedops/issues/209).
* General
  + Updated main `Makefile` to use [Homebrew](https://brew.sh/) GNU `coreutils` and `findutils` tools on the OS X target. If you build BEDOPS on OS X, you can add these tools with `brew install coreutils findutils`.

### 3.2.3. v2.4.38[¶](#v2-4-38 "Permalink to this headline")

Released: **March 31, 2020**

* [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed)
  + Patched segmentation fault in malformed RepeatMasker input conversion. Thanks to [Mark Diekhans](https://github.com/bedops/bedops/issues/235) for the bug report.
  + Patched abort and segmentation faults in malformed GVF, GFF, GTF, and WIG input conversion. Thanks to [Hongxu Chen](https://github.com/bedops/bedops/issues/217) for the bug report.
  + Patched documentation and help message for BAM and SAM conversion. Thanks to [Zhuoer Dong](https://github.com/bedops/bedops/issues/215) for the report.
  + Patched GTF conversion test suite.
* General
  + Updated outdated date information.

### 3.2.4. v2.4.37[¶](#v2-4-37 "Permalink to this headline")

Released: **October 11, 2019**

* [starchcat](reference/file-management/compression/starchcat.html#starchcat)
  + A bug was introduced in v2.4.36 that would cause segmentation faults when concatenating disjoint Starch files, which is fixed in this version. Thanks to Eric Rynes for the bug report.
  + Added a unit test to `tests/starch` to test this particular issue.
* [bedmap](reference/statistics/bedmap.html#bedmap)
  + Running `bedmap --version` now exits with a zero (non-error/success) status.
* [starch](reference/file-management/compression/starch.html#starch)
  + When a Starch file with a header is provided as input to `bedops` or `bedmap`, the line is errantly processed as a BED interval. Thanks to [André M. Ribeiro-dos-Santos](https://github.com/bedops/bedops/pull/229) for patching the Starch C++ API to skip headers.
  + Added a unit test to `tests/starch` to test headered Starch mapped against itself.
* General
  + Applied a placeholder workaround to whatever stupid bug was introducted in [Issue 5709](https://github.com/readthedocs/readthedocs.org/issues/5709) that broke image serving for the document index (front page).
  + Improved speed of generating random intervals in `tests/starch` unit tests.

### 3.2.5. v2.4.36[¶](#v2-4-36 "Permalink to this headline")

Released: **May 2, 2019**

* [bedmap](reference/statistics/bedmap.html#bedmap)
  + Resolved an issue preventing use of a `bash` process substitution or Unix named pipe in the reference position: *i.e.*, `bedmap --options <(processToGenerateReferenceElements) map.bed` and similar would issue incorrect output. Thanks to Wouter Meuleman and others for reports and test input.
  + To avoid mapping problems, map elements should not contain spaces in the ID or subsequent non-interval fields. Use of the `--ec` can help identify problems in map input, at the cost of a longer runtime. The documentation is clarified to warn users about avoiding spaces in map input. Thanks to Wouter Meuleman for the report and providing test input.
  + Added `--unmapped-val <val>` option, where `<val>` replaces the empty string output of `--echo-map*` operations when there are no mapped elements. The `--min/max-element` operators will give results as before (the empty string).
* General
  + Reduced `warning: zero as null pointer constant [-Wzero-as-null-pointer-constant]` compiler warnings via Clang.
  + Begun work on a comprehensive test suite for BEDOPS applications. Tests are available via source distribution in `${root}/tests` and can be run by entering `make` in this directory.

### 3.2.6. v2.4.35[¶](#v2-4-35 "Permalink to this headline")

Released: **May 2, 2018**

* [starch](reference/file-management/compression/starch.html#starch)
  + When compressing records, if the last interval in the former chromosome is identical to the first interval of the next chromosome, then a test on the sort order of the remainder string of that interval is applied (incorrectly). This is patched to test that chromosome names are identical before applying sort order rules. Thanks to Andrew Nishida for the report and for providing test input.

### 3.2.7. v2.4.34[¶](#v2-4-34 "Permalink to this headline")

Released: **April 26, 2018**

* [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed)
  + In [Issue 208](https://github.com/bedops/bedops/issues/208) builds of [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed) would exit with an error state when converting SAM input with newline-delimited records longer than the 5 MB per-thread I/O buffer. The `C2B_THREAD_IO_BUFFER_SIZE` constant is now set to the suite-wide `TOKENS_MAX_LENGTH` value, which should make it easier to compile custom builds of BEDOPS that support very-long line lengths. Thanks to Erich Schwarz for the initial report.
* [starchstrip](reference/file-management/compression/starchstrip.html#starchstrip)
  + When starchstrip is compiled with a C compiler, `qsort` uses a comparator that works correctly on the input chromosome list. When compiled with a C++ compiler (such as when building the larger BEDOPS toolkit), a different comparator is used that does not make variables of the correct type, and so the `qsort` result is garbage, leading to missing chromosomes. Thanks to Jemma Nelson for the initial report.

### 3.2.8. v2.4.33[¶](#v2-4-33 "Permalink to this headline")

Released: **April 9, 2018**

* [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed)
  + Resolved [Issue 207](https://github.com/bedops/bedops/issues/207) where a megarow build of [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed) would raise segmentation faults when converting SAM input. This build uses constants that define a longer BED line length. Arrays ended up using more stack than available, resulting in segmentation faults. This issue could potentially affect conversion of any data with the megarow build of [convert2bed](reference/file-management/conversion/convert2bed.html#convert2bed). Arrays using megarow-constants were replaced with heap- or dynamically-allocated pointers. Thanks to Erich Schwarz for the initial report.

### 3.2.9. v2.4.32[¶](#v2-4-32 "Permalink to this headline")

Released: **March 14, 2018**

* New build type (128-bit precision floating point arithmetic, `float128`)
  + A new build type adds support for `long double` or 128-bit floating point operations on measurement values in [bedmap](reference/statistics/bedmap.html#bedmap), such as is used with score operators like: `--min`, `--max`, `--min-element`, `--max-element`, `--mean`, and so on.
  + This build includes support for measurements on values ranging from approximately ±6.48e−4966 to ±6.48e4966 ([subnormal](https://en.wikipedia.org/wiki/Denormal_number)), or ±1.19e-4932 to ±1.19e4932 (normal), which enables [bedmap](reference/statistics/bedmap.html#bedmap) to handle, for example, lower p-values without log- or other transformation preprocessing steps. The article on [quadruple precision](https://en.wikipedia.org/wiki/Quadruple-precision_floating-point_format) can be useful for technical review.
  + For comparison, the current “non-float128” typical and megarow builds allow measurements on values from approximately ±5e−324 to ±5e324 (subnormal) or ±2.23e-308 to ±2.23e308 (normal). Please refer to the article on [double precision](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) for more technical detail.
  + Please use `make float128 && make install_float128` to install this build type.
  + This build type combines support for quadruple, 128-bit precision floats with the `typical` build type for handling “typical” BED4+ style line lengths. At this time, “megarow” support is not enabled with higher precision floats.
  + This build will use more memory to store floating-point values with higher precision, and processing those data will require more computation time. It is recommended that this build be used only if analyses require a higher level of precision than what the `double` type allows.
* OS X (Darwin) megarow build
  + Some applications packaged in the OS X installer or compiled via the OS X command-line developer toolkit lacked [megarow](http://bedops.readthedocs.io/en/latest/content/revision-history.html#v2-4-27) build support, despite those flags being specified in the parent Makefile. These applications specifically were affected: `bedextract`, `bedmap`, and `convert2bed`. These binaries rely on wider suite-wide constants and data types that the megarow build variety specifies. The Darwin-specific Makefiles have been fixed to resolve this build issue, so that all OS X BEDOPS binaries should now be able to compile in the correct megarow-specific settings.

### 3.2.10. v2.4.31[¶](#v2-4-31 "Perm