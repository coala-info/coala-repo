# flair CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| flair_align | PASS |  |
| flair_bed_to_gtf | PASS |  |
| flair_bed_to_sequence | PASS |  |
| flair_collapse | PASS |  |
| flair_combine | PASS |  |
| flair_correct | PASS |  |
| flair_diff_iso_usage | PASS |  |
| flair_diffexp | Failed | image problem: Rscript (R with DESeq2 and DRIMSeq) is missing in the image, so diffexp stops at the first R step |
| flair_diffsplice | PASS | event tables match the expected files; the --test option stops because R is missing in the image |
| flair_fusion | PASS |  |
| flair_gtf_to_bed | PASS |  |
| flair_junctions_from_sam | PASS |  |
| flair_mark_intron_retention | Failed | image problem: the entry point cannot import main from the module, so the command exits with an error after writing its files |
| flair_partition | Failed | image problem: busybox sort in the image has no --parallel option, so the tool silently writes an empty ranges file |
| flair_plot_isoform_usage | PASS |  |
| flair_predictProductivity | PASS |  |
| flair_quantify | PASS |  |
| flair_transcriptome | PASS |  |
| flair_variants | Not completed | needs a VCF made by longshot, and longshot is not in the image |

## flair_align

### Tool Description
FLAIR align outputs an unfiltered bam file and a filtered bed file for use in the downstream pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Total Downloads**: 18.7K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/BrooksLabUCSC/flair
- **Stars**: N/A
### Original Help Text
```text
usage: align [-h] -r READS [READS ...] [-g GENOME] [--mm_index MM_INDEX]
             [-o OUTPUT] [-t THREADS] [--junction_bed JUNCTION_BED] [--nvrna]
             [--quality QUALITY] [--minfragmentsize MINFRAGMENTSIZE]
             [--maxintronlen MAXINTRONLEN]
             [--filtertype {keepsup,removesup,separate}] [--quiet]
             [--remove_internal_priming] [-f GTF]
             [--intprimingthreshold INTPRIMINGTHRESHOLD]
             [--intprimingfracAs INTPRIMINGFRACAS] [--remove_singleexon]
             [--log-stderr] [--log-level LOG_LEVEL] [--log-conf LOG_CONF]
             [--log-debug]

FLAIR align outputs an unfiltered bam file and a filtered bed file for use in
the downstream pipeline

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        output file name base (default: flair.aligned)
  -t THREADS, --threads THREADS
                        minimap2 number of threads (4)
  --junction_bed JUNCTION_BED
                        annotated isoforms/junctions bed file for splice site-
                        guided minimap2 genomic alignment
  --nvrna               specify this flag to use native-RNA specific alignment
                        parameters for minimap2
  --quality QUALITY     minimum MAPQ of read alignment to the genome (0)
  --minfragmentsize MINFRAGMENTSIZE
                        minimum size of alignment kept, used in minimap -s.
                        More important when doing downstream fusion detection
  --maxintronlen MAXINTRONLEN
                        maximum intron length in genomic alignment. Longer can
                        help recover more novel isoforms with long introns
  --filtertype {keepsup,removesup,separate}
                        method of filtering chimeric alignments (potential
                        fusion reads). Options: removesup (default), separate
                        (required for downstream work with fusions), keepsup
                        (keeps supplementary alignments for isoform detection,
                        does not allow gene fusion detection)
  --quiet               Suppress minimap progress statements from being
                        printed
  --remove_internal_priming
                        specify if want to remove reads with internal priming
  -f GTF, --gtf GTF     reference annotation, only used if
                        --remove_internal_priming is specified, recommended if
                        so
  --intprimingthreshold INTPRIMINGTHRESHOLD
                        number of bases that are at leas 75% As required to
                        call read as internal priming
  --intprimingfracAs INTPRIMINGFRACAS
                        number of bases that are at least 75% As required to
                        call read as internal priming
  --remove_singleexon   specify if want to remove unspliced reads
  --log-stderr          also log to stderr, even when logging to syslog
  --log-level LOG_LEVEL
                        Set level to case-insensitive symbolic value, one of
                        CRITICAL, DEBUG, ERROR, FATAL, INFO, NOTSET, WARN,
                        WARNING
  --log-conf LOG_CONF   Python logging configuration file, see
                        logging.config.fileConfig()
  --log-debug           short-cut that that sets --log-stderr and --log-
                        level=DEBUG

required named arguments:
  -r READS [READS ...], --reads READS [READS ...]
                        FASTA/FASTQ file(s) of raw reads, either space or
                        comma separated

Either one of the following arguments is required:
  -g GENOME, --genome GENOME
                        FASTA of reference genome, can be minimap2 indexed
  --mm_index MM_INDEX   minimap2 index .mmi file
```


