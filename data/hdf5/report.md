# hdf5 CWL Generation Report

## hdf5_h5ls

### Tool Description
List the contents of an HDF5 file

### Metadata
- **Docker Image**: quay.io/biocontainers/hdf5:1.10.4
- **Homepage**: https://github.com/HDFGroup/hdf5
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/hdf5/overview
- **Total Downloads**: 45.9K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/HDFGroup/hdf5
- **Stars**: N/A
### Original Help Text
```text
usage: h5ls [OPTIONS] file[/OBJECT] [file[/[OBJECT]...]
  OPTIONS
   -h, -?, --help  Print a usage message and exit
   -a, --address   Print raw data address.  If dataset is contiguous, address
                   is offset in file of beginning of raw data. If chunked,
                   returned list of addresses indicates offset of each chunk.
                   Must be used with -v, --verbose option.
                   Provides no information for non-dataset objects.
   -d, --data      Print the values of datasets
   --enable-error-stack
                   Prints messages from the HDF5 error stack as they occur.
   --follow-symlinks
                   Follow symbolic links (soft links and external links)
                   to display target object information.
                   Without this option, h5ls identifies a symbolic link
                   as a soft link or external link and prints the value
                   assigned to the symbolic link; it does not provide any
                   information regarding the target object or determine
                   whether the link is a dangling link.
   --no-dangling-links
                   Must be used with --follow-symlinks option;
                   otherwise, h5ls shows error message and returns an exit
                   code of 1. 
                   Check for any symbolic links (soft links or external links)
                   that do not resolve to an existing object (dataset, group,
                   or named datatype).
                   If any dangling link is found, this situation is treated
                   as an error and h5ls returns an exit code of 1.
   -f, --full      Print full path names instead of base names
   -g, --group     Show information about a group, not its contents
   -l, --label     Label members of compound datasets
   -r, --recursive List all groups recursively, avoiding cycles
   -s, --string    Print 1-byte integer datasets as ASCII
   -S, --simple    Use a machine-readable output format
   -wN, --width=N  Set the number of columns of output
   -v, --verbose   Generate more verbose output
   -V, --version   Print version number and exit
   --vfd=DRIVER    Use the specified virtual file driver
   -x, --hexdump   Show raw data in hexadecimal format

  file/OBJECT
    Each object consists of an HDF5 file name optionally followed by a
    slash and an object name within the file (if no object is specified
    within the file then the contents of the root group are displayed).
    The file name may include a printf(3C) integer format such as
    "%05d" to open a file family.

  Deprecated Options
    The following options have been deprecated in HDF5. While they remain
    available, they have been superseded as indicated and may be removed
    from HDF5 in the future. Use the indicated replacement option in all
    new work; where possible, existing scripts, et cetera, should also be
    updated to use the replacement option.

   -E or --external   Follow external links.
                      Replaced by --follow-symlinks.
   -e, --errors       Show all HDF5 error reporting
                      Replaced by --enable-error-stack.
```


## hdf5_h5dump

### Tool Description
Print a usage message and exit

### Metadata
- **Docker Image**: quay.io/biocontainers/hdf5:1.10.4
- **Homepage**: https://github.com/HDFGroup/hdf5
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: h5dump [OPTIONS] files
  OPTIONS
     -h,   --help         Print a usage message and exit
     -V,   --version      Print version number and exit
--------------- File Options ---------------
     -n,   --contents     Print a list of the file contents and exit
                          Optional value 1 also prints attributes.
     -B,   --superblock   Print the content of the super block
     -H,   --header       Print the header only; no data is displayed
     -f D, --filedriver=D Specify which driver to open the file with
     -o F, --output=F     Output raw data into file F
     -b B, --binary=B     Binary file output, of form B
     -O F, --ddl=F        Output ddl text into file F
                          Use blank(empty) filename F to suppress ddl display
