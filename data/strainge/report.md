# strainge CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| strainge_cluster | PASS |  |
| strainge_compare | PASS |  |
| strainge_createdb | PASS |  |
| strainge_kmerize | PASS |  |
| strainge_kmersim | PASS |  |
| strainge_plot | PASS |  |
| strainge_stats | PASS |  |
| strainge_straingr_call | PASS |  |
| strainge_straingr_dist | PASS |  |
| strainge_straingr_prepare_ref | Failed | image problem: needs MUMmer (nucmer), which is missing in the image; the command stops with a FileNotFoundError |
| strainge_straingst_kmermerge | PASS |  |
| strainge_straingst_run | PASS |  |
| strainge_tree | PASS |  |
| strainge_view | PASS |  |

## strainge_kmerize

### Tool Description
K-merize a given reference sequence or a sample read dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge kmerize [-h] [-k K] -o OUTPUT [-f FINGERPRINT_FRACTION] [-F]
                        [-l LIMIT] [-p PRUNE]
                        sequences [sequences ...]

K-merize a given reference sequence or a sample read dataset.

positional arguments:
  sequences             Input sequence files (fasta or fastq by default;
                        optionally compressed with gz or bz2)

optional arguments:
  -h, --help            show this help message and exit
  -k K, --k K           K-mer size (default 23)
  -o OUTPUT, --output OUTPUT
                        Filename of the output HDF5.
  -f FINGERPRINT_FRACTION, --fingerprint-fraction FINGERPRINT_FRACTION
                        Fraction of k-mers to keep for a minhash sketch.
                        Default: 0.01. No fingerprint will be created if set
                        to zero.
  -F, --filter          Filter output kmers based on kmer spectrum (to prune
                        sequencing errors)
  -l LIMIT, --limit LIMIT
                        Only process about this many kmers (can have suffix of
                        M or G)
  -p PRUNE, --prune PRUNE
                        Prune singletons after accumulating this (can have
                        suffix of M or G)
```

## strainge_kmersim

### Tool Description
Compare k-mer sets with each other. Both all-vs-all and one-vs-all is supported.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge kmersim [-h] (-a | -s FILE) [-f]
                        [-S {jaccard,minsize,meansize,maxsize,subset,reference}]
                        [-t THREADS] [-o FILE]
                        strains [strains ...]

Compare k-mer sets with each other. Both all-vs-all and one-vs-all is
supported.

positional arguments:
  strains               Filenames of k-mer set HDF5 files.

optional arguments:
  -h, --help            show this help message and exit
  -a, --all-vs-all      Perform all-vs-all comparisons for the given k-mer
                        sets. Either --all-vs-all is required or --sample.
  -s FILE, --sample FILE
                        Perform one-vs-all comparisons with the given filename
                        as sample. Either --all-vs-all is required or
                        --sample.
  -f, --full-db         Use full k-mer set instead of min-hash fingerprint.
  -S {jaccard,minsize,meansize,maxsize,subset,reference}, --scoring {jaccard,minsize,meansize,maxsize,subset,reference}
                        The scoring metric to use (default: jaccard). Can be
                        used multiple times to include multiple scoring
                        metrics. Choices: jaccard, minsize, meansize, maxsize,
                        subset, reference.
  -t THREADS, --threads THREADS
                        Use multiple processes the compute the similarity
                        scores (default 1).
  -o FILE, --output FILE
                        File to write the results (default: standard output).
```

## strainge_cluster

### Tool Description
Group k-mer sets that are very similar to each other together.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge cluster [-h] [-c CUTOFF] [-i FILE] [-d] [-C CONTAINED_CUTOFF]
                        [-w ANI] [-p FILE] [-o FILE] [--clusters-out FILE]
                        kmerset [kmerset ...]

Group k-mer sets that are very similar to each other together.

positional arguments:
  kmerset               The list of HDF5 filenames of k-mer sets to cluster.

