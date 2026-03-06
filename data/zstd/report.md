# zstd CWL Generation Report

## zstd

### Tool Description
zstd command line interface for compression and decompression

### Metadata
- **Docker Image**: biocontainers/zstd:v1.3.8dfsg-3-deb_cv1
- **Homepage**: https://github.com/facebook/zstd
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/main/packages/zstd/overview
- **Total Downloads**: 729.1K
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/facebook/zstd
- **Stars**: N/A
### Original Help Text
```text
*** zstd command line interface 64-bits v1.3.8, by Yann Collet ***
Usage : 
      zstd [args] [FILE(s)] [-o file] 

FILE    : a filename 
          with no FILE, or when FILE is - , read standard input
Arguments : 
 -#     : # compression level (1-19, default: 3) 
 -d     : decompression 
 -D file: use `file` as Dictionary 
 -o file: result stored into `file` (only if 1 input file) 
 -f     : overwrite output without prompting and (de)compress links 
--rm    : remove source file(s) after successful de/compression 
 -k     : preserve source file(s) (default) 
 -h/-H  : display help/long help and exit 

Advanced arguments : 
 -V     : display Version number and exit 
 -v     : verbose mode; specify multiple times to increase verbosity
 -q     : suppress warnings; specify twice to suppress errors too
 -c     : force write to standard output, even if it is the console
 -l     : print information about zstd compressed files 
--ultra : enable levels beyond 19, up to 22 (requires more memory)
--long[=#]: enable long distance matching with given window log (default: 27)
--fast[=#]: switch to ultra fast compression level (default: 1)
--adapt : dynamically adapt compression level to I/O conditions 
 -T#    : spawns # compression threads (default: 1, 0==# cores) 
 -B#    : select size of each job (default: 0==automatic) 
 --rsyncable : compress using a rsync-friendly method (-B sets block size) 
--no-dictID : don't write dictID into header (dictionary compression)
--[no-]check : integrity check (default: enabled) 
 -r     : operate recursively on directories 
--format=zstd : compress files to the .zst format (default) 
--format=gzip : compress files to the .gz format 
--format=xz : compress files to the .xz format 
--format=lzma : compress files to the .lzma format 
--format=lz4 : compress files to the .lz4 format 
--test  : test compressed file integrity 
--[no-]sparse : sparse mode (default: enabled on file, disabled on stdout)
 -M#    : Set a memory usage limit for decompression 
--no-progress : do not display the progress bar 
--      : All arguments after "--" are treated as files 

Dictionary builder : 
--train ## : create a dictionary from a training set of files 
--train-cover[=k=#,d=#,steps=#,split=#] : use the cover algorithm with optional args
--train-fastcover[=k=#,d=#,f=#,steps=#,split=#,accel=#] : use the fast cover algorithm with optional args
--train-legacy[=s=#] : use the legacy algorithm with selectivity (default: 9)
 -o file : `file` is dictionary name (default: dictionary) 
--maxdict=# : limit dictionary to specified size (default: 112640) 
--dictID=# : force dictionary ID to specified value (default: random)

Benchmark arguments : 
 -b#    : benchmark file(s), using # compression level (default: 3) 
 -e#    : test all compression levels from -bX to # (default: 1)
 -i#    : minimum evaluation time in seconds (default: 3s) 
 -B#    : cut file into independent blocks of size # (default: no block)
--priority=rt : set process priority to real-time
```

