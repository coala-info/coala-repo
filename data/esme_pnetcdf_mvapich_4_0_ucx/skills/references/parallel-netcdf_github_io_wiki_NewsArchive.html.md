## PnetCDF News Archive

---

* **November 2, 2018**: The official PnetCDF project web pages
  have migrated to github.com from its previous location at <https://trac.mcs.anl.gov/projects/parallel-netcdf>.
* **July 2, 2018**: Release of PnetCDF version 1.10.0 contains
  a new feature of using locally or globally accessible
  [burst buffers](doc/burst_buffering.html).
* **June 23, 2018**: PnetCDF source code repository has moved
  from its [SVN](https://svn.mcs.anl.gov/repos/parallel-netcdf) server
  at Argonne National Laboratory to
  [https://parallel-netcdf.github.io](https://github.com/Parallel-NetCDF/PnetCDF).

## 1.9.0

* **December 19, 2017**: PnetCDF **1.9.0** is
  released. See [1.9.0 Release Note](../Release_notes/1.9.0.html).
* **November 1, 2017**: PnetCDF **1.9.0.pre1** is
  available as a pre-release of version 1.9.0.

## 1.8.1

* **January 28, 2017**: PnetCDF **1.8.1** is
  released (the latest stable version). See [1.8.1 Release Note](../Release_notes/1.8.1.html).

## 1.8.0

* **December 19, 2016**: PnetCDF **1.8.0** is released (the latest stable version). See [ReleaseNotes-1.8.0](./ReleaseNotes-1.8.0).
* **November 15, 2016**: a preview release of PnetCDF **1.8.0**
  is available.
* **March 3, 2016**: PnetCDF **1.7.0** is released (the latest stable version). See
  [ReleaseNotes-1.7.0](../Release_notes/1.7.0.html).
* We continue working with the netCDF team at Unidata to improve CDF-5 and PnetCDF features in netCDF-4.

## 1.7.0pre1

* **January 12, 2016**: PnetCDF **1.7.0pre1** is available as a pre-release of version 1.7.0. See
  [release note](../Release_notes/1.7.0.html).
* We work with the netCDF team at Unidata to integrate CDF-5 and PnetCDF features in netCDF-4. See [​release note](https://github.com/Unidata/netcdf-c/releases) of 4.4.0 candidate RC4 for more information.

## 1.6.1

* **June 1, 2015**: PnetCDF **1.6.1** is released (the latest stable version). See
  [ReleaseNotes-1.6.1](../Release_notes/1.6.1.html).
* We are developing a [​patch](https://github.com/wkliao/netcdf-c/tree/CDF-5) to teach netCDF-4 to access CDF-5 files both in sequential and parallel. We encourage netCDF-4 users to give it a try and welcome all comments.

## 1.6.0

* **February 2, 2015**: PnetCDF **1.6.0** is released. See
  [ReleaseNotes-1.6.0](../Release_notes/1.6.html).

## 1.6.0.pre1

* **January 3, 2015**: a test release of PnetCDF **1.6.0.pre1** is available. See
  [ReleaseNotes-1.6.0.pre1](../Release_notes/1.6.0.p1.html) for more details.

## 1.5.0

* **July 8, 2014**: PnetCDF **1.5.0** is released. See
  [ReleaseNotes-1.5.0](../Release_notes/1.5.html).
* C++ APIs are now available in 1.5.0.

## 1.5.0.pre1

* **May 16, 2014**: a test release of PnetCDF **1.5.0.pre1** is available. See
  [ReleaseNotes-1.5.0.pre1](../Release_notes/1.5.0.p1.html) for more details.

## 1.4.1

* **December 23, 2013**: PnetCDF **1.4.1** is released. See
  [ReleaseNotes-1.4.1](../Release_notes/1.4.1.html) for more details.
* Fortran header file, pnetcdf.inc, now can be included in both fixed and free-formed Fortran programs.
* Initial [​subfiling](http://cucis.ece.northwestern.edu/projects/PnetCDF/subfiling.html) feature has been added to 1.4.1.

## 1.4.0

* **November 17, 2013**: PnetCDF **1.4.0** is released. See
  [ReleaseNotes-1.4.0](../Release_notes/1.4.html) for more details.
* Fortran 90 APIs are now available in 1.4.0.
* New APIs, ncmpi\_get/put\_varn\_<type> for reading/writing a list of sub-requests to a single variable. Available for F77 and F90 as well.
* FLASH-IO benchmark using PnetCDF is now part of the source code release.

## 1.4.0.pre1

* **September 19 2013**: PnetCDF **1.4.0.pre1** test release. See
  [ReleaseNotes-1.4.0.pre1](../Release_notes/1.4.0.p1.html) for more details.

## 1.3.1

* **September 24, 2012**: PnetCDF **1.3.1** released. See
  [ReleaseNotes-1.3.1](../Release_notes/1.3.1.html) for more details.

## 1.3.0

* **26 June 2012**: PnetCDF **1.3.0** released. See
  [ReleaseNotes-1.3.0](../Release_notes/1.3.html) for more details.
* In the 1.3.0 release, the unsigned and 64-bit integer data types are supported for CDF-5 format. The unsigned data types include NC\_UBYTE, NC\_USHORT, NC\_UINT, and NC\_UINT64. The 64-bit integer data types are NC\_INT64 and NC\_UINT64.
* New APIs for supporting more data types are added. For C, they are ncmpi\_(i)put/(i)get\_var\*\_ushort/uint/longlong/ulonglong. For Fortran, they are nfmpi\_(i)put/(i)get\_var\*\_int8.
* A new set of "buffered"-put APIs is supported in 1.3.0 release. The nonblocking iput/iget APIs require the contents of user buffers not to be changed until the wait call completed. The bput APIs use a user attached buffer to make a copy of request data, so the user buffer is free to change once the bput call returns.
* The special character set, "special2", and multi-byte UTF-8 encoded characters introduced in the CDF-2 file format for variable, dimension, and attribute name strings are now supported.
* A set of example programs and [QuickTutorial](QuickTutorial.html) are now available.

## 1.2.0

* **19 August 2010**: PnetCDF **1.2.0** released. See [ReleaseNotes-1.2.0](./ReleaseNotes-1.2.0) for more details.
* Nonblocking I/O is redesigned in the 1.2.0 release. It defers the I/O requests until "wait" call, so small requests can be aggregated into large ones for better performance.
* Two new hints, nc\_header\_align\_size and nc\_var\_align\_size, are added. The former allows pre-allocation of a larger header size to accommodate new header data in case new variables or attributed are added later. The latter aligns the starting file offsets of non-record variables. Refer to [VariableAlignment](./VariableAlignment.html) for a more detailed description.
* Data consistency control has been revised. A more strict consistency can be enforced by using NC\_SHARE mode at the file open/create time. In this mode, the file header is synchronized to the file if its contents have changed. Such file synchronization of calling MPI\_File\_sync() happens in many places, including ncmpi\_enddef(), ncmpi\_redef(), all APIs that change global or variable attributes, dimensions, and number of records.
* As calling MPI\_File\_sync() is very expensive on many file systems, users can choose more relaxed data consistency, i.e. by not using NC\_SHARE. In this case, file header is synchronized among all processes in memories. No MPI\_File\_sync() will be called if header contents have changed. MPI\_File\_sync() will only be called when switching data mode, i.e ncmpi\_begin\_indep\_data() and ncmpi\_end\_indep\_data().

---

Return to [PnetCDF Home](https://parallel-netcdf.github.io)