# pandora CWL Generation Report

## pandora_index

### Tool Description
Index population reference graph (PRG) sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Total Downloads**: 4.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rmcolq/pandora
- **Stars**: N/A
### Original Help Text
```text
Index population reference graph (PRG) sequences.
Usage: /usr/local/bin/pandora index [OPTIONS] <PRG>

Positionals:
  <PRG> FILE [required]       PRG to index (in fasta format)

Options:
  -h,--help                   Print this help message and exit
  -w INT                      Window size for (w,k)-minimizers (must be <=k) [default: 14]
  -k INT                      K-mer size for (w,k)-minimizers [default: 15]
  -t,--threads INT            Maximum number of threads to use [default: 1]
  -o,--outfile FILE           Filename for the index [default: <PRG>.kXX.wXX.idx]
  -v                          Verbosity of logging. Repeat for increased verbosity
```


## pandora_map

### Tool Description
Quasi-map reads to an indexed PRG, infer the sequence of present loci in the sample, and optionally genotype variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Quasi-map reads to an indexed PRG, infer the sequence of present loci in the sample, and optionally genotype variants.
Usage: /usr/local/bin/pandora map [OPTIONS] <TARGET> <QUERY>

Positionals:
  <TARGET> FILE [required]    An indexed PRG file (in fasta format)
  <QUERY> FILE [required]     Fast{a,q} file containing reads to quasi-map

Options:
  -h,--help                   Print this help message and exit
  -v                          Verbosity of logging. Repeat for increased verbosity

Indexing:
  -w INT                      Window size for (w,k)-minimizers (must be <=k) [default: 14]
  -k INT                      K-mer size for (w,k)-minimizers [default: 15]

Input/Output:
  -o,--outdir DIR             Directory to write output files to [default: "pandora"]
  -t,--threads INT            Maximum number of threads to use [default: 1]
  --vcf-refs FILE             Fasta file with a reference sequence to use for each loci. The sequence MUST have a perfect match in <TARGET> and the same name
  --kg                        Save kmer graphs with forward and reverse coverage annotations for found loci
  --loci-vcf                  Save a VCF file for each found loci
  -C,--comparison-paths       Save a fasta file for a random selection of paths through loci
  -M,--mapped-reads           Save a fasta file for each loci containing read parts which overlapped it

Parameter Estimation:
  -e,--error-rate FLOAT       Estimated error rate for reads [default: 0.11]
  -g,--genome-size STR/INT    Estimated length of the genome - used for coverage estimation. Can pass string such as 4.4m, 100k etc. [default: 5000000]
  --bin                       Use binomial model for kmer coverages [default: negative binomial]

Mapping:
  -m,--max-diff INT           Maximum distance (bp) between consecutive hits within a cluster [default: 250]
  -c,--min-cluster-size INT   Minimum size of a cluster of hits between a read and a loci to consider the loci present [default: 10]

Preset:
  -I,--illumina               Reads are from Illumina. Alters error rate used and adjusts for shorter reads

Filtering:
  --clean                     Add a step to clean and detangle the pangraph
  --max-covg INT              Maximum coverage of reads to accept [default: 300]

Consensus/Variant Calling:
  --genotype                  Add extra step to carefully genotype sites.
  --snps                      When genotyping, only include SNP sites
  --kmer-avg INT              Maximum number of kmers to average over when selecting the maximum likelihood path [default: 100]

Genotyping:
  --local Needs: --genotype   (Intended for developers) Use coverage-oriented (local) genotyping instead of the default ML path-oriented (global) approach.
  -a INT                      Hard threshold for the minimum allele coverage allowed when genotyping [default: 0]
  -s INT                      The minimum required total coverage for a site when genotyping [default: 0]
  -D INT                      Minimum difference in coverage on a site required between the first and second maximum likelihood path [default: 0]
  -F INT                      Minimum allele coverage, as a fraction of the expected coverage, allowed when genotyping [default: 0]
  -E,--gt-error-rate FLOAT    When genotyping, assume that coverage on alternative alleles arises as a result of an error process with rate -E. [default: 0.01]
  -G,--gt-conf INT            Minimum genotype confidence (GT_CONF) required to make a call [default: 1]
