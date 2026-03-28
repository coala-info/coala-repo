# PnetCDF C Interface Guide

Next: [Use of the PnetCDF Library](Use-of-the-PnetCDF-Library.html#Use-of-the-PnetCDF-Library), Previous: [(dir)](../dir/index.html), Up: [(dir)](../dir/index.html)   [[Index](Combined-Index.html#Combined-Index "Index")]

---

# The PnetCDF C Interface Guide

| ``` Table of contents ``` | | |
| --- | --- | --- |
| • [Use of the PnetCDF Library](Use-of-the-PnetCDF-Library.html#Use-of-the-PnetCDF-Library): |  | General guide of using PnetCDF APIs |
| • [Files](Files.html#Files): |  | APIs for operating netCDF files |
| • [Dimensions](Dimensions.html#Dimensions): |  | APIs for dimension objects |
| • [Variables](Variables.html#Variables): |  | APIs for accessing variables |
| • [Attributes](Attributes.html#Attributes): |  | APIs for accessing attributes |
| • [Run-time Environment Variables](Run_002dtime-Environment-Variables.html#Run_002dtime-Environment-Variables): |  | Tuning I/O performance, debugging |
| • [Utility programs](Utility-programs.html#Utility-programs): |  | ncmpidiff, cdfdiff, pnetcdf\_version, ncoffsets, pnetcdf-config, ncvalidator |
| • [Summary of C Interface](Summary-of-C-Interface.html#Summary-of-C-Interface): |  | List of C APIs |
| • [Summary of Fortran 77 Interface](Summary-of-Fortran-77-Interface.html#Summary-of-Fortran-77-Interface): |  | List of Fortran 77 APIs |
| • [Summary of Fortran 90 Interface](Summary-of-Fortran-90-Interface.html#Summary-of-Fortran-90-Interface): |  | List of Fortran 90 APIs |
| • [Error Codes](Error-Codes.html#Error-Codes): |  | List of error codes and their meanings |
| • [Combined Index](Combined-Index.html#Combined-Index): |  |  |
| • [CDF-1 file format specification](CDF_002d1-file-format-specification.html#CDF_002d1-file-format-specification): |  |  |
| • [CDF-2 file format specification](CDF_002d2-file-format-specification.html#CDF_002d2-file-format-specification): |  |  |
| • [CDF-5 file format specification](CDF_002d5-file-format-specification.html#CDF_002d5-file-format-specification): |  |  |
| ```  ``` | | |
| ``` Use of the PnetCDF Library ``` | | |
| • [Creating](Creating.html#Creating): |  | Creating a NetCDF file |
| • [Reading Known](Reading-Known.html#Reading-Known) : |  | Reading a NetCDF file with known names |
| • [Reading Unknown](Reading-Unknown.html#Reading-Unknown) : |  | Reading a netCDF file with Unknown Names |
| • [Adding](Adding.html#Adding): |  | Adding new dimensions, variables, attributes |
| • [Nonblocking Write](Nonblocking-Write.html#Nonblocking-Write): |  | Nonblocking write to one or more variables |
| • [Nonblocking Read](Nonblocking-Read.html#Nonblocking-Read): |  | Nonblocking read from one or more variables |
| • [Errors](Errors.html#Errors): |  | Error handling |
| • [Compiling](Compiling.html#Compiling): |  | Compiling and linking with the PnetCDF library |
| ``` Files ``` | | |
| • [Interface Descriptions](Interface-Descriptions.html#Interface-Descriptions): |  | What’s in the Function Documentation |
| • [ncmpi\_strerror](ncmpi_005fstrerror.html#ncmpi_005fstrerror): |  | Get error string from error code |
| • [ncmpi\_strerrno](ncmpi_005fstrerrno.html#ncmpi_005fstrerrno): |  | Get string name of an error code (1.8.0 and later) |
| • [ncmpi\_inq\_libvers](ncmpi_005finq_005flibvers.html#ncmpi_005finq_005flibvers): |  | Get netCDF library version |
| • [ncmpi\_create](ncmpi_005fcreate.html#ncmpi_005fcreate): |  | Create a file (collective) |
| • [ncmpi\_open](ncmpi_005fopen.html#ncmpi_005fopen): |  | Open a file (collective) |
| • [ncmpi\_redef](ncmpi_005fredef.html#ncmpi_005fredef): |  | Put a file into Define Mode (collective) |
| • [ncmpi\_enddef](ncmpi_005fenddef.html#ncmpi_005fenddef): |  | Leave Define Mode (collective) |
| • [ncmpi\_\_enddef](ncmpi_005f_005fenddef.html#ncmpi_005f_005fenddef): |  | Leave Define Mode with Performance Tuning (1.5.0 and later) (collective) |
| • [ncmpi\_close](ncmpi_005fclose.html#ncmpi_005fclose): |  | Close a file (collective) |
| • [ncmpi\_inq Family](ncmpi_005finq-Family.html#ncmpi_005finq-Family): |  | Inquire about a file |
| • [ncmpi\_sync](ncmpi_005fsync.html#ncmpi_005fsync): |  | Synchronize a file to Disk (collective) |
| • [ncmpi\_abort](ncmpi_005fabort.html#ncmpi_005fabort): |  | Back Out of Recent Definitions (collective) |
| • [ncmpi\_set\_fill](ncmpi_005fset_005ffill.html#ncmpi_005fset_005ffill): |  | Set fill mode for a file (1.6.1 and later) (collective) |
| • [ncmpi\_set\_default\_format](ncmpi_005fset_005fdefault_005fformat.html#ncmpi_005fset_005fdefault_005fformat): |  | Set/change the default output format (1.6.1 and later) |
| • [ncmpi\_begin\_indep\_data](ncmpi_005fbegin_005findep_005fdata.html#ncmpi_005fbegin_005findep_005fdata): |  | Enter independent parallel data access mode (collective) |
| • [ncmpi\_end\_indep\_data](ncmpi_005fend_005findep_005fdata.html#ncmpi_005fend_005findep_005fdata): |  | Exit independent data mode (collective) |
| • [ncmpi\_inq\_put\_size](ncmpi_005finq_005fput_005fsize.html#ncmpi_005finq_005fput_005fsize): |  | Inquire the amount of data written to file so far (1.4.0 and later) |
| • [ncmpi\_inq\_get\_size](ncmpi_005finq_005fget_005fsize.html#ncmpi_005finq_005fget_005fsize): |  | Inquire the amount of data read from file so far (1.4.0 and later) |
| • [ncmpi\_inq\_header\_size](ncmpi_005finq_005fheader_005fsize.html#ncmpi_005finq_005fheader_005fsize): |  | Inquire the size of the file header (1.4.0 and later) |
| • [ncmpi\_inq\_header\_extent](ncmpi_005finq_005fheader_005fextent.html#ncmpi_005finq_005fheader_005fextent): |  | Inquire the file header extent (1.4.0 and later) |
| • [ncmpi\_sync\_numrecs](ncmpi_005fsync_005fnumrecs.html#ncmpi_005fsync_005fnumrecs): |  | Synchronize the number of records (1.4.0 and later) (collective) |
| • [ncmpi\_delete](ncmpi_005fdelete.html#ncmpi_005fdelete): |  | Delete a file |
| • [ncmpi\_inq\_file\_info](ncmpi_005finq_005ffile_005finfo.html#ncmpi_005finq_005ffile_005finfo): |  | Obtain the MPI Info object that contains all the I/O hints currently used (1.5.0 and later) |
| • [ncmpi\_get\_file\_info](ncmpi_005fget_005ffile_005finfo.html#ncmpi_005fget_005ffile_005finfo): |  | (deprecated) |
| • [ncmpi\_inq\_files\_opened](ncmpi_005finq_005ffiles_005fopened.html#ncmpi_005finq_005ffiles_005fopened): |  | Reports the number of files that are currently opened (1.5.0 and later) |
| ``` Dimensions ``` | | |
| • [Dimensions Introduction](Dimensions-Introduction.html#Dimensions-Introduction): |  | Rules for Dimensions |
| • [ncmpi\_def\_dim](ncmpi_005fdef_005fdim.html#ncmpi_005fdef_005fdim): |  | Create a Dimension (collective) |
| • [ncmpi\_inq\_dimid](ncmpi_005finq_005fdimid.html#ncmpi_005finq_005fdimid): |  | Get a Dimension ID from Its Name |
| • [ncmpi\_inq\_dim Family](ncmpi_005finq_005fdim-Family.html#ncmpi_005finq_005fdim-Family): |  | Inquire about a Dimension |
| • [ncmpi\_rename\_dim](ncmpi_005frename_005fdim.html#ncmpi_005frename_005fdim): |  | Rename a Dimension (collective) |
| ``` Variables ``` | | |
| • [Variable Introduction](Variable-Introduction.html#Variable-Introduction): |  | What are Variables? |
| • [Variable Types](Variable-Types.html#Variable-Types): |  | Floating point, integer, and all that |
| • [ncmpi\_def\_var](ncmpi_005fdef_005fvar.html#ncmpi_005fdef_005fvar): |  | Create a Variable (collective) |
| • [ncmpi\_def\_var\_fill](ncmpi_005fdef_005fvar_005ffill.html#ncmpi_005fdef_005fvar_005ffill): |  | Set fill mode for a Variable (1.6.1 and later) (collective) |
| • [ncmpi\_inq\_var\_fill](ncmpi_005finq_005fvar_005ffill.html#ncmpi_005finq_005fvar_005ffill): |  | Inquire fill mode of a Variable (1.6.1 and later) |
| • [ncmpi\_fill\_var\_rec](ncmpi_005ffill_005fvar_005frec.html#ncmpi_005ffill_005fvar_005frec): |  | Fill a record of a record variable (1.6.1 and later) (collective) |
| • [ncmpi\_inq\_varid](ncmpi_005finq_005fvarid.html#ncmpi_005finq_005fvarid): |  | Get a Variable ID from Its Name |
| • [ncmpi\_inq\_var Family](ncmpi_005finq_005fvar-Family.html#ncmpi_005finq_005fvar-Family): |  | Get Information about a Variable from Its ID |
| • [ncmpi\_put\_var1\_<type>](ncmpi_005fput_005fvar1_005f_003ctype_003e.html#ncmpi_005fput_005fvar1_005f_003ctype_003e): |  | Write a Single Data Value |
| • [ncmpi\_put\_var\_<type>](ncmpi_005fput_005fvar_005f_003ctype_003e.html#ncmpi_005fput_005fvar_005f_003ctype_003e): |  | Write an Entire Variable |
| • [ncmpi\_put\_vara\_<type>](ncmpi_005fput_005fvara_005f_003ctype_003e.html#ncmpi_005fput_005fvara_005f_003ctype_003e): |  | Write an Array of Values |
| • [ncmpi\_put\_vars\_<type>](ncmpi_005fput_005fvars_005f_003ctype_003e.html#ncmpi_005fput_005fvars_005f_003ctype_003e): |  | Write a Subsampled Array of Values |
| • [ncmpi\_put\_varm\_<type>](ncmpi_005fput_005fvarm_005f_003ctype_003e.html#ncmpi_005fput_005fvarm_005f_003ctype_003e): |  | Write a Mapped Array of Values |
| • [ncmpi\_put\_varn\_<type>](ncmpi_005fput_005fvarn_005f_003ctype_003e.html#ncmpi_005fput_005fvarn_005f_003ctype_003e): |  | Write a List of Subarrays of Values (1.4.0 and later) |
| • [ncmpi\_put\_vard](ncmpi_005fput_005fvard.html#ncmpi_005fput_005fvard): |  | Write an Array of Values using filetype (1.6.0 and later) |
| • [ncmpi\_get\_var1\_<type>](ncmpi_005fget_005fvar1_005f_003ctype_003e.html#ncmpi_005fget_005fvar1_005f_003ctype_003e): |  | Read a Single Data Value |
| • [ncmpi\_get\_var\_<type>](ncmpi_005fget_005fvar_005f_003ctype_003e.html#ncmpi_005fget_005fvar_005f_003ctype_003e): |  | Read an Entire Variable |
| • [ncmpi\_get\_vara\_<type>](ncmpi_005fget_005fvara_005f_003ctype_003e.html#ncmpi_005fget_005fvara_005f_003ctype_003e): |  | Read an Array of Values |
| • [ncmpi\_get\_vars\_<type>](ncmpi_005fget_005fvars_005f_003ctype_003e.html#ncmpi_005fget_005fvars_005f_003ctype_003e): |  | Read a Subsampled Array of Values |
| • [ncmpi\_get\_varm\_<type>](ncmpi_005fget_005fvarm_005f_003ctype_003e.html#ncmpi_005fget_005fvarm_005f_003ctype_003e): |  | Read a Mapped Array of Values |
| • [ncmpi\_get\_varn\_<type>](ncmpi_005fget_005fvarn_005f_003ctype_003e.html#ncmpi_005fget_005fvarn_005f_003ctype_003e): |  | Read a List of Subarrays of Values (1.4.0 and later) |
| • [ncmpi\_get\_vard](ncmpi_005fget_005fvard.html#ncmpi_005fget_005fvard): |  | read an Array of Values using filetype (1.6.0 and later) |
| • [Strings](Strings.html#Strings): |  | Reading and Writing Character String Values |
| • [Fill Values](Fill-Values.html#Fill-Values): |  | What’s Written Where there’s No Data? |
| • [ncmpi\_rename\_var](ncmpi_005frename_005fvar.html#ncmpi_005frename_005fvar): |  | Rename a Variable (collective) |
| • [ncmpi\_iput\_var<kind>\_<type>](ncmpi_005fiput_005fvar_003ckind_003e_005f_003ctype_003e.html#ncmpi_005fiput_005fvar_003ckind_003e_005f_003ctype_003e): |  | Non-blocking APIs for Writing a Subarray |
| • [ncmpi\_iget\_var<kind>\_<type>](ncmpi_005figet_005fvar_003ckind_003e_005f_003ctype_003e.html#ncmpi_005figet_005fvar_003ckind_003e_005f_003ctype_003e): |  | Non-blocking APIs for Reading a Subarray |
| • [ncmpi\_iput\_varn\_<type>](ncmpi_005fiput_005fvarn_005f_003ctype_003e.html#ncmpi_005fiput_005fvarn_005f_003ctype_003e): |  | Non-blocking APIs for Writing a List of Subarrays (1.6.0 and later) |
| • [ncmpi\_iget\_varn\_<type>](ncmpi_005figet_005fvarn_005f_003ctype_003e.html#ncmpi_005figet_005fvarn_005f_003ctype_003e): |  | Non-blocking APIs for Reading a List of Subarrays (1.6.0 and later) |
| • [ncmpi\_bput\_var<kind>\_<type>](ncmpi_005fbput_005fvar_003ckind_003e_005f_003ctype_003e.html#ncmpi_005fbput_005fvar_003ckind_003e_005f_003ctype_003e): |  | Non-blocking Buffered-version APIs for Writing a Subarray (1.3.0 and later) |
| • [ncmpi\_bput\_varn\_<type>](ncmpi_005fbput_005fvarn_005f_003ctype_003e.html#ncmpi_005fbput_005fvarn_005f_003ctype_003e): |  | Non-blocking Buffered-version APIs for Writing a List of subarrays (1.6.0 and later) |
| • [ncmpi\_wait/wait\_all](ncmpi_005fwait_002fwait_005fall.html#ncmpi_005fwait_002fwait_005fall): |  | Wait function for Non-blocking APIs |
| • [ncmpi\_inq\_nreqs](ncmpi_005finq_005fnreqs.html#ncmpi_005finq_005fnreqs): |  | inquire number of pending nonblocking requests (1.4.0 and later) |
| • [ncmpi\_inq\_buffer Family](ncmpi_005finq_005fbuffer-Family.html#ncmpi_005finq_005fbuffer-Family): |  | inquire information about the attached buffer used by buffered put APIs |
| • [ncmpi\_cancel](ncmpi_005fcancel.html#ncmpi_005fcancel): |  | cancel one or more pending nonblocking requests |
| ``` Attributes ``` | | |
| • [Attributes Introduction](Attributes-Introduction.html#Attributes-Introduction): |  | What are Attributes? |
| • [ncmpi\_put\_att\_<type>](ncmpi_005fput_005fatt_005f_003ctype_003e.html#ncmpi_005fput_005fatt_005f_003ctype_003e): |  | Write an Attribute (collective) |
| • [ncmpi\_inq\_att Family](ncmpi_005finq_005fatt-Family.html#ncmpi_005finq_005fatt-Family): |  | Get Information about an Attribute |
| • [ncmpi\_get\_att\_<type>](ncmpi_005fget_005fatt_005f_003ctype_003e.html#ncmpi_005fget_005fatt_005f_003ctype_003e): |  | Read an Attribute |
| • [ncmpi\_copy\_att](ncmpi_005fcopy_005fatt.html#ncmpi_005fcopy_005fatt): |  | Copy an Attribute (collective) |
| • [ncmpi\_rename\_att](ncmpi_005frename_005fatt.html#ncmpi_005frename_005fatt): |  | Rename an Attribute (collective) |
| • [ncmpi\_del\_att](ncmpi_005fdel_005fatt.html#ncmpi_005fdel_005fatt): |  | Delete an Attribute (collective) |
| ``` Run-time Environment Variables ``` | | |
| • [PNETCDF\_SAFE\_MODE](PNETCDF_005fSAFE_005fMODE.html#PNETCDF_005fSAFE_005fMODE): |  | Enable/disable checking for data consistency (1.4.0 and later) |
| • [PNETCDF\_VERBOSE\_DEBUG\_MODE](PNETCDF_005fVERBOSE_005fDEBUG_005fMODE.html#PNETCDF_005fVERBOSE_005fDEBUG_005fMODE): |  | Enable/disable printing verbose debugging messages (1.7.0 and later) |
| • [PNETCDF\_HINTS](PNETCDF_005fHINTS.html#PNETCDF_005fHINTS): |  | I/O hints for performance improvement (1.4.0 and later) |
| ``` Utility programs ``` | | |
| • [ncmpidiff](ncmpidiff.html#ncmpidiff): |  | Compare two netCDF files and report differences |
| • [cdfdiff](ncmpidiff.html#cdfdiff): |  | A serial version of ncmpidiff (1.12.0 and later) |
| • [pnetcdf\_version](pnetcdf_005fversion.html#pnetcdf_005fversion): |  | Report version information of PnetCDF library (1.5.0 and later) |
| • [ncoffsets](ncoffsets.html#ncoffsets): |  | Report starting/ending file offsets of netCDF variables (1.7.0 and later) |
| • [ncvalidator](ncvalidator.html#ncvalidator): |  | Validates a classic netCDF file against CDF file formats (1.9.0 and later) |
| • [pnetcdf-config](pnetcdf_002dconfig.html#pnetcdf_002dconfig): |  | Report configure options used to build PnetCDF library (1.8.0 and later) |

---

Next: [Use of the PnetCDF Library](Use-of-the-PnetCDF-Library.html#Use-of-the-PnetCDF-Library), Previous: [(dir)](../dir/index.html), Up: [(dir)](../dir/index.html)   [[Index](Combined-Index.html#Combined-Index "Index")]