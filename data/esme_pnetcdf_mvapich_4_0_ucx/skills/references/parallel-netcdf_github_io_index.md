# PnetCDF: A Parallel I/O Library for NetCDF File Access

---

## News

* **October 27, 2025**: Alpha Release of PnetCDF 1.15.0 is available.
* **July 31, 2025**: Release of PnetCDF 1.14.1 is available.
* **November 12, 2024**: [PnetCDF-Python](https://github.com/Parallel-NetCDF/PnetCDF-Python) package 1.0.0 is released.
* Starting from version [4.4.0](https://github.com/Unidata/netcdf-c/blob/v4.4.0/RELEASE_NOTES.md), the NetCDF library developed at Unidata supports the CDF-5 file
  format for both sequential and parallel file access.
* [News Archive](wiki/NewsArchive.html)

## Overview of PnetCDF

PnetCDF is a high-performance parallel I/O library for accessing
[Unidata's NetCDF](http://www.unidata.ucar.edu/software/netcdf/),
files in classic formats, specifically the formats of CDF-1, 2, and 5.
CDF-1 is the default NetCDF classic format. CDF-2 is an extended format
created through using flag NC\_64BIT\_OFFSET to support 64-bit file offsets. The
CDF-5 file format, an extension of CDF-2 and created through using flag
NC\_64BIT\_DATA, supports unsigned data types and uses 64-bit integers to allow
users to define large dimensions, attributes, and variables (> 2B array
elements).

In addition to the conventional netCDF read and write APIs, PnetCDF
provides a new set of nonblocking APIs. Nonblocking APIs allow users to post
multiple read and write requests first, and let PnetCDF to aggregate them
into a large request, hence to achieve a better performance.
See [nonblocking I/O](wiki/CombiningOperations.html) for further
description and example programs.

* [Software Downloads](wiki/Download.html): latest and
  previous software releases, as well as information for accessing the
  [GitHub repository](https://github.com/Parallel-NetCDF/PnetCDF) of
  source codes under development.
* Documents:
  + [User Guide](wiki/Documentation.html), published papers,
    presentations, articles, and other resources.
  + [Quick tutorial](wiki/QuickTutorial.html)
  + [NetCDF-4 example programs](http://cucis.ece.northwestern.edu/projects/PnetCDF/#InteroperabilityWithNetCDF4) that show how to access files through PnetCDF and HDF5 libraries underneath.
  + PnetCDF [C Programming Interface Reference](doc/c-reference/pnetcdf-c/index.html)
  + [Q&A](doc/faq.html)
    contains some guide lines for I/O performance tuning.
* [Benchmarking](wiki/Benchmarking.html): programs and suggestions
  for evaluating PnetCDF performance.

## A Brief Background About NetCDF

NetCDF gives scientific programmers a self-describing and portable means for
storing data. However, prior to version 4, netCDF does so in a serial manner.

NetCDF started to support parallel I/O from version 4, whose parallel I/O
feature was at first built on top of parallel HDF5. Thus, the file format
required by NetCDF-4 parallel I/O operations was restricted to HDF5 format.
Starting from the
[release of 4.1](http://www.unidata.ucar.edu/mailing_lists/archives/netcdfgroup/2010/msg00061.html),
NetCDF has also included a dispatcher that enables parallel I/O operations on
files in classic formats (CDF-1 and 2) through PnetCDF. Official support for
the CDF-5 format started in the
[release of NetCDF 4.4.0](https://github.com/Unidata/netcdf-c/releases/tag/v4.4.0-rc5).

Note NetCDF now can be built with PnetCDF as its sole parallel I/O mechanism by
using command-line option **"--disable-netcdf-4
--enable-pnetcdf"**. Certainly, NetCDF can also be built with both
PnetCDF and Parallel HDF5 enabled. In this case, a NetCDF program can choose
either PnetCDF or Parallel HDF5 to carry out the parallel I/O by adding
**NC\_MPIIO** or **NC\_NETCDF4** respectively to the
file open/create flag argument when calling API nc\_create\_par or nc\_open\_par.
When using PnetCDF underneath, the files must be in the classic formats
(CDF-1/2/5). Similarly for HDF5, the files must be in the HDF5 format (aka
NetCDF-4 format). A few
 [NetCDF-4 example programs](http://cucis.ece.northwestern.edu/projects/PnetCDF/#InteroperabilityWithNetCDF4)
are available that shows parallel I/O operations through PnetCDF and HDF5.

## A Brief History of PnetCDF

The PnetCDF project started in 2001, independently from the Unidata's NetCDF
project. Applications can use PnetCDF library completely without NetCDF
library. The initial goal of PnetCDF is to develop a parallel I/O library for
applications to access CDF-1 and 2 formats on parallel computers. Its focus is
to achieve high I/O performance. The design adopts a new set of APIs (with
prefix name of "ncmpi\_") due to its implementation being tightly coupled with
MPI. To encourage adoption from NetCDF users, the syntax of PnetCDF APIs stays
mostly the same as the NetCDF's. Through fully use of existing optimizations
available in MPI-IO implementation, PnetCDF has been demonstrated to be able to
deliver high-performance parallel I/O.

## A Note About Large File Support

The classic
[CDF](doc/c-reference/pnetcdf-c/CDF_002d1-file-format-specification.html)
file format (referred as CDF-1) has been solely in use by NetCDF library
through version 3.5.1. The classic format has been updated by NASA ESDS
community standard and added a support for 64-bit offset file format
(also referred as CDF-2). See
[NetCDF Classic and 64-bit Offset File Formats](doc/c-reference/pnetcdf-c/CDF_002d2-file-format-specification.html).

Starting from 3.6.0, the serial NetCDF library added support for the
[CDF-2](http://www.unidata.ucar.edu/software/netcdf/documentation/historic/netcdf/Classic-Format-Spec.html)
format. With this format, even 32 bit platforms can create NetCDF files
greater than 2 GiB in size. CDF-2 also allows more special characters in the
name strings of defined dimension, variables, and attributes. The support was
based largely on work from Greg Sjaardema.

Starting from the release of 0.9.2, PnetCDF supports CDF-2 format. See
[README.large\_files](https://github.com/Parallel-NetCDF/PnetCDF/blob/master/doc/README.large_files.md)
for more information.

Starting from the release of [1.3.0](Release_notes/1.3.0.html),
PnetCDF supports
[CDF-5](doc/c-reference/pnetcdf-c/CDF_002d5-file-format-specification.html)
format, an extension of CDF-2 that adds unsigned and 64-bit integer data types
and allows variables to be defined with more than 232 array
elements.

## File and Variable Limits

Both PnetCDF and NetCDF share limitations on file and variable sizes. More
information can be found on the [FileLimits](wiki/FileLimits.html)
page.

## Required Software

PnetCDF requires an MPI implementation with MPI-IO support. Most MPI libraries
have this nowadays. A parallel file system would also go a long way towards
achieving highest performance.

## Related Projects

PnetCDF makes use of several other technologies.

* [ROMIO](http://www.mcs.anl.gov/romio), an implementation of
  MPI-IO, provides optimized collective and noncontiguous operations. It also
  provides an abstract interface for a large number of parallel file systems.
* One of those file systems ROMIO supports is
  [PVFS](http://www.pvfs.org), a high performance parallel
  file system for Linux clusters.

Today, there are several options for high level I/O libraries. Here are some
discussions on the role of PnetCDF in this ecosystem:

* pnetcdf\_vs\_hdf5?
* pnetcdf\_vs\_netcdf4?

## Mailing List

We discuss the design and use of the PnetCDF library on the
parallel-netcdf@mcs.anl.gov mailing list. Anyone interested in
developing or using PnetCDF is encouraged to join. Visit
[the list
information page](https://lists.mcs.anl.gov/mailman/listinfo/parallel-netcdf) for details. This mailing list is also for
announcements, bug reports, and questions about PnetCDF software.

The URL for the list archive is <http://lists.mcs.anl.gov/pipermail/parallel-netcdf/>. You can browse even
older mailing list messages at the older
[mailing list archives](http://www.mcs.anl.gov/web-mail-archive/lists/parallel-netcdf/threads.html).

## Project Members

PnetCDF is jointly developed by **Northwestern University** and
**Argonne National Laboratory**.

* Wei-keng Liao, Kai-yuan Hou, and Alok Choudhary (Northwestern University)
* Rob Latham, Rob Ross, and Rajeev Thakur (Argonne National Lab)
* Kai-yuan Hou(Ph.D. student at Northwestern, graduated in 2022)
* Seung Woo Son (formerly a postdoc at ANL, and then a postdoc at Northwestern, now a Professor at UMass Lowell)
* Kui Gao (formerly a postdoc at Northwestern, now Dassault Systèmes Simulia Corp.)
* Jianwei Li (Ph.D. student at Northwestern, graduated in 2006, now at Bloomberg)
* Bill Gropp (formerly ANL, now UIUC)

## Citations

The official name of this project is **PnetCDF** (capital "P", lowercase
"net", followed by capital "CDF"). When referring to the PnetCDF project,
please use the following URL:

* https://parallel-netcdf.github.io

If you are looking for a reference to use in a published paper, please cite
our SC2003 paper below.

* Jianwei Li, Wei-keng Liao, Alok Choudhary, Robert Ross, Rajeev Thakur, William Gropp, Rob Latham, Andrew Siegel, Brad Gallagher, and Michael Zingale. [Parallel netCDF: A Scientific High-Performance I/O Interface](http://www.computer.org/csdl/proceedings/sc/2003/2113/00/21130039-abs.html). In the Proceedings of ACM/IEEE conference on Supercomputing, pp. 39, November, 2003.

The two previous project web pages can still be found.

* <https://trac.mcs.anl.gov/projects/parallel-netcdf>
* <http://cucis.ece.northwestern.edu/projects/PnetCDF> (a page maintained by Northwestern University)

## Acknowledgements

Original PnetCDF development was sponsored by the Scientific Data Management
Center ([SDM](https://sdm.lbl.gov/sdmcenter/)) under the DOE
program of Scientific Discovery through Advanced Computing ([SciDAC](http://www.scidac.gov/)). It was also supported in part by

* National Science Foundation under the SDCI HPC program award numbers
  OCI-0724599 and HECURA program award numbers CCF-0938000.
* Scientific Data, Analysis, and Visualization ([SDAV](https://sdm.lbl.gov/sdav/)) Institute under the DOE SciDAC
  program.
* The Exascale Computing Project ([ECP](https://exascaleproject.org/))
  under the DOE Office of Science.

Ongoing maintenance is funded by the OASIS Project under the DOE Office of Science.

---