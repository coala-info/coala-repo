## PnetCDF 1.3.0 Release Notes

Release Date: June 26, 2012

## Compatibility note

* In testing with version 11.7 of the Portland Group compiler, some of the Fortran test programs fail to compile if built with pgf77. The tests work if built with the Fortran90 compiler.

## New in 1.3.0

* Bug fixes in new ncmpidiff tool.
* Small optimizations to reduce communication in library.
* Improved documentation, including more test programs and a [QuickTutorial](../wiki/QuickTutorial.html).
* Bug fixes in our Fortran90 support.
* Better compatibility with NetCDF-4: no need for a modified pnetcdf.h from Unidata when building NetCDF-4 with PnetCDF support.
* PnetCDF now duplicates the MPI communicator internally, which fixed at least one odd behavior seen in a pnetcdf-using application.
* Improvements to PnetCDF header and variable alignment (see [VariableAlignment](../wiki/VariableAlignment)).
* Add a checking for file create mode consistency across all processes and an error code for it, NC\_ECMODE.
* Bug fix for updating the number of record variables in nonblocking APIs.
* Bug fix for variable starting file offsets when defining multiple large variables (> 232 elements) in one CDF-5 file.
* Add a new configure option that takes environment variable $RM to replace the default "rm" command in all Makefiles.
* Bug fix for nonblocking varm APIs.
* Support for CDF-2's special2 characters in names (variables, attributes, dimensions, etc.)
* Release of the official CDF-5 file format specification (see wiki page [CD-5](./cdf5_format)).
* Support for CDF-5 data types: NC\_UBYTE, NC\_USHORT, NC\_UINT, NC\_INT64, NC\_UINT64, and NF\_INT64.
* New C APIs: ncmpi\_put\_vara\_ushort, ncmpi\_put\_vara\_uint, ncmpi\_put\_vara\_longlong, and ncmpi\_put\_vara\_ulonglong. Similarly for var1, var, vars and varm APIs. Also for get and nonblocking APIs.
* New Fortran APIs: nfmpi\_put\_vars\_int8 and similarly for var1, var, vars, varm, get, and nonblocking APIs.
* Add a new error code, NC\_ENOTSUPPORT, for not-yet-supported features.
* A new set of buffered put APIs (eg. ncmpi\_bput\_vara\_float) is added (see [BufferedInterface](../wiki/BufferedInterface)). They make a copy of the user's buffer internally, so the user's buffer can be reused when the call returns. Their usage are similar to the iput APIs.
* Add new error codes for buffered put APIs: NC\_ENULLBUF, NC\_EPREVATTACHBUF, NC\_ENULLABUF, NC\_EPENDINGBPUT, and NC\_EINSUFFBUF.
* Add new test and example programs for the buffered put APIs.
* The error string returned by ncmpi\_strerror() for an undefined error code is updated from "Unknown Error" to "Unknown Error: Unrecognized PnetCDF error code ID" to be more descriptive.
* Remove the use of POSIX error codes: EINVAL, ENOERR, ERANGE, and ENOMEM. They are replaced by NC error codes now: NC\_EINVAL, NC\_NOERR, NC\_ERANGE, and NC\_ENOMEM.
* A better translation of MPI-IO error classes to netCDF/PnetCDF error codes. For example, MPI-IO error class MPI\_ERR\_NO\_SUCH\_FILE is translated to NC\_ENOENT.

---

Return to [PnetCDF Home](https://parallel-netcdf.github.io)