optional arguments:
  -h, --help            show this help message and exit
  -c CUTOFF, --cutoff CUTOFF
                        Minimum similarity between two sets to group them
                        together.
  -i FILE, --similarity-scores FILE
                        The file with the similarity scores between kmersets
                        (the output of 'strainge compare --all-vs-all').
                        Defaults to standard input.
  -d, --discard-contained
                        Discard k-mersets that are a subset of another
                        k-merset. Requires 'subset' scoring metric in the
                        similarity scores TSV files.
  -C CONTAINED_CUTOFF, --contained-cutoff CONTAINED_CUTOFF
                        Minimum fraction of kmers to be present in another
                        genome to discard it.
  -w ANI, --warn-too-distant ANI
                        Warn when including references that that seem too
                        distantly related, which could indicate a mislabeled
                        reference genome. Default: 85% ANI.
  -p FILE, --priorities FILE
                        An optional TSV file where the first column represents
                        the ID of a reference kmerset, and the second an
                        integer indicating the priority for clustering.
                        References with higher priority get precedence over
                        references with lower priority in the same cluster.
  -o FILE, --output FILE
                        The file where the list of kmersets to keep after
                        clustering gets written. Defaults to standard output.
  --clusters-out FILE   Output an optional tab separated file with all
                        clusters and their entries.
```

## strainge_createdb

### Tool Description
Create pan-genome database in HDF5 format from a list of k-merized strains.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge createdb [-h] [-o OUTPUT] [-f FILE] [kmerset [kmerset ...]]

Create pan-genome database in HDF5 format from a list of k-merized
strains.

positional arguments:
  kmerset               The HDF5 filenames of the kmerized reference strains.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Pan-genome database output HDF5 file.
  -f FILE, --from-file FILE
                        Read list of HDF5 filenames to include in the database
                        from a given file (use '-' to denote standard input).
                        This is in addition to any k-merset given as
                        positional argument.
```

## strainge_view

### Tool Description
View call statistics stored in a HDF5 file and output results to different file formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge view [-h] [-s FILE] [-t TRACKS] [-p PATH]
                     [--track-min-size TRACK_MIN_SIZE] [-G MIN_GAP] [-V FILE]
                     [--verbose-vcf LEVEL]
                     hdf5

View call statistics stored in a HDF5 file and output results to
different file formats

positional arguments:
  hdf5                  HDF5 file with StrainGR call statistics.

optional arguments:
  -h, --help            show this help message and exit
  -s FILE, --summary FILE
                        Output a TSV with a summary of variant calling
                        statistics to the given file.
  -t TRACKS, --tracks TRACKS
                        Write track files that can be visualized in a genome
                        viewer, use this option multiple times to generate
                        multiple track types. Use 'all' to generate all
                        tracks. Available track types: coverage, callable,
                        multimapped, lowmq, bad, high_coverage, gaps
  -p PATH, --track-prefix PATH
                        Specifiy filename prefix for all track files. By
                        default it will use the path of the HDF5 file without
                        the '.hdf5' extension.
  --track-min-size TRACK_MIN_SIZE
                        For all --track-* options above, only include features
                        (regions) of at least the given size. Default: 1.
  -G MIN_GAP, --min-gap MIN_GAP
                        Minimum size of gap to be considered as such. If not
                        set, will use the value used in the original `straingr
                        call` run. If set, gaps will need to be at least the
                        given size to be reported. Will be scaled depending on
                        coverage.
  -V FILE, --vcf FILE   Output a VCF file with SNP's. Please be aware that we
                        do not have a good insertion/deletion calling
                        mechanism, but some information on possible indels is
                        written to the VCF file.
  --verbose-vcf LEVEL   To be used with --vcf. Increase the verboseness of the
                        generated VCF. By default it only outputs strong SNPs.
                        A value of 1 will also output any weak calls.