```


## pandora_compare

### Tool Description
Quasi-map reads from multiple samples to an indexed PRG, infer the sequence of present loci in each sample, and call variants between the samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Quasi-map reads from multiple samples to an indexed PRG, infer the sequence of present loci in each sample, and call variants between the samples.
Usage: /usr/local/bin/pandora compare [OPTIONS] <TARGET> <QUERY_IDX>

Positionals:
  <TARGET> FILE [required]    An indexed PRG file (in fasta format)
  <QUERY_IDX> FILE [required] A tab-delimited file where each line is a sample identifier followed by the path to the fast{a,q} of reads for that sample

Options:
  -h,--help                   Print this help message and exit
  -v                          Verbosity of logging. Repeat for increased verbosity

Indexing:
  -w INT                      Window size for (w,k)-minimizers (must be <=k) [default: 14]
  -k INT                      K-mer size for (w,k)-minimizers [default: 15]

Input/Output:
  -o,--outdir DIR             Directory to write output files to [default: "pandora"]
  -t,--threads INT            Maximum number of threads to use [default: 1]
  --vcf-refs FILE             Fasta file with a reference sequence to use for each loci. The sequence MUST have a perfect match in <TARGET> and the same name
  --loci-vcf                  Save a VCF file for each found loci

Parameter Estimation:
  -e,--error-rate FLOAT       Estimated error rate for reads [default: 0.11]
  -g,--genome-size STR/INT    Estimated length of the genome - used for coverage estimation. Can pass string such as 4.4m, 100k etc. [default: 5000000]
  --bin                       Use binomial model for kmer coverages [default: negative binomial]

Mapping:
  -m,--max-diff INT           Maximum distance (bp) between consecutive hits within a cluster [default: 250]
  -c,--min-cluster-size INT   Minimum size of a cluster of hits between a read and a loci to consider the loci present [default: 10]

Preset:
  -I,--illumina               Reads are from Illumina. Alters error rate used and adjusts for shorter reads

Filtering:
  --clean                     Add a step to clean and detangle the pangraph
  --max-covg INT              Maximum coverage of reads to accept [default: 300]

Consensus/Variant Calling:
  --genotype                  Add extra step to carefully genotype sites.
  --kmer-avg INT              Maximum number of kmers to average over when selecting the maximum likelihood path [default: 100]

Genotyping:
  --local Needs: --genotype   (Intended for developers) Use coverage-oriented (local) genotyping instead of the default ML path-oriented (global) approach.
  -a INT                      Hard threshold for the minimum allele coverage allowed when genotyping [default: 0]
  -s INT                      The minimum required total coverage for a site when genotyping [default: 0]
  -D INT                      Minimum difference in coverage on a site required between the first and second maximum likelihood path [default: 0]
  -F INT                      Minimum allele coverage, as a fraction of the expected coverage, allowed when genotyping [default: 0]
  -E,--gt-error-rate FLOAT    When genotyping, assume that coverage on alternative alleles arises as a result of an error process with rate -E. [default: 0.01]
  -G,--gt-conf INT            Minimum genotype confidence (GT_CONF) required to make a call [default: 1]
```


## pandora_discover

### Tool Description
Quasi-map reads to an indexed PRG, infer the sequence of present loci in the sample and discover novel variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Quasi-map reads to an indexed PRG, infer the sequence of present loci in the sample and discover novel variants.
Usage: /usr/local/bin/pandora discover [OPTIONS] <TARGET> <QUERY_IDX>

Positionals:
  <TARGET> FILE [required]    An indexed PRG file (in fasta format)
  <QUERY_IDX> FILE [required] A tab-delimited file where each line is a sample identifier followed by the path to the fast{a,q} of reads for that sample

Options:
  -h,--help                   Print this help message and exit
  --discover-k INT:[0-32)     K-mer size to use when discovering novel variants [default: 15]
  --max-ins INT               Max. insertion size for novel variants. Warning: setting too long may impair performance [default: 15]
  --covg-threshold INT        Positions with coverage less than this will be tagged for variant discovery [default: 3]
  -l INT                      Min. length of consecutive positions below coverage threshold to trigger variant discovery [default: 1]
  -L INT                      Max. length of consecutive positions below coverage threshold to trigger variant discovery [default: 30]
  -d,--merge INT              Merge candidate variant intervals within distance [default: 15]
  -N INT                      Maximum number of candidate variants allowed for a candidate region [default: 25]
  --min-dbg-dp INT            Minimum node/kmer depth in the de Bruijn graph used for discovering variants [default: 2]
  -v                          Verbosity of logging. Repeat for increased verbosity

Indexing:
  -w INT                      Window size for (w,k)-minimizers (must be <=k) [default: 14]
  -k INT                      K-mer size for (w,k)-minimizers [default: 15]

Input/Output:
  -o,--outdir DIR             Directory to write output files to [default: "pandora_discover"]
  -t,--threads INT            Maximum number of threads to use [default: 1]
  --kg                        Save kmer graphs with forward and reverse coverage annotations for found loci
  -M,--mapped-reads           Save a fasta file for each loci containing read parts which overlapped it