--------------- Object Options ---------------
     -a P, --attribute=P  Print the specified attribute
                          If an attribute name contains a slash (/), escape the
                          slash with a preceding backslash (\).
                          (See example section below.)
     -d P, --dataset=P    Print the specified dataset
     -g P, --group=P      Print the specified group and all members
     -l P, --soft-link=P  Print the value(s) of the specified soft link
     -t P, --datatype=P   Print the specified named datatype
     -N P, --any_path=P   Print any attribute, dataset, group, datatype, or link that matches P
                          P can be the absolute path or just a relative path.
     -A,   --onlyattr     Print the header and value of attributes
                          Optional value 0 suppresses printing attributes.
     --vds-view-first-missing Set the VDS bounds to first missing mapped elements.
     --vds-gap-size=N     Set the missing file gap size, N=non-negative integers
--------------- Object Property Options ---------------
     -i,   --object-ids   Print the object ids
     -p,   --properties   Print dataset filters, storage layout and fill value
     -M L, --packedbits=L Print packed bits as unsigned integers, using mask
                          format L for an integer dataset specified with
                          option -d. L is a list of offset,length values,
                          separated by commas. Offset is the beginning bit in
                          the data value and length is the number of bits of
                          the mask.
     -R,   --region       Print dataset pointed by region references
--------------- Formatting Options ---------------
     -e,   --escape       Escape non printing characters
     -r,   --string       Print 1-byte integer datasets as ASCII
     -y,   --noindex      Do not print array indices with the data
     -m T, --format=T     Set the floating point output format
     -q Q, --sort_by=Q    Sort groups and attributes by index Q
     -z Z, --sort_order=Z Sort groups and attributes by order Z
     --enable-error-stack Prints messages from the HDF5 error stack as they occur.
                          Optional value 2 also prints file open errors.
     --no-compact-subset  Disable compact form of subsetting and allow the use
                          of "[" in dataset names.
     -w N, --width=N      Set the number of columns of output. A value of 0 (zero)
                          sets the number of columns to the maximum (65535).
                          Default width is 80 columns.
