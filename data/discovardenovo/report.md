# discovardenovo CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| discovardenovo | PASS |  |

## discovardenovo

### Tool Description
DISCOVAR de novo (experimental) is a de novo genome assembler that requires only a single PCR-free paired end Illumina library containing 250 base reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/discovardenovo:52488--1
- **Homepage**: https://github.com/bayolau/discovardenovo
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/discovardenovo/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bayolau/discovardenovo
- **Stars**: N/A
### Original Help Text
```text
Usage: DiscovarDeNovo arg1=value1 arg2=value2 ...

DISCOVAR de novo (experimental) is a de novo genome assembler that
requires only a single PCR-free paired end Illumina library containing
250 base reads.

Required arguments:

READS (String) 
  Comma-separated list of input files, see manual for details
OUT_DIR (String) 
  name of output directory

Optional arguments:

NUM_THREADS (unsigned int) default: 0 
  Number of threads. By default, the number of processors online.
REFHEAD (String) 
  use reference sequence REFHEAD.fasta to annotate assembly, and also
  REFHEAD.names if it exists
MAX_MEM_GB (double) default: 0 
  if specified, maximum allowed RAM use in GB; in some cases may be
  exceeded by our code
MEMORY_CHECK (Bool) default: False 
  if True, attempt to determine actual available memory and cap memory
  usage accordingly; slow and can cause machine to become very
  sluggish, or can result in process being killed

Special arguments:

GDB (Bool) default: False 
  Whether to use GDB for tracebacks.
NO_HEADER, or NH (Bool) default: False 
  Whether to suppress the normal command-line header block.
MEM_MONITOR, or MM (Bool) default: False 
  Monitor the memory usage of this module by forking MemMonitor. All
  arguments specifiable to MemMonitor can be supplied here by
  prefixing them with '_MM_'. See MemMonitor help for more
  information.
TEE (String) 
  Redirect standard out to the supplied space separated list of files.
```


## Metadata
- **Skill**: not generated
