# telr CWL Generation Report

## telr

### Tool Description
Program for detecting non-reference TEs in long read data

### Metadata
- **Docker Image**: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bergmanlab/telr
- **Package**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bergmanlab/telr
- **Stars**: N/A
### Original Help Text
```text
usage: telr [-h] -i READS -r REFERENCE -l LIBRARY [--aligner ALIGNER]
            [--assembler ASSEMBLER] [--polisher POLISHER] [-x PRESETS]
            [-p POLISH_ITERATIONS] [-o OUT] [-t THREAD] [-g GAP] [-v OVERLAP]
            [--flank_len FLANK_LEN] [--af_flank_interval AF_FLANK_INTERVAL]
            [--af_flank_offset AF_FLANK_OFFSET]
            [--af_te_interval AF_TE_INTERVAL] [--af_te_offset AF_TE_OFFSET]
            [--different_contig_name] [--minimap2_family] [-k]

Program for detecting non-reference TEs in long read data

required arguments:
  -i READS, --reads READS
                        reads in fasta/fastq format or read alignments in bam
                        format
  -r REFERENCE, --reference REFERENCE
                        reference genome in fasta format
  -l LIBRARY, --library LIBRARY
                        TE consensus sequences in fasta format

optional arguments:
  -h, --help            show this help message and exit
  --aligner ALIGNER     choose method for read alignment, please provide
                        'nglmr' or 'minimap2' (default = 'nglmr')
  --assembler ASSEMBLER
                        Choose the method to be used for local contig assembly
                        step, please provide 'wtdbg2' or 'flye' (default =
                        'wtdbg2')
  --polisher POLISHER   Choose the method to be used for local contig
                        polishing step, please provide 'wtdbg2' or 'flye'
                        (default = 'wtdbg2')
  -x PRESETS, --presets PRESETS
                        parameter presets for different sequencing
                        technologies, please provide 'pacbio' or 'ont'
                        (default = 'pacbio')
  -p POLISH_ITERATIONS, --polish_iterations POLISH_ITERATIONS
                        iterations of contig polishing (default = 1)
  -o OUT, --out OUT     directory to output data (default = '.')
  -t THREAD, --thread THREAD
                        max cpu threads to use (default = '1')
  -g GAP, --gap GAP     max gap size for flanking sequence alignment (default
                        = '20')
  -v OVERLAP, --overlap OVERLAP
                        max overlap size for flanking sequence alignment
                        (default = '20')
  --flank_len FLANK_LEN
                        flanking sequence length (default = '500')
  --af_flank_interval AF_FLANK_INTERVAL
                        5' and 3'flanking sequence interval size used for
                        allele frequency estimation (default = '100')
  --af_flank_offset AF_FLANK_OFFSET
                        5' and 3' flanking sequence offset size used for
                        allele frequency estimation (default = '200')
  --af_te_interval AF_TE_INTERVAL
                        5' and 3' te sequence interval size used for allele
                        frequency estimation (default: '50')
  --af_te_offset AF_TE_OFFSET
                        5' and 3' te sequence offset size used for allele
                        frequency estimation (default: '50')
  --different_contig_name
                        If provided then TELR does not require the contig name
                        to match before and after annotation liftover
                        (default: require contig name to be the same before
                        and after liftover)
  --minimap2_family     If provided then minimap2 will be used to annotate TE
                        families in the assembled contigs (default: use
                        repeatmasker for contig TE annotation)
  -k, --keep_files      If provided then all intermediate files will be kept
                        (default: remove intermediate files)
```


## Metadata
- **Skill**: generated

## telr_ngmlr

### Tool Description
ngmlr 0.2.7 (build: Feb 21 2022 18:53:53, start: 2026-02-25.22:02:43)