--------------- XML Options ---------------
     -x,   --xml          Output in XML using Schema
     -u,   --use-dtd      Output in XML using DTD
     -D U, --xml-dtd=U    Use the DTD or schema at U
     -X S, --xml-ns=S     (XML Schema) Use qualified names n the XML
                          ":": no namespace, default: "hdf5:"
                          E.g., to dump a file called `-f', use h5dump -- -f

--------------- Subsetting Options ---------------
 Subsetting is available by using the following options with a dataset
 option. Subsetting is done by selecting a hyperslab from the data.
 Thus, the options mirror those for performing a hyperslab selection.
 One of the START, COUNT, STRIDE, or BLOCK parameters are mandatory if you do subsetting.
 The STRIDE, COUNT, and BLOCK parameters are optional and will default to 1 in
 each dimension. START is optional and will default to 0 in each dimension.

      -s START,  --start=START    Offset of start of subsetting selection
      -S STRIDE, --stride=STRIDE  Hyperslab stride
      -c COUNT,  --count=COUNT    Number of blocks to include in selection
      -k BLOCK,  --block=BLOCK    Size of block in hyperslab
  START, COUNT, STRIDE, and BLOCK - is a list of integers the number of which are equal to the
      number of dimensions in the dataspace being queried
      (Alternate compact form of subsetting is described in the Reference Manual)

--------------- Option Argument Conventions ---------------
  D - is the file driver to use in opening the file. Acceptable values
      are "sec2", "family", "split", "multi", "direct", and "stream". Without
      the file driver flag, the file will be opened with each driver in
      turn and in the order specified above until one driver succeeds
      in opening the file.
      See examples below for family, split, and multi driver special file name usage.

  F - is a filename.
  P - is the full path from the root group to the object.
  N - is an integer greater than 1.
  T - is a string containing the floating point format, e.g '%.3f'
  U - is a URI reference (as defined in [IETF RFC 2396],
        updated by [IETF RFC 2732])
  B - is the form of binary output: NATIVE for a memory type, FILE for the
        file type, LE or BE for pre-existing little or big endian types.
        Must be used with -o (output file) and it is recommended that
        -d (dataset) is used. B is an optional argument, defaults to NATIVE
  Q - is the sort index type. It can be "creation_order" or "name" (default)
  Z - is the sort order type. It can be "descending" or "ascending" (default)

--------------- Examples ---------------

  1) Attribute foo of the group /bar_none in file quux.h5

      h5dump -a /bar_none/foo quux.h5

     Attribute "high/low" of the group /bar_none in the file quux.h5

      h5dump -a "/bar_none/high\/low" quux.h5

  2) Selecting a subset from dataset /foo in file quux.h5

      h5dump -d /foo -s "0,1" -S "1,1" -c "2,3" -k "2,2" quux.h5

  3) Saving dataset 'dset' in file quux.h5 to binary file 'out.bin'
        using a little-endian type

      h5dump -d /dset -b LE -o out.bin quux.h5

  4) Display two packed bits (bits 0-1 and bits 4-6) in the dataset /dset

      h5dump -d /dset -M 0,1,4,3 quux.h5

  5) Dataset foo in files file1.h5 file2.h5 file3.h5

      h5dump -d /foo file1.h5 file2.h5 file3.h5

  6) Dataset foo in split files splitfile-m.h5 splitfile-r.h5

      h5dump -d /foo -f split splitfile

  7) Dataset foo in multi files mf-s.h5, mf-b.h5, mf-r.h5, mf-g.h5, mf-l.h5 and mf-o.h5

      h5dump -d /foo -f multi mf

  8) Dataset foo in family files fam00000.h5 fam00001.h5 and fam00002.h5

      h5dump -d /foo -f family fam%05d.h5
```


## hdf5_h5diff

### Tool Description
Compares HDF5 files and objects within them.