## flair_correct

### Tool Description
take bed file of long RNA-seq reads and filter out those with anomalous splice junctions correct remaining to nearest orthogonally supported splice site

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: correct [-h] -q QUERY [-f GTF]
               [--junction_tab JUNCTION_TAB | --junction_bed JUNCTION_BED]
               [--junction_support JUNCTION_SUPPORT] [-o OUTPUT] [-t THREADS]
               [--nvrna] [-w SS_WINDOW]

take bed file of long RNA-seq reads and filter out those with anomalous splice
junctions correct remaining to nearest orthogonally supported splice site

options:
  -h, --help            show this help message and exit
  --junction_support JUNCTION_SUPPORT
                        if providing short-read junctions, minimum junction
                        support required to keep junction. If your junctions
                        file is in bed format, the score field will be used
                        for read support. Default=1
  -o OUTPUT, --output OUTPUT
                        output name base (default: flair)
  -t THREADS, --threads THREADS
                        number of threads (4)
  --nvrna               specify this flag to make the strand of a read
                        consistent with the annotation during correction
  -w SS_WINDOW, --ss_window SS_WINDOW
                        window size for correcting splice sites (15)

required named arguments:
  -q QUERY, --query QUERY
                        uncorrected bed12 file

at least one of the following arguments is required:
  -f GTF, --gtf GTF     GTF annotation file
  --junction_tab JUNCTION_TAB
                        short-read junctions in SJ.out.tab format. Use this
                        option if you aligned your short-reads with STAR, STAR
                        will automatically output this file
  --junction_bed JUNCTION_BED
                        short-read junctions in bed format (can be generated
                        from short-read alignment with junctions_from_sam)
```


## flair_transcriptome

### Tool Description
Defines isoforms from genomic alignments and optional short-read junction support.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: transcriptome [-h] [-b GENOMEALIGNEDBAM] [-g GENOME] [-o OUTPUT]
                     [-t THREADS] [-f GTF]
                     [--junction_tab JUNCTION_TAB | --junction_bed JUNCTION_BED]
                     [--junction_support JUNCTION_SUPPORT]
                     [--ss_window SS_WINDOW] [-s SUPPORT] [--stringent]
                     [--check_splice] [-w END_WINDOW] [--noaligntoannot]
                     [-n NO_REDUNDANT] [--max_ends MAX_ENDS] [--filter FILTER]
                     [--parallelmode PARALLELMODE] [--predictCDS]
                     [--keep_intermediate] [--keep_sup]

options:
  -h, --help            show this help message and exit
  -b GENOMEALIGNEDBAM, --genomealignedbam GENOMEALIGNEDBAM
                        Sorted and indexed bam file aligned to the genome
  -g GENOME, --genome GENOME
                        FastA of reference genome, can be minimap2 indexed
  -o OUTPUT, --output OUTPUT
                        output file name base for FLAIR isoforms (default:
                        flair)
  -t THREADS, --threads THREADS
                        minimap2 number of threads (4)
  -f GTF, --gtf GTF     GTF annotation file, used for renaming FLAIR isoforms
                        to annotated isoforms and adjusting TSS/TESs
  --junction_tab JUNCTION_TAB
                        short-read junctions in SJ.out.tab format. Use this
                        option if you aligned your short-reads with STAR, STAR
                        will automatically output this file
  --junction_bed JUNCTION_BED
                        short-read junctions in bed format (can be generated
                        from short-read alignment with junctions_from_sam)
  --junction_support JUNCTION_SUPPORT
                        if providing short-read junctions, minimum junction
                        support required to keep junction. If your junctions
                        file is in bed format, the score field will be used
                        for read support.
  --ss_window SS_WINDOW
                        window size for correcting splice sites (15)
  -s SUPPORT, --support SUPPORT
                        minimum number of supporting reads for an isoform (3)
  --stringent           specify if all supporting reads need to be full-length
                        (spanning 25 bp of the first and last exons)
  --check_splice        enforce coverage of 4 out of 6 bp around each splice
                        site and no insertions greater than 3 bp at the splice
                        site
  -w END_WINDOW, --end_window END_WINDOW
                        window size for comparing TSS/TES (100)
  --noaligntoannot      related to old annotation_reliant, now specify if you
                        don't want an initial alignment to the annotated
                        sequences and only want transcript detection from the
                        genomic alignment. Will be slightly faster but less
                        accurate if the annotation is good
  -n NO_REDUNDANT, --no_redundant NO_REDUNDANT
                        For each unique splice junction chain, report options
                        include: none--best TSSs/TESs chosen for each unique
                        set of splice junctions; longest--single TSS/TES
                        chosen to maximize length; best_only--single most
                        supported TSS/TES used in conjunction chosen (none)
  --max_ends MAX_ENDS   maximum number of TSS/TES picked per isoform (2)
  --filter FILTER       Report options include: nosubset--any isoforms that
                        are a proper set of another isoform are removed;
                        default--subset isoforms are removed based on support;
                        comprehensive--default set + all subset isoforms;
                        ginormous--comprehensive set + single exon subset
                        isoforms
  --parallelmode PARALLELMODE
                        parallelization mode. Default: "auto:1GB" This
                        indicates an automatic threshold where if the file is
                        less than 1GB, parallelization is done by chromosome,
                        but if it's larger, parallelization is done by region
                        of non-overlapping reads. Other modes: bychrom,
                        byregion, auto:xGB - for setting the auto threshold,
                        it must be in units of GB.
  --predictCDS          specify if you want to predict the CDS of the final
                        isoforms. Will be output in the final bed file but not
                        the gtf file. Productivity annotation is also added in
                        the name field, which is detailed further in the
                        predictProductivity documentation
  --keep_intermediate   specify if intermediate and temporary files are to be
                        kept for debugging. Intermediate files include:
                        promoter-supported reads file, read assignments to
                        firstpass isoforms
  --keep_sup            specify if you want to keep supplementary alignments
                        to define isoforms
```


