# pypints CWL Generation Report

## pypints_pints_caller

### Tool Description
Peak Identifier for Nascent Transcripts Starts

### Metadata
- **Docker Image**: quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0
- **Homepage**: https://pints.yulab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/pypints/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pypints/overview
- **Total Downloads**: 19.0K
- **Last updated**: 2025-05-14
- **GitHub**: https://github.com/hyulab/PINTS
- **Stars**: N/A
### Original Help Text
```text
usage: pints_caller [-h] [--bam-file [BAM_FILE ...]] [--save-to SAVE_TO]
                    --file-prefix FILE_PREFIX [--bw-pl [BW_PL ...]]
                    [--bw-mn [BW_MN ...]] [--ct-bw-pl [CT_BW_PL ...]]
                    [--ct-bw-mn [CT_BW_MN ...]] [--ct-bam [CT_BAM ...]]
                    [--exp-type {CoPRO,GROcap,PROcap,CAGE,NETCAGE,RAMPAGE,csRNAseq,STRIPEseq,PROseq,GROseq,R_5,R_3,R1_5,R1_3,R2_5,R2_3}]
                    [--reverse-complement] [--dont-merge-reps]
                    [-f [FILTERS ...]]
                    [--adjust-method {fdr_bh,bonferroni,fdr_tsbh,fdr_tsbky}]
                    [--fdr-target FDR_TARGET]
                    [--close-threshold CLOSE_THRESHOLD]
                    [--stringent-pairs-only]
                    [--min-length-opposite-peaks MIN_LEN_OPPOSITE_PEAKS]
                    [--mapq-threshold MAPQ_THRESHOLD]
                    [--small-peak-threshold SMALL_PEAK_THRESHOLD]
                    [--max-window-size WINDOW_SIZE_THRESHOLD]
                    [--remove-sticks] [--annotation-gtf ANNOTATION_GTF]
                    [--tss-extension TSS_EXTENSION]
                    [--focused-chrom FOCUSED_CHROM] [--alpha DONOR_TOLERANCE]
                    [--ce-trigger CE_TRIGGER]
                    [--top-peak-threshold TOP_PEAK_THRESHOLD]
                    [--min-mu-percent MIN_MU_PERCENT]
                    [--peak-distance PEAK_DISTANCE] [--peak-width PEAK_WIDTH]
                    [--div-size-min DIV_SIZE_MIN]
                    [--summit-dist-min SUMMIT_DIST_MIN]
                    [--model {ZIP,Poisson}] [--IQR-strategy {bgIQR,pkIQR}]
                    [--disable-ler] [--disable-eler]
                    [--eler-lower-bound ELER_LOWER_BOUND] [--disable-small]
                    [--sensitive] [--fc FC_CUTOFF]
                    [--init-dens-cutoff INIT_DENS_CUTOFF]
                    [--init-height-cutoff INIT_HEIGHT_CUTOFF]
                    [--epig-annotation EPIG_ANNOTATION]
                    [--relaxed-fdr-target RELAXED_FDR_TARGET]
                    [--chromosome-start-with CHROMOSOME_STARTSWITH]
                    [--dont-output-chrom-size] [--dont-check-updates]
                    [--disable-qc] [--strict-qc] [--debug]
                    [--dont-borrow-info-reps] [--thread THREAD_N] [-v]

Peak Identifier for Nascent Transcripts Starts

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Input/Output:
  --bam-file [BAM_FILE ...]
                        input bam file, if you want to use bigwig files,
                        please use --bw-pl and --bw-mn (default: None)
  --save-to SAVE_TO     save peaks to this path (a folder), by default,
                        current folder (default: .)
  --file-prefix FILE_PREFIX
                        prefix to all intermediate files (default: 1)
  --bw-pl [BW_PL ...]   Bigwig for plus strand. If you want to use bigwig
                        instead of BAM, please set bam_file to bigwig
                        (default: None)
  --bw-mn [BW_MN ...]   Bigwig for minus strand. If you want to use bigwig
                        instead of BAM, please set bam_file to bigwig
                        (default: None)
  --ct-bw-pl [CT_BW_PL ...]
                        Bigwig for control/input (plus strand). If you want to
                        use bigwig instead of BAM, please use --ct-bam
                        (default: None)
  --ct-bw-mn [CT_BW_MN ...]
                        Bigwig for input/control (minus strand). If you want
                        to use bigwig instead of BAM, please use --ct-bam
                        (default: None)
  --ct-bam [CT_BAM ...]
                        Bam file for input/control (minus strand). If you want
                        to use bigwig instead of BAM, please use --input-bw-pl
                        and --input-bw-mn (default: None)
  --exp-type {CoPRO,GROcap,PROcap,CAGE,NETCAGE,RAMPAGE,csRNAseq,STRIPEseq,PROseq,GROseq,R_5,R_3,R1_5,R1_3,R2_5,R2_3}
                        Type of experiment. If the experiment is not listed as
                        a choice, or you know the position of RNA ends on the
                        reads and you want to override the defaults, you can
                        specify: R_5 (5' of the read for single-end lib), R_3
                        (3' of the read for single-end lib), R1_5 (5' of the
                        read1 for paired-end lib), R1_3 (3' of the read1 for
                        paired-end lib), R2_5 (5' of the read2 for paired-end
                        lib), or R2_3 (3' of the read2 for paired-end lib)
                        (default: CoPRO)
  --reverse-complement  Set this switch if reads in this library represent the
                        reverse complement of RNAs, like PROseq (default:
                        False)
  --dont-merge-reps     Don't merge replicates (this is the default setting
                        for the previous versions) (default: True)
  -f [FILTERS ...], --filters [FILTERS ...]
                        reads from chromosomes whose names contain any matches
                        in filters will be ignored (default: [])

Filtering:
  --adjust-method {fdr_bh,bonferroni,fdr_tsbh,fdr_tsbky}
                        method for calculating adjusted p-vals (default:
                        fdr_bh)
  --fdr-target FDR_TARGET
                        FDR target for multiple testing (default: 0.1)
  --close-threshold CLOSE_THRESHOLD
                        Distance threshold for two peaks (on opposite strands)
                        to be merged (default: 300)
  --stringent-pairs-only
                        Only consider elements as bidirectional when both of
                        the two peaks are significant according to their
                        p-values (default: False)
  --min-length-opposite-peaks MIN_LEN_OPPOSITE_PEAKS, --min-lengths-opposite-peaks MIN_LEN_OPPOSITE_PEAKS
                        Minimum length requirement for peaks on the opposite
                        strand to be paired, set it to 0 to loose this
                        requirement (default: 0)
  --mapq-threshold MAPQ_THRESHOLD
                        Minimum mapping quality (default: 30)
  --small-peak-threshold SMALL_PEAK_THRESHOLD
                        Threshold for small peaks, peaks with width smaller
                        than this value will be required to run extra test
                        (default: 5)
  --max-window-size WINDOW_SIZE_THRESHOLD
                        max size of divergent windows (default: 2000)
  --remove-sticks       Set this switch to remove stick-like peaks (signal on
                        a single position) (default: True)

Edge trimming:
  --annotation-gtf ANNOTATION_GTF
                        Gene annotation file (gtf) format for learning the
                        threshold for edge trimming. If this is specified,
                        other related parameters like --donor-tolerance will
                        be ignored. (default: None)
  --tss-extension TSS_EXTENSION
                        BPs to be extended from annotated TSSs, these extended
                        regions will be used to minimize overlaps between
                        called peaks. (default: 200)
  --focused-chrom FOCUSED_CHROM
                        If --annotation-gtf is specified, you use this
                        parameter to change which chromosome the tool should
                        learn the values from. (default: chr1)
  --alpha DONOR_TOLERANCE, --donor-tolerance DONOR_TOLERANCE
                        The stringency for PINTS to cluster nearby TSSs into a
                        peak. 0 is the least stringent; 1 is the most
                        stringent. (default: 0.3)
  --ce-trigger CE_TRIGGER
                        Trigger for receptor tolerance checking (default: 3)

Peak properties:
  --top-peak-threshold TOP_PEAK_THRESHOLD
                        For very short peaks (smaller than --small-peak-
                        threshold), we use the quantile threshold for peak
                        densities as the background density (default: 0.75)
  --min-mu-percent MIN_MU_PERCENT
                        Local backgrounds smaller than this percentile among
                        all peaks will be replaced. (default: 0.1)
  --peak-distance PEAK_DISTANCE
                        Required minimal horizontal distance (>= 1) in samples
                        between neighbouring peaks. (default: 1)
  --peak-width PEAK_WIDTH
                        Required width of peaks in samples. (default: None)
  --div-size-min DIV_SIZE_MIN
                        Min size for a divergent peak (default: 0)
  --summit-dist-min SUMMIT_DIST_MIN
                        Min dist between two summit (default: 0)

Testing:
  --model {ZIP,Poisson}
                        Statistical model for testing the significance of
                        peaks. (default: ZIP)
  --IQR-strategy {bgIQR,pkIQR}
                        IQR strategy, can be bgIQR (more robust) or pkIQR
                        (more efficient) (default: bgIQR)
  --disable-ler         Disable Local Environment Refinement (default: False)
  --disable-eler        Disable Enhanced Local Environment Refinement
                        (default: True)
  --eler-lower-bound ELER_LOWER_BOUND
                        Lower bound of the empirical estimation for the
                        density of potential true peaks in the local
                        background. (default: 1.0)
  --disable-small       Set this switch to prevent PINTS from reporting very
                        short peaks(shorter than --small-peak-threshold)
                        (default: False)
  --sensitive           Set this switch to enable more sensitive peak calling
                        (default: False)
  --fc FC_CUTOFF        When using the sensitive mode, this sets the cutoff
                        for applying the likelihood ratio test. (default: 1.5)
  --init-dens-cutoff INIT_DENS_CUTOFF
                        Peaks with initiation density lower than this cutoff
                        will not be tested in the sensitive mode. (default:
                        0.25)
  --init-height-cutoff INIT_HEIGHT_CUTOFF
                        Peaks with initiation summit lower than this cutoff
                        will not be tested in the sensitive mode. (default: 4)

Other:
  --epig-annotation EPIG_ANNOTATION
                        Refine peak calls with compiled epigenomic annotation
                        from the PINTS web server. Values should be the name
                        of the biosample, for example, K562. (default: None)
  --relaxed-fdr-target RELAXED_FDR_TARGET
                        Relaxed FDR cutoff for TREs overlap with epigenomic
                        annotations (default: 0.2)
  --chromosome-start-with CHROMOSOME_STARTSWITH
                        Only keep reads mapped to chromosomes with this prefix
                        (default: )
  --dont-output-chrom-size
                        Don't write chromosome dict to local folder (not
                        recommended) (default: True)
  --dont-check-updates  Set this switch to disable update check. (default:
                        True)
  --disable-qc          Disable on-the-fly quality control (default: False)
  --strict-qc           Raise exceptions if PINTS detects abnormalities during
                        on-the-fly quality control; otherwise, PINTS prints
                        warning messages. (default: False)
  --debug               Save diagnostics (independent filtering and pval dist)
                        to local folder (default: False)
  --dont-borrow-info-reps
                        Don't borrow information from reps to refine calling
                        of divergent elements (default: True)
  --thread THREAD_N     Max number of threads PINTS can create (default: 1)
```


