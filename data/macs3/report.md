# macs3 CWL Generation Report

## macs3_callpeak

### Tool Description
Model-based Analysis of ChIP-Seq (MACS) for identifying transcript factor binding sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Total Downloads**: 19.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/macs3-project/MACS
- **Stars**: N/A
### Original Help Text
```text
usage: macs3 callpeak [-h] -t TFILE [TFILE ...] [-c [CFILE ...]]
                      [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE,FRAG}]
                      [-g GSIZE] [-s TSIZE] [--keep-dup KEEPDUPLICATES]
                      [--barcodes BARCODEFILE] [--max-count MAXCOUNT]
                      [--outdir OUTDIR] [-n NAME] [-B] [--verbose VERBOSE]
                      [--trackline] [--SPMR] [--nomodel] [--shift SHIFT]
                      [--extsize EXTSIZE] [--bw BW] [--d-min D_MIN]
                      [-m MFOLD MFOLD] [--fix-bimodal] [-q QVALUE | -p PVALUE]
                      [--scale-to {large,small}] [--down-sample] [--seed SEED]
                      [--tempdir TEMPDIR] [--nolambda] [--slocal SMALLLOCAL]
                      [--llocal LARGELOCAL] [--max-gap MAXGAP]
                      [--min-length MINLEN] [--broad]
                      [--broad-cutoff BROADCUTOFF] [--cutoff-analysis]
                      [--call-summits] [--fe-cutoff FECUTOFF] [--to-large]
                      [--ratio RATIO] [--buffer-size BUFFER_SIZE]

optional arguments:
  -h, --help            show this help message and exit

Input files arguments:
  -t TFILE [TFILE ...], --treatment TFILE [TFILE ...]
                        ChIP-seq treatment file. If multiple files are given
                        as '-t A B C', then they will all be read and pooled
                        together. REQUIRED.
  -c [CFILE ...], --control [CFILE ...]
                        Control file. If multiple files are given as '-c A B
                        C', they will be pooled to estimate ChIP-seq
                        background noise.
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE,FRAG}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE,FRAG}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE" or "BAMPE" or "BEDPE" or "FRAG". The default
                        AUTO option will let MACS decide which format (except
                        for BAMPE, BEDPE, and FRAG which should be implicitly
                        set) the file is. Please check the definition in
                        README. Please note that if the format is set as
                        BAMPE, BEDPE or FRAG, MACS3 will call its special
                        Paired-end mode to call peaks by piling up the actual
                        ChIPed fragments defined by both aligned ends, instead
                        of predicting the fragment size first and extending
                        reads. Also please note that the BEDPE only contains
                        three columns, and is NOT the same BEDPE format used
                        by BEDTOOLS. The FRAG format is for single-cell ATAC-
                        seq fragment file which is a five columns BEDPE file
                        with extra barcode and fragment count column. Please
                        note that if FRAG is used, MACS3 won't remove any
                        duplicates, i.e. `--keep-dup` will be always set as
                        `all`. DEFAULT: "AUTO"
  -g GSIZE, --gsize GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2,913,022,398), 'mm' for
                        mouse (2,652,783,500), 'ce' for C. elegans
                        (100,286,401) and 'dm' for fruitfly (142,573,017),
                        Default:hs. The effective genome size numbers for the
                        above four species are collected from Deeptools https:
                        //deeptools.readthedocs.io/en/develop/content/feature/
                        effectiveGenomeSize.html Please refer to deeptools to
                        define the best genome size you plan to use.
  -s TSIZE, --tsize TSIZE
                        Tag size/read length. This will override the auto
                        detected tag size. DEFAULT: Not set
  --keep-dup KEEPDUPLICATES
                        It controls the behavior towards duplicate tags at the
                        exact same location -- the same coordination and the
                        same strand. The 'auto' option makes MACS calculate
                        the maximum tags at the exact same location based on
                        binomal distribution using 1e-5 as pvalue cutoff; and
                        the 'all' option keeps every tags. If an integer is
                        given, at most this number of tags will be kept at the
                        same location. Note, if you've used samtools or picard
                        to flag reads as 'PCR/Optical duplicate' in bit 1024,
                        MACS3 will still read them although the reads may be
                        decided by MACS3 as duplicate later. If you plan to
                        rely on samtools/picard/any other tool to filter
                        duplicates, please remove those duplicate reads and
                        save a new alignment file then ask MACS3 to keep all
                        by '--keep-dup all'. Also, please note that if the
                        format is FRAG, this option will be ignored and MACS3
                        will behave always like '--keep-dup all'. The default
                        is to keep one tag at the same location. Default: 1
  --barcodes BARCODEFILE
                        A plain text file containing the barcodes for the
                        fragment file while the format is 'FRAG'. Won't have
                        any effect if the fromat is not 'FRAG'. Each row in
                        the file should only have the barcode string. MACS3
                        will extract only the fragments for the specified
                        barcodes.
  --max-count MAXCOUNT  In the FRAG format file, the fifth column indicates
                        the count of fragments found at the exact same
                        location from the same barcode. By default, MACS3
                        treats each fragment count as indicated in this
                        column. However, if this option is enabled and set as
                        a positive integer, MACS3 will not count more than the
                        specified number. If this is set as 0, MACS3 will
                        behave as the default setting to keep all counts.
                        Please note that `callpeak -f FRAG --max-count 1` is
                        supposed to generate the same result as `callpeak -f
                        BEDPE --keep-dup all` on fragment files. This option
                        will be ignored if the format is not FRAG.

Output arguments:
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -n NAME, --name NAME  Experiment name, which will be used to generate output
                        file names. DEFAULT: "NA"
  -B, --bdg             Whether or not to save extended fragment pileup, and
                        local lambda tracks (two files) at every bp into a
                        bedGraph file. DEFAULT: False
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
  --trackline           Instruct MACS to include trackline in the header of
                        output files, including the bedGraph, narrowPeak,
                        gappedPeak, BED format files. To include this
                        trackline is necessary while uploading them to the
                        UCSC genome browser. You can also mannually add these
                        trackline to corresponding output files. For example,
                        in order to upload narrowPeak file to UCSC browser,
                        add this to as the first line -- `track
                        type=narrowPeak name="my_peaks" description="my
                        peaks"`. Default: Not to include trackline.
  --SPMR                If True, MACS will SAVE signal per million reads for
                        fragment pileup profiles. It won't interfere with
                        computing pvalue/qvalue during peak calling, since
                        internally MACS3 keeps using the raw pileup and
                        scaling factors between larger and smaller dataset to
                        calculate statistics measurements. If you plan to use
                        the signal output in bedGraph to call peaks using
                        bdgcmp and bdgpeakcall, you shouldn't use this option
                        because you will end up with different results.
                        However, this option is recommended for displaying
                        normalized pileup tracks across many datasets. Require
                        -B to be set. Default: False