## flair_collapse

### Tool Description
take bed file of corrected reads and generate confident collapsed isoform models

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: collapse [-h] -q QUERY -g GENOME -r READS [READS ...] [-o OUTPUT]
                [-t THREADS] [-f GTF] [--generate_map]
                [--annotation_reliant ANNOTATION_RELIANT] [-s SUPPORT]
                [--stringent] [--check_splice] [--trust_ends]
                [--quality QUALITY] [--longshot_bam LONGSHOT_BAM]
                [--longshot_vcf LONGSHOT_VCF] [-w END_WINDOW] [-p PROMOTERS]
                [--3prime_regions THREEPRIME] [-n NO_REDUNDANT] [-i]
                [--no_gtf_end_adjustment] [--max_ends MAX_ENDS]
                [--filter FILTER] [--temp_dir TEMP_DIR] [--keep_intermediate]
                [--mm2_args MM2_ARGS] [--annotated_bed ANNOTATED_BED]
                [--remove_internal_priming]
                [--intprimingthreshold INTPRIMINGTHRESHOLD]
                [--intprimingfracAs INTPRIMINGFRACAS]
                [--fusion_breakpoints FUSION_BREAKPOINTS] [--allow_paralogs]
                [--predictCDS]

take bed file of corrected reads and generate confident collapsed isoform
models

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        output file name base for FLAIR isoforms (default:
                        flair.collapse)
  -t THREADS, --threads THREADS
                        minimap2 number of threads (4)
  -f GTF, --gtf GTF     GTF annotation file, used for renaming FLAIR isoforms
                        to annotated isoforms and adjusting TSS/TESs
  --generate_map        specify this argument to generate a txt file of read-
                        isoform assignments (default: not specified)
  --annotation_reliant ANNOTATION_RELIANT
                        specify transcript fasta that corresponds to
                        transcripts in the gtf to run annotation- reliant
                        flair collapse; to ask flair to make transcript
                        sequences given the gtf and genome fa, type
                        --annotation_reliant generate
  -s SUPPORT, --support SUPPORT
                        minimum number of supporting reads for an isoform; if
                        s < 1, it will be treated as a percentage of
                        expression of the gene (3)
  --stringent           specify if all supporting reads need to be full-length
                        (80% coverage and spanning 25 bp of the first and last
                        exons)
  --check_splice        enforce coverage of 4 out of 6 bp around each splice
                        site and no insertions greater than 3 bp at the splice
                        site
  --trust_ends          specify if reads are generated from a long read method
                        with minimal fragmentation
  --quality QUALITY     minimum MAPQ of read assignment to an isoform (0)
  --longshot_bam LONGSHOT_BAM
                        bam from longshot containing haplotype information for
                        each read
  --longshot_vcf LONGSHOT_VCF
                        vcf from longshot
  -w END_WINDOW, --end_window END_WINDOW
                        window size for comparing TSS/TES (100)
  -p PROMOTERS, --promoters PROMOTERS
                        promoter regions bed file to identify full-length
                        reads
  --3prime_regions THREEPRIME
                        TES regions bed file to identify full-length reads
  -n NO_REDUNDANT, --no_redundant NO_REDUNDANT
                        For each unique splice junction chain, report options
                        include: none--best TSSs/TESs chosen for each unique
                        set of splice junctions; longest--single TSS/TES
                        chosen to maximize length; best_only--single most
                        supported TSS/TES used in conjunction chosen (none)
  -i, --gene_tss        when specified, TSS/TES for each isoform will be
                        determined standardized at the gene level (default:
                        not specified, determined for each individual isoform)
  --no_gtf_end_adjustment
                        when specified, TSS/TES from the gtf provided with -f
                        will not be used to adjust isoform TSSs/TESs each
                        isoform will be determined from supporting reads
  --max_ends MAX_ENDS   maximum number of TSS/TES picked per isoform (2)
  --filter FILTER       Report options include: nosubset--any isoforms that
                        are a proper set of another isoform are removed;
                        default--subset isoforms are removed based on support;
                        comprehensive--default set + all subset isoforms;
                        ginormous--comprehensive set + single exon subset
                        isoforms
  --temp_dir TEMP_DIR   directory for temporary files. use "./" to indicate
                        current directory (default: python tempfile directory)
  --keep_intermediate   specify if intermediate and temporary files are to be
                        kept for debugging. Intermediate files include:
                        promoter-supported reads file, read assignments to
                        firstpass isoforms
  --mm2_args MM2_ARGS   additional minimap2 arguments when aligning reads
                        first-pass transcripts; separate args by commas, e.g.
                        --mm2_args=-I8g,--MD
  --annotated_bed ANNOTATED_BED
                        annotation_reliant also requires a bedfile of
                        annotated isoforms; if this isn't provided, flair
                        collapse will generate the bedfile from the gtf.
                        eventually this argument will be removed
  --remove_internal_priming
                        specify if want to remove reads with internal priming
  --intprimingthreshold INTPRIMINGTHRESHOLD
                        number of bases that are at least intprimingfracAs% As
                        required to call read as internal priming
  --intprimingfracAs INTPRIMINGFRACAS
                        threshold for fraction of As in sequence near read end
                        to call as internal priming
  --fusion_breakpoints FUSION_BREAKPOINTS
                        [OPTIONAL] fusion detection only - bed file containing
                        locations of fusion breakpoints on the synthetic
                        genome
  --allow_paralogs      specify if want to allow reads to be assigned to
                        multiple paralogs with equivalent alignment
  --predictCDS          specify if you want to predict the CDS of the final
                        isoforms. Will be output in the final bed file but not
                        the gtf file. Productivity annotation is also added in
                        the name field, which is detailed further in the
                        predictProductivity documentation

