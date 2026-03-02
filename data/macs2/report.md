# macs2 CWL Generation Report

## macs2_callpeak

### Tool Description
Model-based Analysis of ChIP-Seq (MACS2) for identifying transcript factor binding sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Total Downloads**: 194.9K
- **Last updated**: 2025-10-05
- **GitHub**: https://github.com/macs3-project/MACS
- **Stars**: N/A
### Original Help Text
```text
usage: macs2 callpeak [-h] -t TFILE [TFILE ...] [-c [CFILE ...]]
                      [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                      [-g GSIZE] [-s TSIZE] [--keep-dup KEEPDUPLICATES]
                      [--outdir OUTDIR] [-n NAME] [-B] [--verbose VERBOSE]
                      [--trackline] [--SPMR] [--nomodel] [--shift SHIFT]
                      [--extsize EXTSIZE] [--bw BW] [--d-min D_MIN]
                      [-m MFOLD MFOLD] [--fix-bimodal] [-q QVALUE | -p PVALUE]
                      [--scale-to {large,small}] [--down-sample] [--seed SEED]
                      [--tempdir TEMPDIR] [--nolambda] [--slocal SMALLLOCAL]
                      [--llocal LARGELOCAL] [--max-gap MAXGAP]
                      [--min-length MINLEN] [--broad]
                      [--broad-cutoff BROADCUTOFF] [--cutoff-analysis]
                      [--call-summits] [--fe-cutoff FECUTOFF]
                      [--buffer-size BUFFER_SIZE] [--to-large] [--ratio RATIO]

options:
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
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE" or "BAMPE" or "BEDPE". The default AUTO
                        option will let MACS decide which format (except for
                        BAMPE and BEDPE which should be implicitly set) the
                        file is. Please check the definition in README. Please
                        note that if the format is set as BAMPE or BEDPE,
                        MACS2 will call its special Paired-end mode to call
                        peaks by piling up the actual ChIPed fragments defined
                        by both aligned ends, instead of predicting the
                        fragment size first and extending reads. Also please
                        note that the BEDPE only contains three columns, and
                        is NOT the same BEDPE format used by BEDTOOLS.
                        DEFAULT: "AUTO"
  -g GSIZE, --gsize GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2.7e9), 'mm' for mouse
                        (1.87e9), 'ce' for C. elegans (9e7) and 'dm' for
                        fruitfly (1.2e8), Default:hs
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
                        MACS2 will still read them although the reads may be
                        decided by MACS2 as duplicate later. If you plan to
                        rely on samtools/picard/any other tool to filter
                        duplicates, please remove those duplicate reads and
                        save a new alignment file then ask MACS2 to keep all
                        by '--keep-dup all'. The default is to keep one tag at
                        the same location. Default: 1

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
  --trackline           Tells MACS to include trackline with bedGraph files.
                        To include this trackline while displaying bedGraph at
                        UCSC genome browser, can show name and description of
                        the file as well. However my suggestion is to convert
                        bedGraph to bigWig, then show the smaller and faster
                        binary bigWig file at UCSC genome browser, as well as
                        downstream analysis. Require -B to be set. Default:
                        Not include trackline.
  --SPMR                If True, MACS will SAVE signal per million reads for
                        fragment pileup profiles. It won't interfere with
                        computing pvalue/qvalue during peak calling, since
                        internally MACS2 keeps using the raw pileup and
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
                        that in broad peakcalling mode, MACS2 uses this
                        setting to control the overall peak calling behavior,
                        then uses -q or -p setting to define regions inside
                        broad region as 'stronger' enrichment. DEFAULT: 0.1
  --cutoff-analysis     While set, MACS2 will analyze number or total length
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
  --fe-cutoff FECUTOFF  When set, the value will be used to filter out peaks
                        with low fold-enrichment. Note, MACS2 use 1.0 as
                        pseudocount while calculating fold-enrichment.
                        DEFAULT: 1.0

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

Obsolete options:
  --to-large            Obsolete option. Please use '--scale-to large'
                        instead.
  --ratio RATIO         Obsolete option. Originally designed to normalize
                        treatment and control with customized ratio, now it
                        won't have any effect.
```


## macs2_bdgpeakcall

### Tool Description
Call peaks from bedGraph output of MACS2

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 bdgpeakcall [-h] -i IFILE [-c CUTOFF] [-l MINLEN] [-g MAXGAP]
                         [--cutoff-analysis] [--no-trackline]
                         [--outdir OUTDIR] (-o OFILE | --o-prefix OPREFIX)

