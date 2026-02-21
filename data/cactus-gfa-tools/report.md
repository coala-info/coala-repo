# cactus-gfa-tools CWL Generation Report

## cactus-gfa-tools

### Tool Description
FAIL to generate CWL: cactus-gfa-tools not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Total Downloads**: 489
- **Last updated**: 2025-08-22
- **GitHub**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: cactus-gfa-tools not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: cactus-gfa-tools not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## cactus-gfa-tools_gaf2paf

### Tool Description
Convert minigraph GAF to PAF

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/gaf2paf: option requires an argument -- 'h'
usage: /usr/local/bin/gaf2paf [options] <gaf> [gaf2] [gaf3] [...] > output.paf
Convert minigraph GAF to PAF

options: 
    -l, --lengths FILE      TSV with contig length as first two columns (.fai will do).
```

## cactus-gfa-tools_gaf2unstable

### Tool Description
Replace stable sequences in path steps, ex >chr1:500-1000, with the unstable graph node names, ex >s1:1-100>s2:100-600

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
usage: /usr/local/bin/gaf2unstable [options] <gaf> 
Replace stable sequences in path steps, ex >chr1:500-1000, with the unstable graph node names, ex >s1:1-100>s2:100-600

options: 
    -g, --rGFA FILE           (uncompressed) minigraph rGFA, required to look up unstable mappings
    -o, --out-lengths FILE    Output lengths of all minigraph sequences in given file (can be passed to gaf2paf)
```

## cactus-gfa-tools_gaffilter

### Tool Description
Filter GAF record if its query interval overlaps another query interval based on primary/secondary status, MAPQ ratio, or block length ratio.

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
/usr/local/bin/gaffilter: option requires an argument -- 'h'
usage: /usr/local/bin/gaffilter [options] <gaf> > output.gaf
Filter GAF record if its query interval overlaps another query interval and
  1) the record is secondary and the overlapping record is primary or
  2) the record's MAPQ is lower than {ratio, see -r} times the overlapping record's MAPQ or
  3) the record's block length is less than {ratio, see -r} times larger than the overlapping record's block length (and its MAPQ isn't higher)
  Also: the -o option can be used to mimic mzgaf2paf's query overlap filter

options: 
    -r, --ratio N                   If two query blocks overlap, and one is Nx bigger than the other, the bigger one is kept (otherwise both deleted) [0]
    -m, --min-overlap N             Ignore overlaps that consitute <N% of the length [0]
    -o, --min-overlap-length N      If >= 2 query regions with size >= N overlap, ignore the query region.  If 1 query region with size >= N overlaps any regions of size <= N, ignore the smaller ones only. Works separate to -r/-m but can be used in conjunction with them to combine the two filters (0 = disable) [0]
    -q, --min-mapq N                Don't let an interval with MAPQ < N cause something to be filtered out
    -b, --min-block-length N        Don't let an interval with block length < N cause something to be filtered out
    -i, --min-identity N            Don't let an interval with identity < N cause something to be filtered out
    -p, --paf                       Input is PAF, not GAF
```

## cactus-gfa-tools_rgfa-split

### Tool Description
Partition rGFA nodes into reference contigs. Input must be uncompressed GFA (not stdin)

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
usage: /usr/local/bin/rgfa-split [options]
Partition rGFA nodes into reference contigs.  Input must be uncompressed GFA (not stdin)
input options: 
    -g, --rgfa FILE                         rGFA to use as baseline for contig splitting (if not defined, minmap2 output assumed)
    -m, --input-contig-map FILE             Use tsv map (computed with -M) instead of rGFA
    -p, --paf FILE                          PAF file to split
    -B, --bed FILE                          BED file.  Used to subtract out softmasked regions when computing coverage (multiple allowed)
output options: 
    -b, --output-prefix PREFIX              All output files will be of the form <PREFIX><contig>.paf/.fa_contigs
    -M, --output-contig-map FILE            Output rgfa node -> contig map to this file
    -G, --split-gfa                         Split the input GFA too and output <PREFIX><config>.gfa files
contig selection options: 
    -q, --contig-prefix PREFIX              Only process contigs beginning with PREFIX
    -c, --contig-name NAME                  Only process NAME (multiple allowed)
    -C, --contig-file FILE                  Path to list of contigs to process
    -o, --other-name NAME                   Lump all contigs not selected by above options into single reference with name NAME
contig assignment ambiguity handling options: 
    -n, --min-query-coverage FLOAT          At least this fraction of input contig must align to reference contig for it to be assigned (can repeat)
    -T, --small-coverage-threshold N        Used to toggle between the coverage thresholds (-n). Should have one-fewer value than -n
    -Q, --min-query-uniqueness FLOAT        The ratio of the number of query bases aligned to the chosen ref contig vs the next best ref contig must exceed this threshold to not be considered ambigious
    -u, --min-query-chunk N                 I a query interval of >= N bp aligns to a reference with sufficient coverage, cut it out.  Disabled when 0. [0]
    -s, --allow-softclip                    Allow softclipping with -u
    -P, --max-gap N                         Count cigar gaps of length <= N towards coverage
    -a, --ambiguous-name NAME               All query contigs that do not meet min coverage (-n) assigned to single reference with name NAME
    -A, --min-mapq N                        Don't count PAF lines with MAPQ<N towards coverage
    -r, --reference-prefix PREFIX           Don't apply ambiguity filters to query contigs with this prefix
    -L, --log FILE                          Keep track of filtered and assigned contigs in given file [stderr]
```

## cactus-gfa-tools_paf2lastz

### Tool Description
Convert PAF(s) with cg cigars to LASTZ cigars

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
usage: /usr/local/bin/paf2lastz [options] <paf> [paf2] [paf3] [...] > output.cigar
Convert PAF(s) with cg cigars to LASTZ cigars

options: 
    -q, --mapq-score          Take score from MAPQ field (PAF column 12) instead of AS tag
    -s, --secondary-file      Separate out secondaries (tp tag == S) and write them to given path
```

## cactus-gfa-tools_mzgaf2paf

### Tool Description
Convert minigraph --write-mz output(s) to PAF

### Metadata
- **Docker Image**: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
- **Homepage**: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools
- **Package**: https://anaconda.org/channels/bioconda/packages/cactus-gfa-tools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
usage: /usr/local/bin/mzgaf2paf [options] <gaf> [gaf2] [gaf3] [...] > output.paf
Convert minigraph --write-mz output(s) to PAF

options: 
    -p, --target-prefix PREFIX          Prepend all target (graph) contig names with this prefix
    -b, --min-block-length N            Ignore records with block length (GAF col 11) (only applies if query length > N)< N [0]
    -q, --min-mapq N                    Ignore records with MAPQ (GAF col 12) < N [0]
    -g, --min-gap N                     Filter so that reported minimizer matches have >=N bases between them [0]
    -m, --min-match-len N               Only write matches (formed by overlapping/adjacent mz chains) with length < N
    -u, --universal-mz FLOAT            Filter minimizers that appear in fewer than this fraction of alignments to target [0]
    -n, --node-based-universal          Universal computed on entire node instead of mapped region
    -s, --min-node-length N             Ignore minimizers on GAF nodes of length < N [0]
    -i, --strict-unversal               Count mapq and block length filters against universal (instead of ignoring)
    -o, --min-overlap-length N          If >= query regions with size >= N overlap, ignore the query region.  If 1 query region with size >= N overlaps any regions of size <= N, ignore the smaller ones only. (0 = disable) [0]
```