```

## strainge_compare

### Tool Description
Compare strains and variant calls in two different samples. Reads of both samples must be aligned to the same reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge compare [-h] [-o SUMMARY_OUT] [-d DETAILS_OUT] [-V] [-G SIZE]
                        [-a | -b BASELINE] [-D OUTPUT_DIR]
                        SAMPLE_HDF5 [SAMPLE_HDF5 ...]

Compare strains and variant calls in two different samples. Reads of
both samples must be aligned to the same reference.

It's possible to generate a TSV with summary stats as well as a file
with more detailed information on which alleles are called at what
positions.

positional arguments:
  SAMPLE_HDF5           HDF5 files with variant calling data for each sample.
                        Number of samples should be exactly two, except when
                        used with --baseline.

optional arguments:
  -h, --help            show this help message and exit
  -o SUMMARY_OUT, --summary-out SUMMARY_OUT
                        Output file for summary statistics. Defaults to
                        stdout.
  -d DETAILS_OUT, --details-out DETAILS_OUT
                        Output file for detailed base level differences
                        between samples (optional).
  -V, --verbose-details
                        Output detailed information for every position in the
                        genome instead of only for positions where alleles
                        differ.
  -G SIZE, --min-gap SIZE
                        Only compare gaps larger than the given size.
  -a, --all-vs-all      Perform all-vs-all pairwise comparisons between the
                        given samples. Can't be used together with --baseline.
  -b BASELINE, --baseline BASELINE
                        Path to a sample to use as baseline, and compare all
                        other given samples to this one. Outputs a shell
                        script that runs all individual pairwise comparisons.
                        Can't be used together with --all-vs-all.
  -D OUTPUT_DIR, --output-dir OUTPUT_DIR
                        The output directory of all comparison files when
                        using --baseline or --all-vs-all.
```

## strainge_tree

### Tool Description
Build an approximate phylogenetic tree based on a given distance matrix, using neighbour joining.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge tree [-h] [-o OUTPUT] distance_matrix

Build an approximate phylogenetic tree based on a given distance matrix,
using neighbour joining.

Because our pairwise distances are pretty rough (especially at lower
coverages), the triangle inequality may not hold, and the resulting tree
may not be accurate.

positional arguments:
  distance_matrix       The path to the distance matrix TSV, as created by
                        `straingr dist`.

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename. Defaults to stdout.
```

## strainge_stats

### Tool Description
Obtain statistics about a given k-mer set.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge stats [-h] [-k] [-c] [-H] [-e] [-o OUTPUT] kmerset

Obtain statistics about a given k-mer set.

positional arguments:
  kmerset               The K-mer set to load

optional arguments:
  -h, --help            show this help message and exit
  -k                    Output k-mer size.
  -c, --counts          Output the list of k-mers in this set with
                        corresponding counts.
  -H, --histogram       Write the k-mer frequency histogram to output.
  -e, --entropy         Calculate Shannon entropy in bases and write to
                        output.
  -o OUTPUT, --output OUTPUT
                        Output file, defaults to standard output.
```

## strainge_plot

### Tool Description
Generate plots for a given k-mer set.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: strainge plot [-h] [-o OUTPUT] [-t {spectrum}] kmerset

Generate plots for a given k-mer set.

positional arguments:
  kmerset               The k-mer set to load

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output filename (PNG preferred).
  -t {spectrum}, --plot-type {spectrum}
                        The kind of plot to generate.
```

## strainge_straingr_call

### Tool Description
StrainGR: strain-aware variant caller for metagenomic samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: straingr call [-h] [-Q MIN_QUAL] [-P MIN_PILEUP_QUAL]
                     [-F MIN_QUAL_FRAC] [-M MIN_MAPPING_QUAL]
                     [-N MAX_MISMATCHES] [-G MIN_GAP] -o FILE [-s FILE]
                     [-V FILE] [--verbose-vcf LEVEL] [-t TRACKS]
                     [--track-min-size TRACK_MIN_SIZE]
                     reference sample

StrainGR: strain-aware variant caller for metagenomic samples

This command analyzes

positional arguments:
  reference             Reference FASTA file. Can be GZIP compressed.
  sample                BAM file with the aligned reads of the sample against
                        the reference

optional arguments:
  -h, --help            show this help message and exit

Quality control:
  Options which determine which reads to consider, when base or read mapping qualities are high enough for calling, etc.

  -Q MIN_QUAL, --min-qual MIN_QUAL
                        Minimum quality for a base to be considered. Default:
                        5.
  -P MIN_PILEUP_QUAL, --min-pileup-qual MIN_PILEUP_QUAL
                        Minimum sum of qualities for an allele to be
                        trusted.for variant calling. Default: 50.
  -F MIN_QUAL_FRAC, --min-qual-frac MIN_QUAL_FRAC
                        Minimum fraction of the reads in the pileup required
                        to confirm an allele (fractions are base quality
                        weighted). Default: 0.1
  -M MIN_MAPPING_QUAL, --min-mapping-qual MIN_MAPPING_QUAL
                        Minimum mapping quality of the whole read to be
                        considered. Default: 5.
  -N MAX_MISMATCHES, --max-mismatches MAX_MISMATCHES
                        Ignore alignments with a higher number of mismatches
                        than the given threshold. A value of 0 disables this
                        check. Default: 0.
  -G MIN_GAP, --min-gap MIN_GAP
                        Minimum size of gap to be considered as such. Default:
                        5000. Will be automatically scaled depending on
                        coverage.

Output formats:
  Options for writing the results to different file formats.

  -o FILE, --hdf5-out FILE
                        Output StrainGR variant calling data to the given HDF5
                        file. Required.
  -s FILE, --summary FILE
                        Output a TSV with a summary of variant calling
                        statistics to the given file. Defaults to stdout.
  -V FILE, --vcf FILE   Output a VCF file with SNP's. Please be aware that we
                        do not have a good insertion/deletion calling
                        mechanism, but some information on possible indels is
                        written to the VCF file.
  --verbose-vcf LEVEL   To be used with --vcf. Increase the verboseness of the
                        generated VCF. By default it only outputs strong SNPs.
                        A value of 1 will also output any weak calls.
  -t TRACKS, --tracks TRACKS
                        Write track files that can be visualized in a genome
                        viewer, use this option multiple times to generate
                        multiple track types. Use 'all' to generate all
                        tracks. Available track types: coverage, callable,
                        multimapped, lowmq, bad, high_coverage, gaps
  --track-min-size TRACK_MIN_SIZE
                        For all tracks to generate, only include features
                        (regions) of at least the given size. Default: 1.
```

