# mbuffer CWL Generation Report

## mbuffer

### Tool Description
mbuffer is a "pipe" like program that supports buffering. It can be used to buffer data from a producer to a consumer. It can also be used to buffer data from a file to a file, or from a network to a file, or from a file to a network, etc.

### Metadata
- **Docker Image**: quay.io/biocontainers/mbuffer:20160228--h7b50bb2_8
- **Homepage**: https://github.com/ilovezfs/mbuffer-osx
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mbuffer/overview
- **Total Downloads**: 17.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ilovezfs/mbuffer-osx
- **Stars**: N/A
### Original Help Text
```text
usage: mbuffer [Options]
Options:
-b <num>   : use <num> blocks for buffer (default: 39955)
-s <size>  : use blocks of <size> bytes for processing (default: 4096)
-m <size>  : memory <size> of buffer in b,k,M,G,% (default: 2% = 156M)
-L         : lock buffer in memory (unusable with file based buffers)
-d         : use blocksize of device for output
-D <size>  : assumed output device size (default: infinite/auto-detect)
-P <num>   : start writing after buffer has been filled more than <num>%
-p <num>   : start reading after buffer has been filled less than <num>%
-i <file>  : use <file> for input
-o <file>  : use <file> for output (this option can be passed MULTIPLE times)
--append   : append to output file (must be passed before -o)
--truncate : truncate next file (must be passed before -o)
-I <h>:<p> : use network port <port> as input, allow only host <h> to connect
-I <p>     : use network port <port> as input
-O <h>:<p> : output data to host <h> and port <p> (MUTLIPLE outputs supported)
-n <num>   : <num> volumes for input, '0' to prompt interactively
-t         : use memory mapped temporary file (for huge buffer)
-T <file>  : as -t but uses <file> as buffer
-l <file>  : use <file> for logging messages
-u <num>   : pause <num> milliseconds after each write
-r <rate>  : limit read rate to <rate> B/s, where <rate> can be given in b,k,M,G
-R <rate>  : same as -r for writing; use eiter one, if your tape is too fast
-f         : overwrite existing files
-a <time>  : autoloader which needs <time> seconds to reload
-A <cmd>   : issue command <cmd> to request new volume
-v <level> : set verbose level to <level> (valid values are 0..6)
-q         : quiet - do not display the status on stderr
-Q         : quiet - do not log the status
-c         : write with synchronous data integrity support
-e         : stop processing on any kind of error
--direct   : open input and output with O_DIRECT
-4         : force use of IPv4
-6         : force use of IPv6
-0         : use IPv4 or IPv6
--tcpbuffer: size for TCP buffer
-V
--version  : print version information
Unsupported buffer options: -t -Z -B
```