required named arguments:
  -q QUERY, --query QUERY
                        bed file of aligned/corrected reads
  -g GENOME, --genome GENOME
                        FastA of reference genome
  -r READS [READS ...], --reads READS [READS ...]
                        FastA/FastQ files of raw reads, can specify multiple
                        files
```


## flair_quantify

### Tool Description
takes in many long-read RNA-seq reads files and quantifies them against a single transcriptome. A stringent, full-read-match-based approach

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: quantify [-h] -r R -i I [-o O] [-t T] [--temp_dir TEMP_DIR]
                [--sample_id_only] [--tpm] [--quality QUALITY] [--trust_ends]
                [--generate_map] [--isoform_bed ISOFORMS] [--stringent]
                [--check_splice] [--output_bam]

takes in many long-read RNA-seq reads files and quantifies them against a
single transcriptome. A stringent, full-read-match-based approach

options:
  -h, --help            show this help message and exit
  -o O, --output O      output file name base for FLAIR quantify (default:
                        flair.quantify)
  -t T, --threads T     minimap2 number of threads (4)
  --temp_dir TEMP_DIR   directory to put temporary files. use './" to indicate
                        current directory (default: python tempfile directory)
  --sample_id_only      only use sample id in output header
  --tpm                 Convert counts matrix to transcripts per million and
                        output as a separate file named <output>.tpm.tsv
  --quality QUALITY     minimum MAPQ of read assignment to an isoform (0)
  --trust_ends          specify if reads are generated from a long read method
                        with minimal fragmentation
  --generate_map        create read-to-isoform assignment files for each
                        sample (default: not specified)
  --isoform_bed ISOFORMS, --isoformbed ISOFORMS
                        isoform .bed file, must be specified if --stringent or
                        check_splice is specified
  --stringent           Supporting reads must cover 80 percent of their
                        isoform and extend at least 25 nt into the first and
                        last exons. If those exons are themselves shorter than
                        25 nt, the requirement becomes 'must start within 4 nt
                        from the start" or "must end within 4 nt from the end"
  --check_splice        enforce coverage of 4 out of 6 bp around each splice
                        site and no insertions greater than 3 bp at the splice
                        site
  --output_bam          whether to output bam file of reads aligned to correct
                        isoforms

required named arguments:
  -r R, --reads_manifest R
                        Tab delimited file containing sample id, condition,
                        batch, reads.fq
  -i I, --isoforms I    FastA of FLAIR collapsed isoforms
```


