# paragraph CWL Generation Report

## paragraph

### Tool Description
Graph-based structural variant caller and sequence aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
- **Homepage**: https://github.com/Illumina/paragraph
- **Package**: https://anaconda.org/channels/bioconda/packages/paragraph/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/paragraph/overview
- **Total Downloads**: 13.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Illumina/paragraph
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
paragraph -r <reference> -g <graph(s)> -b <input cram(s)/bam(s)> [optional arguments]

Command line options:
  --bad-align-frac arg (=0.800000012)          Fraction of read that needs to 
                                               be mapped in order for it to be 
                                               used.
  --bad-align-nonuniq arg (=1)                 Remove reads that are not mapped
                                               uniquely.
  --bad-align-uniq-kmer-len arg (=0)           Kmer length for uniqueness check
                                               during read filtering.
  -b [ --bam ] arg                             Input BAM file(s) for read 
                                               extraction. We align all reads 
                                               to all graphs.
  --graph-sequence-matching arg (=1)           Enables smith waterman graph 
                                               alignment
  -g [ --graph-spec ] arg                      JSON file(s) describing the 
                                               graph(s)
  -z [ --gzip-output ] [=arg(=1)] (=0)         gzip-compress output files. If 
                                               -O is used, output file names 
                                               are appended with .gz
  -h [ --help ]                                produce help message and exit
  --help-defaults                              produce tab-delimited list of 
                                               command line options and their 
                                               default values
  --help-md                                    produce help message 
                                               pre-formatted as a markdown file
                                               section and exit
  --klib-sequence-matching arg (=0)            Use klib smith-waterman aligner.
  --kmer-sequence-matching arg (=0)            Use kmer aligner.
  --log-async arg (=0)                         Enable / disable async logging.
  --log-file arg                               Log to a file instead of stderr.
  --log-level arg (=info)                      Set log level (error, warning, 
                                               info).
  -M [ --max-reads-per-event ] arg (=10000)    Maximum number of reads to 
                                               process for a single event.
  -a [ --output-alignments ] arg (=0)          Output alignments for every read
                                               (large).
  --output-detailed-read-counts arg (=0)       Output detailed read counts not 
                                               just for paths but also for each
                                               node/edge on the paths.
  -E [ --output-everything ] arg (=0)          Write all information we have 
                                               into JSON. (=enable all 
                                               --output-* above)
  -o [ --output-file ] arg                     Output file name. Will output to
                                               stdout if '-' or neither of 
                                               output-file or output-folder 
                                               provided.
  -A [ --output-filtered-alignments ] arg (=0) Output alignments for every read
                                               even when it was filtered 
                                               (larger).
  -O [ --output-folder ] arg                   Output folder path. paragraph 
                                               will attempt to create the 
                                               folder but not the entire path. 
                                               Will output to stdout if neither
                                               of output-file or output-folder 
                                               provided. If specified, 
                                               paragraph will produce one 
                                               output file for each input file 
                                               bearing the same name.
  --output-node-coverage arg (=0)              Output coverage for nodes
  --output-path-coverage arg (=0)              Output coverage for paths
  --output-read-haplotypes arg (=0)            Output graph haplotypes 
                                               supported by reads.
  -v [ --output-variants ] arg (=0)            Output variants not present in 
                                               the graph.
  --path-sequence-matching arg (=1)            Enable path seeding aligner
  -r [ --reference ] arg                       Reference genome fasta file.
  --response-file arg                          file with more command line 
                                               arguments
  -T [ --target-regions ] arg                  Comma-separated list of target 
                                               regions, e.g. chr1:1-20,chr2:2-4
                                               0. This overrides the target 
                                               regions in the graph spec.
  --threads arg (=40)                          Number of threads to use for 
                                               parallel alignment.
  --validate-alignments [=arg(=1)] (=0)        Use information in the input bam
                                               read names to collect statistics
                                               about the accuracy of 
                                               alignments. Requires bam file 
                                               produced with simulate-reads.sh
  --variant-min-frac arg (=0.00999999978)      Minimum fraction of reads 
                                               required to report a variant.
  --variant-min-reads arg (=3)                 Minimum number of reads required
                                               to report a variant.
  -v [ --version ]                             print program version 
                                               information