### Metadata
- **Docker Image**: quay.io/biocontainers/hdf5:1.10.4
- **Homepage**: https://github.com/HDFGroup/hdf5
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: h5diff [OPTIONS] file1 file2 [obj1[ obj2]]
  file1             File name of the first HDF5 file
  file2             File name of the second HDF5 file
  [obj1]            Name of an HDF5 object, in absolute path
  [obj2]            Name of an HDF5 object, in absolute path

  OPTIONS
   -h, --help
         Print a usage message and exit.
   -V, --version
         Print version number and exit.
   -r, --report
         Report mode. Print differences.
   -v --verbose
         Verbose mode. Print differences information and list of objects.
   -vN --verbose=N
         Verbose mode with level. Print differences and list of objects.
         Level of detail depends on value of N:
          0 : Identical to '-v' or '--verbose'.
          1 : All level 0 information plus one-line attribute
              status summary.
          2 : All level 1 information plus extended attribute
              status report.
   -q, --quiet
         Quiet mode. Do not produce output.
   --enable-error-stack
                   Prints messages from the HDF5 error stack as they occur.
   --follow-symlinks
         Follow symbolic links (soft links and external links and compare the)
         links' target objects.
         If symbolic link(s) with the same name exist in the files being
         compared, then determine whether the target of each link is an existing
         object (dataset, group, or named datatype) or the link is a dangling
         link (a soft or external link pointing to a target object that does
         not yet exist).
         - If both symbolic links are dangling links, they are treated as being
           the same; by default, h5diff returns an exit code of 0.
           If, however, --no-dangling-links is used with --follow-symlinks,
           this situation is treated as an error and h5diff returns an
           exit code of 2.
         - If only one of the two links is a dangling link,they are treated as
           being different and h5diff returns an exit code of 1.
           If, however, --no-dangling-links is used with --follow-symlinks,
           this situation is treated as an error and h5diff returns an
           exit code of 2.
         - If both symbolic links point to existing objects, h5diff compares the
           two objects.
         If any symbolic link specified in the call to h5diff does not exist,
         h5diff treats it as an error and returns an exit code of 2.
   --no-dangling-links
         Must be used with --follow-symlinks option; otherwise, h5diff shows
         error message and returns an exit code of 2.
         Check for any symbolic links (soft links or external links) that do not
         resolve to an existing object (dataset, group, or named datatype).
         If any dangling link is found, this situation is treated as an error
         and h5diff returns an exit code of 2.
   -c, --compare
         List objects that are not comparable
   -N, --nan
         Avoid NaNs detection
   -n C, --count=C
         Print differences up to C. C must be a positive integer.
   -d D, --delta=D
         Print difference if (|a-b| > D). D must be a positive number. Where a
         is the data point value in file1 and b is the data point value in file2.
         Can not use with '-p' or '--use-system-epsilon'.
   -p R, --relative=R
         Print difference if (|(a-b)/b| > R). R must be a positive number. Where a
         is the data point value in file1 and b is the data point value in file2.
         Can not use with '-d' or '--use-system-epsilon'.
   --use-system-epsilon
         Print difference if (|a-b| > EPSILON), EPSILON is system defined value. Where a
         is the data point value in file1 and b is the data point value in file2.
         If the system epsilon is not defined,one of the following predefined
         values will be used:
           FLT_EPSILON = 1.19209E-07 for floating-point type
           DBL_EPSILON = 2.22045E-16 for double precision type
         Can not use with '-p' or '-d'.
   --exclude-path "path"
         Exclude the specified path to an object when comparing files or groups.
         If a group is excluded, all member objects will also be excluded.
         The specified path is excluded wherever it occurs.
         This flexibility enables the same option to exclude either objects that
         exist only in one file or common objects that are known to differ.

         When comparing files, "path" is the absolute path to the excluded;
         object; when comparing groups, "path" is similar to the relative
         path from the group to the excluded object. This "path" can be
         taken from the first section of the output of the --verbose option.
         For example, if you are comparing the group /groupA in two files and
         you want to exclude /groupA/groupB/groupC in both files, the exclude
         option would read as follows:
           --exclude-path "/groupB/groupC"

         If there are multiple paths to an object, only the specified path(s)
         will be excluded; the comparison will include any path not explicitly
         excluded.
         This option can be used repeatedly to exclude multiple paths.

 Modes of output:
  Default mode: print the number of differences found and where they occured
  -r Report mode: print the above plus the differences
  -v Verbose mode: print the above plus a list of objects and warnings
  -q Quiet mode: do not print output

 File comparison:
  If no objects [obj1[ obj2]] are specified, the h5diff comparison proceeds as
  a comparison of the two files' root groups.  That is, h5diff first compares
  the names of root group members, generates a report of root group objects
  that appear in only one file or in both files, and recursively compares
  common objects.

 Object comparison:
  1) Groups
      First compares the names of member objects (relative path, from the
      specified group) and generates a report of objects that appear in only
      one group or in both groups. Common objects are then compared recursively.
  2) Datasets
      Array rank and dimensions, datatypes, and data values are compared.
  3) Datatypes
      The comparison is based on the return value of H5Tequal.
  4) Symbolic links
      The paths to the target objects are compared.
      (The option --follow-symlinks overrides the default behavior when
       symbolic links are compared.).

 Exit code:
  0 if no differences, 1 if differences found, 2 if error

 Examples of use:
 1) h5diff file1 file2 /g1/dset1 /g1/dset2
    Compares object '/g1/dset1' in file1 with '/g1/dset2' in file2

 2) h5diff file1 file2 /g1/dset1
    Compares object '/g1/dset1' in both files

 3) h5diff file1 file2
    Compares all objects in both files

 Notes:
  file1 and file2 can be the same file.
  Use h5diff file1 file1 /g1/dset1 /g1/dset2 to compare
  '/g1/dset1' and '/g1/dset2' in the same file