options:
  -h, --help            show this help message and exit
  -i IFILE, --ifile IFILE
                        MACS score in bedGraph. REQUIRED
  -c CUTOFF, --cutoff CUTOFF
                        Cutoff depends on which method you used for score
                        track. If the file contains pvalue scores from MACS2,
                        score 5 means pvalue 1e-5. DEFAULT: 5
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
  --no-trackline        Tells MACS not to include trackline with bedGraph
                        files. The trackline is required by UCSC.
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output file name. Mutually exclusive with --o-prefix.
  --o-prefix OPREFIX    Output file prefix. Mutually exclusive with
                        -o/--ofile.
```


## macs2_bdgbroadcall

### Tool Description
MACS2 subtool to call broad peaks from bedGraph score tracks.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 bdgbroadcall [-h] -i IFILE [-c CUTOFFPEAK] [-C CUTOFFLINK]
                          [-l MINLEN] [-g LVL1MAXGAP] [-G LVL2MAXGAP]
                          [--no-trackline] [--outdir OUTDIR]
                          (-o OFILE | --o-prefix OPREFIX)

options:
  -h, --help            show this help message and exit
  -i IFILE, --ifile IFILE
                        MACS score in bedGraph. REQUIRED
  -c CUTOFFPEAK, --cutoff-peak CUTOFFPEAK
                        Cutoff for peaks depending on which method you used
                        for score track. If the file contains qvalue scores
                        from MACS2, score 2 means qvalue 0.01. DEFAULT: 2
  -C CUTOFFLINK, --cutoff-link CUTOFFLINK
                        Cutoff for linking regions/low abundance regions
                        depending on which method you used for score track. If
                        the file contains qvalue scores from MACS2, score 1
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
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output file name. Mutually exclusive with --o-prefix.
  --o-prefix OPREFIX    Output file prefix. Mutually exclusive with
                        -o/--ofile.
```


## macs2_bdgcmp

### Tool Description
Deduct noise by comparing treatment and control bedGraph files from MACS2

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 bdgcmp [-h] -t TFILE -c CFILE [-S SFACTOR] [-p PSEUDOCOUNT]
                    [-m {ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} [{ppois,qpois,subtract,logFE,FE,logLR,slogLR,max} ...]]
                    [--outdir OUTDIR]
                    (--o-prefix OPREFIX | -o OFILE [OFILE ...])

options:
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
                        you have SPMR output from MACS2 callpeak, and plan to
                        calculate scores as MACS2 callpeak module. If you want
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
                        choices are: ppois, qpois, subtract, logFE, logLR, and
                        slogLR. They represent Poisson Pvalue (-log10(pvalue)
                        form) using control as lambda and treatment as
                        observation, q-value through a BH process for poisson
                        pvalues, subtraction from treatment, linear scale fold
                        enrichment, log10 fold enrichment(need to set
                        pseudocount), log10 likelihood between ChIP-enriched
                        model and open chromatin model(need to set
                        pseudocount), symmetric log10 likelihood between two
                        ChIP-enrichment models, or maximum value between the
                        two tracks. Default option is ppois.
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


## macs2_bdgopt

### Tool Description
Modify the score column of a bedGraph file using various methods like multiply, add, max, min, or p2q conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 bdgopt [-h] -i IFILE [-m {multiply,add,p2q,max,min}]
                    [-p [EXTRAPARAM ...]] [--outdir OUTDIR] -o OFILE

options:
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
                        the scores are -log10 p-value from MACS2. Any other
                        types of score will cause unexpected errors.
  -p [EXTRAPARAM ...], --extra-param [EXTRAPARAM ...]
                        The extra parameter for METHOD. Check the detail of -m
                        option.
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -o OFILE, --ofile OFILE
                        Output BEDGraph filename.
```


## macs2_cmbreps

### Tool Description
Combine scores from replicates in bedGraph format using various methods like Fisher's, max, or mean.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 cmbreps [-h] -i IFILE [IFILE ...] [-m {fisher,max,mean}]
                     [--outdir OUTDIR] -o OFILE

options:
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
```


## macs2_bdgdiff

### Tool Description
Differential peak detection based on paired bedGraph files

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 bdgdiff [-h] --t1 T1BDG --t2 T2BDG --c1 C1BDG --c2 C2BDG
                     [-C CUTOFF] [-l MINLEN] [-g MAXGAP] [--d1 DEPTH1]
                     [--d2 DEPTH2] [--outdir OUTDIR]
                     (--o-prefix OPREFIX | -o OFILE OFILE OFILE)

options:
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
                        logLR cutoff. DEFAULT: 3 (likelihood ratio=1000)
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


