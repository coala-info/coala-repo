# rapmap CWL Generation Report

## rapmap_quasiindex

### Tool Description
RapMap Indexer

### Metadata
- **Docker Image**: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
- **Homepage**: https://github.com/COMBINE-lab/RapMap
- **Package**: https://anaconda.org/channels/bioconda/packages/rapmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rapmap/overview
- **Total Downloads**: 39.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBINE-lab/RapMap
- **Stars**: N/A
### Original Help Text
```text
USAGE: 

   rapmap  [-x <positive integer <= # cores>] [-s <string>] [-p] [-n]
           [--keepDuplicates] [-k <positive integer less than 32>] -i
           <path> -t <path> [--] [--version] [-h]


Where: 

   -x <positive integer <= # cores>,  --numThreads <positive integer <= #
      cores>
     Use this many threads to build the perfect hash function

   -s <string>,  --headerSep <string>
     Instead of a space or tab, break the header at the first occurrence of
     this string, and name the transcript as the token before the first
     separator

   -p,  --perfectHash
     Use a perfect hash instead of sparse hash --- somewhat slows
     construction, but uses less memory

   -n,  --noClip
     Don't clip poly-A tails from the ends of target sequences

   --keepDuplicates
     Retain and index transcripts, even if they are exact sequence-level
     duplicates of others.

   -k <positive integer less than 32>,  --klen <positive integer less than
      32>
     The length of k-mer to index

   -i <path>,  --index <path>
     (required)  The location where the index should be written

   -t <path>,  --transcripts <path>
     (required)  The transcript file to be indexed

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.


   RapMap Indexer
```


## rapmap_quasimap

### Tool Description
RapMap Mapper

### Metadata
- **Docker Image**: biocontainers/rapmap:v0.12.0dfsg-3b1-deb_cv1
- **Homepage**: https://github.com/COMBINE-lab/RapMap
- **Package**: https://anaconda.org/channels/bioconda/packages/rapmap/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE: 

   rapmap  [-q] [-x] [-c] [-f] [--noStrictCheck] [--noSensitive] [-z
           <double in [0,1]>] [-m <positive integer>] [-t <positive
           integer>] [-o <path>] [-r <path>] [-2 <path>] [-1 <path>] [-n]
           -i <path> [--] [--version] [-h]


Where: 

   -q,  --quiet
     Disable all console output apart from warnings and errors

   -x,  --compressed
     Compress the output SAM file using zlib

   -c,  --chaining
     Score the hits to find the best chain

   -f,  --fuzzyIntersection
     Find paired-end mapping locations using fuzzy intersection

   --noStrictCheck
     Don't perform extra checks to try and assure that only equally "best"
     mappings for a read are reported

   --noSensitive
     Perform a less sensitive quasi-mapping by enabling NIP skipping

   -z <double in [0,1]>,  --quasiCoverage <double in [0,1]>
     Require that this fraction of a read is covered by MMPs before it is
     considered mappable.

   -m <positive integer>,  --maxNumHits <positive integer>
     Reads mapping to more than this many loci are discarded

   -t <positive integer>,  --numThreads <positive integer>
     Number of threads to use

   -o <path>,  --output <path>
     The output file (default: stdout)

   -r <path>,  --unmatedReads <path>
     The location of single-end reads

   -2 <path>,  --rightMates <path>
     The location of the right paired-end reads

   -1 <path>,  --leftMates <path>
     The location of the left paired-end reads

   -n,  --noOutput
     Don't write out any alignments (for speed testing purposes)

   -i <path>,  --index <path>
     (required)  The location of the quasiindex

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.


   RapMap Mapper
```


## Metadata
- **Skill**: generated
