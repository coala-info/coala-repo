# twopaco CWL Generation Report

## twopaco

### Tool Description
Program for construction of the condensed de Bruijn graph from complete genomes

### Metadata
- **Docker Image**: quay.io/biocontainers/twopaco:1.1.0--hc252753_1
- **Homepage**: https://github.com/medvedevgroup/TwoPaCo
- **Package**: https://anaconda.org/channels/bioconda/packages/twopaco/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/twopaco/overview
- **Total Downloads**: 15.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/medvedevgroup/TwoPaCo
- **Stars**: N/A
### Original Help Text
```text
USAGE: 

   twopaco  {-f <integer>|--filtermemory <float>} [-o <file name>] [--test]
            [--tmpdir <directory name>] [-a <integer>] [-t <integer>] [-r
            <integer>] [-q <integer>] [-k <oddc>] [--] [--version] [-h]
            <fasta files with genomes> ...


Where: 

   -f <integer>,  --filtersize <integer>
     (OR required)  Size of the filter
         -- OR --
   --filtermemory <float>
     (OR required)  Memory in GBs allocated for the filter


   -o <file name>,  --outfile <file name>
     Output file name prefix

   --test
     Run tests

   --tmpdir <directory name>
     Temporary directory name

   -a <integer>,  --abundance <integer>
     Vertex abundance threshold

   -t <integer>,  --threads <integer>
     Number of worker threads

   -r <integer>,  --rounds <integer>
     Number of computation rounds

   -q <integer>,  --hashfnumber <integer>
     Number of hash functions

   -k <oddc>,  --kvalue <oddc>
     Value of k

   --,  --ignore_rest
     Ignores the rest of the labeled arguments following this flag.

   --version
     Displays version information and exits.

   -h,  --help
     Displays usage information and exits.

   <fasta files with genomes>  (accepted multiple times)
     (required)  FASTA file(s) with nucleotide sequences.


   Program for construction of the condensed de Bruijn graph from complete
   genomes
```

