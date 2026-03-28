## PnetCDF File Limits

---

## Old Format

The [CDF-1](http://www.unidata.ucar.edu/software/netcdf/old_docs/really_old/guide_15.html) file format is the default file format which has been in use through netCDF library version 3.5.1. The definitive resource for these limits can be found at Unidata's [NetCDF Classic Format Limitations](http://www.unidata.ucar.edu/software/netcdf/docs/file_structure_and_performance.html#classic_format_limitations) page.

## Extending Limits

The [CDF-2](http://www.unidata.ucar.edu/software/netcdf/docs/file_format_specifications.html) file format (a.k.a. the 64-bit offset format) relaxes many of the above limitations. In order to create a CDF-2 formatted file, you must pass the flag NC\_64BIT\_OFFSET when creating the file. PnetCDF supports the CDF-2 file format as well, though shares the same limits as serial NetCDF. Read more at [Unidata](http://www.unidata.ucar.edu/)'s [64-bit Offset Format Limitations](http://www.unidata.ucar.edu/software/netcdf/docs/file_structure_and_performance.html#offset_format_limitations) page for limitations on the number of variables allowable per file, maximum sizes of record and non-record variables, and exceptions. The limitations and exceptions are quoted here.

> Although the 64-bit offset format allows the creation of much larger netCDF files than was possible with the classic format, there are still some restrictions on the size of variables.

> It's important to note that without Large File Support (LFS) in the operating system, it's impossible to create any file larger than 2 GiBytes. Assuming an operating system with LFS, the following restrictions apply to the netCDF 64-bit offset format.

> No fixed-size variable can require more than (232 - 4) bytes (i.e. 4GiB - 4 bytes, or 4,294,967,292 bytes) of storage for its data, unless it is the last fixed-size variable and there are no record variables. When there are no record variables, the last fixed-size variable can be any size supported by the file system, e.g. terabytes.
> A 64-bit offset format netCDF file can have up to (232 - 1) fixed sized variables, each under 4GiB in size. If there are no record variables in the file the last fixed variable can be any size.

> No record variable can require more than (232 - 4) bytes of storage for each record's worth of data, unless it is the last record variable. A 64-bit offset format netCDF file can have up to (232 - 1) records, of up to (232 - 1) variables, as long as the size of one record's data for each record variable except the last is less than 4 GiB - 4.

> Note also that all netCDF variables and records are padded to 4 byte boundaries.

The [CDF-5](../doc/c-reference/pnetcdf-c/CDF_002d5-file-format-specification.html) file format further relaxes the limitation to allow large dimensions (i.e. > 232) and more large variables. To create a CDF-5 file, the file create mode NC\_64BIT\_DATA must be used when calling ncmpi\_create function. Please note that [Unidata](http://www.unidata.ucar.edu/)'s NetCDF has also started to support CDF-5 format since its release of version 4.4.0.

## Record vs. Non-Record Variables

One subtle point about the CDF file format limitations is that record
variables (those with one NC\_UNLIMITED dimension) can be quite large. The
product of the fixed-sized dimensions of a record variable defines the size of
a single record. There can be quite a few of these records in a record
variable, though, so that can be one way around the file format limitations on
record size.

The drawback of using record variables is that with multiple record variables,
the data for each variable are interleaved on a per-record basis. This data
layout makes it much harder to figure out the optimal access pattern.
Ideally, though, programs would read and write record variables one record at
a time.

## Amount of Individual Requests is Limited to 2GB

In PnetCDF, a single get/put request is limited to the amount of 2GiB.
First, the MPI standard specifies that the 'count' argument passed to MPI read and write APIs be a 32-bit signed integer and hence the upper bound of 231 elements.
Secondly, ROMIO (the MPI-I/O implementation used by almost all MPI libraries) further limits the request amount to 231 bytes. Future release of ROMIO may fix this problem.
A solution for PnetCDF users is to break the request to multiple get/put calls so that each is less than amount of 2 GiB.

---

Return to [PnetCDF Home](https://parallel-netcdf.github.io)