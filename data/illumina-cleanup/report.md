# illumina-cleanup CWL Generation Report

## illumina-cleanup

### Tool Description
v1.0.0

### Metadata
- **Docker Image**: quay.io/biocontainers/illumina-cleanup:1.0.0--0
- **Homepage**: https://github.com/rpetit3/illumina-cleanup
- **Package**: https://anaconda.org/channels/bioconda/packages/illumina-cleanup/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/illumina-cleanup/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/illumina-cleanup
- **Stars**: N/A
### Original Help Text
```text
N E X T F L O W  ~  version 19.01.0
Launching `/usr/local/bin/illumina-cleanup` [infallible_curie] - revision: a3db52e6a6

illumina-cleanup v1.0.0
Usage: illumina-cleanup --fastqs input_fastqs.txt --max_cpus 8

Requirements: bbmap fastqc fastq-scan lighter nextflow pigz

Required Parameters:
    --fastqs STR        An input file containing the sample name and absolute
                            paths to FASTQs to process.


Optional Parameters:
    --coverage INT      Reduce samples to a given coverage. (Default: 100)

    --genome_size INT   Expected genome size (bp) for all samples. (Default: 0).

    --outdir DIR        Directory to write results to. (Default ./)

    --max_cpus INT       The maximum number of processors this workflow should
                             have access to at any given moment. (Default: 1)

    --cpus INT          Number of processors made available to a single process.
                            If greater than "--max_cpus" it will be set equal to
                            "--max_cpus" (Default: 1)

    --example_fastqs    Print an example of expected input for FASTQs file.

    --check_fastqs      Verify "--fastqs" produces the expected inputs.

    --keep_cache        Keeps 'work' and '.nextflow' logs, default is to
                            delete on successful completion.

BBDuk Parameters:
    --adapters FASTA    Illumina adapters to remove (Default: BBmap adapters)

    --adapter_k INT     Kmer length used for finding adapters. Adapters
                            shorter than k will not be found. (Default: 23)

    --phix FASTA        phiX174 reference genome to remove (Default: NC_001422)

    --phix_k INT        Kmer length used for finding phiX174. Contaminants
                            shorter than k will not be found. (Default: 31)

    --ktrim STR         Trim reads to remove bases matching reference kmers.
                            Values:
                                f (do not trim)
                                r (trim to the right, Default)
                                l (trim to the left)

    --mink INT          Look for shorter kmers at read tips down to this
                            length, when k-trimming or masking. 0 means
                            disabled. Enabling this will disable maskmiddle.
                            (Default: 11)

    --hdist INT         Maximum Hamming distance for ref kmers (subs only).
                            Memory use is proportional to (3*K)^hdist.
                            (Default: 1)

    --tpe BOOL          When kmer right-trimming, trim both reads to the
                            minimum length of either.
                            Values:
                                f (do not equally trim)
                                t (equally trim to the right, Default)

    --tbo BOOL          Trim adapters based on where paired reads overlap.
                            Values:
                                f (do not trim by overlap)
                                t (trim by overlap, Default)

    --qtrim STR         Trim read ends to remove bases with quality below
                            trimq. Performed AFTER looking for kmers. Values:
                                rl (trim both ends, Default)
                                f (neither end)
                                r (right end only)
                                l (left end only)
                                w (sliding window)

    --trimq FLOAT       Regions with average quality BELOW this will be
                            trimmed if qtrim is set to something other than f.
                            (Default: 6)

    --maq INT           Reads with average quality (after trimming) below
                            this will be discarded. (Default: 20)

    --minlength INT     Reads shorter than this after trimming will be
                            discarded. Pairs will be discarded if both are
                            shorter. (Default: 35)

    --ftm INT           If positive, right-trim length to be equal to zero,
                            modulo this number. (Default: 0)

    --tossjunk          Discard reads with invalid characters as bases.
                            Values:
                                f (keep all reads)
                                t (toss reads with ambiguous bases, Default)

    --qout STR          Output quality offset.
                            Values:
                                33 (PHRED33 offset quality scores, Default)
                                64 (PHRED64 offset quality scores)
                                auto (keeps the current input offset)

    --xmx STR           This will be passed to Java to set memory usage.
                            Examples:
                                8g will specify 8 gigs of RAM (Default)
                                20g will specify 20 gigs of RAM
                                200m will specify 200 megs of RAM

Lighter Parameters:
    --maxcor INT        Max number of corrections within a 20bp window
                            (Default: 1)

Reformat (BBmap) Parameters:
    --sampleseed INT    Set to a positive number to use that prng seed for
                            sampling (Default 42).

    --version           Print workflow version information
    --help              Show this message and exit
```

