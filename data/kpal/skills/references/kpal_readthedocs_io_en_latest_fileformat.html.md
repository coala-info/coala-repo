[kPAL](index.html)

latest

* [Introduction](intro.html)
* [Installation](install.html)
* [Methodology](method.html)
* [Tutorial](tutorial.html)
* [Using the Python library](library.html)

* [API reference](api.html)

* [Development](development.html)
* *k*-mer profile file format
  + [Versioning](#versioning)
  + [Current version: 1.0.0](#current-version-1-0-0)
  + [Changes from older versions](#changes-from-older-versions)
* [Changelog](changelog.html)
* [Copyright](copyright.html)

[kPAL](index.html)

* [Docs](index.html) »
* *k*-mer profile file format
* [Edit on GitHub](https://github.com/LUMC/kPAL/blob/master/doc/fileformat.rst)

---

# *k*-mer profile file format[¶](#k-mer-profile-file-format "Permalink to this headline")

The file format kPAL uses to store *k*-mer profiles is [HDF5](http://www.hdfgroup.org/). Here we describe the structure within a *k*-mer
profile file.

## Versioning[¶](#versioning "Permalink to this headline")

The file format is versioned roughly according to [semantic versioning](http://semver.org/). Software designed to work with files in version
*MAJOR.MINOR.PATCH* should be able to work with files in later versions with
the same *MAJOR* version without modification.

## Current version: 1.0.0[¶](#current-version-1-0-0 "Permalink to this headline")

The HDF5 toplevel attributes are:

* **format** (string) – This is always set to `kMer`.
* **version** (string) – Currently `1.0.0`.
* **producer** (string) – Anything, for example `My k-mer program 1.2.1`.

Each *k*-mer profile is a dataset under the `/profiles` group, named
`/profiles/<profile_name>`. The data is a one-dimensional array of integers
of length \(4^k\) (where \(k\) is the *k*-mer length) and is gzip
compressed. This dataset has the following attributes:

* **length** (integer): *k*-mer length (also know as *k*).
* **total** (integer): Sum of *k*-mer counts.
* **non\_zero** (integer): Number of *k*-mers with a non-zero count.
* **mean** (float): Mean of *k*-mer counts.
* **median** (integer): Median of *k*-mer counts.
* **std** (float): Standard deviation of *k*-mer counts.

Within one file, all profiles must have the same value for the length
attribute.

All strings and object names in the file are unicode strings encoded as
described in the [h5py documentation](http://docs.h5py.org/en/latest/strings.html).

## Changes from older versions[¶](#changes-from-older-versions "Permalink to this headline")

None yet.

[Next](changelog.html "Changelog")
 [Previous](development.html "Development")

---

© [Copyright](copyright.html) 2013-2014, LUMC, Jeroen F.J. Laros, Martijn Vermaat.
Revision `79b2ff97`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/snide/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).