Shifting model arguments:
  --nomodel             Whether or not to build the shifting model. If True,
                        MACS will not build model. by default it means
                        shifting size = 100, try to set extsize to change it.
                        It's highly recommended that while you have many
                        datasets to process and you plan to compare different
                        conditions, aka differential calling, use both
                        'nomodel' and 'extsize' to make signal files from
                        different datasets comparable. DEFAULT: False
  --shift SHIFT         (NOT the legacy --shiftsize option!) The arbitrary
                        shift in bp. Use discretion while setting it other
                        than default value. When NOMODEL is set, MACS will use
                        this value to move cutting ends (5') towards 5'->3'
                        direction then apply EXTSIZE to extend them to
                        fragments. When this value is negative, ends will be
                        moved toward 3'->5' direction. Recommended to keep it
                        as default 0 for ChIP-Seq datasets, or -1 * half of
                        EXTSIZE together with EXTSIZE option for detecting
                        enriched cutting loci such as certain DNAseI-Seq
                        datasets. Note, you can't set values other than 0 if
                        format is BAMPE or BEDPE for paired-end data. DEFAULT:
                        0.
  --extsize EXTSIZE     The arbitrary extension size in bp. When nomodel is
                        true, MACS will use this value as fragment size to
                        extend each read towards 3' end, then pile them up.
                        It's exactly twice the number of obsolete SHIFTSIZE.
                        In previous language, each read is moved 5'->3'
                        direction to middle of fragment by 1/2 d, then
                        extended to both direction with 1/2 d. This is
                        equivalent to say each read is extended towards 5'->3'
                        into a d size fragment. DEFAULT: 200. EXTSIZE and
                        SHIFT can be combined when necessary. Check SHIFT
                        option.
  --bw BW               Band width for picking regions to compute fragment
                        size. This value is only used while building the
                        shifting model. Tweaking this is not recommended.
                        DEFAULT: 300
  --d-min D_MIN         Minimum fragment size in basepair. Any predicted
                        fragment size less than this will be excluded.
                        DEFAULT: 20
  -m MFOLD MFOLD, --mfold MFOLD MFOLD
                        Select the regions within MFOLD range of high-
                        confidence enrichment ratio against background to
                        build model. Fold-enrichment in regions must be lower
                        than upper limit, and higher than the lower limit. Use
                        as "-m 10 30". This setting is only used while
                        building the shifting model. Tweaking it is not
                        recommended. DEFAULT:5 50
  --fix-bimodal         Whether turn on the auto pair model process. If set,
                        when MACS failed to build paired model, it will use
                        the nomodel settings, the --exsize parameter to extend
                        each tags towards 3' direction. Not to use this
                        automate fixation is a default behavior now. DEFAULT:
                        False

Peak calling arguments:
  -q QVALUE, --qvalue QVALUE
                        Minimum FDR (q-value) cutoff for peak detection.
                        DEFAULT: 0.05. -q, and -p are mutually exclusive.
  -p PVALUE, --pvalue PVALUE
                        Pvalue cutoff for peak detection. DEFAULT: not set.
                        -q, and -p are mutually exclusive. If pvalue cutoff is
                        set, qvalue will not be calculated and reported as -1
                        in the final .xls file.
  --scale-to {large,small}
                        When set to 'small', scale the larger sample up to the
                        smaller sample. When set to 'larger', scale the
                        smaller sample up to the bigger sample. By default,
                        scale to 'small'. This option replaces the obsolete '
                        --to-large' option. The default behavior is
                        recommended since it will lead to less significant
                        p/q-values in general but more specific results. Keep
                        in mind that scaling down will influence control/input
                        sample more. DEFAULT: 'small', the choice is either
                        'small' or 'large'.
  --down-sample         When set, random sampling method will scale down the
                        bigger sample. By default, MACS uses linear scaling.
                        Warning: This option will make your result unstable
                        and irreproducible since each time, random reads would
                        be selected. Consider to use 'randsample' script
                        instead. <not implmented>If used together with --SPMR,
                        1 million unique reads will be randomly picked.</not
                        implemented> Caution: due to the implementation, the
                        final number of selected reads may not be as you
                        expected! DEFAULT: False
  --seed SEED           Set the random seed while down sampling data. Must be
                        a non-negative integer in order to be effective.
                        DEFAULT: not set
  --tempdir TEMPDIR     Optional directory to store temp files. DEFAULT: /tmp
  --nolambda            If True, MACS will use fixed background lambda as
                        local lambda for every peak region. Normally, MACS
                        calculates a dynamic local lambda to reflect the local
                        bias due to the potential chromatin accessibility.
  --slocal SMALLLOCAL   The small nearby region in basepairs to calculate
                        dynamic lambda. This is used to capture the bias near
                        the peak summit region. Invalid if there is no control
                        data. If you set this to 0, MACS will skip slocal
                        lambda calculation. *Note* that MACS will always
                        perform a d-size local lambda calculation while the
                        control data is available. The final local bias would
                        be the maximum of the lambda value from d, slocal, and
                        llocal size windows. While control is not available, d
                        and slocal lambda won't be considered. DEFAULT: 1000
  --llocal LARGELOCAL   The large nearby region in basepairs to calculate
                        dynamic lambda. This is used to capture the surround
                        bias. If you set this to 0, MACS will skip llocal
                        lambda calculation. *Note* that MACS will always
                        perform a d-size local lambda calculation while the
                        control data is available. The final local bias would
                        be the maximum of the lambda value from d, slocal, and
                        llocal size windows. While control is not available, d
                        and slocal lambda won't be considered. DEFAULT: 10000.
  --max-gap MAXGAP      Maximum gap between significant sites to cluster them
                        together. The DEFAULT value is the detected read
                        length/tag size.
  --min-length MINLEN   Minimum length of a peak. The DEFAULT value is the
                        predicted fragment size d. Note, if you set a value
                        smaller than the fragment size, it may have NO effect
                        on the result. For BROAD peak calling, try to set a
                        large value such as 500bps. You can also use '--
                        cutoff-analysis' option with default setting, and
                        check the column 'avelpeak' under different cutoff
                        values to decide a reasonable minlen value.
  --broad               If set, MACS will try to call broad peaks using the
                        --broad-cutoff setting. Please tweak '--broad-cutoff'
                        setting to control the peak calling behavior. At the
                        meantime, either -q or -p cutoff will be used to
                        define regions with 'stronger enrichment' inside of
                        broad peaks. The maximum gap is expanded to 4 * MAXGAP
                        (--max-gap parameter). As a result, MACS will output a
                        'gappedPeak' and a 'broadPeak' file instead of
                        'narrowPeak' file. Note, a broad peak will be reported
                        even if there is no 'stronger enrichment' inside.
                        DEFAULT: False
  --broad-cutoff BROADCUTOFF
                        Cutoff for broad region. This option is not available
                        unless --broad is set. If -p is set, this is a pvalue
                        cutoff, otherwise, it's a qvalue cutoff. Please note
                        that in broad peakcalling mode, MACS3 uses this
                        setting to control the overall peak calling behavior,
                        then uses -q or -p setting to define regions inside
                        broad region as 'stronger' enrichment. DEFAULT: 0.1
  --cutoff-analysis     While set, MACS3 will analyze number or total length
                        of peaks that can be called by different p-value
                        cutoff then output a summary table to help user decide
                        a better cutoff. The table will be saved in
                        NAME_cutoff_analysis.txt file. Note, minlen and maxgap
                        may affect the results. WARNING: May take ~30 folds
                        longer time to finish. The result can be useful for
                        users to decide a reasonable cutoff value. DEFAULT:
                        False

Post-processing options:
  --call-summits        If set, MACS will use a more sophisticated signal
                        processing approach to find subpeak summits in each
                        enriched peak region. DEFAULT: False
  --fe-cutoff FECUTOFF  When set, the value will be used as the minimum
                        requirement to filter out peaks with low fold-
                        enrichment. Note, MACS3 adds one as pseudocount while
                        calculating fold-enrichment. By default, it is set as
                        1 so there is no filtering. DEFAULT: 1.0

Obsolete options:
  --to-large            Obsolete option. Please use '--scale-to large'
                        instead.
  --ratio RATIO         Obsolete option. Originally designed to normalize
                        treatment and control with customized ratio, now it
                        won't have any effect.

Other options:
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000

Examples:
1. Peak calling for regular TF ChIP-seq:
    $ macs3 callpeak -t ChIP.bam -c Control.bam -f BAM -g hs -n test -B -q 0.01
2. Broad peak calling on Histone Mark ChIP-seq:
    $ macs3 callpeak -t ChIP.bam -c Control.bam --broad -g hs --broad-cutoff 0.1
3. Peak calling on ATAC-seq (paired-end mode):
    $ macs3 callpeak -f BAMPE -t ATAC.bam -g hs -n test -B -q 0.01
4. Peak calling on ATAC-seq (focusing on insertion sites, and using single-end mode):
    $ macs3 callpeak -f BAM -t ATAC.bam -g hs -n test -B -q 0.01 --shift -50 --extension 100
5. Peak calling on scATAC-seq (paired-end mode):
    $ macs3 callpeak -f BEDPE -t scATAC.fragments.tsv.gz -g hs -n test -B -q 0.01 -n test
6. Peak calling on scATAC-seq (paired-end mode):
    $ macs3 callpeak -f FRAG -t scATAC.fragments.tsv.gz -g hs -n test -B -q 0.01 -n test
7. Peak calling on scATAC-seq (paired-end mode) and only for given barcodes:
    $ macs3 callpeak -f FRAG -t scATAC.fragments.tsv.gz -g hs -n test -B -q 0.01 -n test --barcodes barcodes.txt
```


## macs3_bdgpeakcall

### Tool Description
Call peaks from bedGraph output of MACS3

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 bdgpeakcall [-h] -i IFILE [-c CUTOFF] [-l MINLEN] [-g MAXGAP]
                         [--cutoff-analysis]
                         [--cutoff-analysis-max CUTOFF_ANALYSIS_MAX]
                         [--cutoff-analysis-steps CUTOFF_ANALYSIS_STEPS]
                         [--no-trackline] [--verbose VERBOSE]
                         [--outdir OUTDIR] (-o OFILE | --o-prefix OPREFIX)

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE, --ifile IFILE
                        MACS score in bedGraph. REQUIRED
  -c CUTOFF, --cutoff CUTOFF
                        Cutoff depends on which method you used for score
                        track. If the file contains pvalue scores from MACS3,
                        score 5 means pvalue 1e-5. Regions with signals lower
                        than cutoff will not be considerred as enriched
                        regions. DEFAULT: 5
  -l MINLEN, --min-length MINLEN
                        minimum length of peak, better to set it as d value.
                        DEFAULT: 200
  -g MAXGAP, --max-gap MAXGAP
                        maximum gap between significant points in a peak,
                        better to set it as tag size. DEFAULT: 30
  --cutoff-analysis     While set, bdgpeakcall will analyze number or total
                        length of peaks that can be called by different cutoff
                        then output a summary table to help user decide a
                        better cutoff. Note, minlen and maxgap may affect the
                        results. DEFAULT: False
  --cutoff-analysis-max CUTOFF_ANALYSIS_MAX
                        The maximum cutoff score for performing cutoff
                        analysis. Together with --cutoff-analysis-steps, the
                        resolution in the final report can be controlled.
                        Please check the description in --cutoff-analysis-
                        steps for detail. DEFAULT: 100
  --cutoff-analysis-steps CUTOFF_ANALYSIS_STEPS
                        Steps for performing cutoff analysis. It will be used
                        to decide which cutoff value should be included in the
                        final report. Larger the value, higher resolution the
                        cutoff analysis can be. The cutoff analysis function
                        will first find the smallest (at least 0) and the
                        largest (controlled by --cutoff-analysis-max) score in
                        the data, then break the range of score into
                        `CUTOFF_ANALYSIS_STEPS` intervals. It will then use
                        each score as cutoff to call peaks and calculate the
                        total number of candidate peaks, the total basepairs
                        of peaks, and the average length of peak in basepair.
                        Please note that the final report ideally should
                        include `CUTOFF_ANALYSIS_STEPS` rows, but in practice,
                        if the cutoff yield zero peak, the row for that value
                        won't be included. DEFAULT: 100
  --no-trackline        Tells MACS not to include trackline with bedGraph
                        files. The trackline is used by UCSC for the options
                        for display.
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output file name. Mutually exclusive with --o-prefix.
  --o-prefix OPREFIX    Output file prefix. Mutually exclusive with
                        -o/--ofile.
```


## macs3_bdgbroadcall

### Tool Description
MACS3 tool for calling broad peaks from bedGraph score tracks

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 bdgbroadcall [-h] -i IFILE [-c CUTOFFPEAK] [-C CUTOFFLINK]
                          [-l MINLEN] [-g LVL1MAXGAP] [-G LVL2MAXGAP]
                          [--no-trackline] [--verbose VERBOSE]
                          [--outdir OUTDIR] (-o OFILE | --o-prefix OPREFIX)

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE, --ifile IFILE
                        MACS score in bedGraph. REQUIRED
  -c CUTOFFPEAK, --cutoff-peak CUTOFFPEAK
                        Cutoff for peaks depending on which method you used
                        for score track. If the file contains qvalue scores
                        from MACS3, score 2 means qvalue 0.01. Regions with
                        signals lower than cutoff will not be considerred as
                        enriched regions. DEFAULT: 2
  -C CUTOFFLINK, --cutoff-link CUTOFFLINK
                        Cutoff for linking regions/low abundance regions
                        depending on which method you used for score track. If
                        the file contains qvalue scores from MACS3, score 1
                        means qvalue 0.1, and score 0.3 means qvalue 0.5.
                        DEFAULT: 1
  -l MINLEN, --min-length MINLEN
                        minimum length of peak, better to set it as d value.
                        DEFAULT: 200
  -g LVL1MAXGAP, --lvl1-max-gap LVL1MAXGAP
                        maximum gap between significant peaks, better to set
                        it as tag size. DEFAULT: 30
  -G LVL2MAXGAP, --lvl2-max-gap LVL2MAXGAP
                        maximum linking between significant peaks, better to
                        set it as 4 times of d value. DEFAULT: 800
  --no-trackline        Tells MACS not to include trackline with bedGraph
                        files. The trackline is required by UCSC.
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output file name. Mutually exclusive with --o-prefix.
  --o-prefix OPREFIX    Output file prefix. Mutually exclusive with
                        -o/--ofile.
```


## macs3_bdgcmp

### Tool Description
Deduct noise by comparing treatment and control bedGraph files using various methods.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 bdgcmp [-h] -t TFILE -c CFILE [-S SFACTOR] [-p PSEUDOCOUNT]
                    [-m {ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} [{ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} ...]]
                    [--verbose VERBOSE] [--outdir OUTDIR]
                    (--o-prefix OPREFIX | -o OFILE [OFILE ...])

optional arguments:
  -h, --help            show this help message and exit
  -t TFILE, --tfile TFILE
                        Treatment bedGraph file, e.g. *_treat_pileup.bdg from
                        MACSv2. REQUIRED
  -c CFILE, --cfile CFILE
                        Control bedGraph file, e.g. *_control_lambda.bdg from
                        MACSv2. REQUIRED
  -S SFACTOR, --scaling-factor SFACTOR
                        Scaling factor for treatment and control track. Keep
                        it as 1.0 or default in most cases. Set it ONLY while
                        you have SPMR output from MACS3 callpeak, and plan to
                        calculate scores as MACS3 callpeak module. If you want
                        to simulate 'callpeak' w/o '--to-large', calculate
                        effective smaller sample size after filtering redudant
                        reads in million (e.g., put 31.415926 if effective
                        reads are 31,415,926) and input it for '-S'; for
                        'callpeak --to-large', calculate effective reads in
                        larger sample. DEFAULT: 1.0
  -p PSEUDOCOUNT, --pseudocount PSEUDOCOUNT
                        The pseudocount used for calculating logLR, logFE or
                        FE. The count will be applied after normalization of
                        sequencing depth. DEFAULT: 0.0, no pseudocount is
                        applied.
  -m {ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} [{ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} ...], --method {ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} [{ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} ...]
                        Method to use while calculating a score in any bin by
                        comparing treatment value and control value. Available
                        choices are: ppois, qpois, subtract, logFE, FE, logLR,
                        slogLR, and max. They represent Poisson Pvalue
                        (-log10(pvalue) form) using control as lambda and
                        treatment as observation, q-value through a BH process
                        for poisson pvalues, subtraction from treatment,
                        linear scale fold enrichment, log10 fold
                        enrichment(need to set pseudocount), log10 likelihood
                        between ChIP-enriched model and open chromatin
                        model(need to set pseudocount), symmetric log10
                        likelihood between two ChIP-enrichment models, or
                        maximum value between the two tracks. Default option
                        is ppois.
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  --o-prefix OPREFIX    The PREFIX of output bedGraph file to write scores. If
                        it is given as A, and method is 'ppois', output file
                        will be A_ppois.bdg. Mutually exclusive with
                        -o/--ofile.
  -o OFILE [OFILE ...], --ofile OFILE [OFILE ...]
                        Output filename. Mutually exclusive with --o-prefix.
                        The number and the order of arguments for --ofile must
                        be the same as for -m.
```


## macs3_bdgopt

### Tool Description
Modify the score column of a bedGraph file using various methods like multiply, add, max, min, or p2q conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 bdgopt [-h] -i IFILE [-m {multiply,add,p2q,max,min}]
                    [-p [EXTRAPARAM ...]] [--outdir OUTDIR] -o OFILE
                    [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE, --ifile IFILE
                        MACS score in bedGraph. Note: this must be a bedGraph
                        file covering the ENTIRE genome. REQUIRED
  -m {multiply,add,p2q,max,min}, --method {multiply,add,p2q,max,min}
                        Method to modify the score column of bedGraph file.
                        Available choices are: multiply, add, max, min, or
                        p2q. 1) multiply, the EXTRAPARAM is required and will
                        be multiplied to the score column. If you intend to
                        divide the score column by X, use value of 1/X as
                        EXTRAPARAM. 2) add, the EXTRAPARAM is required and
                        will be added to the score column. If you intend to
                        subtract the score column by X, use value of -X as
                        EXTRAPARAM. 3) max, the EXTRAPARAM is required and
                        will take the maximum value between score and the
                        EXTRAPARAM. 4) min, the EXTRAPARAM is required and
                        will take the minimum value between score and the
                        EXTRAPARAM. 5) p2q, this will convert p-value scores
                        to q-value scores using Benjamini-Hochberg process.
                        The EXTRAPARAM is not required. This method assumes
                        the scores are -log10 p-value from MACS3. Any other
                        types of score will cause unexpected errors.
  -p [EXTRAPARAM ...], --extra-param [EXTRAPARAM ...]
                        The extra parameter for METHOD. Check the detail of -m
                        option.
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output BEDGraph filename.
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
```


## macs3_cmbreps

### Tool Description
Combine scores from replicates using different methods like Fisher's, max, or mean.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 cmbreps [-h] -i IFILE [IFILE ...] [-m {fisher,max,mean}]
                     [--outdir OUTDIR] -o OFILE [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...]  MACS score in bedGraph for each replicate. Require at
                        least 2 files such as '-i A B C D'. REQUIRED
  -m {fisher,max,mean}, --method {fisher,max,mean}
                        Method to use while combining scores from replicates.
                        1) fisher: Fisher's combined probability test. It
                        requires scores in ppois form (-log10 pvalues) from
                        bdgcmp. Other types of scores for this method may
                        cause cmbreps unexpected errors. 2) max: take the
                        maximum value from replicates for each genomic
                        position. 3) mean: take the average value. Note,
                        except for Fisher's method, max or mean will take
                        scores AS IS which means they won't convert scores
                        from log scale to linear scale or vice versa.
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output BEDGraph filename for combined scores.
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
```