```


## hdf5_h5repack

### Tool Description
Repacks HDF5 files

### Metadata
- **Docker Image**: quay.io/biocontainers/hdf5:1.10.4
- **Homepage**: https://github.com/HDFGroup/hdf5
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: h5repack [OPTIONS] file1 file2
  file1                    Input HDF5 File
  file2                    Output HDF5 File
  OPTIONS
   -h, --help              Print a usage message and exit
   -v, --verbose           Verbose mode, print object information
   -V, --version           Print version number and exit
   -n, --native            Use a native HDF5 type when repacking
   --enable-error-stack    Prints messages from the HDF5 error stack as they occur
   -L, --latest            Use latest version of file format
                           This option will take precedence over the -j and -k options
   --low=BOUND             The low bound for library release versions to use when creating
                           objects in the file (default is H5F_LIBVER_EARLIEST)
   --high=BOUND            The high bound for library release versions to use when creating
                           objects in the file (default is H5F_LIBVER_LATEST)
   -c L1, --compact=L1     Maximum number of links in header messages
   -d L2, --indexed=L2     Minimum number of links in the indexed format
   -s S[:F], --ssize=S[:F] Shared object header message minimum size
   -m M, --minimum=M       Do not apply the filter to datasets smaller than M
   -e E, --file=E          Name of file E with the -f and -l options
   -u U, --ublock=U        Name of file U with user block data to be added
   -b B, --block=B         Size of user block to be added
   -M A, --metadata_block_size=A  Metadata block size for H5Pset_meta_block_size
   -t T, --threshold=T     Threshold value for H5Pset_alignment
   -a A, --alignment=A     Alignment value for H5Pset_alignment
   -q Q, --sort_by=Q       Sort groups and attributes by index Q
   -z Z, --sort_order=Z    Sort groups and attributes by order Z
   -f FILT, --filter=FILT  Filter type
   -l LAYT, --layout=LAYT  Layout type
   -S FS_STRATEGY, --fs_strategy=FS_STRATEGY  File space management strategy for H5Pset_file_space_strategy
   -P FS_PERSIST, --fs_persist=FS_PERSIST  Persisting or not persisting free-space for H5Pset_file_space_strategy
   -T FS_THRESHOLD, --fs_threshold=FS_THRESHOLD   Free-space section threshold for H5Pset_file_space_strategy
   -G FS_PAGESIZE, --fs_pagesize=FS_PAGESIZE   File space page size for H5Pset_file_space_page_size

    M - is an integer greater than 1, size of dataset in bytes (default is 0)
    E - is a filename.
    S - is an integer
    U - is a filename.
    T - is an integer
    A - is an integer greater than zero
    Q - is the sort index type for the input file. It can be "name" or "creation_order" (default)
    Z - is the sort order type for the input file. It can be "descending" or "ascending" (default)
    B - is the user block size, any value that is 512 or greater and is
        a power of 2 (1024 default)
    F - is the shared object header message type, any of <dspace|dtype|fill|
        pline|attr>. If F is not specified, S applies to all messages

    BOUND is an integer indicating the library release versions to use when creating
          objects in the file (see H5Pset_libver_bounds()):
        0: This is H5F_LIBVER_EARLIEST in H5F_libver_t struct
        1: This is H5F_LIBVER_V18 in H5F_libver_t struct
        2: This is H5F_LIBVER_V110 in H5F_libver_t struct
           (H5F_LIBVER_LATEST is aliased to H5F_LIBVER_V110 for this release

    FS_STRATEGY is a string indicating the file space strategy used:
        FSM_AGGR:
               The mechanisms used in managing file space are free-space managers, aggregators and virtual file driver.
        PAGE:
               The mechanisms used in managing file space are free-space managers with embedded paged aggregation and virtual file driver.
        AGGR:
               The mechanisms used in managing file space are aggregators and virtual file driver.
        NONE:
               The mechanisms used in managing file space are virtual file driver.
        The default strategy when not set is FSM_AGGR without persisting free-space.

    FS_PERSIST is 1 to persisting free-space or 0 to not persisting free-space.
      The default when not set is not persisting free-space.
      The value is ignored for AGGR and NONE strategies.

    FS_THRESHOLD is the minimum size (in bytes) of free-space sections to be tracked by the library.
      The default when not set is 1.
      The value is ignored for AGGR and NONE strategies.

    FS_PAGESIZE is the size (in bytes) >=512 that is used by the library when the file space strategy PAGE is used.
      The default when not set is 4096.

    FILT - is a string with the format:

      <list of objects>:<name of filter>=<filter parameters>

      <list of objects> is a comma separated list of object names, meaning apply
        compression only to those objects. If no names are specified, the filter
        is applied to all objects
      <name of filter> can be:
        GZIP, to apply the HDF5 GZIP filter (GZIP compression)
        SZIP, to apply the HDF5 SZIP filter (SZIP compression)
        SHUF, to apply the HDF5 shuffle filter
        FLET, to apply the HDF5 checksum filter
        NBIT, to apply the HDF5 NBIT filter (NBIT compression)
        SOFF, to apply the HDF5 Scale/Offset filter
        UD,   to apply a user defined filter
        NONE, to remove all filters
      <filter parameters> is optional filter parameter information
        GZIP=<deflation level> from 1-9
        SZIP=<pixels per block,coding> pixels per block is a even number in
            2-32 and coding method is either EC or NN
        SHUF (no parameter)
        FLET (no parameter)
        NBIT (no parameter)
        SOFF=<scale_factor,scale_type> scale_factor is an integer and scale_type
            is either IN or DS
        UD=<filter_number,filter_flag,cd_value_count,value_1[,value_2,...,value_N]>
            required values for filter_number,filter_flag,cd_value_count,value_1
            optional values for value_2 to value_N
        NONE (no parameter)

    LAYT - is a string with the format:

      <list of objects>:<layout type>=<layout parameters>

      <list of objects> is a comma separated list of object names, meaning that
        layout information is supplied for those objects. If no names are
        specified, the layout type is applied to all objects
      <layout type> can be:
        CHUNK, to apply chunking layout
        COMPA, to apply compact layout
        CONTI, to apply contiguous layout
      <layout parameters> is optional layout information
        CHUNK=DIM[xDIM...xDIM], the chunk size of each dimension
        COMPA (no parameter)
        CONTI (no parameter)

Examples of use:

1) h5repack -v -f GZIP=1 file1 file2

   GZIP compression with level 1 to all objects

2) h5repack -v -f dset1:SZIP=8,NN file1 file2

   SZIP compression with 8 pixels per block and NN coding method to object dset1

3) h5repack -v -l dset1,dset2:CHUNK=20x10 -f dset3,dset4,dset5:NONE file1 file2

   Chunked layout, with a layout size of 20x10, to objects dset1 and dset2
   and remove filters to objects dset3, dset4, dset5

4) h5repack -L -c 10 -s 20:dtype file1 file2

   Using latest file format with maximum compact group size of 10 and
   and minimum shared datatype size of 20

5) h5repack --low=0 --high=1 file1 file2

   Set low=H5F_LIBVER_EARLIEST and high=H5F_LIBVER_V18 via H5Pset_libver_bounds() when
   creating the repacked file: file2

5) h5repack -f SHUF -f GZIP=1 file1 file2

   Add both filters SHUF and GZIP in this order to all datasets

6) h5repack -f UD=307,0,1,9 file1 file2

   Add bzip2 filter to all datasets
```