Failed to parse the options: Throw location unknown (consider using BOOST_THROW_EXCEPTION)
Dynamic exception type: boost::wrapexcept<boost::program_options::ambiguous_option>
std::exception::what: option '--h' is ambiguous and matches '--help', '--help-defaults', and '--help-md'
```


## Metadata
- **Skill**: generated

## paragraph_multigrmpy.py

### Tool Description
A tool for graph-based genotyping of variants using a manifest of samples and a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
- **Homepage**: https://github.com/Illumina/paragraph
- **Package**: https://anaconda.org/channels/bioconda/packages/paragraph/overview
- **Validation**: PASS
### Original Help Text
```text
usage: Multigrmpy.py [-h] -i INPUT -m MANIFEST -o OUTPUT [-A]
                     [--infer-read-haplotypes] -r REFERENCE
                     [--threads THREADS] [--keep-scratch]
                     [--scratch-dir SCRATCH_DIR] [--grmpy GRMPY]
                     [--logfile LOGFILE]
                     [--graph-sequence-matching GRAPH_SEQUENCE_MATCHING]
                     [--klib-sequence-matching KLIB_SEQUENCE_MATCHING]
                     [--kmer-sequence-matching KMER_SEQUENCE_MATCHING]
                     [--bad-align-uniq-kmer-len BAD_ALIGN_UNIQ_KMER_LEN]
                     [--no-alt-splitting] [--verbose | --quiet | --debug]
                     [-G GENOTYPING_PARAMETERS | -M MAX_READS_PER_EVENT]
                     [--vcf-split {lines,full,by_id,superloci} | -p READ_LENGTH | -l MAX_REF_NODE_LENGTH | --retrieve-reference-sequence | --graph-type {alleles,haplotypes} | --ins-info-key INS_INFO_KEY]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input file of variants. Must be either JSON or VCF.
  -m MANIFEST, --manifest MANIFEST
                        Manifest of samples with path and bam stats.
  -o OUTPUT, --output OUTPUT
                        Output directory.
  -A, --write-alignments
                        Write alignment JSON files into the output folder
                        (large!).
  --infer-read-haplotypes
                        Infer read haplotype paths
  -r REFERENCE, --reference-sequence REFERENCE
                        Reference genome fasta file.
  --threads THREADS, -t THREADS
                        Number of events to process in parallel.
  --keep-scratch        Do not delete temp files.
  --scratch-dir SCRATCH_DIR
                        Directory for temp files
  --grmpy GRMPY         Path to the grmpy executable
  --logfile LOGFILE     Write logging information into file rather than to
                        stderr
  --graph-sequence-matching GRAPH_SEQUENCE_MATCHING
                        Use graph aligner.
  --klib-sequence-matching KLIB_SEQUENCE_MATCHING
                        Use klib smith waterman aligner.
  --kmer-sequence-matching KMER_SEQUENCE_MATCHING
                        Use kmer aligner.
  --bad-align-uniq-kmer-len BAD_ALIGN_UNIQ_KMER_LEN
                        Kmer length for uniqueness check during read
                        filtering.
  --no-alt-splitting    Keep long insertion sequences in the graph rather than
                        trimming them at the read / padding length.
  --verbose             Raise logging level from warning to info.
  --quiet               Set logging level to output errors only.
  --debug               Log debug level events.
  -G GENOTYPING_PARAMETERS, --genotyping-parameters GENOTYPING_PARAMETERS
                        JSON string or file with genotyping model parameters.
  -M MAX_READS_PER_EVENT, --max-reads-per-event MAX_READS_PER_EVENT
                        Maximum number of reads to process for a single event.
  --vcf-split {lines,full,by_id,superloci}
                        Mode for splitting the input VCF: lines (default) --
                        one graph per record ; full -- one graph for the whole
                        VCF ; by_id -- use the VCF id column to group adjacent
                        records ; superloci -- split VCF into blocks where
                        records are separated by at least read-length
                        characters
  -p READ_LENGTH, --read-length READ_LENGTH
                        Read length -- this is used to add reference padding
                        when converting VCF to graphs.
  -l MAX_REF_NODE_LENGTH, --max-ref-node-length MAX_REF_NODE_LENGTH
                        Maximum length of reference nodes before they get
                        padded and truncated.
  --retrieve-reference-sequence
                        Retrieve reference sequence for REF nodes
  --graph-type {alleles,haplotypes}
                        Type of complex graph to generate. Same as --graph-
                        type in vcf2paragraph.
  --ins-info-key INS_INFO_KEY
                        Key in INFO field to indicate sequence of symbolic
                        <INS>