## macs3_bdgdiff

### Tool Description
Differential peak detection based on paired bedGraph files

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 bdgdiff [-h] --t1 T1BDG --t2 T2BDG --c1 C1BDG --c2 C2BDG
                     [-C CUTOFF] [-l MINLEN] [-g MAXGAP] [--d1 DEPTH1]
                     [--d2 DEPTH2] [--verbose VERBOSE] [--outdir OUTDIR]
                     (--o-prefix OPREFIX | -o OFILE OFILE OFILE)

optional arguments:
  -h, --help            show this help message and exit
  --t1 T1BDG            MACS pileup bedGraph for condition 1. Incompatible
                        with callpeak --SPMR output. REQUIRED
  --t2 T2BDG            MACS pileup bedGraph for condition 2. Incompatible
                        with callpeak --SPMR output. REQUIRED
  --c1 C1BDG            MACS control lambda bedGraph for condition 1.
                        Incompatible with callpeak --SPMR output. REQUIRED
  --c2 C2BDG            MACS control lambda bedGraph for condition 2.
                        Incompatible with callpeak --SPMR output. REQUIRED
  -C CUTOFF, --cutoff CUTOFF
                        log10LR cutoff. Regions with signals lower than cutoff
                        will not be considerred as enriched regions. DEFAULT:
                        3 (likelihood ratio=1000)
  -l MINLEN, --min-len MINLEN
                        Minimum length of differential region. Try bigger
                        value to remove small regions. DEFAULT: 200
  -g MAXGAP, --max-gap MAXGAP
                        Maximum gap to merge nearby differential regions.
                        Consider a wider gap for broad marks. Maximum gap
                        should be smaller than minimum length (-g). DEFAULT:
                        100
  --d1 DEPTH1, --depth1 DEPTH1
                        Sequencing depth (# of non-redundant reads in million)
                        for condition 1. It will be used together with --d2.
                        See description for --d2 below for how to assign them.
                        Default: 1
  --d2 DEPTH2, --depth2 DEPTH2
                        Sequencing depth (# of non-redundant reads in million)
                        for condition 2. It will be used together with --d1.
                        DEPTH1 and DEPTH2 will be used to calculate scaling
                        factor for each sample, to down-scale larger sample to
                        the level of smaller one. For example, while comparing
                        10 million condition 1 and 20 million condition 2, use
                        --d1 10 --d2 20, then pileup value in bedGraph for
                        condition 2 will be divided by 2. Default: 1
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  --o-prefix OPREFIX    Output file prefix. Actual files will be named as
                        PREFIX_cond1.bed, PREFIX_cond2.bed and
                        PREFIX_common.bed. Mutually exclusive with -o/--ofile.
  -o OFILE OFILE OFILE, --ofile OFILE OFILE OFILE
                        Output filenames. Must give three arguments in order:
                        1. file for unique regions in condition 1; 2. file for
                        unique regions in condition 2; 3. file for common
                        regions in both conditions. Note: mutually exclusive
                        with --o-prefix.
```


## macs3_filterdup

### Tool Description
MACS3 filterdup is used to remove duplicate reads at the same location based on a binomial distribution test or a fixed number.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 filterdup [-h] -i IFILE [IFILE ...]
                       [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                       [-g GSIZE] [-s TSIZE] [-p PVALUE]
                       [--keep-dup KEEPDUPLICATES] [--buffer-size BUFFER_SIZE]
                       [--verbose VERBOSE] [--outdir OUTDIR] [-o OUTPUTFILE]
                       [-d]

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        Alignment file. If multiple files are given as '-t A B
                        C', then they will all be read and combined. REQUIRED.
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED", "ELAND",
                        "ELANDMULTI", "ELANDEXPORT", "SAM", "BAM", "BOWTIE",
                        "BAMPE", or "BEDPE". The default AUTO option will let
                        MACS3 guess which format the file is. Please check the
                        definition in README file for each specific format.
                        DEFAULT: "AUTO"
  -g GSIZE, --gsize GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2,913,022,398), 'mm' for
                        mouse (2,652,783,500), 'ce' for C. elegans
                        (100,286,401) and 'dm' for fruitfly (142,573,017),
                        Default:hs. The effective genome size numbers for the
                        above four species are collected from Deeptools https:
                        //deeptools.readthedocs.io/en/develop/content/feature/
                        effectiveGenomeSize.html Please refer to deeptools to
                        define the best genome size you plan to use.
  -s TSIZE, --tsize TSIZE
                        Tag size. This will override the auto detected tag
                        size. DEFAULT: Not set
  -p PVALUE, --pvalue PVALUE
                        Pvalue cutoff for binomial distribution test.
                        DEFAULT:1e-5
  --keep-dup KEEPDUPLICATES
                        It controls the 'macs3 filterdup' behavior towards
                        duplicate tags/pairs at the exact same location -- the
                        same coordination and the same strand. The 'auto'
                        option makes 'macs3 filterdup' calculate the maximum
                        tags at the exact same location based on binomal
                        distribution using given -p as pvalue cutoff; and the
                        'all' option keeps every tags (useful if you only want
                        to convert formats). If an integer is given, at most
                        this number of tags will be kept at the same location.
                        Note, MACS3 callpeak function uses KEEPDUPLICATES=1 as
                        default. Note, if you've used samtools or picard to
                        flag reads as 'PCR/Optical duplicate' in bit 1024,
                        MACS3 will still read them although the reads may be
                        decided by MACS3 as duplicate later. Default: auto
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000
  --verbose VERBOSE     Set verbose level. 0: only show critical message, 1:
                        show additional warning message, 2: show process
                        information, 3: show debug messages. If you want to
                        know where are the duplicate reads, use 3. DEFAULT:2
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OUTPUTFILE, --ofile OUTPUTFILE
                        Output BED file name. If not specified, will write to
                        standard output. Note, if the input format is BAMPE or
                        BEDPE, the output will be in BEDPE format. DEFAULT:
                        stdout
  -d, --dry-run         When set, filterdup will only output numbers instead
                        of writing output files, including maximum allowable
                        duplicates, total number of reads before filtering,
                        total number of reads after filtering, and redundant
                        rate. Default: not set
```


## macs3_predictd

### Tool Description
Predict d or fragment size from alignment files

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 predictd [-h] -i IFILE [IFILE ...]
                      [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                      [-g GSIZE] [-s TSIZE] [--bw BW] [--d-min D_MIN]
                      [-m MFOLD MFOLD] [--outdir OUTDIR] [--rfile RFILE]
                      [--buffer-size BUFFER_SIZE] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        ChIP-seq alignment file. If multiple files are given
                        as '-t A B C', then they will all be read and
                        combined. REQUIRED.
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE" or "BAMPE" or "BEDPE". The default AUTO
                        option will let MACS decide which format the file is.
                        However, if you want to decide the average insertion
                        size/fragment size from PE data such as BEDPE or
                        BAMPE, please specify the format as BAMPE or BEDPE
                        since MACS3 won't automatically recognize three two
                        formats with -f AUTO. Please be aware that in PE mode,
                        -g, -s, --bw, --d-min, -m, and --rfile have NO effect.
                        DEFAULT: "AUTO"
  -g GSIZE, --gsize GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2,913,022,398), 'mm' for
                        mouse (2,652,783,500), 'ce' for C. elegans
                        (100,286,401) and 'dm' for fruitfly (142,573,017),
                        Default:hs. The effective genome size numbers for the
                        above four species are collected from Deeptools https:
                        //deeptools.readthedocs.io/en/develop/content/feature/
                        effectiveGenomeSize.html Please refer to deeptools to
                        define the best genome size you plan to use.
  -s TSIZE, --tsize TSIZE
                        Tag size. This will override the auto detected tag
                        size. DEFAULT: Not set
  --bw BW               Band width for picking regions to compute fragment
                        size. This value is only used while building the
                        shifting model. DEFAULT: 300
  --d-min D_MIN         Minimum fragment size in basepair. Any predicted
                        fragment size less than this will be excluded.
                        DEFAULT: 20
  -m MFOLD MFOLD, --mfold MFOLD MFOLD
                        Select the regions within MFOLD range of high-
                        confidence enrichment ratio against background to
                        build model. Fold-enrichment in regions must be lower
                        than upper limit, and higher than the lower limit. Use
                        as "-m 10 30". DEFAULT:5 50
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  --rfile RFILE         PREFIX of filename of R script for drawing
                        X-correlation figure. DEFAULT:'predictd_model.R' and R
                        file will be predicted_model.R
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
```


## macs3_pileup

### Tool Description
Create a pileup bedGraph file from alignment files.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 pileup [-h] -i IFILE [IFILE ...] -o OUTPUTFILE [--outdir OUTDIR]
                    [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE,FRAG}]
                    [--barcodes BARCODEFILE] [--max-count MAXCOUNT] [-B]
                    [--extsize EXTSIZE] [--buffer-size BUFFER_SIZE]
                    [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        Alignment file. If multiple files are given as '-t A B
                        C', then they will all be read and combined. REQUIRED.
  -o OUTPUTFILE, --ofile OUTPUTFILE
                        Output bedGraph file name. If not specified, will
                        write to standard output. REQUIRED.
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE,FRAG}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE,FRAG}
                        Format of tag file, "AUTO", "BED", "ELAND",
                        "ELANDMULTI", "ELANDEXPORT", "SAM", "BAM", "BOWTIE",
                        "BAMPE", "BEDPE", or "FRAG". The default AUTO option
                        will let 'macs3 pileup' decide which format the file
                        is. DEFAULT: "AUTO", MACS3 will pick a format from
                        "AUTO", "BED", "ELAND", "ELANDMULTI", "ELANDEXPORT",
                        "SAM", "BAM" and "BOWTIE". If the format is BAMPE,
                        BEDPE or FRAG, please specify it explicitly. Please
                        note that when the format is BAMPE, BEDPE or FRAG, the
                        -B and --extsize options would be ignored, and MACS3
                        will process the input in Paired-End mode.
  --barcodes BARCODEFILE
                        A plain text file containing the barcodes for the
                        fragment file while the format is 'FRAG'. Won't have
                        any effect if the fromat is not 'FRAG'. Each row in
                        the file should only have the barcode string. MACS3
                        will extract only the fragments for the specified
                        barcodes.
  --max-count MAXCOUNT  In the FRAG format file, the fifth column indicates
                        the count of fragments found at the exact same
                        location from the same barcode. By default, MACS3
                        treats each fragment count as indicated in this
                        column. However, if this option is enabled and set as
                        a positive integer, MACS3 will not count more than the
                        specified number. If this is set as 0, MACS3 will
                        behave as the default setting to keep all counts.
                        Please note that `callpeak -f FRAG --max-count 1` is
                        supposed to generate the same result as `callpeak -f
                        BEDPE --keep-dup all` on fragment files. This option
                        will be ignored if the format is not FRAG.
  -B, --both-direction  By default, any read will be extended towards
                        downstream direction by extension size. So it's
                        [0,size-1] (1-based index system) for plus strand read
                        and [-size+1,0] for minus strand read where position 0
                        is 5' end of the aligned read. Default behavior can
                        simulate MACS3 way of piling up ChIP sample reads
                        where extension size is set as fragment size/d. If
                        this option is set as on, aligned reads will be
                        extended in both upstream and downstream directions by
                        extension size. It means [-size,size] where 0 is the
                        5' end of a aligned read. It can partially simulate
                        MACS3 way of piling up control reads. However MACS3
                        local bias is calculated by maximizing the expected
                        pileup over a ChIP fragment size/d estimated from
                        10kb, 1kb, d and whole genome background. This option
                        will be ignored when the format is set as BAMPE,
                        BEDPE, or FRAG. DEFAULT: False
  --extsize EXTSIZE     The extension size in bps. Each alignment read will
                        become a EXTSIZE of fragment, then be piled up. Check
                        description for -B for detail. It's twice the
                        `shiftsize` in old MACSv1 language. This option will
                        be ignored when the format is set as BAMPE, BEDPE or
                        FRAG. DEFAULT: 200
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000
  --verbose VERBOSE     Set verbose level. 0: only show critical message, 1:
                        show additional warning message, 2: show process
                        information, 3: show debug messages. If you want to
                        know where are the duplicate reads, use 3. DEFAULT:2
```


## macs3_randsample

### Tool Description
Randomly sample tags from alignment files to a specified percentage or number.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 randsample [-h] -i IFILE [IFILE ...] (-p PERCENTAGE | -n NUMBER)
                        [--seed SEED] [-o OUTPUTFILE] [--outdir OUTDIR]
                        [-s TSIZE]
                        [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                        [--buffer-size BUFFER_SIZE] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        Alignment file. If multiple files are given as '-t A B
                        C', then they will all be read and combined. REQUIRED.
  -p PERCENTAGE, --percentage PERCENTAGE
                        Percentage of tags you want to keep. Input 80.0 for
                        80%. This option can't be used at the same time with
                        -n/--num. If the setting is 100, it will keep all the
                        reads and convert any format that MACS3 supports into
                        BED or BEDPE (if input is BAMPE) format. REQUIRED
  -n NUMBER, --number NUMBER
                        Number of tags you want to keep. Input 8000000 or 8e+6
                        for 8 million. This option can't be used at the same
                        time with -p/--percent. Note that the number of tags
                        in output is approximate as the number specified here.
                        REQUIRED
  --seed SEED           Set the random seed while down sampling data. Must be
                        a non-negative integer in order to be effective. If
                        you want more reproducible results, please specify a
                        random seed and record it.DEFAULT: not set
  -o OUTPUTFILE, --ofile OUTPUTFILE
                        Output BED file name. If not specified, will write to
                        standard output. Note, if the input format is BAMPE or
                        BEDPE, the output will be in BEDPE format. DEFAULT:
                        stdout
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -s TSIZE, --tsize TSIZE
                        Tag size. This will override the auto detected tag
                        size. DEFAULT: Not set
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE" or "BAMPE" or "BEDPE". The default AUTO
                        option will macs3 randsample decide which format the
                        file is. Please check the definition in README file if
                        you choose ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE
                        or BAMPE/BEDPE. DEFAULT: "AUTO"
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000
  --verbose VERBOSE     Set verbose level. 0: only show critical message, 1:
                        show additional warning message, 2: show process
                        information, 3: show debug messages. If you want to
                        know where are the duplicate reads, use 3. DEFAULT:2
```


## macs3_refinepeak

### Tool Description
Refine peak summits and compute enrichment scores using MACS3

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 refinepeak [-h] -b BEDFILE -i IFILE [IFILE ...]
                        [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE}]
                        [-c CUTOFF] [-w WINDOWSIZE]
                        [--buffer-size BUFFER_SIZE] [--verbose VERBOSE]
                        [--outdir OUTDIR] (-o OFILE | --o-prefix OPREFIX)

optional arguments:
  -h, --help            show this help message and exit
  -b BEDFILE            Candidate peak file in BED format. REQUIRED.
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        ChIP-seq alignment file. If multiple files are given
                        as '-t A B C', then they will all be read and
                        combined. Note that pair-end data is not supposed to
                        work with this command. REQUIRED.
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE". The default AUTO option will let 'macs3
                        refinepeak' decide which format the file is. Please
                        check the definition in README file if you choose
                        ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE. DEFAULT:
                        "AUTO"
  -c CUTOFF, --cutoff CUTOFF
                        Cutoff. Regions with SPP wtd score lower than cutoff
                        will not be considerred. DEFAULT: 5
  -w WINDOWSIZE, --window-size WINDOWSIZE
                        Scan window size on both side of the summit (default:
                        100bp)
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000
  --verbose VERBOSE     Set verbose level. 0: only show critical message, 1:
                        show additional warning message, 2: show process
                        information, 3: show debug messages. If you want to
                        know where are the duplicate reads, use 3. DEFAULT:2
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output file name. Mutually exclusive with --o-prefix.
  --o-prefix OPREFIX    Output file prefix. Mutually exclusive with
                        -o/--ofile.
```


## macs3_callvar

### Tool Description
Call variants from ChIP-seq/ATAC-seq treatment and optional control BAM files within specified peak regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 callvar [-h] -b PEAKBED -t TFILE [-c CFILE] [--outdir OUTDIR] -o
                     OFILE [--verbose VERBOSE] [-g GQCUTOFFHETERO]
                     [-G GQCUTOFFHOMO] [-Q Q] [-D MAXDUPLICATE] [-F FERMI]
                     [--fermi-overlap FERMIMINOVERLAP]
                     [--top2alleles-mratio TOP2ALLELESMINRATIO]
                     [--altallele-count ALTALLELEMINCOUNT] [--max-ar MAXAR]
                     [-m NP]

optional arguments:
  -h, --help            show this help message and exit

Input files arguments:
  -b PEAKBED, --peak PEAKBED
                        Peak regions in BED format, sorted by coordinates.
                        REQUIRED.
  -t TFILE, --treatment TFILE
                        ChIP-seq/ATAC-seq treatment file in BAM format, sorted
                        by coordinates. Make sure the .bai file is avaiable in
                        the same directory. REQUIRED.
  -c CFILE, --control CFILE
                        Optional control file in BAM format, sorted by
                        coordinates. Make sure the .bai file is avaiable in
                        the same directory.

Output arguments:
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output VCF file name.
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2

Variant calling arguments:
  -g GQCUTOFFHETERO, --gq-hetero GQCUTOFFHETERO
                        Genotype Quality score
                        (-10log10((L00+L11)/(L01+L00+L11))) cutoff for
                        Heterozygous allele type. Default:0, or there is no
                        cutoff on GQ.
  -G GQCUTOFFHOMO, --gq-homo GQCUTOFFHOMO
                        Genotype Quality score
                        (-10log10((L00+L01)/(L01+L00+L11))) cutoff for
                        Homozygous allele (not the same as reference) type.
                        Default:0, or ther is no cutoff on GQ.
  -Q Q                  Only consider bases with quality score greater than
                        this value. Default: 20, which means Q20 or 0.01 error
                        rate.
  -D MAXDUPLICATE       Maximum duplicated reads allowed per mapping position,
                        mapping strand and the same CIGAR code. Default: 1.
                        When sequencing depth is high, to set a higher value
                        might help evaluate the correct allele ratio.
  -F FERMI, --fermi FERMI
                        Option to control when to apply local assembly through
                        fermi-lite. By default (set as 'auto'), while callvar
                        detects any INDEL variant in a peak region, it will
                        utilize fermi-lite to recover the actual DNA sequences
                        to refine the read alignments. If set as 'on', fermi-
                        lite will be always invoked. It can increase
                        specificity however sensivity and speed will be
                        significantly lower. If set as 'off', Fermi won't be
                        invoked at all. If so, speed and sensitivity can be
                        higher but specificity will be significantly lower.
                        Default: auto
  --fermi-overlap FERMIMINOVERLAP
                        The minimal overlap for fermi to initially assemble
                        two reads. Must be between 1 and read length. A longer
                        fermiMinOverlap is needed while read length is small
                        (e.g. 30 for 36bp read, but 33 for 100bp read may
                        work). Default:30
  --top2alleles-mratio TOP2ALLELESMINRATIO
                        The reads for the top 2 most frequent alleles (e.g. a
                        ref allele and an alternative allele) at a loci
                        shouldn't be too few comparing to total reads mapped.
                        The minimum ratio is set by this optoin. Must be a
                        float between 0.5 and 1. Default:0.8 which means at
                        least 80% of reads contain the top 2 alleles.
  --altallele-count ALTALLELEMINCOUNT
                        The count of the alternative (non-reference) allele at
                        a loci shouldn't be too few. By default, we require at
                        least two reads support the alternative allele.
                        Default:2
  --max-ar MAXAR        The maximum Allele-Ratio allowed while calculating
                        likelihood for allele-specific binding. If we allow
                        higher maxAR, we may mistakenly assign some homozygous
                        loci as heterozygous. Default:0.95

Misc arguments:
  -m NP, --multiple-processing NP
                        CPU used for mutliple processing. Please note that,
                        assigning more CPUs does not guarantee the process
                        being faster. Creating too many parrallel processes
                        need memory operations and may negate benefit from
                        multi processing. Default: 1

 Assuming you have two types of BAM files. The first type, what we
call `TREAT`, is from DNA enrichment assay such as ChIP-seq or
ATAC-seq where the DNA fragments in the sequencing library are
enriched in certain genomics regions with potential allele biases; the
second type, called `CTRL` for control, is from genomic assay in which
the DNA enrichment is less biased in multiploid chromosomes and more
uniform across the whole genome (the later one is optional). In order
to run `callvar`, please sort (by coordinates) and index the BAM
files. Example:

1. Sort the BAM file:
    $ samtools sort TREAT.bam -o TREAT_sorted.bam
    $ samtools sort CTRL.bam -o CTRL_sorted.bam
2. Index the BAM file:
    $ samtools index TREAT_sorted.bam
    $ samtools index CTRL_sorted.bam
3. Make sure .bai files are available:
    $ ls TREAT_sorted.bam.bai
    $ ls CTRL_sorted.bam.bai

To call variants:
    $ macs3 callvar -b peaks.bed -t TREAT_sorted.bam -c CTRL_sorted.bam -o peaks.vcf
```


## macs3_hmmratac

### Tool Description
HMMRATAC is a dedicated tool specifically designed for processing ATAC-seq data using a Hidden Markov Model to learn the nucleosome structure around open chromatin regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs3:3.0.3--py39h0699b22_0
- **Homepage**: https://pypi.org/project/MACS3/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs3/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs3 hmmratac [-h] -i INPUT_FILE [INPUT_FILE ...] [-f {BAMPE,BEDPE}]
                      [--outdir OUTDIR] [-n NAME] [--cutoff-analysis-only]
                      [--cutoff-analysis-max CUTOFF_ANALYSIS_MAX]
                      [--cutoff-analysis-steps CUTOFF_ANALYSIS_STEPS]
                      [--save-digested] [--save-states] [--save-likelihoods]
                      [--save-training-data] [--no-fragem]
                      [--means EM_MEANS EM_MEANS EM_MEANS EM_MEANS]
                      [--stddevs EM_STDDEVS EM_STDDEVS EM_STDDEVS EM_STDDEVS]
                      [--min-frag-p MIN_FRAG_P] [--binsize HMM_BINSIZE]
                      [-u HMM_UPPER] [-l HMM_LOWER] [--maxTrain HMM_MAXTRAIN]
                      [--training-flanking HMM_TRAINING_FLANKING]
                      [-t HMM_TRAINING_REGIONS] [--model HMM_FILE]
                      [--modelonly] [--hmm-type {gaussian,poisson}]
                      [-c PRESCAN_CUTOFF] [--minlen OPENREGION_MINLEN]
                      [--pileup-short] [--randomSeed HMM_RANDOMSEED]
                      [--decoding-steps DECODING_STEPS] [-e BLACKLIST]
                      [--remove-dup] [--verbose VERBOSE]
                      [--buffer-size BUFFER_SIZE]

optional arguments:
  -h, --help            show this help message and exit

Input files arguments:
  -i INPUT_FILE [INPUT_FILE ...], --input INPUT_FILE [INPUT_FILE ...]
                        Input files containing the aligment results for ATAC-
                        seq paired end reads. If multiple files are given as
                        '-t A B C', then they will all be read and pooled
                        together. The file should be in BAMPE or BEDPE format
                        (aligned in paired end mode). Files can be gzipped.
                        Note: all files should be in the same format!
                        REQUIRED.
  -f {BAMPE,BEDPE}, --format {BAMPE,BEDPE}
                        Format of input files, "BAMPE" or "BEDPE". If there
                        are multiple files, they should be in the same format
                        -- either BAMPE or BEDPE. Please check the definition
                        in README. Also please note that the BEDPE only
                        contains three columns -- chromosome, left position of
                        the whole pair, right position of the whole pair-- and
                        is NOT the same BEDPE format used by BEDTOOLS. To
                        convert BAMPE to BEDPE, you can use this command
                        `macs3 filterdup --keep-dup all -f BAMPE -i input.bam
                        -o output.bedpe`. DEFAULT: "BAMPE"

Output arguments:
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -n NAME, --name NAME  Name for this experiment, which will be used as a
                        prefix to generate output file names. DEFAULT: "NA"
  --cutoff-analysis-only
                        Only run the cutoff analysis and output a report.
                        After generating the report, the process will stop. By
                        default, the cutoff analysis will be included in the
                        whole process, but won't quit after the report is
                        generated. The report will help user decide the three
                        crucial parameters for `-l`, `-u`, and `-c`. So it's
                        highly recommanded to run this first! Please read the
                        report and instructions in `Choices of cutoff values`
                        on how to decide the three crucial parameters. The
                        resolution of cutoff analysis can be controlled by
                        --cutoff-analysis-max and --cutoff-analysis-steps
                        options.
  --cutoff-analysis-max CUTOFF_ANALYSIS_MAX
                        The maximum cutoff score for performing cutoff
                        analysis. Together with --cutoff-analysis-steps, the
                        resolution in the final report can be controlled.
                        Please check the description in --cutoff-analysis-
                        steps for detail. DEFAULT: 100
  --cutoff-analysis-steps CUTOFF_ANALYSIS_STEPS
                        Steps for performing cutoff analysis. It will be used
                        to decide which cutoff value should be included in the
                        final report. Larger the value, higher resolution the
                        cutoff analysis can be. The cutoff analysis function
                        will first find the smallest (at least 0) and the
                        largest (controlled by --cutoff-analysis-max)
                        foldchange score in the data, then break the range of
                        foldchange score into `CUTOFF_ANALYSIS_STEPS`
                        intervals. It will then use each foldchange score as
                        cutoff to call peaks and calculate the total number of
                        candidate peaks, the total basepairs of peaks, and the
                        average length of peak in basepair. Please note that
                        the final report ideally should include
                        `CUTOFF_ANALYSIS_STEPS` rows, but in practice, if the
                        foldchange cutoff yield zero peak, the row for that
                        foldchange value won't be included. DEFAULT: 100
  --save-digested       Save the digested ATAC signals of short-, mono-, di-,
                        and tri- signals in three BedGraph files with the
                        names NAME_short.bdg, NAME_mono.bdg, NAME_di.bdg, and
                        NAME_tri.bdg. DEFAULT: False
  --save-states         Save all open and nucleosomal state annotations into a
                        BED file with the name NAME_states.bed. DEFAULT: False
  --save-likelihoods    Save the likelihoods to each state annotation in three
                        BedGraph files, named with NAME_open.bdg for open
                        states, NAME_nuc.bdg for nucleosomal states, and
                        NAME_bg.bdg for the background states. DEFAULT: False
  --save-training-data  Save the training regions and training data into
                        NAME_training_regions.bed and NAME_training_data.txt.
                        Default: False

EM algorithm arguments:
  --no-fragem           Do not perform EM training on the fragment
                        distribution. If set, EM_MEANS and EM.STDDEVS will be
                        used instead. Default: False
  --means EM_MEANS EM_MEANS EM_MEANS EM_MEANS
                        Comma separated list of initial mean values for the
                        fragment distribution for short fragments, mono-, di-,
                        and tri-nucleosomal fragments. Default: 50 200 400 600
  --stddevs EM_STDDEVS EM_STDDEVS EM_STDDEVS EM_STDDEVS
                        Comma separated list of initial standard deviation
                        values for fragment distribution for short fragments,
                        mono-, di-, and tri-nucleosomal fragments. Default: 20
                        20 20 20
  --min-frag-p MIN_FRAG_P
                        We will exclude the abnormal fragments that can't be
                        assigned to any of the four signal tracks. After we
                        use EM to find the means and stddevs of the four
                        distributions, we will calculate the likelihood that a
                        given fragment length fit any of the four using normal
                        distribution. The criteria we will use is that if a
                        fragment length has less than MIN_FRAG_P probability
                        to be like either of short, mono, di, or tri-nuc
                        fragment, we will exclude it while generating the four
                        signal tracks for later HMM training and prediction.
                        The value should be between 0 and 1. Larger the value,
                        more abnormal fragments will be allowed. So if you
                        want to include more 'ideal' fragments, make this
                        value smaller. Default=0.001

Hidden Markov Model arguments:
  --binsize HMM_BINSIZE
                        Size of the bins to split the pileup signals for
                        training and decoding with Hidden Markov Model. Must
                        >= 1. Smaller the binsize, higher the resolution of
                        the results, slower the process. Default=10
  -u HMM_UPPER, --upper HMM_UPPER
                        Upper limit on fold change range for choosing training
                        sites. This is an important parameter for training so
                        please read. The purpose of this parameter is to
                        EXCLUDE those unusually highly enriched chromatin
                        regions so we can get training samples in 'ordinary'
                        regions instead. It's highly recommended to run the
                        `--cutoff-analysis-only` first to decide the lower
                        cutoff `-l`, the upper cutoff `-u`, and the pre-
                        scanning cutoff `-c`. The upper cutoff should be the
                        cutoff in the cutoff analysis result that can capture
                        some (typically hundreds of) extremely high enrichment
                        and unusually wide peaks. Default: 20
  -l HMM_LOWER, --lower HMM_LOWER
                        Lower limit on fold change range for choosing training
                        sites. This is an important parameter for training so
                        please read. The purpose of this parameter is to ONLY
                        INCLUDE those chromatin regions having ordinary
                        enrichment so we can get training samples to learn the
                        common features through HMM. It's highly recommended
                        to run the `--cutoff-analysis-only` first to decide
                        the lower cutoff `-l`, the upper cutoff `-u`, and the
                        pre-scanning cutoff `-c`. The lower cutoff should be
                        the cutoff in the cutoff analysis result that can
                        capture moderate number ( about 10k) of peaks with
                        normal width ( average length 500-1000bps long).
                        Default: 10
  --maxTrain HMM_MAXTRAIN
                        Maximum number of training regions to use. After we
                        identify the training regions between `-l` and `-u`,
                        the lower and upper cutoffs, we will randomly pick
                        this number of regions for training. Default: 1000
  --training-flanking HMM_TRAINING_FLANKING
                        Training regions will be expanded to both side with
                        this number of basepairs. The purpose is to include
                        more background regions. Default: 1000
  -t HMM_TRAINING_REGIONS, --training HMM_TRAINING_REGIONS
                        Filename of training regions (previously was BED_file)
                        to use for training HMM, instead of using foldchange
                        settings to select. Default: NA
  --model HMM_FILE      A JSON file generated from previous HMMRATAC run to
                        use instead of creating new one. When provided, HMM
                        training will be skipped. Default: NA
  --modelonly           Stop the program after generating model. Use this
                        option to generate HMM model ONLY, which can be later
                        applied with `--model`. Default: False
  --hmm-type {gaussian,poisson}
                        Use --hmm-type to select a Gaussian ('gaussian') or
                        Poisson ('poisson') model for the hidden markov model
                        in HMMRATAC. Default: 'gaussian'.

Peak calling/HMM decoding arguments:
  -c PRESCAN_CUTOFF, --prescan-cutoff PRESCAN_CUTOFF
                        The fold change cutoff for prescanning candidate
                        regions in the whole dataset. Then we will use HMM to
                        predict/decode states on these candidate regions.
                        Higher the prescan cutoff, fewer regions will be
                        considered. Must > 1. This is an important parameter
                        for decoding so please read. The purpose of this
                        parameter is to EXCLUDE those chromatin regions having
                        noises/random enrichment so we can have a large number
                        of possible regions to predict the HMM states. It's
                        highly recommended to run the `--cutoff-analysis-only`
                        first to decide the lower cutoff `-l`, the upper
                        cutoff `-u`, and the pre-scanning cutoff `-c`. The
                        pre-scanning cutoff should be the cutoff close to the
                        BOTTOM of the cutoff analysis result that can capture
                        large number of possible peaks with normal length
                        (average length 500-1000bps). In most cases, please do
                        not pick a cutoff too low that capture almost all the
                        background noises from the data. Default: 1.2
  --minlen OPENREGION_MINLEN
                        Minimum length of open region to call accessible
                        regions. Must be larger than 0. If it is set as 0, it
                        means no filtering on the length of the open regions
                        called. Please note that, when bin size is small,
                        setting a too small OPENREGION_MINLEN will bring a lot
                        of false positives. Default: 100

Misc arguments:
  --pileup-short        By default, HMMRATAC will pileup all fragments in
                        order to identify regions for training and candidate
                        regions for decoding. When this option is on, it will
                        pileup only the short fragments to do so. Although it
                        sounds a good idea since we assume that open region
                        should have a lot of short fragments, it may be
                        possible that the overall short fragments are too few
                        to be useful. Default: False
  --randomSeed HMM_RANDOMSEED
                        Seed to set for random sampling of training regions.
                        Default: 10151
  --decoding-steps DECODING_STEPS
                        Number of candidate regions to be decoded at a time.
                        The HMM model will be applied with Viterbi to find the
                        optimal state path in each region. bigger the number,
                        'possibly' faster the decoding process, 'definitely'
                        larger the memory usage. Default: 1000.
  -e BLACKLIST, --blacklist BLACKLIST
                        Filename of blacklisted regions to exclude. Fragments
                        aligned to such regions will be excluded from
                        analysis. Examples are those from ENCODE. Default:
                        None
  --remove-dup          Remove duplicated fragments from analysis. A fragment
                        is duplicated if both ends of the fragment are the
                        same as another fragment. By default, duplicated
                        fragments won't be excluded. Default: False
  --verbose VERBOSE     Set verbose level of runtime message. 0: only show
                        critical message, 1: show additional warning message,
                        2: show process information, 3: show debug messages.
                        DEFAULT:2
  --buffer-size BUFFER_SIZE
                        Buffer size for incrementally increasing internal
                        array size to store reads alignment information. In
                        most cases, you don't have to change this parameter.
                        However, if there are large number of
                        chromosomes/contigs/scaffolds in your alignment, it's
                        recommended to specify a smaller buffer size in order
                        to decrease memory usage (but it will take longer time
                        to read alignment files). Minimum memory requested for
                        reading an alignment file is about # of CHROMOSOME *
                        BUFFER_SIZE * 8 Bytes. DEFAULT: 100000

HMMRATAC is a dedicated tool for processing ATAC-seq data

HMMRATAC, first released as a JAVA program in 2019, is a dedicated
tool specifically designed for processing ATAC-seq data. In MACS3, it
has been integrated as a subcommand (`hmmratac`). Reimagined and
rewritten in Python and Cython, this tool's functionality might vary
from its JAVA version. The core principle of HMMRATAC involves
utilizing the Hidden Markov Model to learn the nucleosome structure
around open chromatin regions.

Here's an example of how to run the `hmmratac` command:

```
$ macs3 hmmratac -i yeast.bam -n yeast
```

or with the BEDPE format

```
$ macs3 hmmratac -i yeast.bedpe.gz -f BEDPE -n yeast
```

Note: you can convert BAMPE to BEDPE by using

```
$ macs3 filterdup --keep-dup all -f BAMPE -i yeast.bam -o yeast.bedpe
```

The final output from `hmmratac` is in narrowPeak format containing
the accessible regions (open state in `hmmratac` Hidden Markov
Moedel). The columns in the narrowPeak file are:

 1. chromosome name
 2. start position of the accessible region
 3. end position of the accesssible region
 4. peak name
 5. peak score. The peak score represents the maximum fold change
    (signal/average signal) within the peak. By default, the signal is
    the total pileup of all types of fragments, ranging from short to
    tri-nucleosome-sized fragments.
 6. Not used
 7. Not used
 8. Not used
 9. peak summit position. It's the relative position from the start
    position to the peak summit which is defined as the position with
    the maximum foldchange score.

Before proceeding, it's essential to carefully read the help messages
concerning each option and the default parameters. There are several
crucial parameters we usually need to specify:

1. Lower cutoff to select training regions through `-l`.
2. Upper cutoff to select training regions through `-u`.
3. Pre-scanning cutoff to select candidate regions for
   decoding/predicting the states, including open, nucleosome, and
   background states, through `-c`.

These three parameters can significantly influence the
results. Therefore, it's highly recommended to run `macs3 hmmratac
--cutoff-analysis-only -i your.bam` first, which will help you decide
the parameters for `-l`, `-u`, and `-c`. Since there isn't an
automatic way to determine these parameters, your judgement will be
vital. Please read the output from `macs3 hmmratac
--cutoff-analysis-only -i your.bam` and the following section `Choices
of cutoff values` for guidance.

* Choices of cutoff values *

Before you proceed, it's highly recommended to run with
`--cutoff-analysis-only` for the initial attempt. When this option is
activated, `hmmratac` will use EM to estimate the best parameters for
fragment sizes of short fragments, mono-, di-, and tri-nucleosomes,
pileup fragments, convert the pileup values into fold-change, and
analyze each possible cutoff. This analysis includes the number of
peaks that can be called, their average peak length, and their total
length. After the report is generated, you can review its contents and
decide on the optimal `-l`, `-u`, and `-c`.

The report consists of four columns:

1. score: the possible fold change cutoff value.
2. npeaks: the number of peaks under this cutoff.
3. lpeaks: the total length of all peaks.
4. avelpeak: the average length of peaks.

While there's no universal rule, here are a few suggestions:

- The lower cutoff should be the cutoff in the report that captures a
  moderate number (about 10k-30k) of peaks with a normal width (average
  length 500-1000bps long).
- The upper cutoff should capture some (typically hundreds of)
  extremely high enrichment and unusually wide peaks in the
  report. The aim here is to exclude abnormal enrichment caused by
  artifacts such as repetitive regions.
- The pre-scanning cutoff should be the cutoff close to the BOTTOM of
  the report that can capture a large number of potential peaks with a
  normal length (average length 500-1000bps). However, it's
  recommended not to use the lowest cutoff value in the report as this
  may include too much noise from the genome.

* Tune the HMM model *

It's highly recommended to check the runtime message of the HMM model
after training. An example is like this:

```
#4 Train Hidden Markov Model with Multivariate Gaussian Emission
#  Extract signals in training regions with bin size of 10
#  Use Baum-Welch algorithm to train the HMM
#   HMM converged: True
#  Write HMM parameters into JSON: test_model.json
#  The Hidden Markov Model for signals of binsize of 10 basepairs:
#   open state index: state2
#   nucleosomal state index: state1
#   background state index: state0
#   Starting probabilities of states:
#                            bg        nuc       open
#                        0.7994     0.1312    0.06942
#   HMM Transition probabilities:
#                            bg        nuc       open
#               bg->     0.9842    0.01202   0.003759
#              nuc->    0.03093     0.9562    0.01287
#             open->   0.007891    0.01038     0.9817
#   HMM Emissions (mean):
#                         short       mono         di        tri
#               bg:      0.2551      1.526     0.4646    0.07071
#              nuc:       6.538      17.94      3.422    0.05819
#             open:       5.016      17.47      6.897      2.121
```

We will 'guess' which hidden state is for the open region, which is
the nucleosomal region, and which is the background. We compute from
the HMM Emission matrix to pick the state with the highest sum of mean
signals as the open state, the lowest as the backgound state, then the
rest is the nucleosomal state. However it may not work in every
case. In the above example, it may be tricky to call the second row as
'nuc' and the third as 'open'. If the users want to exchange the state
assignments of the 'nuc' and 'open', they can modify the state
assignment in the HMM model file (e.g. test_model.json). For the above
example, the model.json looks like this (we skipped some detail):

```
{"startprob": [...], "transmat": [...], "means": [...], "covars": [...],
"covariance_type": "full", "n_features": 4,
"i_open_region": 2, "i_background_region": 0, "i_nucleosomal_region": 1,
"hmm_binsize": 10}
```

We can modify the assignment of: `"i_open_region": 2,
"i_background_region": 0, "i_nucleosomal_region": 1,` by assigning `1`
to open, and `2` to nucleosomal as: `"i_open_region": 1,
"i_background_region": 0, "i_nucleosomal_region": 2,` Then save the
HMM in a new model file such as `new_model.json`.

Then next, we can re-run `macs3 hmmratac` with the same parameters
plus an extra option for the HMM model file like `macs3 hmmratac
--model new_model.json`
```


## Metadata
- **Skill**: generated