## flair_combine

### Tool Description
Combine transcriptomes from multiple samples based on a manifest file.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: combine [-h] -m MANIFEST [-o OUTPUT_PREFIX] [-w ENDWINDOW]
               [-p MINPERCENTUSAGE] [-c] [-s] [-f FILTER]

options:
  -h, --help            show this help message and exit
  -m MANIFEST, --manifest MANIFEST
                        path to manifest files that points to transcriptomes
                        to combine. Each line of file should be tab separated
                        with sample name, sample type (isoform or
                        fusionisoform), path/to/isoforms.bed,
                        path/to/isoforms.fa,
                        path/to/combined.isoform.read.map.txt. fa and
                        read.map.txt files are not required, although if .fa
                        files are not provided for each sample a .fa output
                        will not be generated
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        path to collapsed_output.bed file. default:
                        'collapsed_flairomes'
  -w ENDWINDOW, --endwindow ENDWINDOW
                        window for comparing ends of isoforms with the same
                        intron chain. Default:200bp
  -p MINPERCENTUSAGE, --minpercentusage MINPERCENTUSAGE
                        minimum percent usage required in one sample to keep
                        isoform in combined transcriptome. Default:10
  -c, --convert_gtf     [optional] whether to convert the combined
                        transcriptome bed file to gtf
  -s, --include_se      whether to include single exon isoforms. Default: dont
                        include
  -f FILTER, --filter FILTER
                        type of filtering. Options: usageandlongest(default),
                        usageonly, none, or a number for the total count of
                        reads required to call an isoform
```


## flair_variants

### Tool Description
FLAIR variants module for calling variants from isoform data.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: variants [-h] -m MANIFEST [-o OUTPUT_PREFIX] [-i ISOFORMS]
                [-b BEDISOFORMS] -g GENOME -f GTF

options:
  -h, --help            show this help message and exit
  -m MANIFEST, --manifest MANIFEST
                        path to manifest files that points to sample names +
                        bam files aligned to transcriptome. Each line of file
                        should be tab separated.
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        path to collapsed_output.bed file. default: 'flair'
  -i ISOFORMS, --isoforms ISOFORMS
                        path to transcriptome fasta file
  -b BEDISOFORMS, --bedisoforms BEDISOFORMS
                        path to transcriptome bed file
  -g GENOME, --genome GENOME
                        FastA of reference genome
  -f GTF, --gtf GTF     GTF annotation file
```


## flair_fusion