Parameter Estimation:
  -e,--error-rate FLOAT       Estimated error rate for reads [default: 0.11]
  -g,--genome-size STR/INT    Estimated length of the genome - used for coverage estimation. Can pass string such as 4.4m, 100k etc. [default: 5000000]
  --bin                       Use binomial model for kmer coverages [default: negative binomial]

Mapping:
  -m,--max-diff INT           Maximum distance (bp) between consecutive hits within a cluster [default: 250]
  -c,--min-cluster-size INT   Minimum size of a cluster of hits between a read and a loci to consider the loci present [default: 10]

Preset:
  -I,--illumina               Reads are from Illumina. Alters error rate used and adjusts for shorter reads

Filtering:
  --clean                     Add a step to clean and detangle the pangraph
  --clean-dbg                 Clean the local assembly de Bruijn graph
  --max-covg INT              Maximum coverage of reads to accept [default: 600]

Consensus/Variant Calling:
  --kmer-avg INT              Maximum number of kmers to average over when selecting the maximum likelihood path [default: 100]
```


## pandora_walk

### Tool Description
Outputs a path through the nodes in a PRG corresponding to the either an input sequence (if it exists) or the top/bottom path

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Outputs a path through the nodes in a PRG corresponding to the either an input sequence (if it exists) or the top/bottom path
Usage: /usr/local/bin/pandora walk [OPTIONS] <PRG>

Positionals:
  <PRG> FILE [required]       A PRG file (in fasta format)

Options:
  -h,--help                   Print this help message and exit
  -i,--input FILE Excludes: --top --bottom
                              Fast{a,q} of sequences to output paths through the PRG for
  -T,--top Excludes: --input --bottom
                              Output the top path through each local PRG
  -B,--bottom Excludes: --input --top
                              Output the bottom path through each local PRG
```


## pandora_seq2path

### Tool Description
For each sequence, return the path through the PRG

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
For each sequence, return the path through the PRG
Usage: /usr/local/bin/pandora seq2path [OPTIONS] <PRG>

Positionals:
  <PRG> FILE [required]       PRG to index (in fasta format)

Options:
  -h,--help                   Print this help message and exit
  -i,--input FILE Excludes: --top --bottom
                              Fast{a,q} of sequences to output paths through the PRG for
  -w INT                      Window size for (w,k)-minimizers (must be <=k) [default: 14]
  -k INT                      K-mer size for (w,k)-minimizers [default: 15]
  -T,--top Excludes: --input --bottom
                              Output the top path through each local PRG
  -B,--bottom Excludes: --input --top
                              Output the bottom path through each local PRG
  --flag Needs: --input       output success/fail rather than the node path
  -v                          Verbosity of logging. Repeat for increased verbosity
```


## pandora_get_vcf_ref

### Tool Description
Outputs a fasta suitable for use as the VCF reference using input sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Outputs a fasta suitable for use as the VCF reference using input sequences
Usage: /usr/local/bin/pandora get_vcf_ref [OPTIONS] <PRG> [<QUERY>]

Positionals:
  <PRG> FILE [required]       PRG to index (in fasta format)
  <QUERY> FILE                Fast{a,q} file of sequences to retrive the PRG reference for

Options:
  -h,--help                   Print this help message and exit
  -z,--compress               Compress the output with gzip
  -v                          Verbosity of logging. Repeat for increased verbosity
```


## pandora_random

### Tool Description
Outputs a fasta of random paths through the PRGs

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Outputs a fasta of random paths through the PRGs
Usage: /usr/local/bin/pandora random [OPTIONS] <PRG>

Positionals:
  <PRG> FILE [required]       PRG to generate random paths from

Options:
  -h,--help                   Print this help message and exit
  -n INT                      Number of paths to output [default: 1]
  -z,--compress               Compress the output with gzip
  -v                          Verbosity of logging. Repeat for increased verbosity
```


## pandora_merge_index

### Tool Description
Allows multiple indices to be merged (no compatibility check)

### Metadata
- **Docker Image**: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
- **Homepage**: https://github.com/rmcolq/pandora
- **Package**: https://anaconda.org/channels/bioconda/packages/pandora/overview
- **Validation**: PASS

### Original Help Text
```text
Allows multiple indices to be merged (no compatibility check)
Usage: /usr/local/bin/pandora merge_index [OPTIONS] <IDX>...

Positionals:
  <IDX> FILES [required]      Indices to merge

Options:
  -h,--help                   Print this help message and exit
  -o,--outfile FILE           Filename for merged index [default: "merged_index.idx"]
  -v                          Verbosity of logging. Repeat for increased verbosity
```


## Metadata
- **Skill**: generated
