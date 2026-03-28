[![](/cgi-bin/code/bgen/logo)](http://www.bgenformat.org)

# BGEN

Top-level Files of trunk

[Login](/cgi-bin/code/bgen/login)

[☰](/cgi-bin/code/bgen/sitemap)[Home](/cgi-bin/code/bgen/dir?ci=trunk)
[Timeline](/cgi-bin/code/bgen/timeline)
[Branches](/cgi-bin/code/bgen/brlist)
[Tags](/cgi-bin/code/bgen/taglist)
[Tickets](/cgi-bin/code/bgen/rptview?rn=2)
[Wiki](/cgi-bin/code/bgen/wiki)

[All](/cgi-bin/code/bgen/dir)
[File Ages](/cgi-bin/code/bgen/fileage?name=trunk)
[Tree-View](/cgi-bin/code/bgen/dir?ci=trunk&type=tree)

## Files in the top-level directory of check-in trunk

* .hgignore
* 3rd\_party
* appcontext
* apps
* db
* doc
* example
* genfile
* R
* src
* test
* bitbucket-pipelines.yml
* CHANGELOG.md
* LICENSE\_1\_0.txt
* Makefile
* README.md
* waf
* wscript

---

# BGEN reference implementation

This repository contains a reference implementation of the [BGEN
format](http://www.bgenformat.org), written in C++. The library can be used as the basis for BGEN
support in other software, or as a reference for developers writing their own implementations of
the BGEN format.

### What's included?

This repository contains the library itself, a set of [example data files](/cgi-bin/code/bgen/dir?name=example), and a number
of example programs (e.g. [bgen\_to\_vcf](/cgi-bin/code/bgen/finfo?name=example/bgen_to_vcf.cpp)) that demonstrate the use of the
library API.

In addition, a number of utilities built using the library are also included in this repository:

* [bgenix](/cgi-bin/code/bgen/doc/trunk/doc/wiki/bgenix.md) - a tool to index and efficiently retrieve subsets of a BGEN file.
* [cat-bgen](/cgi-bin/code/bgen/doc/trunk/doc/wiki/cat-bgen.md) - a tool to efficiently concatenate BGEN files.
* [edit-bgen](/cgi-bin/code/bgen/doc/trunk/doc/wiki/edit-bgen.md) - a tool to edit BGEN file metadata.
* An R package called [rbgen](/cgi-bin/code/bgen/doc/trunk/doc/wiki/rbgen.md) is also constructed in the build directory.
  See the [rbgen wiki page](/cgi-bin/code/bgen/doc/trunk/doc/wiki/rbgen.md) for more information on using this package.

### Citing BGEN

If you make use of the BGEN library, its tools or example programs, please cite:

Band, G. and Marchini, J., "*BGEN: a binary file format for imputed genotype and haplotype data*",
bioArxiv 308296; doi: <https://doi.org/10.1101/308296>

Thanks!

### License

This BGEN implementation is released under the Boost Software License v1.0. This is a relatively
permissive open-source license that is compatible with many other open-source licenses. See [this
page](http://www.boost.org/users/license.html) and the file
[LICENSE\_1\_0.txt](/cgi-bin/code/bgen/artifact/12bafc460efc829b) for full details.

This repository also contains code from the [sqlite](www.sqlite.org), [boost](www.boost.org), and
[zstandard](http://www.zstd.net) libraries, which comes with their own respective licenses.
(Respectively, [public domain](http://www.sqlite.org/copyright.html), the boost software license,
and the [BSD license](https://github.com/facebook/zstd/blob/dev/LICENSE)). These libraries are not
used in the core BGEN implementation, but are used in the applications, example programs, and
`rbgen` R package.

### Note on UK Biobank data

A particularly important dataset released in BGEN is the imputed genotype data released by the UK
Biobank. See [the relevant wiki page](/cgi-bin/code/bgen/wiki/?name=BGEN+in+the+UK+Biobank) for details.

---

This page was generated in about
0.022s by
Fossil 2.22 [66ee0beb9b] 2023-05-31 15:26:08