### Tool Description
FLAIR fusion detection module for identifying gene fusions from transcriptomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fusion [-h] -g GENOME -f GTF -r READS [READS ...] -b GENOMECHIMBAM
              [--transcriptchimbam TRANSCRIPTCHIMBAM] [-o OUTPUT] [-t THREADS]
              [--minfragmentsize MINFRAGMENTSIZE] [-s SUPPORT]
              [--maxloci MAXLOCI]

options:
  -h, --help            show this help message and exit
  -f GTF, --gtf GTF     GTF annotation file, used for renaming FLAIR isoforms
                        to annotated isoforms and adjusting TSS/TESs
  --transcriptchimbam TRANSCRIPTCHIMBAM
                        Optional: bam file of chimeric reads from
                        transcriptomic alignment. If not provided, this will
                        be made for you
  -o OUTPUT, --output OUTPUT
                        output file name base for FLAIR isoforms (default:
                        flair.collapse)
  -t THREADS, --threads THREADS
                        minimap2 number of threads (4)
  --minfragmentsize MINFRAGMENTSIZE
                        minimum size of alignment kept, used in minimap -s.
                        More important when doing downstream fusion detection
  -s SUPPORT, --support SUPPORT
                        minimum number of supporting reads for a fusion (3)
  --maxloci MAXLOCI     max loci detected in fusion. Set higher for detection
                        of 3-gene+ fusions

required named arguments:
  -g GENOME, --genome GENOME
                        FastA of reference genome
  -r READS [READS ...], --reads READS [READS ...]
                        FastA/FastQ files of raw reads, can specify multiple
                        files
  -b GENOMECHIMBAM, --genomechimbam GENOMECHIMBAM
                        bam file of chimeric reads from genomic alignment from
                        flair align
```


## flair_diffexp

### Tool Description
Differential expression analysis of isoforms using flair. It performs parallel DRIMSeq and filters isoforms based on expression thresholds.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: diffexp [-h] -q COUNTS_MATRIX -o OUT_DIR [-t THREADS] [-e EXP_THRESH]
               [-of]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads for parallel DRIMSeq.
  -e EXP_THRESH, --exp_thresh EXP_THRESH
                        Read count expression threshold. Isoforms in which
                        both conditions contain fewer than E reads are
                        filtered out (Default E=10)
  -of, --out_dir_force  Specify this argument to force overwriting of files in
                        an existing output directory

required named arguments:
  -q COUNTS_MATRIX, --counts_matrix COUNTS_MATRIX
                        Tab-delimited isoform count matrix from flair quantify
                        module.
  -o OUT_DIR, --out_dir OUT_DIR
                        Output directory for tables and plots.
```


## flair_diffsplice

### Tool Description
Differential splicing analysis using DRIMSeq, taking isoforms and count matrices as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: diffsplice [-h] -i ISOFORMS -q COUNTS_MATRIX -o OUT_DIR [-t THREADS]
                  [--test] [--drim1 DRIM1] [--drim2 DRIM2] [--drim3 DRIM3]
                  [--drim4 DRIM4] [--batch] [--conditionA CONDITIONA]
                  [--conditionB CONDITIONB] [-of]

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads for parallel DRIMSeq (4)
  --test                Run DRIMSeq statistical testing
  --drim1 DRIM1         The minimum number of samples that have coverage over
                        an AS event inclusion/exclusion for DRIMSeq testing;
                        events with too few samples are filtered out and not
                        tested (6)
  --drim2 DRIM2         The minimum number of samples expressing the inclusion
                        of an AS event; events with too few samples are
                        filtered out and not tested (3)
  --drim3 DRIM3         The minimum number of reads covering an AS event
                        inclusion/exclusion for DRIMSeq testing, events with
                        too few samples are filtered out and not tested (15)
  --drim4 DRIM4         The minimum number of reads covering an AS event
                        inclusion for DRIMSeq testing, events with too few
                        samples are filtered out and not tested (5)
  --batch               If specified with --test, DRIMSeq will perform batch
                        correction
  --conditionA CONDITIONA
                        Implies --test. Specify one condition corresponding to
                        samples in the counts_matrix to be compared against
                        condition2; by default, the first two unique
                        conditions are used
  --conditionB CONDITIONB
                        Specify another condition corresponding to samples in
                        the counts_matrix to be compared against conditionA
  -of, --out_dir_force  Specify this argument to force overwriting of files in
                        an existing output directory