## strainge_straingr_dist

### Tool Description
Calculate the pairwise genetic distance between strains close to the same reference genome across samples, output as a matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: straingr dist [-h] [-r REFERENCE] [-d {jc,kimura}] [-c MIN_CALLABLE]
                     [-a MIN_ABUNDANCE] [-p PROCESSES] [-o OUTPUT]
                     samples [samples ...]

For all strains across multiple samples close to the same reference
genome, calculate the pairwise genetic distance and output it in matrix
form.

Can be used for ordination plots and approximate phylogenetic trees.

positional arguments:
  samples               StrainGR call data HDF5 file for each sample.

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        Analyze strains across samples close to this reference
                        genome
  -d {jc,kimura}, --dist-correction {jc,kimura}
                        Genetic distance correction method, either Jukes
                        Cantor (jc) or Kimura's two parameter model (kimura).
                        If none given, then the SNP rate is used as distance.
  -c MIN_CALLABLE, --min-callable MIN_CALLABLE
                        Minimum percentage of callable genome to consider a
                        strain for comparison. Default 0.5%.
  -a MIN_ABUNDANCE, --min-abundance MIN_ABUNDANCE
                        Minimum abundance fraction of this strain in a sample.
                        Default 0.01.
  -p PROCESSES, --processes PROCESSES
                        Number of parallel processes to start. Default 2.
  -o OUTPUT, --output OUTPUT
                        Output filename. Defaults to stdout.
```

## strainge_straingr_prepare_ref

### Tool Description
Prepare a concatenated reference for StrainGR variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: straingr prepare-ref [-h] [-r [REFS [REFS ...]]]
                            [-s [STRAINGST_FILES [STRAINGST_FILES ...]]]
                            [-p PATH_TEMPLATE] -o OUTPUT [-S SIMILARITIES]
                            [-t THRESHOLD] [-l MINMATCH]

Prepare a concatenated reference for StrainGR variant calling.

optional arguments:
  -h, --help            show this help message and exit

I/O:
  Arguments to specify input and output files.

  -r [REFS [REFS ...]], --refs [REFS [REFS ...]]
                        Force inclusion of given reference genome in the
                        concatenated reference output (pre-clustering). The
                        given name should match a reference genome in the
                        StrainGST database. To be clear: the given argument
                        should *not* be a filename. See --path-template how
                        this command finds the corresponding FASTA files.
  -s [STRAINGST_FILES [STRAINGST_FILES ...]], --straingst-files [STRAINGST_FILES [STRAINGST_FILES ...]]
                        Read the list of StrainGST result files and collect
                        all reported strains to include in the concatenated
                        output. Use together with --path-template to specify
                        how to determine the correct filename.
  -p PATH_TEMPLATE, --path-template PATH_TEMPLATE
                        Specify how to determine the path to the FASTA file of
                        a reference strain as reported by StrainGST. This
                        command will replace "{ref}" with the strain name.
                        Example: "refs/{ref}.fa". Warning: in many shells {
                        and } are special characters. Make sure to use quotes.
                        Default: {ref}.fa.
  -o OUTPUT, --output OUTPUT
                        Output FASTA filename.

Clustering:
  Options to change clustering behaviour.

  -S SIMILARITIES, --similarities SIMILARITIES
                        Enable clustering of closely related reference genomes
                        by specifying the path to the k-mer similarity scores
                        as created at the StrainGST database construction
                        step.
  -t THRESHOLD, --threshold THRESHOLD
                        K-mer clustering threshold, the default (0.7) is a bit
                        more lenient than the clustering step for database
                        construction, because for a concatenated reference
                        you'll want the included references not too closely
                        related, due to increased shared content.

MUMmer:
  Settings for MUMmer, used to analyze the repetitiveness of a concatenated reference.

  -l MINMATCH, --minmatch MINMATCH
                        Mininum exact match size. Default: 250. For best
                        estimation that resembles StrainGR's 'lowmq' field,
                        set this to your library's average insert size.
```