### Metadata
- **Docker Image**: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bergmanlab/telr
- **Package**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Validation**: PASS
### Original Help Text
```text
ngmlr 0.2.7 (build: Feb 21 2022 18:53:53, start: 2026-02-25.22:02:43)
Contact: philipp.rescheneder@univie.ac.at

Usage: ngmlr [options] -r <reference> -q <reads> [-o <output>]

Input/Output:
    -r <file>,  --reference <file>
        (required)  Path to the reference genome (FASTA/Q, can be gzipped)
    -q <file>,  --query <file>
        Path to the read file (FASTA/Q) [/dev/stdin]
    -o <string>,  --output <string>
        Adds RG:Z:<string> to all alignments in SAM/BAM [none]
    --skip-write
        Don't write reference index to disk [false]
    --bam-fix
        Report reads with > 64k CIGAR operations as unmapped. Required to be compatibel to BAM format [false]
    --rg-id <string>
        Adds RG:Z:<string> to all alignments in SAM/BAM [none]
    --rg-sm <string>
        RG header: Sample [none]
    --rg-lb <string>
        RG header: Library [none]
    --rg-pl <string>
        RG header: Platform [none]
    --rg-ds <string>
        RG header: Description [none]
    --rg-dt <string>
        RG header: Date (format: YYYY-MM-DD) [none]
    --rg-pu <string>
        RG header: Platform unit [none]
    --rg-pi <string>
        RG header: Median insert size [none]
    --rg-pg <string>
        RG header: Programs [none]
    --rg-cn <string>
        RG header: sequencing center [none]
    --rg-fo <string>
        RG header: Flow order [none]
    --rg-ks <string>
        RG header: Key sequence [none]

General:
    -t <int>,  --threads <int>
        Number of threads [1]
    -x <pacbio, ont>,  --presets <pacbio, ont>
        Parameter presets for different sequencing technologies [pacbio]
    -i <0-1>,  --min-identity <0-1>
        Alignments with an identity lower than this threshold will be discarded [0.65]
    -R <int/float>,  --min-residues <int/float>
        Alignments containing less than <int> or (<float> * read length) residues will be discarded [0.25]
    --no-smallinv
        Don't detect small inversions [false]
    --no-lowqualitysplit
        Split alignments with poor quality [false]
    --verbose
        Debug output [false]
    --no-progress
        Don't print progress info while mapping [false]

Advanced:
    --match <float>
        Match score [2]
    --mismatch <float>
        Mismatch score [-5]
    --gap-open <float>
        Gap open score [-5]
    --gap-extend-max <float>
        Gap open extend max [-5]
    --gap-extend-min <float>
        Gap open extend min [-1]
    --gap-decay <float>
        Gap extend decay [0.15]
    -k <10-15>,  --kmer-length <10-15>
        K-mer length in bases [13]
    --kmer-skip <int>
        Number of k-mers to skip when building the lookup table from the reference [2]
    --bin-size <int>
        Sets the size of the grid used during candidate search [4]
    --max-segments <int>
        Max number of segments allowed for a read per kb [1]
    --subread-length <int>
        Length of fragments reads are split into [256]
    --subread-corridor <int>
        Length of corridor sub-reads are aligned with [40]
```

## telr_sniffles

### Tool Description
Structural Variant Caller

### Metadata
- **Docker Image**: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bergmanlab/telr
- **Package**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: sniffles [options] -m <sorted.bam> -v <output.vcf> 
Version: 1.0.12
Contact: fritz.sedlazeck@gmail.com

Input/Output:
    -m <string>,  --mapped_reads <string>
        (required)  Sorted bam File
    -v <string>,  --vcf <string>
        VCF output file name []
    -b <string>,  --bedpe <string>
         bedpe output file name []
    --Ivcf <string>
        Input VCF file name. Enable force calling []
    --tmp_file <string>
        path to temporary file otherwise Sniffles will use the current directory. []

General:
    -s <int>,  --min_support <int>
        Minimum number of reads that support a SV. [10]
    --max_num_splits <int>
        Maximum number of splits per read to be still taken into account. [7]
    -d <int>,  --max_distance <int>
        Maximum distance to group SV together. [1000]
    -t <int>,  --threads <int>
        Number of threads to use. [3]
    -l <int>,  --min_length <int>
        Minimum length of SV to be reported. [30]
    -q <int>,  --minmapping_qual <int>
        Minimum Mapping Quality. [20]
    -n <int>,  --num_reads_report <int>
        Report up to N reads that support the SV in the vcf file. -1: report all. [0]
    -r <int>,  --min_seq_size <int>
        Discard read if non of its segment is larger then this. [2000]
    -z <int>,  --min_zmw <int>
        Discard SV that are not supported by at least x zmws. This applies only for PacBio recognizable reads. [0]
    --cs_string
        Enables the scan of CS string instead of Cigar and MD.  [false]

Clustering/phasing and genotyping:
    --genotype
        Inactivated: Automatically true. [true]
    --cluster
        Enables Sniffles to phase SVs that occur on the same reads [false]
    --cluster_support <int>
        Minimum number of reads supporting clustering of SV. [1]
    -f <float>,  --allelefreq <float>
        Threshold on allele frequency (0-1).  [0]
    --min_homo_af <float>
        Threshold on allele frequency (0-1).  [0.8]
    --min_het_af <float>
        Threshold on allele frequency (0-1).  [0.3]

