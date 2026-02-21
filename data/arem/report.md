# arem CWL Generation Report

## arem

### Tool Description
Model-based Analysis for ChIP-Sequencing

### Metadata
- **Docker Image**: quay.io/biocontainers/arem:1.0.1--py27_0
- **Homepage**: http://cbcl.ics.uci.edu/AREM
- **Package**: https://anaconda.org/channels/bioconda/packages/arem/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arem/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: arem <-t tfile> [-n name] [-g genomesize] [options]

Example: arem -t ChIP.bam -c Control.bam -f BAM -g h -n test -w --call-subpeaks


arem -- Model-based Analysis for ChIP-Sequencing

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit.
  -t TFILE, --treatment=TFILE
                        ChIP-seq treatment files. REQUIRED. When ELANDMULTIPET
                        is selected, you must provide two files separated by
                        comma, e.g.
                        s_1_1_eland_multi.txt,s_1_2_eland_multi.txt
  -c CFILE, --control=CFILE
                        Control files. When ELANDMULTIPET is selected, you
                        must provide two files separated by comma, e.g.
                        s_2_1_eland_multi.txt,s_2_2_eland_multi.txt
  -n NAME, --name=NAME  Experiment name, which will be used to generate output
                        file names. DEFAULT: "NA"
  -f FORMAT, --format=FORMAT
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDMULTIPET" or "ELANDEXPORT" or
                        "SAM" or "BAM" or "BOWTIE". The default AUTO option
                        will let AREM decide which format the file is. Please
                        check the definition in 00README file if you choose EL
                        AND/ELANDMULTI/ELANDMULTIPET/ELANDEXPORT/SAM/BAM/BOWTI
                        E. DEFAULT: "AUTO"
  --petdist=PETDIST     Best distance between Pair-End Tags. Only available
                        when format is 'ELANDMULTIPET'. DEFAULT: 200
  -g GSIZE, --gsize=GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2.7e9), 'mm' for mouse
                        (1.87e9), 'ce' for C. elegans (9e7) and 'dm' for
                        fruitfly (1.2e8), Default:hs
  -s TSIZE, --tsize=TSIZE
                        Tag size. This will overide the auto detected tag
                        size. DEFAULT: 25
  --bw=BW               Band width. This value is only used while building the
                        shifting model. DEFAULT: 300
  -p PVALUE, --pvalue=PVALUE
                        Pvalue cutoff for peak detection. DEFAULT: 1e-5
  -m MFOLD, --mfold=MFOLD
                        Select the regions within MFOLD range of high-
                        confidence enrichment ratio against background to
                        build model. The regions must be lower than upper
                        limit, and higher than the lower limit. DEFAULT:10,30
  --nolambda            If True, AREM will use fixed background lambda as
                        local lambda for every peak region. Normally, AREM
                        calculates a dynamic local lambda to reflect the local
                        bias due to potential chromatin structure.
  --slocal=SMALLLOCAL   The small nearby region in basepairs to calculate
                        dynamic lambda. This is used to capture the bias near
                        the peak summit region. Invalid if there is no control
                        data. DEFAULT: 1000
  --llocal=LARGELOCAL   The large nearby region in basepairs to calculate
                        dynamic lambda. This is used to capture the surround
                        bias. DEFAULT: 10000.
  --off-auto            Whether turn off the auto pair model process. If not
                        set, when AREM failed to build paired model, it will
                        use the nomodel settings, the '--shiftsize' parameter
                        to shift and extend each tags. DEFAULT: False
  --nomodel             Whether or not to build the shifting model. If True,
                        AREM will not build model. by default it means
                        shifting size = 100, try to set shiftsize to change
                        it. DEFAULT: False
  --shiftsize=SHIFTSIZE
                        The arbitrary shift size in bp. When nomodel is true,
                        AREM will use this value as 1/2 of fragment size.
                        DEFAULT: 100
  --keep-dup=KEEPDUPLICATES
                        It controls the AREM behavior towards duplicate tags
                        at the exact same location -- the same coordination
                        and the same strand. The default 'auto' option makes
                        MACS calculate the maximum tags at the exact same
                        location based on binomal distribution using 1e-5 as
                        pvalue cutoff; and the 'all' option keeps every tags.
                        If an integer is given, at most this number of tags
                        will be kept at the same location. Default: auto
  --to-small            When set, scale the larger dataset down to the smaller
                        dataset, by default, the smaller dataset will be
                        scaled towards the larger dataset. DEFAULT: False
  -w, --wig             Whether or not to save extended fragment pileup at
                        every WIGEXTEND bps into a wiggle file. When --single-
                        profile is on, only one file for the whole genome is
                        saved. WARNING: this process is time/space consuming!!
  -B, --bdg             Whether or not to save extended fragment pileup at
                        every bp into a bedGraph file. When it's on, -w,
                        --space and --call-subpeaks will be ignored. When
                        --single-profile is on, only one file for the whole
                        genome is saved. WARNING: this process is time/space
                        consuming!!
  -S, --single-profile  When set, a single wiggle file will be saved for
                        treatment and input. Default: False
  --space=SPACE         The resoluation for saving wiggle files, by default,
                        MACS will save the raw tag count every 10 bps. Usable
                        only with '--wig' option.
  --call-subpeaks       If set, AREM will invoke Mali Salmon's PeakSplitter
                        soft through system call. If PeakSplitter can't be
                        found, an instruction will be shown for downloading
                        and installing the PeakSplitter package. -w option
                        needs to be on and -B should be off to let it work.
                        DEFAULT: False
  --verbose=VERBOSE     Set verbose level. 0: only show critical message, 1:
                        show additional warning message, 2: show process
                        information, 3: show debug messages. DEFAULT:2
  --diag                Whether or not to produce a diagnosis report. It's up
                        to 9X time consuming. Please check 00README file for
                        detail. DEFAULT: False
  --fe-min=FEMIN        For diagnostics, min fold enrichment to consider.
                        DEFAULT: 0
  --fe-max=FEMAX        For diagnostics, max fold enrichment to consider.
                        DEFAULT: maximum fold enrichment
  --fe-step=FESTEP      For diagnostics, fold enrichment step.  DEFAULT: 20
  --no-EM               Do NOT iteratively align multi-reads by E-M. Multi-
                        read probabilities will be based on quality scores or
                        uniform (if --no-quals) DEFAULT : FALSE
  --EM-converge-diff=MIN_CHANGE
                        The minimum entropy change between iterations before
                        halting E-M steps. DEFAULT : 1e-05
  --EM-min-score=MIN_SCORE
                        Minimum enrichment score. Windows below this threshold
                        will all look the same to the aligner. DEFAULT : 1.5
  --EM-max-score=MAX_SCORE
                        Maximum enrichment score. Windows above this threshold
                        will all look the same to the aligner, DEFAULT : No
                        Maximum
  --EM-show-graphs      generate diagnostic graphs for E-M. (requires
                        MATPLOTLIB). DEFAULT : FALSE
  --quality-scale=QUAL_SCALE
                        Initial alignment probabilities are determined by read
                        quality and mismatches. Each possible alignment is
                        assigned a probability from the product over all bases
                        of either 1-p(ReadError_base) when there is no
                        mismatch, or p(ReadError_base) when the called base
                        disagrees with the reference.  You may also select a
                        uniform initialization. Read quality scale is the must
                        be one of ['auto', 'sanger+33', 'illumina+64'].
                        DEFAULT : auto
  --random-multi        Convert all multi reads to unique reads by selecting
                        one alignment at random for each read. DEFAULT : False
  --no-multi            Throw away all reads that have more than one alignment
  --no-greedy-caller    Use AREM default peak caller instead of the greedy
                        caller. This normally results in wider, less enriched
                        peaks, especially with multi-reads. DEFAULT : False
  --no-map-quals        Do not use mapping probabilities as priors in each
                        update step; just use relative enrichment. DEFAULT :
                        False
  --prior-snp=PRIOR_PROB_SNP
                        Prior probability that a SNP occurs at any base in the
                        genome. DEFAULT : 0.001
  --write-read-probs    Write out all final reads, including their alignment
                        probabilities as a BED file. DEFAULT : FALSE
```


## Metadata
- **Skill**: not generated