## strainge_straingst_kmermerge

### Tool Description
Merge k-mer set files.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: straingst kmermerge [-h] [-k K] [-o OUTPUT] [-f FINGERPRINT_FRACTION]
                           kmerfiles [kmerfiles ...]

Merge k-mer set files.

positional arguments:
  kmerfiles             Input KmerSet files to be merged (hdf5 files)

optional arguments:
  -h, --help            show this help message and exit
  -k K, --k K           K-mer size (default 23)
  -o OUTPUT, --output OUTPUT
                        Filename of the output HDF5.
  -f FINGERPRINT_FRACTION, --fingerprint-fraction FINGERPRINT_FRACTION
                        Fraction of k-mers to keep for a minhash sketch.
                        Default: 0.01. No fingerprint will be created if set
                        to zero.
```

## strainge_straingst_run

### Tool Description
StrainGST: strain genome search tool. Identify close reference genomes to strains present in a sample.

### Metadata
- **Docker Image**: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
- **Homepage**: https://github.com/broadinstitute/strainge
- **Package**: https://anaconda.org/channels/bioconda/packages/strainge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: straingst run [-h] [-o OUTPUT] [-O] [-d DEBUG_OUT] [-i ITERATIONS]
                     [-t TOP] [-f] [-F MINFRAC] [-s SCORE] [-e EVENNESS]
                     [-a MINACCT] [-u UNIVERSAL] [-S SCORE_STRAINS]
                     pan sample

StrainGST: strain genome search tool. Identify close reference genomes
to strains present in a sample.

positional arguments:
  pan                   HDF5 file containing pan-genome kmer set (database).
  sample                Search for strains in this sample

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Output text file (default: standard out), or output
                        filename prefix if enabling --separate-output.
  -O, --separate-output
                        Separate sample and strain metrics in different files,
                        such that they can be easily read with Pandas or R.
  -d DEBUG_OUT, --debug-out DEBUG_OUT
                        Output a debug HDF5 file containing the remaining
                        sample k-mers per iteration. Optional.
  -i ITERATIONS, --iterations ITERATIONS
                        max strains to look for (default: 5)
  -t TOP, --top TOP     How many best matches to print per iteration (default:
                        1)
  -f, --fulldb          Using full pan-genome kmer database rather than pan-
                        genome fingerprint kmer db
  -F MINFRAC, --minfrac MINFRAC
                        Minimum fraction of original kmers in strain (default:
                        0.01)
  -s SCORE, --score SCORE
                        Minimum score (default: 0.02)
  -e EVENNESS, --evenness EVENNESS
                        Minimum evenness (default: 0.00)
  -a MINACCT, --minacct MINACCT
                        Minimum fraction of pan genome kmers accounted for by
                        genome to be considered (default: 0.00)
  -u UNIVERSAL, --universal UNIVERSAL
                        Exclude Kmers occurring more often in the sample than
                        this times the mean pangenome kmer frequency (default:
                        10)
  -S SCORE_STRAINS, --score-strains SCORE_STRAINS
                        Only score these strains (primarily for debugging)
```

## Metadata
- **Skill**: not generated
