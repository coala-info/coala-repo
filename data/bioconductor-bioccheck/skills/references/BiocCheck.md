# BiocCheck: Ensuring Bioconductor package guidelines

#### 11 December 2025

# Contents

* [1 `BiocCheck` Summary](#bioccheck-summary)
* [2 Using `BiocCheck`](#using-bioccheck)
* [3 When should `BiocCheck` be run](#when-should-bioccheck-be-run)
* [4 Installing `BiocCheck`](#installing-bioccheck)
* [5 Interpreting `BiocCheck` output](#interpreting-bioccheck-output)
  + [5.1 Deprecated Package Checks](#deprecated-package-checks)
  + [5.2 Remotes Usage Check](#remotes-usage-check)
  + [5.3 LazyData Usage Check](#lazydata-usage-check)
  + [5.4 Version Checks](#version-checks)
  + [5.5 Package and File Size Check](#package-and-file-size-check)
  + [5.6 biocViews Checks](#biocviews-checks)
  + [5.7 Build System Compatibility Checks](#build-system-compatibility-checks)
  + [5.8 DESCRIPTION checks](#description-checks)
  + [5.9 NAMESPACE checks](#namespace-checks)
  + [5.10 .Rbuildignore checks](#rbuildignore-checks)
  + [5.11 BiocCheck output folder check](#bioccheck-output-folder-check)
  + [5.12 Check for inst/doc folder](#check-for-instdoc-folder)
  + [5.13 Vignette Checks](#vignette-checks)
  + [5.14 Checking Install or Update Package Calls in R code](#checking-install-or-update-package-calls-in-r-code)
  + [5.15 Coding Practices Checks](#coding-practices-checks)
  + [5.16 Function length checking](#function-length-checking)
  + [5.17 man page checking](#man-page-checking)
  + [5.18 NEWS checks](#news-checks)
  + [5.19 Unit Test Checks](#unit-test-checks)
  + [5.20 Formatting checks](#formatting-checks)
  + [5.21 Duplication checks](#duplication-checks)
  + [5.22 bioc-devel Subscription Check](#bioc-devel-subscription-check)
  + [5.23 Support Site Registration Check](#support-site-registration-check)
* [6 `BiocCheckGitClone`](#bioccheckgitclone)
* [7 Using `BiocCheckGitClone`](#using-bioccheckgitclone)
* [8 Installing `BiocCheckGitClone`](#installing-bioccheckgitclone)
* [9 Interpreting `BiocCheckGitClone` output](#interpreting-bioccheckgitclone-output)
  + [9.1 Bad File Check](#bad-file-check)
  + [9.2 Description Check](#description-check)
  + [9.3 CITATION checks](#citation-checks)
* [10 Expanding `BiocCheck`](#expanding-bioccheck)
* [SessionInfo](#sessioninfo)

# 1 `BiocCheck` Summary

```
library(BiocCheck)
```

`BiocCheck` encapsulates *Bioconductor* package guidelines and best
practices, analyzing packages and reporting three categories of
issues:

* **ERROR**. This means the package is missing something critical and
  it cannot be accepted into *Bioconductor* until the issue is
  fixed. (`BiocCheck` will continue past an `ERROR`, thus it is
  possible to have more than one, but it will exit with an error code
  if run from the OS command line.)
* **WARNING**. These issues almost always need to be addressed before
  the package is added to *Bioconductor*. In the weeks leading up to a
  *Bioconductor* release we will ask package authors to fix these
  issues.
* **NOTE**: Not necessarily something bad, just something we wanted to
  point out. package authors don’t need to take action on these, but
  they can.

# 2 Using `BiocCheck`

`BiocCheck` is meant to run within R on a directory containing an R package, or
a source tarball (`.tar.gz` file):

```
BiocCheck("<packageDirOrTarball>")
```

`BiocCheck` takes options which can be seen with `?BioCheck`.

Note that the `--new-package` option is turned on in the Single Package
Builder (SPB) during the new package submission process.

# 3 When should `BiocCheck` be run

`BiocCheck` should always be run after `R CMD check`.

Note that `BiocCheck` is not a replacement for `R CMD check`; it is
complementary. It should be run after `R CMD check` completes
successfully.

`BiocCheck` can also be run via
[GitHub Actions](https://docs.github.com/en/actions),
a continuous integration system on GitHub. This service allows automatic
testing of R packages in a controlled build environment.

See the *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* package for more details.

# 4 Installing `BiocCheck`

`BiocCheck` should be installed as follows:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BiocCheck")
```

# 5 Interpreting `BiocCheck` output

Actual `BiocCheck` output is shown below in **bold**.

## 5.1 Deprecated Package Checks

**Checking for deprecated package usage…**

Can be disabled with `--no-check-deprecated`.

At present, this looks to see whether your package has a dependency on
the `multicore` package (`ERROR`).

Our recommendation is to use *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*. Note that ‘fork’
clusters do not provide any gain from parallelizing code on
Windows. Socket clusters work on all operating systems.

Also checks `Deprecated` Packages currently specified in release and devel
versions of Bioconductor (`ERROR`).

## 5.2 Remotes Usage Check

**Checking for remote package usage…**

Can be disabled with `--no-check-remotes`

Bioconductor only allows dependencies that are hosted on CRAN or
Bioconductor. The use of `Remotes:` in the DESCRIPTION to specify a unique
remote location is not allowed.

## 5.3 LazyData Usage Check

**Checking for ‘LazyData: true’ usage…**

For packages that include data, we recommend not including `LazyData: TRUE`.
This rarely proves to be a good thing. In our experience it only slows down
the loading of packages with large data (`NOTE`).

## 5.4 Version Checks

Can be disabled with `--no-check-version-num` and `--no-check-R-ver`.

**Checking version number…**

* **Checking for version number mismatch…**
  Checks that the package version specified in your package tarball
  (if you are checking a tarball) matches the value of the `Version:`
  field in your `DESCRIPTION` file. If it doesn’t, it usually means
  you did not build the tarball with `R CMD build`. (`ERROR`)
* **Checking new package version number…**
  Checks that the pre-release version for an potential *Bioconductor*
  package uses a `99` ‘y’ version in the `x.y.z` versioning scheme
  (`ERROR`). Package versions starting with a non-zero value will
  get flagged with a warning. Typical new package submissions
  start with a zero ‘x’ version (e.g., `0.99.*`; `WARNING`). This
  is only done if the `--new-package` option is supplied. An ‘x’ nonzero will
  only be accepted if the package was pre-released or published under such a
  case.
* **Checking version number validity…**
  Checks for a valid version, that format is correct and that version
  number is appropriate for this version of *Bioconductor* (`ERROR`).
* **Checking R Version dependency…**
  If you specify an R version in the `Depends:` field of your
  `DESCRIPTION` file, `BiocCheck` checks to make sure that the R
  version specified matches the version currently used in
  *Bioconductor*. This helps to prevent mixing of Bioconductor release and
  devel versions (esp. when R versions differ) which is a frequent source of
  confusion and errors (`NOTE`).

For more information on package versions, see the
[Version Numbering HOWTO](https://contributions.bioconductor.org/versionnum.html).

## 5.5 Package and File Size Check

Can be disabled with `--no-check-pkg-size` and `--no-check-file-size`.

* **Checking package size**
  Checks that the package size meets *Bioconductor* requirements. The current
  package size limit is 5 MB for Software packages. Experiment Data and
  Annotation packages are excluded from this check. This check is only run if
  checking a source tarball. (ERROR)
* **Checking individual file sizes**
  The current size limit for all individual files is 5 MB. Checks inspect both
  package-wide files and data files found in the `data`, `inst/extdata`, and
  `data-raw` folders. (WARNING)

It may be necessary to remove large files from your Git history; see
[Remove Large Data Files and Clean Git Tree](https://contributions.bioconductor.org/git-version-control.html#remove-large-data-files-and-clean-git-tree)

## 5.6 biocViews Checks

These can be disabled with the `--no-check-bioc-views` option, which
might be useful when checking non-*Bioconductor* packages (since
biocViews is a concept unique to *Bioconductor*).

**Checking biocViews…**

Can be disabled with `--no-check-bioc-views`

* **Checking that biocViews are present…**
  Checks that a `biocViews` field is present in the DESCRIPTION file
  (`ERROR`).
* **Checking package type based on biocViews**
  Gives an indication if the package is identified as a Software, Annotation,
  Experiment, or Workflow package.
* **Checking for non-trivial biocViews…**
  Checks that biocViews are more specific than the top-level terms
  Software, AnnotationData, or ExperimentData (`ERROR`).
* **Checking biocViews validity…**
  Checks for valid views and displays invalid ones. Note that
  biocViews are case-sensitive (`WARNING`).
* **Checking that biocViews come from the same category…**
  Checks that all views come from the same parent (one of Software,
  AnnotationData, ExperimentData) (`WARNING`).
* **Checking for recommended biocViews…**
  Uses the `recommendBiocViews()` function from `biocViews` to
  automatically suggest some biocViews for your package.

More information about biocViews is available in the
[Using biocViews HOWTO](https://contributions.bioconductor.org/important-bioconductor-package-development-features.html#biocviews).

## 5.7 Build System Compatibility Checks

The *Bioconductor* Build System (BBS) is our nightly build system and
it has certain requirements. Packages which don’t meet these
requirements can be silently skipped by BBS, so it’s important to make
sure that every package meets the requirements.

Can be disabled with `--no-check-bbs`

**Checking build system compatibility…**

* **Checking for blank lines in DESCRIPTION…**
  Checks to make sure there are no blank lines in the DESCRIPTION
  file (`ERROR`).
* **Checking if DESCRIPTION is well formatted…**
  Checks if the DESCRIPTION can be parsed with read.dcf (`ERROR`)
* **Checking Description: field length…**
  Checks that the Description field in the DESCRIPTION file has a minimum

  + number of characters (`WARNING` if less than 50)
  + number of words (`WARNING` if less than 20)
  + number of sentences (`NOTE` if less than 3)
* **Checking for whitespace in DESCRIPTION field names…**
  Checks to make sure there is no whitespace in DESCRIPTION file field
  names (`ERROR`).
* **Checking that Package field matches dir/tarball name…**
  Checks to make sure that `Package` field of DESCRIPTION file matches
  directory or tarball name (`ERROR`).
* **Checking for Version field…**
  Checks to make sure a `Version` field is present in the DESCRIPTION
  file (`ERROR`).
* **Checking for valid maintainer…**
  Checks to make sure the DESCRIPTION file has a valid `Authors@R` field which
  resolves to a valid `Maintainer` (`ERROR`).

  A valid `Authors@R` field consists of:

  + A valid R object of class `person`.
  + Only one person with the `cre` (creator) role.
  + That person must have a syntactically valid email address.
  + That person must have either `family` or `given` name defined.
  + (optional) A syntactically valid [ORCID iD](https://orcid.org/), results in `NOTE` if not.

  Suggests that the maintainer provide an [ORCID iD](https://orcid.org/) in the `Authors@R`
  field as an argument in the person function, e.g., `comment = c(ORCID = ...)`
  (`NOTE`).

## 5.8 DESCRIPTION checks

* **Checking License: for restrictive use…**
  Checks to make sure that the `License:` in the `DESCRIPTION` file does not
  restrict use, e.g., to academic-use only (`ERROR`). Licenses are compared to
  R’s internal database provided at $R\_HOME/share/licenses/license.db and
  read with `read.dcf`. Licenses not listed in the database or with spelling
  deviations e.g., `GPL-3.0` vs `GPL-3` are flagged with a `NOTE`. A `NOTE` is
  also generated if the license is not a valid SPDX license identifier (with the
  exception of those already in the database file) or if the license cannot be
  verified in the database. A `NOTE` is also generated if the `License:` field
  is malformed, or the database cannot be located. We also recommend developers
  to browse to the [choosealicense](https://choosealicense.com/appendix) to find a suitable license for their
  package as well as the [SPDX License List](https://spdx.org/licenses/) website.
* **Checking for pinned package versions…**
  Ensures that maintainers are not indicating a specific dependency version
  using `==` in the `DESCRIPTION` file (`ERROR`).
* **Checking for recommended fields in DESCRIPTION…** Looks through the
  `DESCRIPTION` file to see whether recommended fields i.e., ‘URL’, ‘Date’ and
  ‘BugReports’ are populated (`NOTE`). `Date` field is checked for the format
  `YYYY-MM-DD`.
* **Checking for Bioconductor software dependencies…** Checks to see if
  the package depends on any Bioconductor software packages in the `Depends:`
  and `Imports:` fields; if none (`WARNING`).
* **Checking for ‘fnd’ role in Authors@R…** Checks to see if the `Authors@R`
  field has a person or organization with the `fnd` (funder) role (`NOTE`).

## 5.9 NAMESPACE checks

Can be disabled with `--no-check-namespace`.

* **Checking NAMESPACE…** ensures that the NAMESPACE file does not contain a
  match all export pattern, i.e., `exportPattern("^[[:alpha:]]+")` or similar
  (`ERROR`).

## 5.10 .Rbuildignore checks

* **Checking .Rbuildignore…** ensures that the ‘tests’ folder is
  not accidentally added to the `.Rbuildignore` file (`ERROR`).

## 5.11 BiocCheck output folder check

* **Checking for stray BiocCheck output folders…** ensures that the
  `<package_name>.BiocCheck` folder byproduct when running `BiocCheck(".")`
  locally does not get included in the package directory (`ERROR`).

## 5.12 Check for inst/doc folder

* **Checking for inst/doc folders…** ensures that there are no pre-built
  vignettes and their products in the *source* package directory. Vignettes are
  built when running `R CMD build`; therefore, `inst/doc` folder is not needed
  (`ERROR`).

## 5.13 Vignette Checks

Can be disabled with `--no-check-vignettes`.

**Checking vignette directory…**

* Checks that the `vignettes` directory exists (`ERROR`).
* Checks that the `vignettes` directory only contains vignette sources
  *(*.Rmd, *.qmd,* .Rnw, *.Rrst, .Rhtml,* .Rtex) (`ERROR`).
* Checks for `.Rnw` vignettes, if any found, suggest RMarkdown (`.Rmd`)
  vignettes instead (`WARNING`)
* Checks for `.qmd` vignettes, if any found, a ‘SystemRequirements’ field
  must be present in the `DESCRIPTION` file (`WARNING`). The field should
  list `quarto` as a system requirement.
* Checks whether, while checking a directory (not a tarball), vignette
  sources exist in inst/doc (`ERROR`).
* Checks that vignetteBuidler/vignetteEngine are listed in, minimally, Suggests
  field of DESCRIPTION file (`WARNING`)
* Checks that vignetteBuilder in DESCRIPTION and VignetteEngine in vignette
  are compatible (`ERROR`)
* Checks whether vignette title is still using template value (`WARNING`)
* Checks whether the number of `eval=FALSE` chunks is more than 50% of
  the total (`WARNING`).
* Checks whether the global vignette code option is set to `eval=FALSE`.
  The majority of vignette code is expected to be evaluated (`WARNING`)
* Checks for any legacy `BiocInstaller` code (`WARNING`)
* Checks that vignette code contains `sessionInfo()` or `session_info()` for
  reproducibility (`NOTE`).
* Checks that evaluated vignette code does not invoke package installation
  functions (`ERROR`). Function calls in the vignette that match `install.*`
  will produce a warning (`WARNING`).
* Checks that there are no duplicate code chunk labels in the vignettes
  (`ERROR`).
* Checks that all chunks have labels in vignettes (`NOTE`).

**Checking whether vignette is built with ‘R CMD build’…**

Only run when `--build-output-file` is specified.

Analyzes the output of `R CMD build` to see if vignettes are built.
It simply looks for a line that starts:

```
* creating vignettes ...
```

If this line is not present, it means `R` has not detected that a
vignette needs to be built (`ERROR`).

If you have vignette sources yet still get this message, there could
be several causes:

* Missing or invalid `VignetteBuilder` line in the `DESCRIPTION` file.
* Missing or invalid `VignetteEngine` line in the vignette source.

See `knitr`’s [package vignette](http://yihui.name/knitr/demo/vignette/) page, or the
[Non-Sweave vignettes](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Non_002dSweave-vignettes) section of “Writing R Extensions” for more
information.

## 5.14 Checking Install or Update Package Calls in R code

Can be disabled with `--no-check-library-calls` and `--no-check-install-self`.

* **Checking library calls…** (`NOTE`)
  Check for use of functions that install or update packages. This list
  currently includes the use of `install`, `install.packages`,
  `install_packages` `update.packages` or `biocLite`.
* **Checking for library/require of *(your package name)*…** (`ERROR`)
  It is not necessary to call `library()` or `require()` on your own
  package within code in the R directory or in man page examples. In
  these contexts, your package is already loaded.

## 5.15 Coding Practices Checks

Can be disabled with `--no-check-coding-practices`.

**Checking coding practices…**

Checks to see whether certain programming practices are found in the R
directory.

* We recommend that `vapply()` be used instead of `sapply()`. Problems
  arise when the `X` argument to `sapply()` has length 0; the return
  type is then a `list()` rather than a vector or array. (`NOTE`)
* We recommend that `seq_len()` or `seq_along()` be used instead of
  `1:...`. This is because the case `1:0` creates the sequence `c(1, 0)`
  which may be an unexpected or unwanted result (`NOTE`).
* Single colon typos are checked for when a user inputs ‘package:function’
  instead of using double colons (‘::’) to import a function (`ERROR`).
* Users should not download data from external hosting platforms. This
  means avoiding references to major platforms such as GitHub, GitLab,
  and BitBucket. For the same reason we do not import GitHub packages,
  external data can be unstable and not well maintained. Maintainers
  should re-use data already available in Bioconductor or contribute
  an `ExperimentHub`, `AnnotationHub` or similar package (`ERROR`).
* A package should not download files at the time of loading or attaching
  i.e., using `library`. Using `download.file` and `download` should be avoided
  and when found, an `ERROR` will be emitted.
* `paste` and `paste0` function calls within signaling functions such as
  `message`, `warning`, and `stop` are redundant and should be avoided
  (`NOTE`). `paste` calls with the `collapse` argument are ignored.
* When notifying users, `message` should be used. When `cat` and `print` are
  used, users will get a note saying that these should only be used in show
  methods for classes (`NOTE`).
* `message`, `warn*`, and `error` keywords should not be included in
  signal condition functions: `message`, `warning`, and `stop`. This is
  redundant and should be avoided (`NOTE`).
* It is favorable to use the assignment arrow (‘<-’) over the equals assignment
  (‘=’) for clarity in the code and legibility. Any use of the `=` will be
  flagged with a `NOTE`.
* New submissions should not use any `.Deprecated`, `.Defunct`, `lifeCycle`,
  `deprecate_warn`, or `deprecate_stop` function calls (`WARNING`). Existing
  packages should evolve these functions after a Bioconductor release according
  to the [package guidelines](https://contributions.bioconductor.org/deprecation.html).

* **Checking for T…** **Checking for F…**
  It is bad practice to use `T` and `F` for `TRUE` and `FALSE`. This
  is because `T` and `F` are ordinary variables whose value can be
  altered, leading to unexpected results, whereas the value of `TRUE`
  and `FALSE` cannot be changed (`WARNING`).
* Avoid class membership checks with `class()` / `is()` and `==` / `!=`.
  Developers should use `is(x, 'class')` for S4 classes. (`WARNING`)
* Use `system2()` over `system()`. ‘system2’ is a more portable and
  flexible interface than ‘system’.(`NOTE`)
* Use of `set.seed()` in R code. The `set.seed` should not be set in
  R functions directly. The user should always have the option for
  the set.seed and know when it is being invoked. (`WARNING`)

**Checking parsed R code in R directory, examples, vignettes…**

`BiocCheck` parses the code in your package’s R directory, and in
evaluated man page and vignette examples to look for various symbols,
which result in issues of varying severity.

* **Checking for direct slot access…**
  `BiocCheck` checks for direct slot access (via `@` or `slot()`) to
  S4 objects in vignette and example code. This code should **always**
  use accessors to interact with S4 classes. Since you may be using S4
  classes (which don’t provide accessors) from another package, the
  severity is only `NOTE`. But if the S4 object is defined in your
  package, it’s **mandatory** to write accessors for it and to use
  them (instead of direct slot access) in all vignette and example
  code (`NOTE`).
* **Checking for browser()…**
  `browser()` causes the command-line R debugger to be invoked, and
  should not be used in production code (though it’s OK to wrap such
  calls in a conditional that evaluates to TRUE if some debugging
  option is set) (`WARNING`).
* **Checking for <<-…**
  Non-local assignment using `<<-` is bad practice. It can over-write
  user-defined symbols, and introduces non-linear paths of evaluation
  that are difficult to debug (`NOTE`).
* **Checking for Sys.setenv calls…**
  Packages should not modify system environment variables with the
  `Sys.setenv` function (`ERROR`).
* **Checking for suppressWarnings/Messages…**
  The excessive use of `suppressWarnings` and `suppressMessages` is
  problematic as it usually indicates a larger underlying issue with
  the fragility of the package codebase (`NOTE`).

## 5.16 Function length checking

Can be disabled with `--no-check-function-len`.

**Checking function lengths…**

`BiocCheck` prints an informative message about the length (in lines)
of your five longest functions (this includes functions in your R
directory and in evaluated man page and vignette examples).

If there are functions longer than 50 lines, `BiocCheck` outputs (`NOTE`).
You may want to consider breaking up long functions into smaller ones. This is
a basic refactoring technique that results in code that’s easier to
read, debug, test, reuse, and maintain.

## 5.17 man page checking

Can be disabled with `--no-check-man-doc`.

**Checking man page documentation…**

* Checking for canned comments in man pages

It can be handy to generate man page skeletons with `prompt()` and/or
RStudio. These skeletons contain comments that look like this:

```
%%  ~~ A concise (1-5 lines) description of the dataset. ~~
```

`BiocCheck` asks you to remove such comments (`NOTE`).

* Every man page must have a non-empty `\value` section (`WARNING`). `Rd`
  pages without `\usage` sections or documenting data sets are excluded.
* man page examples examples

**Checking exported objects have runnable examples…**

`BiocCheck` looks at all man pages which document exported objects and
lists the ones that don’t contain runnable examples (either because
there is no `examples` section or because its examples are tagged with
`dontrun` or `donttest`). Runnable examples are a key part of literate
programming and help ensure that your code does what you say it does.

* Checks that at least 80% of man pages must have runnable examples (`ERROR`).
* Checks that, if more than 80% of the man pages have runnable
  examples, but some are still missing, `BiocCheck` lists the missing
  ones and asks you to add runnable examples to them (`NOTE`).
* Check the usage of `dontrun` or `donttest`. Use of these functions is not
  recommended and shoud be justified (`NOTE`). If exception is made the
  recommended usage is to use donttest over dontrun (`NOTE`) as donttest
  requires valid R code.

## 5.18 NEWS checks

Can be disabled with `--no-check-news`.

**Checking package NEWS…**

`BiocCheck` looks to see if there is a valid NEWS file either in the ‘inst’
directory or in the top-level directory of your package, and checks whether it
is properly formatted (`NOTE`).

The location and format of the NEWS file must be consistent with
`?news`. Meaning the file can be one of the following four options:

* `inst/NEWS.Rd`
* `./NEWS.md`
* `./NEWS`
* `inst/NEWS`

NEWS files are a good way to keep users up-to-date on changes to your
package. Excerpts from properly formatted NEWS files will be included
in *Bioconductor* release announcements to tell users what has changed
in your package in the last release. In order for this to happen, your
NEWS file must be formatted in a specific way; you may want to
consider using an `inst/NEWS.Rd` file instead as the format is more
well-defined. Malformatted NEWS file outputs `WARNING`.

More information on NEWS files is available in the help topic `?news`.

## 5.19 Unit Test Checks

Can be disabled with `--no-check-unit-tests`.

**Checking unit tests…**

We strongly recommend unit tests, though we do not at present require
them. For more on what unit tests are, why they are helpful, and how
to implement them, read our [Unit Testing HOWTO](https://contributions.bioconductor.org/tests.html).

At present we just check to see whether unit tests are present, and if not,
urge you to add them (`NOTE`).

**Checking skip\_on\_bioc() in tests…**

Can be disabled with `--no-check-skip-bioc-tests`.

Finds flag for skipping tests in the bioconductor environment (`NOTE`)

## 5.20 Formatting checks

Can be disabled with `--no-check-formatting`.

**Checking formatting of DESCRIPTION, NAMESPACE, man pages, R source,
and vignette source…**

There is no 100% correct way to format code. These checks adhere to the
[*Bioconductor* Style Guide](https://contributions.bioconductor.org/r-code.html) (`NOTE`).

We think it’s important to avoid very long lines in code. Note that
some text editors do not wrap text automatically, requiring horizontal
scrolling in order to read it. Also note that R syntax is very
flexible and whitespace can be inserted almost anywhere in an
expression, making it easy to break up long lines.

These checks are run against not just R code, but the DESCRIPTION and
NAMESPACE files as well as man pages and vignette source files. All
of these files allow long lines to be broken up.

The output of this check includes the first few lines of offending code for
many of the various checks. To see the full output, users are encouraged to
run the check locally and browse to the `BiocCheck` output folder that was
created with the `<PackageName>.BiocCheck` naming convention. The full output
log file is named `00BiocCheck.log`.

There are several helpful packages that can be used for formatting of
R code to particular coding standards such as [formatR](https://cran.r-project.org/package%3DformatR) and
[styler](https://cran.r-project.org/package%3Dstyler) as well as the “Reformat code” button in
[RStudio Desktop](https://rstudio.com/products/rstudio/download/). Each solution has its advantages, though
[styler](https://cran.r-project.org/package%3Dstyler) works with `roxygen2` examples and is actively
maintained. You can re-format your code using [styler](https://cran.r-project.org/package%3Dstyler) as shown
below:

```
## Install styler if necessary
if (!requireNamespace("styler", quietly = TRUE)) {
    install.packages("styler")
}
## Automatically re-format the R code in your package
styler::style_pkg(transformers = styler::tidyverse_style(indent_by = 4))
```

If you are
working with [RStudio Desktop](https://rstudio.com/products/rstudio/download/) use also the “Reformat code”
button which will help you break long lines of code. Alternatively,
use [formatR](https://cran.r-project.org/package%3DformatR), though beware that it can break valid R code
involving both types of quotation marks (`"` and `'`) and does not
support re-formatting `roxygen2` examples. In general,
it is best to version control your code before applying any
automatic re-formatting solutions and implement unit tests to
verify that your code runs as intended after you re-format your code.

## 5.21 Duplication checks

* **Checking if package already exists in CRAN…**
  This can be disabled with the `--no-check-CRAN` option. A package with the
  same name (case differences are ignored) cannot exist on CRAN. Packages
  submitted to Bioconductor must be removed from CRAN before the next
  Bioconductor release (`WARNING`).
* **Checking if new package already exists in *Bioconductor*…**
  Only run if the `--new-package` flag is turned on. A package
  with the same name (case differences are ignored) cannot exist in
  *Bioconductor* (`ERROR`).

## 5.22 bioc-devel Subscription Check

**Checking for bioc-devel mailing list subscription…**

This only applies if `BiocCheck` is run on the *Bioconductor* build
machines, because this step requires special authorization. This can be disabled
with the `--no-check-bioc-help` option.

* Check that the email address in the Maintainer (or Authors@R) field
  is subscribed to the bioc-devel mailing list (`ERROR`).

  All maintainers must subscribe to the bioc-devel mailing list, with
  the email address used in the DESCRIPTION file. You can subscribe
  [here](https://stat.ethz.ch/mailman/listinfo/bioc-devel).

## 5.23 Support Site Registration Check

**Checking for support site registration…**

* Check that the package maintainer is register at our
  [support site](https://support.bioconductor.org) using the same email address that is in the
  `Maintainer` field of their package `DESCRIPTION` file (`ERROR`).
  This can be disabled with the `--no-check-bioc-help` option.

  The main place people ask questions about *Bioconductor* packages is
  the support site. Please [register](https://support.bioconductor.org/accounts/signup/) and then include
  your package name in the list of watched tags.
  When a question is asked and tagged with your package name, you’ll
  get an email.
* Package name is in support site watched tags is now a requirement.

# 6 `BiocCheckGitClone`

`BiocCheckGitClone` provides a few additional *Bioconductor* package checks that
can only should be run on a open source directory (raw Git clone) NOT a
tarball. Reporting similarly in three categories as discussed above:

* **ERROR**.
* **WARNING**.
* **NOTE**.

Developers should check packages with `BiocCheck()` within an R session
while `BiocCheckGitClone()` is meant to run on the source package folder i.e.,
the cloned git repository.

# 7 Using `BiocCheckGitClone`

`BiocCheckGitClone` is meant to run within R on a directory containing an R
package:

```
BiocCheckGitClone("packageDir")
```

# 8 Installing `BiocCheckGitClone`

Please see previous Installing `BiocCheck` section.

# 9 Interpreting `BiocCheckGitClone` output

Actual `BiocCheckGitClone` output is shown below in **bold**.

## 9.1 Bad File Check

**Checking valid files**

There are a number of files that should not be Git tracked. This check notifies
if any of these files are present (`ERROR`)

The current list of files checked are given by this internal constant:

```
BiocCheck:::.HIDDEN_FILE_EXTS
```

```
##  [1] ".renviron"      ".rprofile"      ".rproj"         ".rproj.user"
##  [5] ".rhistory"      ".rapp.history"  ".o"             ".sl"
##  [9] ".so"            ".dylib"         ".a"             ".dll"
## [13] ".def"           ".ds_store"      "unsrturl.bst"   ".log"
## [17] ".aux"           ".backups"       ".cproject"      ".directory"
## [21] ".dropbox"       ".exrc"          ".gdb.history"   ".gitattributes"
## [25] ".gitmodules"    ".hgtags"        ".project"       ".seed"
## [29] ".settings"      ".tm_properties" ".rdata"
```

These files may be included in your personal directories but should be added to
a `.gitignore` file so they are not Git tracked.

## 9.2 Description Check

**Checking DESCRIPTION**

Default R CMD build behavior will format the DESCRIPTION file; After this occurs,
it is hard to determine certain aspects of the original DESCRIPTION file. An
example would be how the Authors and Maintainers are specified. The DESCRIPTION
file is therefore checked in its raw original form.

* **Checking if DESCRIPTION is well formatted**
  The DESCRIPTION file must be properly formatted and able to be read in with
  `read.dcf()` in order to function properly on the Bioconductor build
  machines. This check attempts to `read.dcf("DESCRIPTION")` and throws an ERROR
  if mal-formatted. (`ERROR`)
* **Checking for valid maintainer**
  While in the past using the Author and Maintainer fields were acceptable, R
  has moved towards using the `Authors@R` standard for listing package
  contributors. This checks that Authors@R is utilized and that there are no
  instances of Author or Maintainer in the DESCRIPTION (`ERROR`)

## 9.3 CITATION checks

**Checking that CITATION file is correctly formatted**

`BiocCheck` tries to read the provided `CITATION` file (i.e. not the one
automatically generated by each package) with `readCitationFile()` - this is
expected to be in the `INST` folder (`NOTE`). `readCitationFile()` needs to work
properly without the package being installed. Most common causes of failure
occur when trying to use helper functions like `packageVersion()` or
`packageDate()` instead of using `meta$Version` or `meta$Date`. See
[R documentation](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#CITATION-files)
for more information.

Here is an example of a formatted `CITATION` file. See the `GenomicRanges`
package `CITATION` file for details.

```
library(utils)
readCitationFile(
    system.file("CITATION", package = "GenomicRanges")
)
```

```
## Lawrence M, Huber W, Pag\`es H, Aboyoun P, Carlson M, et al. (2013)
## Software for Computing and Annotating Genomic Ranges. PLoS Comput Biol
## 9(8): e1003118. doi:10.1371/journal.pcbi.1003118
##
## A BibTeX entry for LaTeX users is
##
##   @Article{,
##     title = {Software for Computing and Annotating Genomic Ranges},
##     author = {Michael Lawrence and Wolfgang Huber and Herv\'e Pag\`es and Patrick Aboyoun and Marc Carlson and Robert Gentleman and Martin Morgan and Vincent Carey},
##     year = {2013},
##     journal = {{PLoS} Computational Biology},
##     volume = {9},
##     issue = {8},
##     doi = {10.1371/journal.pcbi.1003118},
##     url = {http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118},
##   }
```

`CITATION` files are expected to contain a `doi` input within the `bibentry()`
function call. When a `doi` input is not present, a `WARNING` is emitted as most
modern publications should have an assigned DOI.

Note that `citEntry()` should be updated to `bibentry()` as seen with
`R CMD check --as-cran`.

Bioconductor packages are not required to have a `CITATION` file but it is
useful both for users and for tracking Bioconductor project-wide metrics.
Maintainers should update the `CITATION` file once a preprint or publication is
released. Packages that do not have a `CITATION` file are flagged with a `NOTE`.

# 10 Expanding `BiocCheck`

We make an effort to reduce package reviewer burden and to increase the quality
of Bioconductor submissions via automated checks; therefore, `BiocCheck` is a
continually evolving package. Contributions are certainly most welcome. Consider
opening a pull request on GitHub with unit tests and updates to both the `NEWS`
file and vignette. Thank you for being part of the community!

# SessionInfo

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] BiocCheck_1.46.3 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rappdirs_0.3.3       sass_0.4.10          generics_0.1.4
##  [4] bitops_1.0-9         RSQLite_2.4.5        digest_0.6.39
##  [7] magrittr_2.0.4       evaluate_1.0.5       bookdown_0.46
## [10] fastmap_1.2.0        blob_1.2.4           jsonlite_2.0.0
## [13] graph_1.88.1         DBI_1.2.3            BiocManager_1.30.27
## [16] stringdist_0.9.15    XML_3.99-0.20        codetools_0.2-20
## [19] httr2_1.2.2          jquerylib_0.1.4      cli_3.6.5
## [22] rlang_1.1.6          dbplyr_2.5.1         Biobase_2.70.0
## [25] bit64_4.6.0-1        cachem_1.1.0         yaml_2.3.12
## [28] otel_0.2.0           BiocBaseUtils_1.12.0 parallel_4.5.2
## [31] tools_4.5.2          memoise_2.0.1        dplyr_1.1.4
## [34] filelock_1.0.3       BiocGenerics_0.56.0  RUnit_0.4.33.1
## [37] curl_7.0.0           vctrs_0.6.5          R6_2.6.1
## [40] stats4_4.5.2         biocViews_1.78.0     BiocFileCache_3.0.0
## [43] lifecycle_1.0.4      RBGL_1.86.0          bit_4.6.0
## [46] pkgconfig_2.0.3      bslib_0.9.0          pillar_1.11.1
## [49] glue_1.8.0           xfun_0.54            tibble_3.3.0
## [52] tidyselect_1.2.1     knitr_1.50           htmltools_0.5.9
## [55] rmarkdown_2.30       compiler_4.5.2       RCurl_1.98-1.17
```