required named arguments:
  -i ISOFORMS, --isoforms ISOFORMS
                        isoforms in bed format
  -q COUNTS_MATRIX, --counts_matrix COUNTS_MATRIX
                        tab-delimited isoform count matrix from flair quantify
                        module
  -o OUT_DIR, --out_dir OUT_DIR
                        Output directory for tables and plots.
```


## flair_bed_to_gtf

### Tool Description
Convert an isoform bed file to GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bed_to_gtf [-h] [--force] [--add_reference_transcript_id]
                  [--dontuseCDS]
                  inputfile

options

positional arguments:
  inputfile             isoforms in bed format

options:
  -h, --help            show this help message and exit
  --force               specify to not split isoform name by underscore into
                        isoform and gene ids
  --add_reference_transcript_id
                        specify to add reference_transcript_id attribute
  --dontuseCDS
```

## flair_gtf_to_bed

### Tool Description
Convert a GTF annotation to bed12.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtf_to_bed [-h] [--include_gene] gtf bed

converts a gtf to a bed, depending on the output filename extension; gtf exons
need to be grouped by transcript and sorted by coordinate w/in a transcript

options:
  -h, --help      show this help message and exit
  --include_gene  Include gene name in the isoform name

required named arguments:
  gtf             annotated gtf
  bed             bed file
```

## flair_bed_to_sequence

### Tool Description
Extract isoform sequences for a bed file from a genome FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bed_to_sequence [-h] [-v VCF] [--isoform_haplotypes ISOFORM_HAPLOTYPES]
                       [--vcf_out VCF_OUT]
                       bed genome outfilename

options

positional arguments:
  bed                   isoforms in bed format
  genome                genomic sequence
  outfilename           Name of output file

options:
  -h, --help            show this help message and exit
  -v VCF, --vcf VCF     vcf file with flair phased transcripts
  --isoform_haplotypes ISOFORM_HAPLOTYPES
                        isoform haplotype assignments
  --vcf_out VCF_OUT     vcf output file name
```

## flair_diff_iso_usage

### Tool Description
Compare the usage of each isoform between two samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: diff_iso_usage [-h] [--log-stderr] [--log-level LOG_LEVEL]
                      [--log-conf LOG_CONF] [--log-debug]
                      counts_matrix_tsv colname1 colname2 outfile

Calculates the usage of each isoform as a fraction of the total expression of
the gene and compares this between samples.

positional arguments:
  counts_matrix_tsv     counts matrix TSV from flair-quantify
  colname1              the name of the column of the first sample
  colname2              the name of the column of the second sample
  outfile               output filename containing the p-value associated with
                        differential isoform usage for each isoform

options:
  -h, --help            show this help message and exit
  --log-stderr          also log to stderr, even when logging to syslog
  --log-level LOG_LEVEL
                        Set level to case-insensitive symbolic value, one of
                        CRITICAL, DEBUG, ERROR, FATAL, INFO, NOTSET, WARN,
                        WARNING
  --log-conf LOG_CONF   Python logging configuration file, see
                        logging.config.fileConfig()
  --log-debug           short-cut that that sets --log-stderr and --log-
                        level=DEBUG
```

## flair_partition

### Tool Description
Define non-overlapping regions from BED, SAM/BAM or GTF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: flair_partition [-h] [--min_partition_items MIN_PARTITION_ITEMS]
                       [-part_merge_dist PART_MERGE_DIST] [--threads THREADS]
                       [--bed BED_FILES] [--bam BAM_FILES] [--gtf GTF_FILES]
                       [--log-stderr] [--log-level LOG_LEVEL]
                       [--log-conf LOG_CONF] [--log-debug]
                       ranges_bed

Define non-overlapping regions from BED, SAM/BAM, or GTF files. Partitions are
made across all input files

positional arguments:
  ranges_bed            Output ranges BED file, will be compressed if it ends
                        in .gz

options:
  -h, --help            show this help message and exit
  --min_partition_items MIN_PARTITION_ITEMS
                        Minimum number of input items in a partition
  -part_merge_dist PART_MERGE_DIST
                        Combine adjacent non-overlapping partitions separated
                        by this distance
  --threads THREADS     Number of cores for parallel sorting
  --bed BED_FILES       Input BED file, maybe compressed. Maybe repeated
  --bam BAM_FILES       Input SAM/BAM file. Maybe repeated.
  --gtf GTF_FILES       Input GTF file. Maybe repeated.
  --log-stderr          also log to stderr, even when logging to syslog
  --log-level LOG_LEVEL
                        Set level to case-insensitive symbolic value, one of
                        CRITICAL, DEBUG, ERROR, FATAL, INFO, NOTSET, WARN,
                        WARNING
  --log-conf LOG_CONF   Python logging configuration file, see
                        logging.config.fileConfig()
  --log-debug           short-cut that that sets --log-stderr and --log-
                        level=DEBUG
```