## macs2_filterdup

### Tool Description
Filter duplicate reads from alignment files based on a binomial distribution test or a fixed threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 filterdup [-h] -i IFILE [IFILE ...]
                       [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                       [-g GSIZE] [-s TSIZE] [-p PVALUE]
                       [--keep-dup KEEPDUPLICATES] [--buffer-size BUFFER_SIZE]
                       [--verbose VERBOSE] [--outdir OUTDIR] [-o OUTPUTFILE]
                       [-d]

options:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        Alignment file. If multiple files are given as '-t A B
                        C', then they will all be read and combined. Note that
                        pair-end data is not supposed to work with this
                        command. REQUIRED.
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE" or "BAMPE" or "BEDPE". The default AUTO
                        option will let 'macs2 filterdup' decide which format
                        the file is. Please check the definition in README
                        file if you choose
                        ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE or
                        BAMPE/BEDPE. DEFAULT: "AUTO"
  -g GSIZE, --gsize GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2.7e9), 'mm' for mouse
                        (1.87e9), 'ce' for C. elegans (9e7) and 'dm' for
                        fruitfly (1.2e8), DEFAULT:hs
  -s TSIZE, --tsize TSIZE
                        Tag size. This will override the auto detected tag
                        size. DEFAULT: Not set
  -p PVALUE, --pvalue PVALUE
                        Pvalue cutoff for binomial distribution test.
                        DEFAULT:1e-5
  --keep-dup KEEPDUPLICATES
                        It controls the 'macs2 filterdup' behavior towards
                        duplicate tags/pairs at the exact same location -- the
                        same coordination and the same strand. The 'auto'
                        option makes 'macs2 filterdup' calculate the maximum
                        tags at the exact same location based on binomal
                        distribution using given -p as pvalue cutoff; and the
                        'all' option keeps every tags (useful if you only want
                        to convert formats). If an integer is given, at most
                        this number of tags will be kept at the same location.
                        Note, MACS2 callpeak function uses KEEPDUPLICATES=1 as
                        default. Note, if you've used samtools or picard to
                        flag reads as 'PCR/Optical duplicate' in bit 1024,
                        MACS2 will still read them although the reads may be
                        decided by MACS2 as duplicate later. Default: auto
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


## macs2_predictd

### Tool Description
Predict fragment size from ChIP-seq alignment files using MACS2

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 predictd [-h] -i IFILE [IFILE ...]
                      [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                      [-g GSIZE] [-s TSIZE] [--bw BW] [--d-min D_MIN]
                      [-m MFOLD MFOLD] [--outdir OUTDIR] [--rfile RFILE]
                      [--buffer-size BUFFER_SIZE] [--verbose VERBOSE]

options:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        ChIP-seq alignment file. If multiple files are given
                        as '-t A B C', then they will all be read and
                        combined. Note that pair-end data is not supposed to
                        work with this command. REQUIRED.
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED" or "ELAND" or
                        "ELANDMULTI" or "ELANDEXPORT" or "SAM" or "BAM" or
                        "BOWTIE" or "BAMPE" or "BEDPE". The default AUTO
                        option will let MACS decide which format the file is.
                        Please check the definition in README file if you
                        choose ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE.
                        DEFAULT: "AUTO"
  -g GSIZE, --gsize GSIZE
                        Effective genome size. It can be 1.0e+9 or 1000000000,
                        or shortcuts:'hs' for human (2.7e9), 'mm' for mouse
                        (1.87e9), 'ce' for C. elegans (9e7) and 'dm' for
                        fruitfly (1.2e8), Default:hs
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
                        X-correlation figure. DEFAULT:'predictd' and R file
                        will be predicted_model.R
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


## macs2_pileup

### Tool Description
Create a pileup bedGraph file from alignment files

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 pileup [-h] -i IFILE [IFILE ...] -o OUTPUTFILE [--outdir OUTDIR]
                    [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                    [-B] [--extsize EXTSIZE] [--buffer-size BUFFER_SIZE]
                    [--verbose VERBOSE]

options:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        Alignment file. If multiple files are given as '-t A B
                        C', then they will all be read and combined. Note that
                        pair-end data is not supposed to work with this
                        command. REQUIRED.
  -o OUTPUTFILE, --ofile OUTPUTFILE
                        Output bedGraph file name. If not specified, will
                        write to standard output. REQUIRED.
  --outdir OUTDIR       If specified all output files will be written to that
                        directory. Default: the current working directory
  -f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}, --format {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}
                        Format of tag file, "AUTO", "BED", "ELAND",
                        "ELANDMULTI", "ELANDEXPORT", "SAM", "BAM", "BOWTIE",
                        "BAMPE", or "BEDPE". The default AUTO option will let
                        'macs2 pileup' decide which format the file is.
                        DEFAULT: "AUTO", MACS2 will pick a format from "AUTO",
                        "BED", "ELAND", "ELANDMULTI", "ELANDEXPORT", "SAM",
                        "BAM" and "BOWTIE". If the format is BAMPE or BEDPE,
                        please specify it explicitly. Please note that when
                        the format is BAMPE or BEDPE, the -B and --extsize
                        options would be ignored.
  -B, --both-direction  By default, any read will be extended towards
                        downstream direction by extension size. So it's
                        [0,size-1] (1-based index system) for plus strand read
                        and [-size+1,0] for minus strand read where position 0
                        is 5' end of the aligned read. Default behavior can
                        simulate MACS2 way of piling up ChIP sample reads
                        where extension size is set as fragment size/d. If
                        this option is set as on, aligned reads will be
                        extended in both upstream and downstream directions by
                        extension size. It means [-size,size] where 0 is the
                        5' end of a aligned read. It can partially simulate
                        MACS2 way of piling up control reads. However MACS2
                        local bias is calculated by maximizing the expected
                        pileup over a ChIP fragment size/d estimated from
                        10kb, 1kb, d and whole genome background. This option
                        will be ignored when the format is set as BAMPE or
                        BEDPE. DEFAULT: False
  --extsize EXTSIZE     The extension size in bps. Each alignment read will
                        become a EXTSIZE of fragment, then be piled up. Check
                        description for -B for detail. It's twice the
                        `shiftsize` in old MACSv1 language. This option will
                        be ignored when the format is set as BAMPE or BEDPE.
                        DEFAULT: 200
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


## macs2_randsample

### Tool Description
Randomly sample alignment files to a specific number or percentage of tags.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 randsample [-h] -i IFILE [IFILE ...] (-p PERCENTAGE | -n NUMBER)
                        [--seed SEED] [-o OUTPUTFILE] [--outdir OUTDIR]
                        [-s TSIZE]
                        [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE,BAMPE,BEDPE}]
                        [--buffer-size BUFFER_SIZE] [--verbose VERBOSE]