## hdf5_h5cc

### Tool Description
Compile line for HDF5

### Metadata
- **Docker Image**: quay.io/biocontainers/hdf5:1.10.4
- **Homepage**: https://github.com/HDFGroup/hdf5
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: h5cc [OPTIONS] <compile line>
  OPTIONS:
    -help        This help message.
    -echo        Show all the shell commands executed
    -prefix=DIR  Prefix directory to find HDF5 lib/ and include/
                   subdirectories [default: /usr/local]
usage: h5cc [OPTIONS] <compile line>
  OPTIONS:
    -help        This help message.
    -echo        Show all the shell commands executed
    -prefix=DIR  Prefix directory to find HDF5 lib/ and include/
                   subdirectories [default: /usr/local]
    -show        Show the commands without executing them
    -showconfig  Show the HDF5 library configuration summary
    -shlib       Compile with shared HDF5 libraries [default for hdf5 built
                                                     without static libraries]
    -noshlib     Compile with static HDF5 libraries [default for hdf5 built
                                                     with static libraries]
 
  <compile line>  - the normal compile line options for your compiler.
                    h5cc uses the same compiler you used to compile
                    HDF5. Check with your compiler's man pages for more
                    information on which options are needed.
 
 You can override the compiler, linker, and whether or not to use static
 or shared libraries to compile your program by setting the following
 environment variables accordingly:
 
   HDF5_CC                  -  use a different C compiler
   HDF5_CLINKER             -  use a different linker
   HDF5_USE_SHLIB=[yes|no]  -  use shared or static version of the HDF5 library
                                 [default: no except when built with only
                                           shared libraries]
 
 You can also add or change paths and flags to the compile line using
 the following environment varibles or by assigning them to their counterparts
 in the 'Things You Can Modify to Override...' section of h5cc
 
  Variable              Current value to be replaced
  HDF5_CPPFLAGS         ""
  HDF5_CFLAGS           ""
  HDF5_LDFLAGS          ""
  HDF5_LIBS             ""
 
 Note that adding library paths to HDF5_LDFLAGS where another hdf5 version
 is located may link your program with that other hdf5 library version.