## pypints_pints_visualizer

### Tool Description
Visualize BAM files with PINTs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypints:1.2.1--pyh7e72e81_0
- **Homepage**: https://pints.yulab.org
- **Package**: https://anaconda.org/channels/bioconda/packages/pypints/overview
- **Validation**: PASS

### Original Help Text
```text
usage: pints_visualizer [-h] -b BAM [-e BAM_PARSER] [-r] [-c]
                        [--mapq-threshold MAPQ_THRESHOLD]
                        [--chromosome-start-with CHROMOSOME_STARTSWITH]
                        [-o OUTPUT_PREFIX] [-f [FILTERS ...]] [-n NORM_FACT]
                        [-s] [-v]

options:
  -h, --help            show this help message and exit
  -b BAM, --bam BAM
  -e BAM_PARSER, --exp-type BAM_PARSER
                        Type of experiment, acceptable values are:
                        CoPRO/GROcap/GROseq/PROcap/PROseq, or if you know the
                        position of RNA ends which you're interested on the
                        reads, you can specify R_5, R_3, R1_5, R1_3, R2_5 or
                        R2_3 (default: None)
  -r, --reverse-complement
                        Set this switch if reads in this library represent the
                        reverse complement of nascent RNAs, like PROseq
                        (default: False)
  -c, --rpm             Set this switch if you want to use RPM to normalize
                        the outputs (default: False)
  --mapq-threshold MAPQ_THRESHOLD
                        Minimum mapping quality (default: 30)
  --chromosome-start-with CHROMOSOME_STARTSWITH
                        Only keep reads mapped to chromosomes with this prefix
                        (default: chr)
  -o OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
  -f [FILTERS ...], --filters [FILTERS ...]
                        reads from chromosomes whose names contain any matches
                        in filters will be ignored (default: None)
  -n NORM_FACT, --norm-fact NORM_FACT
                        Normalization factor, can be generated by
                        normalizer.py (default: 1.0)
  -s, --cache           Set this switch if you want to reuse the intermediate
                        .npy files. (default: False)
  -v, --version         show program's version number and exit
```