```

## paragraph_grmpy

### Tool Description
Graph-based read mapping and genotyping for structural variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
- **Homepage**: https://github.com/Illumina/paragraph
- **Package**: https://anaconda.org/channels/bioconda/packages/paragraph/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
grmpy -r <reference> -g <graphs> -m <manifest> [optional arguments]

Command line options:
  -A [ --alignment-output-folder ] arg      Output folder for alignments. Note 
                                            these can become very large and are
                                            only requiredfor curation / 
                                            visualisation or faster reanalysis.
  --bad-align-frac arg (=0.800000012)       Fraction of read that needs to be 
                                            mapped in order for it to be used.
  --bad-align-uniq-kmer-len arg (=0)        Kmer length for uniqueness check 
                                            during read filtering.
  -G [ --genotyping-parameters ] arg        JSON file with genotyping model 
                                            parameters
  --graph-sequence-matching arg (=1)        Enables smith waterman graph 
                                            alignment
  -g [ --graph-spec ] arg                   JSON file(s) describing the 
                                            graph(s)
  -z [ --gzip-output ] [=arg(=1)] (=0)      gzip-compress output files. If -O 
                                            is used, output file names are 
                                            appended with .gz
  -h [ --help ]                             produce help message and exit
  --help-defaults                           produce tab-delimited list of 
                                            command line options and their 
                                            default values
  --help-md                                 produce help message pre-formatted 
                                            as a markdown file section and exit
  --infer-read-haplotypes [=arg(=1)] (=0)   Infer haplotype paths using read 
                                            and fragment information.
  --klib-sequence-matching arg (=0)         Use klib smith-waterman aligner.
  --kmer-sequence-matching arg (=0)         Use kmer aligner.
  --log-async arg (=0)                      Enable / disable async logging.
  --log-file arg                            Log to a file instead of stderr.
  --log-level arg (=info)                   Set log level (error, warning, 
                                            info).
  -m [ --manifest ] arg                     Manifest of samples with path and 
                                            bam stats.
  -M [ --max-reads-per-event ] arg (=10000) Maximum number of reads to process 
                                            for a single event.
  -o [ --output-file ] arg                  Output file name. Will output to 
                                            stdout if omitted or '-'.
  -O [ --output-folder ] arg                Output folder path. paragraph will 
                                            attempt to create the folder but 
                                            not the entire path. Will output to
                                            stdout if neither of output-file or
                                            output-folder provided. If 
                                            specified, paragraph will produce 
                                            one output file for each input file
                                            bearing the same name.
  --path-sequence-matching arg (=0)         Enables alignment to paths
  --progress [=arg(=1)] (=1)
  -r [ --reference ] arg                    Reference genome fasta file.
  --response-file arg                       file with more command line 
                                            arguments
  -t [ --sample-threads ] arg (=40)         Number of threads for parallel 
                                            sample processing.
  -v [ --version ]                          print program version information


Failed to parse the options: Throw location unknown (consider using BOOST_THROW_EXCEPTION)
Dynamic exception type: boost::wrapexcept<boost::program_options::ambiguous_option>
std::exception::what: option '--h' is ambiguous and matches '--help', '--help-defaults', and '--help-md'
```

## paragraph_idxdepth

### Tool Description
Estimate coverage depth from BAM/CRAM files using index information.

### Metadata
- **Docker Image**: quay.io/biocontainers/paragraph:2.3--h8908b6f_0
- **Homepage**: https://github.com/Illumina/paragraph
- **Package**: https://anaconda.org/channels/bioconda/packages/paragraph/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Allowed options:
  -h [ --help ]                         produce help message
  -b [ --bam ] arg                      BAM / CRAM input file
  --bam-index arg                       BAM / CRAM index file when not at 
                                        default location.
  -o [ --output ] arg                   Output file name. Will output to stdout
                                        if omitted.
  -O [ --output-bins ] arg              Output binned coverage in tsv format.
  -r [ --reference ] arg                FASTA with reference genome
  --altcontig arg (=0)                  Include ALT contigs in estimation
  -I [ --include-regex ] arg            Regex to identify contigs to include
  --autosome-regex arg (=(chr)?[1-9][0-9]?)
                                        Regex to identify autosome chromosome 
                                        names (default: '(chr)?[1-9][0-9]?'
  --sex-chromosome-regex arg (=(chr)?[XY]?)
                                        Regex to identify sex chromosome names 
                                        (default: '(chr)?[XY]?'
  --threads arg (=40)                   Number of threads to use for parallel 
                                        estimation.
  --log-level arg (=info)               Set log level (error, warning, info).
  --log-file arg                        Log to a file instead of stderr.
  --log-async arg (=1)                  Enable / disable async logging.
```