```


## hdf5_h5c++

### Tool Description
Compile line for HDF5 C++ programs

### Metadata
- **Docker Image**: quay.io/biocontainers/hdf5:1.10.4
- **Homepage**: https://github.com/HDFGroup/hdf5
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: h5c++ [OPTIONS] <compile line>
  OPTIONS:
    -help        This help message.
    -echo        Show all the shell commands executed
    -prefix=DIR  Prefix directory to find HDF5 lib/ and include/
                   subdirectories [default: /usr/local]
    -show        Show the commands without executing them
    -showconfig  Show the HDF5 library configuration summary
    -shlib       Compile with shared HDF5 libraries [default for hdf5 built
                                                     without static libraries]
    -noshlib     Compile with static HDF5 libraries [default for hdf5 built
                                                     with static libraries]
 
  <compile line>  - the normal compile line options for your compiler.
                    h5c++ uses the same compiler you used to compile
                    HDF5. Check with your compiler's man pages for more
                    information on which options are needed.
 
 You can override the compiler, linker, and whether or not to use static
 or shared libraries to compile your program by setting the following
 environment variables accordingly:
 
   HDF5_CXX                 -  use a different C++ compiler
   HDF5_CXXLINKER           -  use a different linker
   HDF5_USE_SHLIB=[yes|no]  -  use shared or static version of the HDF5 library
                                 [default: no except when built with only
                                           shared libraries]
 You can also add or change paths and flags to the compile line using
 the following environment variables or by assigning them to their counterparts
 in the 'Things You Can Modify to Override...' section of h5c++
 
  Variable              Current value to be replaced
  HDF5_CPPFLAGS         ""
  HDF5_CXXFLAGS         ""
  HDF5_LDFLAGS          ""
  HDF5_LIBS             ""
 
 Note that adding library paths to HDF5_LDFLAGS where another hdf5 version
 is located may link your program with that other hdf5 library version.
```

