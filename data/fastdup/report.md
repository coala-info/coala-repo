# fastdup CWL Generation Report

## fastdup

### Tool Description
Identifies duplicate reads. This tool locates and tags duplicate reads in a coordinate ordered SAM or BAM file.
Use the same algorithm as picard MarkDuplicates and output identical results.
Use spdlog as log tool and the default level is 'info'.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastdup:1.0.0--hc033996_0
- **Homepage**: https://github.com/zzhofict/FastDup
- **Package**: https://anaconda.org/channels/bioconda/packages/fastdup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastdup/overview
- **Total Downloads**: 641
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/zzhofict/FastDup
- **Stars**: N/A
### Original Help Text
```text
Usage: FastDup --input <INPUT> --metrics <METRICS> --output <OUTPUT> [--num-threads <NUM_THREADS>] [--none-duplex-io] [--create-index] [--index-format <IndexFormat>] [--remove-duplicates] [--duplicate-scoring-strategy <ScoringStrategy>] [--optical-duplicate-pixel-distance <Integer>] [--read-name-regex <ReadNameRegex>] [--tag-duplicate-set-members] [--tagging-policy <DuplicateTaggingPolicy>] [--help] [--version]

Identifies duplicate reads. This tool locates and tags duplicate reads in a coordinate ordered SAM or BAM file.
Use the same algorithm as picard MarkDuplicates and output identical results.
Use spdlog as log tool and the default level is 'info'.

Optional arguments:
  --input <INPUT>                                 Input file. One coordinate ordered SAM or BAM file. [required]
  --metrics <METRICS>                             Metrics file. File to write duplication metrics to. [required]
  --output <OUTPUT>                               Output file. SAM or BAM file to write marked records to. [required]
  --num-threads <NUM_THREADS>                     Number of threads to use. [default: 1]
  --none-duplex-io                                Do not use writing-while-reading mode. 
  --create-index                                  Whether to create an index when writing coordinate sorted BAM output. 
  --index-format <IndexFormat>                    Format for bam index file. Possible values: {BAI, CSI} [default: "BAI"]
  --remove-duplicates                             If true do not write duplicates to the output file instead of writing them with appropriate flags set. 
  --duplicate-scoring-strategy <ScoringStrategy>  The scoring strategy for choosing the non-duplicate among candidates. Possible values: {SUM_OF_BASE_QUALITIES, TOTAL_MAPPED_REFERENCE_LENGTH, RANDOM} [default: "SUM_OF_BASE_QUALITIES"]
  --optical-duplicate-pixel-distance <Integer>    
                                                  The maximum offset between two duplicate clusters in order to consider them opticalduplicates. The default is appropriate for unpatterned versions of the Illumina platform.For the patterned flowcell models, 2500 is moreappropriate. For other platforms andmodels, users should experiment to find what works best. [default: 100]
  --read-name-regex <ReadNameRegex>               
                                                  MarkDuplicates can use the tile and cluster positions to estimate the rate of optical duplication in addition to the dominant source of duplication, PCR, to provide a more accurate estimation of library size. By default (with no READ_NAME_REGEX specified), MarkDuplicates will attempt to extract coordinates using a split on ':' (see Note below). Set READ_NAME_REGEX to 'null' to disable optical duplicate detection. Note that without optical duplicate counts, library size estimation will be less accurate. If the read name does not follow a standard Illumina colon-separation convention, but does contain tile and x,y coordinates, a regular expression can be specified to extract three variables: tile/region, x coordinate and y coordinate from a read name. The regular expression must contain three capture groups for the three variables, in order. It must match the entire read name.   e.g. if field names were separated by semi-colon (';') this example regex could be specified      (?:.*;)?([0-9]+)[^;]*;([0-9]+)[^;]*;([0-9]+)[^;]*$ Note that if no READ_NAME_REGEX is specified, the read name is split on ':'.   For 5 element names, the 3rd, 4th and 5th elements are assumed to be tile, x and y values.   For 7 element names (CASAVA 1.8), the 5th, 6th, and 7th elements are assumed to be tile, x and y values. Default value: <optimized capture of last three ':' separated fields as numeric values>. [default: "(?:.*:)?([0-9]+)[^:]*:([0-9]+)[^:]*:([0-9]+)[^:]*$"]
  --tag-duplicate-set-members                     
                                                  If a read appears in a duplicate set, add two tags. The first tag, DUPLICATE_SET_SIZE_TAG(DS), indicates the size of the duplicate set. The smallest possible DS value is 2 whichoccurs when two reads map to the same portion of the reference only one of which is markedas duplicate. The second tag, DUPLICATE_SET_INDEX_TAG (DI), represents a unique identifierfor the duplicate set to which the record belongs. This identifier is the index-in-file ofthe representative read that was selected out of the duplicate set. 
  --tagging-policy <DuplicateTaggingPolicy>       Determines how duplicate types are recorded in the DT optional attribute. Possible values: {DontTag, OpticalOnly, All}. [default: "DontTag"]
  -h, --help                                      shows help message and exits 
  -v, --version                                   prints version information and exits
```