Advanced:
    --report_BND
        Dont report BND instead use Tra in vcf output.  [true]
    --not_report_seq
        Dont report sequences for indels in vcf output. (Beta version!)  [false]
    --report-seq
        Inactivated (see not_report_seq). [false]
    --ignore_sd
        Ignores the sd based filtering.  [false]
    --ccs_reads
        Preset CCS Pacbio setting. (Beta)  [false]
    --report_str
        Enables the report of str. (alpha testing)  [false]

Parameter estimation:
    --skip_parameter_estimation
        Enables the scan if only very few reads are present.  [false]
    --del_ratio <float>
        Estimated ration of deletions per read (0-1).  [0.0458369]
    --ins_ratio <float>
        Estimated ratio of insertions per read (0-1).  [0.049379]
    --max_diff_per_window <int>
        Maximum differences per 100bp. [50]
    --max_dist_aln_events <int>
        Maximum distance between alignment (indel) events. [4]
```

## telr_minimap2

### Tool Description
Minimap2 is a versatile tool for sequence alignment. It can be used for various tasks including indexing reference genomes, mapping long reads (PacBio, Nanopore), short reads, and performing overlap detection for assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/telr:1.1--pyhdfd78af_0
- **Homepage**: https://github.com/bergmanlab/telr
- **Package**: https://anaconda.org/channels/bioconda/packages/telr/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: minimap2 [options] <target.fa>|<target.idx> [query.fa] [...]
Options:
  Indexing:
    -H           use homopolymer-compressed k-mer (preferrable for PacBio)
    -k INT       k-mer size (no larger than 28) [15]
    -w INT       minimizer window size [10]
    -I NUM       split index for every ~NUM input bases [8G]
    -d FILE      dump index to FILE []
  Mapping:
    -f FLOAT     filter out top FLOAT fraction of repetitive minimizers [0.0002]
    -g NUM       stop chain enlongation if there are no minimizers in INT-bp [5000]
    -G NUM       max intron length (effective with -xsplice; changing -r) [200k]
    -F NUM       max fragment length (effective with -xsr or in the fragment mode) [800]
    -r NUM[,NUM] chaining/alignment bandwidth and long-join bandwidth [500,20000]
    -n INT       minimal number of minimizers on a chain [3]
    -m INT       minimal chaining score (matching bases minus log gap penalty) [40]
    -X           skip self and dual mappings (for the all-vs-all mode)
    -p FLOAT     min secondary-to-primary score ratio [0.8]
    -N INT       retain at most INT secondary alignments [5]
  Alignment:
    -A INT       matching score [2]
    -B INT       mismatch penalty (larger value for lower divergence) [4]
    -O INT[,INT] gap open penalty [4,24]
    -E INT[,INT] gap extension penalty; a k-long gap costs min{O1+k*E1,O2+k*E2} [2,1]
    -z INT[,INT] Z-drop score and inversion Z-drop score [400,200]
    -s INT       minimal peak DP alignment score [80]
    -u CHAR      how to find GT-AG. f:transcript strand, b:both strands, n:don't match GT-AG [n]
    -J INT       splice mode. 0: original minimap2 model; 1: miniprot model [1]
  Input/Output:
    -a           output in the SAM format (PAF by default)
    -o FILE      output alignments to FILE [stdout]
    -L           write CIGAR with >65535 ops at the CG tag
    -R STR       SAM read group line in a format like '@RG\tID:foo\tSM:bar' []
    -c           output CIGAR in PAF
    --cs[=STR]   output the cs tag; STR is 'short' (if absent) or 'long' [none]
    --MD         output the MD tag
    --eqx        write =/X CIGAR operators
    -Y           use soft clipping for supplementary alignments
    -t INT       number of threads [3]
    -K NUM       minibatch size for mapping [500M]
    --version    show version number
  Preset:
    -x STR       preset (always applied before other options; see minimap2.1 for details) []
                 - map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping
                 - map-hifi - PacBio HiFi reads vs reference mapping
                 - ava-pb/ava-ont - PacBio/Nanopore read overlap
                 - asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence
                 - splice/splice:hq - long-read/Pacbio-CCS spliced alignment
                 - sr - genomic short-read mapping

See `man ./minimap2.1' for detailed description of these and other advanced command-line options.
```

