# mashmap CWL Generation Report

## mashmap

### Tool Description
Mashmap is an pproximate long read or contig mapper based on Jaccard similarity

### Metadata
- **Docker Image**: quay.io/biocontainers/mashmap:3.1.3--pl5321hb4818e0_2
- **Homepage**: https://github.com/marbl/MashMap
- **Package**: https://anaconda.org/channels/bioconda/packages/mashmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mashmap/overview
- **Total Downloads**: 32.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/marbl/MashMap
- **Stars**: N/A
### Original Help Text
```text
-----------------
Mashmap is an pproximate long read or contig mapper based on Jaccard similarity
-----------------
Example usage:
$ mashmap -r ref.fa -q seq.fq [OPTIONS]
$ mashmap --rl reference_files_list.txt -q seq.fq [OPTIONS]

Available options
-----------------
-h, --help
    Print this help page

-v, --version
    Print MashMap version

-r <value>, --ref <value>
    an input reference file (fasta/fastq)[.gz]

--refList <value>, --rl <value>
    a file containing list of reference files, one per line

-q <value>, --query <value>
    an input query file (fasta/fastq)[.gz]

--ql <value>, --queryList <value>
    a file containing list of query files, one per line

-s <value>, --segLength <value>
    mapping segment length [default : 5,000]
    sequences shorter than segment length will be ignored

-J <value>, --sketchSize <value>
    Number of sketch elements

--dense
    Use dense sketching to yield higher ANI estimation accuracy. [disabled by
    default]

--blockLength <value>, -l <value>
    keep merged mappings supported by homologies of at least this length
    [default: segmentLength]

-c <value>, --chainGap <value>
    chain mappings closer than this distance in query and target, retaining
    mappings in best chain [default: segmentLength]

-n <value>, --numMappingsForSegment <value>
    number of mappings to retain for each segment [default: 1]

--numMappingsForShortSeq <value>
    number of mappings to retain for each sequence shorter than segment length
    [default: 1]

--saveIndex <value>
    Prefix of index files to save. PREFIX.map and PREFIX.index files will be
    created

--loadIndex <value>
    Prefix of index files to load, where PREFIX.map and PREFIX.index are the
    files to be loaded

--noSplit
    disable splitting of input sequences during mapping [enabled by default]

--perc_identity <value>, --pi <value>
    threshold for identity [default : 85]

-K, --dropLowMapId
    drop mappings with estimated identity below --perc_identity=%

-t <value>, --threads <value>
    count of threads for parallel execution [default : 1]

-o <value>, --output <value>
    output file name [default : mashmap.out ]

-k <value>, --kmer <value>
    kmer size [default : 19]

--kmerThreshold <value>
    ignore the top % most-frequent kmer window [default: 0.001]

--kmerComplexity <value>
    threshold for kmer complexity [0, 1] [default : 0.0]

--noHgFilter
    Don't use the hypergeometric filtering and instead use the MashMap2 first
    pass filtering.

--hgFilterAniDiff <value>
    Filter out mappings unlikely to be this ANI less than the best mapping
    [default: 0.0]

--hgFilterConf <value>
    Confidence value for the hypergeometric filtering [default: 99.9%]

--filterLengthMismatches
    Filter mappings where the ratio of reference/query mapped lengths
    disagrees with the ANI threshold

--lowerTriangular
    Only map sequence i to sequence j if i > j.

-X, --skipSelf
    skip self mappings when the query and target name is the same (for
    all-vs-all mode)

-Y <value>, --skipPrefix <value>
    skip mappings when the query and target have the same prefix before the
    last occurrence of the given character C

--targetPrefix <value>
    Only index reference sequences beginning with this prefix

--targetList <value>
    file containing list of target sequence names

--sparsifyMappings <value>, -x <value>
    keep this fraction of mappings

-M, --noMerge
    don't merge consecutive segment-level mappings

-f <value>, --filter_mode <value>
    filter modes in mashmap: 'map', 'one-to-one' or 'none' [default: map]
    'map' computes best mappings for each query sequence
    'one-to-one' computes best mappings for query as well as reference sequence
    'none' disables filtering

--legacy
    MashMap2 output format

--reportPercentage
    Report predicted ANI values in [0, 100] instead of [0,1] (necessary for
    use with wfmash)
```