## flair_junctions_from_sam

### Tool Description
Extract splice junctions from SAM/BAM alignments into a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: junctions_from_sam [options]

Options:
  -h, --help           show this help message and exit
  -s SAM_FILE          SAM/BAM file of read alignments to junctions and
                       the genome. More than one file can be listed,
                       but comma-delimited, e.g file_1.bam,file_2.bam
  --unique             Only keeps uniquely aligned reads. Looks at NH
                       tag to be 1 for this information.
  -n NAME              Name prefixed used for output BED file.
                       Default=junctions_from_sam
  -l READ_LENGTH       Expected read length if all reads should be of
                       the same length
  -c CONFIDENCE_SCORE  The mininmum entropy score a junction
                       has to have in order to be considered
                       confident. The entropy score =
                       -Shannon Entropy. Default=1.0
  -j FORCED_JUNCTIONS  File containing intron coordinates
                       that correspond to junctions that will be
                       kept regardless of the confidence score.
  -v                   Will run the program with junction strand ambiguity
                       messages
```

## flair_mark_intron_retention

### Tool Description
Mark intron retention events in an isoform bed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mark_intron_retention in.bed out_isoforms.bed out_introns.txt
```

## flair_plot_isoform_usage

### Tool Description
Plot isoform models and usage proportions for one gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_isoform_usage [-h] [-o O] [--min_reads MIN_READS] [-v VCF]
                          [--palette PALETTE]
                          isoforms counts_matrix gene_name

The script will produce two images, one of the isoform models and another of
the usage proportions. The most highly expressed isoforms across all the
samples will be plotted. The minor isoforms are aggregated into a gray bar.
You can toggle min_reads or color_palette to plot more isoforms.

positional arguments:
  isoforms              isoforms in bed format
  counts_matrix         isoform counts
  gene_name             Name of gene, must correspond with the gene names in
                        the isoform and counts matrix files

options:
  -h, --help            show this help message and exit
  -o O                  prefix used for output files (default=gene_name)
  --min_reads MIN_READS
                        minimum number of total supporting reads for an
                        isoform to be visualized (default=6)
  -v VCF, --vcf VCF     VCF containing the isoform names that include each
                        variant in the last sample column
  --palette PALETTE     provide a palette file if you would like to visualize
                        more than 7 isoforms at once or change the palette
                        used. each line contains a hex color for each isoform
```

## flair_predictProductivity

### Tool Description
Predict open reading frames and productivity of isoforms.

### Metadata
- **Docker Image**: quay.io/biocontainers/flair:3.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/BrooksLabUCSC/flair
- **Package**: https://anaconda.org/channels/bioconda/packages/flair/overview
- **Validation**: PASS

### Original Help Text
```text
usage: predictProductivity [-h] -i INPUT_ISOFORMS -g GTF -f GENOME_FASTA -o
                           OUTPUT [--quiet] [--append_column]
                           (--firstTIS | --longestORF)

predictProductivity - a tool.

options:
  -h, --help            show this help message and exit
  -i INPUT_ISOFORMS, --input_isoforms INPUT_ISOFORMS
                        Input collapsed isoforms in bed12 format.
  -g GTF, --gtf GTF     Gencode annotation file.
  -f GENOME_FASTA, --genome_fasta GENOME_FASTA
                        Fasta file containing transcript sequences.
  -o OUTPUT, --output OUTPUT
                        prefix of output files
  --quiet               Do not display progress
  --append_column       Append prediction as an additional column in file
  --firstTIS            Defined ORFs by the first annotated TIS.
  --longestORF          Defined ORFs by the longest open reading frame.
```

## Metadata
- **Skill**: generated
