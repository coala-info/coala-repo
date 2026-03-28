---

# Parallel netCDF Q&A

---

This page provides frequently asked questions and tips for obtaining better I/O performance.
Readers are also referred to [NetCDF FAQ](http://www.unidata.ucar.edu/software/netcdf/docs/faq.html) for netCDF specific questions.

1. [Q: Is PnetCDF a file format?](#format)
2. [Q: How do I improve I/O performance on Lustre?](#lustre)
3. [Q: Should I compile my program (or PnetCDF library) to use shared or static libraries?](#shared)
4. [Q: What is file striping?](#striping)
5. [Q: Must I use a parallel file system to run PnetCDF?](#pfs)
6. [Q: Can a netCDF-4 program make use of PnetCDF internally (instead of HDF5) to perform parallel I/O?](#netcdf4)
7. [Q: How do I avoid the "data shift penalty" due to growth of the file header?](#shifting)
8. [Q: How do I enable file access layout alignment for fixed-size variables?](#align)
9. [Q: What run-time environment variables are available in PnetCDF?](#env)
10. [Q: How do I find out the PnetCDF and MPI-IO hint values used in my program?](#hint)
11. [Q: How do I inquire the file header size and the amount of space allocated for it?](#header)
12. [Q: Should I consider using nonblocking APIs?](#nonblocking)
13. [Q: How do I use the buffered nonblocking write APIs?](#bufferred)
14. [Q: What is the difference between collective and independent APIs?](#coll_indep)
15. [Q: Should I use collective APIs or independent APIs?](#collective)
16. [Q: Is there an API to read/write multiple subarrays of a single variable?](#varn)
17. [Q: What file formats does PnetCDF support and what are their differences?](#format)
18. [Q: How do I obtain the error message corresponding to a returned error code?](#error)
19. [Q: What should I call API ncmpi\_sync?](#sync)
20. [Q: Does PnetCDF support fill mode?](#fill)
21. [Q: Is there an API that reports the amount of data read/written that was carried out by PnetCDF?](#amount)
22. [Q: What are the numerical/non-numerical data types referred in NetCDF/PnetCDF?](#numerical)
23. [Q: Why do I get NC\_EBADTYPE error when I used MPI\_BYTE in flexible APIs?](#MPI_BYTE)
24. [Q: Does PnetCDF support compound data types?](#compound)
25. [Q: Can I run my PnetCDF program sequentially?](#sequential)
26. [Q: What level of parallel I/O data consistency is supported by PnetCDF?](#consistency)
27. [Q: Where can I find PnetCDF example programs?](#examples)
28. [Q: How to find out the PnetCDF version I am using?](#version)
29. [Q: Is there a mailing list for PnetCDF discussions and questions?](#discuss)

---

1. **Q: Is PnetCDF a file format?**
   **A:** No. [NetCDF](https://www.unidata.ucar.edu/software/netcdf/docs/netcdf_introduction.html#netcdf_format)
   is a file format. PnetCDF is an I/O library that lets MPI programs to
   read and write NetCDF files in parallel. Note NetCDF is also referred as
   an I/O library that defines a set of application programming interfaces
   (APIs) for reading and writing files in the netCDF format.

---

2. **Q: How do I improve I/O performance on Lustre?**
   **A:** Lustre is a parallel file system that allows users to customize a file's
   [striping](#striping) setting. If the amount of your I/O requests
   is sufficiently large, then the best strategy is to set the striping count
   to the maximal allowable by the file system. For Lustre, the user
   configurable parameters are striping count, striping size, and striping
   offset.
   * **Striping count** is the number of object storage targets (OST), i.e. the
     number of file servers storing the files in round robin.
   * **Striping size** is the size of the block. 1 MB is a good size.
   * **Striping offset** is the starting OST index (default -1). In most of the case, OSTs are selected by the system, not configurable by users.To find the (default) striping setting of your files (or folders), use the following command:
   > `% lfs getstripe filename
   > stripe_count: 12 stripe_size: 1048576 stripe_offset: -1`

   The command to change a directory's/file's striping setting is "lfs".
   Its syntax is:
   > `% lfs setstripe -s stripe_size -c stripe_count -o start_ost_index directory|filename`

   Note that users can change a directory's striping settings. New files created in a Lustre directory inherit the same settings.
   All in all, we recommend the followings.
   1. Use command "lfs" to set the striping count and size for the output directory and create your output files there.
   2. Use collective APIs. Collective I/O coordinates application processes and reorganizes their requests into an access pattern that fits better for the underlying file system.
   3. Use [nonblocking APIs](#nonblocking) for multiple small requests. Nonblocking APIs aggregate small requests into large ones and hence have a better chance to achieve higher performance.

---

3. **Q: Should I compile my program (or PnetCDF library) to use shared or static libraries?**
   **A:** If performance is your top priority, then we recommend static libraries. Although using shared (aka dynamic) libraries can produce the executable files in smaller size, it may introduce delays. See [further notes](http://www.nersc.gov/users/computational-systems/edison/running-jobs/shared-and-dynamic-libraries/) from NERSC.

---

4. **Q: What is file striping?**
   **A:** On parallel file systems, a file can be divided into blocks of same size,
   called striping size, which are stored in a set of file servers in a
   round-robin fashion. File striping allows multiple file servers to service
   I/O requests simultaneously, achieving a higher I/O bandwidth result.

---

5. **Q: Must I use a parallel file system to run PnetCDF?**
   **A:** No. However, using a parallel file system with a proper file
   striping setting can significantly improve your parallel I/O performance.

---

6. **Q: Can a netCDF-4 program make use of PnetCDF internally (instead of HDF5) to perform parallel I/O?**
   **A:** Yes. Starting from the release of 4.1, NetCDF has incorporated PnetCDF library to enable parallel I/O operations on files in classic formats (i.e. CDF-1 and 2).
   Note that when using HDF5 to carry out parallel I/O, the files will be created in the HDF5 format, instead of the classic netCDF format.
   To create a HDF5 format file, user must set the file create mode to add either
   NC\_CLASSIC\_MODEL or NC\_NETCDF4 flag (together with NC\_MPIIO), when calling API nc\_create\_par.

   To use PnetCDF for parallel I/O, users must add the NC\_MPIIO (or NC\_PNETCDF) flag to the create mode argument when calling nc\_create\_par.
   Without this flag, netCDF-4 programs can only perform sequential I/O on the classic CDF-1 and CDF-2 files.
   Starting from version 4.4.0, netCDF 4 supports the CDF-5 format which allows larger sized variables and 8-byte integers.

   Example netCDF-4 programs that use PnetCDF for parallel I/O are available [here](http://cucis.ece.northwestern.edu/projects/PnetCDF/#InteroperabilityWithNetCDF4).

---

7. **Q: How do I avoid the "data shift penalty" due to growth of the file header?**
   **A:**
   "Data shift" occurs when the size of file header grows.
   Files in CDF formats comprise two sections: metadata section and data section.
   The metadata section, also referred as the file header, is stored at the beginning of the file.
   The data section is stored after the metadata section and its starting file offset is
   determined at the first call to the end-define API (eg. ncmpi\_enddef or nc\_enddef), when
   the file is created.
   Afterward, the starting offset is recalculated every time the program calls end-define
   (from entering the re-define mode, finishing changes to metadata, and exiting).

   The "data shift penalty" happens when the new file header grows bigger than
   the space reserved for the original header and forces PnetCDF to "shift"
   the entire data section to a location with higher file offset. The header
   of a netCDF file can grow if a program opens an existing file and enters
   the redefine mode to add more metadata (e.g. new attributes, dimensions, or
   variables). PnetCDF provides an I/O hint, nc\_header\_align\_size, to allow
   user to preserve a larger space for file header if it is expected to grow.
   We refer to the space allocated for the file header as "file header
   extent".

   The default file header extent is of size 512 bytes, if the file system's
   striping size cannot be obtained from the underneath MPI-IO library. If the
   file striping size can be obtained (such as on Lustre) and the total size of
   all defined fix-sized variables is larger than 4 times the file striping
   size, then PnetCDF aligns the file header extent to the file striping size.
   Note PnetCDF always sets a header space of size equal to a multiple of
   nc\_header\_align\_size.

   Below is an example code fragment that sets the file header hint to 1MB and
   pass it to PnetCDF when creating a file.
   > `MPI_Info_create(&info);
   > MPI_Info_set(info, "nc_header_align_size", "1048576");
   > ncmpi_create(MPI_COMM_WORLD, "filename.nc", NC_CLOBBER|NC_64BIT_DATA, info, &ncid);`

   You can also use the run-time [environment variable](#env) PNETCDF\_HINTS to set a desired value.
   More information regarding to the netCDF file layout, readers are referred to [Parts of a NetCDF Classic File](http://www.unidata.ucar.edu/software/netcdf/docs/classic_file_parts.html).

   Note all I/O hints in PnetCDF and MPI-IO are advisory. The actual values
   used by PnetCDF and MPI-IO may be different from the ones set by the user
   programs. Users are encouraged to print the actual values used by both
   libraries.
   See [I/O hints](#hint) for how to print the hint values.

---

8. **Q: How do I enable file access layout alignment for fixed-size variables?**
   **A:** On most of the file systems, file locking is performed in the
   units of file blocks. If a write straddles two blocks, then locks must be
   acquired for both blocks. Aligning the start of a variable to a block
   boundary can often eliminate all unaligned file system accesses. For IBM's
   GPFS and Lustre, the locking unit size is also the file striping size.
   The PnetCDF hint for setting the file alignment size is nc\_var\_align\_size.
   Below is an example of setting the alignment size to 1 MB.
   > `MPI_Info_create(&info);
   > MPI_Info_set(info, "nc_var_align_size", "1048576");
   > ncmpi_create(MPI_COMM_WORLD, "filename.nc", NC_CLOBBER|NC_64BIT_DATA, info, &ncid);`

   If you are using independent APIs, then setting this hint is more important
   than if using collective. This is because most of the latest MPI-IO
   implementations have incorporated the file access alignment in their
   collective I/O functions, if MPI-IO can successfully retrieve the file
   striping information from the underlying parallel file system. This is one
   of the reasons we encourage PnetCDF users to use collective APIs whenever
   possible.

   To disable the alignment, set the hint value of nc\_var\_align\_size to 1.
   If you are using [nonblocking APIs](#nonblocking) to write data,
   we recommend to disable the alignment.

   Note all I/O hints in PnetCDF and MPI-IO are advisory. The actual values
   used by PnetCDF and MPI-IO may be different from the ones set by the user
   programs. Users are encouraged to print the actual values used by both
   libraries.
   See [I/O hints](#hint) for how to print the hint values.

---

9. **Q: What run-time environment variables are available in PnetCDF?**
   **A:** The list of PnetCDF run-time environment variables can be found
   [here](c-reference/pnetcdf-c/Run_002dtime-Environment-Variables.html).
   * PNETCDF\_HINTS allows users to pass I/O hints to PnetCDF library. Hints
     include both PnetCDF and MPI-IO hints. The value is a string of hints
     separated by ";" and each hint is in the form of "keyword=value". E.g.
     under csh/tcsh environment, use command:
   > `setenv PNETCDF_HINTS "romio_ds_write=disable;nc_header_align_size=1048576"`

   * PNETCDF\_VERBOSE\_DEBUG\_MODE is used to print the location in the source
     code where the error code is originated, no matter the error is intended or
     not. This run-time environment variable only takes effect when PnetCDF is
     configure with debug mode, i.e. --enable-debug is used at the configure
     command line. Users are warned that enabling this mode may result in a lot
     of debugging messages printed in stderr. Set this variable to 1 to enable.
     Set it to 0 or keep it unset disables this mode. Default is 0, i.e.
     disabled.
   * PNETCDF\_SAFE\_MODE is used to enable/disable the internal checking for
     attribute/argument consistency across all processes. Set it to 1 to enable
     the checking. Default is 0, i.e. disabled.

   Note the environment variables precede the (hint) values set in the
   application program.

---

10. **Q: How do I find out the PnetCDF and MPI-IO hint values used in my program?**
    **A:** Hint values can be retrieved from calls to ncmpi\_get\_file\_info
    and MPI\_Info\_get. Users are encouraged to check the hint values for the
    ones used in their programs. Since all hints are advisory, the actual
    values used by PnetCDF and MPI-IO may be different from the values set by
    the user programs. The real hint values are automatically adjusted based
    on many factors, including file size, variable sizes, and file system
    settings.

    Example programs that print PnetCDF hints only can be found in the
    ["examples"](https://trac.mcs.anl.gov/projects/parallel-netcdf/browser/trunk/examples) directory of the PnetCDF release:
    [hints.c](https://trac.mcs.anl.gov/projects/parallel-netcdf/browser/trunk/examples/C/hints.c),
    [hints.f](https://trac.mcs.anl.gov/projects/parallel-netcdf/browser/trunk/examples/F77/hints.f), and
    [hints.f90](https://trac.mcs.anl.gov/projects/parallel-netcdf/browser/trunk/examples/F90/hints.f90).
    Below is a code fragment in C that prints all I/O hints, including PnetCDF and MPI-IO.

    ```
        err = ncmpi_get_file_info(ncid, &info_used);
        MPI_Info_get_nkeys(info_used, &nkeys);
        for (i=0; i<nkeys; i++) {
            char key[MPI_MAX_INFO_KEY], value[MPI_MAX_INFO_VAL];
            int  valuelen, flag;
            MPI_Info_get_nthkey(info_used, i, key);
            MPI_Info_get_valuelen(info_used, key, &valuelen, &flag);
            MPI_Info_get(info_used, key, valuelen+1, value, &flag);
            printf("I/O hint: key = %21s, value = %s\n", key,value);
        }
        MPI_Info_free(&info_used);
    ```

---

11. **Q: How do I inquire the file header size and the amount of space allocated for it?**
    **A:** Starting from version 1.4.0, the following two APIs were added for such inquiries.
    > `int ncmpi_inq_header_size(int ncid, MPI_Offset *hdr_size);
    > int ncmpi_inq_header_extent(int ncid, MPI_Offset *hdr_extent);`

    API ncmpi\_inq\_header\_size returns in argument hdr\_size the amount in bytes
 