options:
  -h, --help            show this help message and exit
  -i IFILE [IFILE ...], --ifile IFILE [IFILE ...]
                        Alignment file. If multiple files are given as '-t A B
                        C', then they will all be read and combined. Note that
                        pair-end data is not supposed to work with this
                        command. REQUIRED.
  -p PERCENTAGE, --percentage PERCENTAGE
                        Percentage of tags you want to keep. Input 80.0 for
                        80%. This option can't be used at the same time with
                        -n/--num. REQUIRED
  -n NUMBER, --number NUMBER
                        Number of tags you want to keep. Input 8000000 or 8e+6
                        for 8 million. This option can't be used at the same
                        time with -p/--percent. Note that the number of tags
                        in output is approximate as the number specified here.
                        REQUIRED
  --seed SEED           Set the random seed while down sampling data. Must be
                        a non-negative integer in order to be effective.
                        DEFAULT: not set
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
                        option will macs2 randsample decide which format the
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


## macs2_refinepeak

### Tool Description
Refine peak summits and give a score measuring the balance of Watson and Crick tags. MACS2 refinepeak is used to take a candidate peak list and alignment files to refine the peak summits.

### Metadata
- **Docker Image**: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
- **Homepage**: https://pypi.org/project/MACS2/
- **Package**: https://anaconda.org/channels/bioconda/packages/macs2/overview
- **Validation**: PASS

### Original Help Text
```text
usage: macs2 refinepeak [-h] -b BEDFILE -i IFILE [IFILE ...]
                        [-f {AUTO,BAM,SAM,BED,ELAND,ELANDMULTI,ELANDEXPORT,BOWTIE}]
                        [-c CUTOFF] [-w WINDOWSIZE]
                        [--buffer-size BUFFER_SIZE] [--verbose VERBOSE]
                        [--outdir OUTDIR] (-o OFILE | --o-prefix OPREFIX)

options:
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
                        "BOWTIE". The default AUTO option will let 'macs2
                        refinepeak' decide which format the file is. Please
                        check the definition in README file if you choose
                        ELAND/ELANDMULTI/ELANDEXPORT/SAM/BAM/BOWTIE. DEFAULT:
                        "AUTO"
  -c CUTOFF, --cutoff CUTOFF
                        Cutoff DEFAULT: 5
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


## Metadata
- **Skill**: generated
