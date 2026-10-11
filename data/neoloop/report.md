# neoloop CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| neoloop_add_prefix_to_cool | PASS | synthetic data: chr prefix removed from a real cool first |
| neoloop_assemble-complexSVs | PASS |  |
| neoloop_calculate-cnv | PASS | real SK-N-MC Hi-C (chr1, chrX, 25kb); default download fails (busybox wget lacks -L), so reference files were given through the cachefolder input |
| neoloop_correct-cnv | PASS |  |
| neoloop_neoloop-caller | PASS | real SK-N-MC Hi-C; Peakachu model given through the cachefolder input because the image wget lacks -L |
| neoloop_neotad-caller | PASS |  |
| neoloop_plot-cnv | PASS |  |
| neoloop_prepare-SV-breakpoints | PASS | synthetic data: small planted SV table based on a real SK-N-MC translocation |
| neoloop_searchSVbyGene | Failed | image problem: pyensembl/gtfparse crash (polars has no toggle_string_cache) |
| neoloop_segment-cnv | PASS |  |
| neoloop_simulate-cnv | PASS | synthetic data: the same SK-N-MC cool was used as normal and cancer map |

## neoloop_calculate-cnv

### Tool Description
Calculate the copy number variation profile from Hi-C map using a generalized additive model with the Poisson link function

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Stars**: N/A
### Original Help Text
```text
usage: calculate-cnv [-h] [-v] [-H HIC] [-g {hg19,hg38,mm9,mm10}]
                     [-e {HindIII,MboI,DpnII,Arima,BglII,uniform}]
                     [--output OUTPUT] [--cachefolder CACHEFOLDER]
                     [--logFile LOGFILE]

Calculate the copy number variation profile from Hi-C map using a generalized
additive model with the Poisson link function

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -H HIC, --hic HIC     Cool URI. (default: None)
  -g {hg19,hg38,mm9,mm10}, --genome {hg19,hg38,mm9,mm10}
                        Reference genome name. (default: hg38)
  -e {HindIII,MboI,DpnII,Arima,BglII,uniform}, --enzyme {HindIII,MboI,DpnII,Arima,BglII,uniform}
                        The restriction enzyme name used in the Hi-C
                        experiment. If the genome was cutted using a sequence-
                        independent/uniform-cutting enzyme, please consider
                        setting this parameter to "uniform". (default: MboI)
  --output OUTPUT       Output file path. (default: None)
  --cachefolder CACHEFOLDER
                        Cache folder. We suggest keep this setting the same
                        between different runs. (default: .cache)
  --logFile LOGFILE     Logging file name. (default: cnv-calculation.log)
```


## neoloop_segment-cnv

### Tool Description
Perform HMM segmentation on a pre-calculated copy number variation profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: segment-cnv [-h] [-v] [--cnv-file CNV_FILE] [--ploidy PLOIDY]
                   [--binsize BINSIZE] [--num-of-states NUM_OF_STATES]
                   [--cbs-pvalue CBS_PVALUE] [--max-dist MAX_DIST]
                   [--min-diff MIN_DIFF] [--min-segment-size MIN_SEGMENT_SIZE]
                   [--output OUTPUT] [--nproc NPROC] [--logFile LOGFILE]

Perform HMM segmentation on a pre-calculated copy number variation profile.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  --cnv-file CNV_FILE   Copy number profile in bedGraph format. (default:
                        None)
  --ploidy PLOIDY       Ploidy of the cell. (default: 2)
  --binsize BINSIZE     Bin size in base pairs. (default: None)
  --num-of-states NUM_OF_STATES
                        The number of states to initialize. By default, this
                        number is estimated using a Gaussian Mixture model and
                        the AIC criterion. (default: None)
  --cbs-pvalue CBS_PVALUE
                        The P-value cutoff used in the circular binary
                        segmentation (CBS) algorithm. (default: 1e-05)
  --max-dist MAX_DIST   Maximum allowed distance between HMM and CBS
                        breakpoints. (default: 4)
  --min-diff MIN_DIFF   Minimum copy number difference between neighboring
                        segments. Two neighboring segments will be merged
                        together if the difference of their copy number ratio
                        is less than this value. (default: 0.4)
  --min-segment-size MIN_SEGMENT_SIZE
                        Minimum segment size. Small segments with a size less
                        than this number of bins will be merged with nearby
                        larger segments. (default: 3)
  --output OUTPUT       Output file path. (default: None)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: cnv-seg.log)
```


## neoloop_assemble-complexSVs

### Tool Description
Assemble complex SVs given an individual SV list.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assemble-complexSVs [-h] [-v] [-O OUTPUT] [-B BREAK_POINTS]
                           [-H HIC [HIC ...]] [-R REGION_SIZE]
                           [--minimum-size MINIMUM_SIZE]
                           [--balance-type {CNV,ICE}]
                           [--protocol {insitu,dilution}] [--nproc NPROC]
                           [--logFile LOGFILE]

Assemble complex SVs given an individual SV list.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -O OUTPUT, --output OUTPUT
                        Output prefix. (default: None)
  -B BREAK_POINTS, --break-points BREAK_POINTS
                        Path to a TXT file containing pairs of break points.
                        (default: None)
  -H HIC [HIC ...], --hic HIC [HIC ...]
                        List of cooler URIs. If URIs at multiple resolutions
                        are provided, the program will first detect complex
                        SVs from each individual resolution, and then combine
                        results from all resolutions in a non-redundant way.
                        (default: None)
  -R REGION_SIZE, --region-size REGION_SIZE
                        The extended genomic span of SV break points.(bp)
                        (default: 5000000)
  --minimum-size MINIMUM_SIZE
                        For intra-chromosomal SVs, only SVs that are larger
                        than this size will be considered by the pipeline.
                        (default: 500000)
  --balance-type {CNV,ICE}
                        Normalization method. (default: CNV)
  --protocol {insitu,dilution}
                        Experimental protocol of your Hi-C. (default: insitu)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: assembleSVs.log)
```


## neoloop_neoloop-caller

### Tool Description
Identify novel loop interactions across SV points.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neoloop-caller [-h] [-v] [-O OUTPUT] [-H HIC [HIC ...]]
                      [--assembly ASSEMBLY] [--cachefolder CACHEFOLDER]
                      [-R REGION_SIZE] [--balance-type {CNV,ICE}]
                      [--protocol {insitu,dilution}] [--prob PROB]
                      [--no-clustering]
                      [--min-marginal-peaks MIN_MARGINAL_PEAKS]
                      [--nproc NPROC] [--logFile LOGFILE]

Identify novel loop interactions across SV points.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -O OUTPUT, --output OUTPUT
                        Path to the output file. (default: None)
  -H HIC [HIC ...], --hic HIC [HIC ...]
                        List of cooler URIs. If URIs at multiple resolutions
                        are provided, the program will first detect neo-loops
                        from each individual resolution, and then combine
                        results from all resolutions in a non-redundant way.
                        If an interaction is detected as a loop in multiple
                        resolutions, only the one with the highest resolution
                        will be recorded. (default: None)
  --assembly ASSEMBLY   The assembled SV list outputed by assemble-complexSVs.
                        (default: None)
  --cachefolder CACHEFOLDER
                        Path to a folder to place the pre-trained Peakachu
                        models. This command will automatically download
                        appropriate models according to the sequencing depths
                        and resolutions of your input Hi-C matrices. (default:
                        .cache)
  -R REGION_SIZE, --region-size REGION_SIZE
                        The extended genomic span of SV break points.(bp)
                        (default: 3000000)
  --balance-type {CNV,ICE}
                        Normalization method. (default: CNV)
  --protocol {insitu,dilution}
                        Experimental protocol of your Hi-C. (default: insitu)
  --prob PROB           Probability threshold. (default: 0.9)
  --no-clustering       No pooling will be performed if specified. (default:
                        False)
  --min-marginal-peaks MIN_MARGINAL_PEAKS
                        Minimum marginal number of loops when detecting loop
                        anchors. (default: 2)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: neoloop.log)
```


## neoloop_neotad-caller

### Tool Description
Identify neo-TADs.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neotad-caller [-h] [-v] [-O OUTPUT] [-H HIC] [--assembly ASSEMBLY]
                     [-R REGION_SIZE] [--balance-type {CNV,ICE}]
                     [--protocol {insitu,dilution}]
                     [--window-size WINDOW_SIZE] [--nproc NPROC]
                     [--logFile LOGFILE]

Identify neo-TADs.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -O OUTPUT, --output OUTPUT
                        Output path. (default: None)
  -H HIC, --hic HIC     Cooler URI. (default: None)
  --assembly ASSEMBLY   The assembled SV list outputed by assemble-complexSVs.
                        (default: None)
  -R REGION_SIZE, --region-size REGION_SIZE
                        The extended genomic span of SV break points.(bp)
                        (default: 3000000)
  --balance-type {CNV,ICE}
                        Normalization method. (default: CNV)
  --protocol {insitu,dilution}
                        Experimental protocol of your Hi-C. (default: insitu)
  --window-size WINDOW_SIZE
                        Window size for calculating DI. (default: 2000000)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: neotad.log)
```


## neoloop_searchSVbyGene

### Tool Description
Search matched SV regions by gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: searchSVbyGene [-h] [-v] [-L LOOP_FILE] [-G GENE_NAME]
                      [--ensembl-release ENSEMBL_RELEASE] [--species SPECIES]

Search matched SV regions by gene.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -L LOOP_FILE, --loop-file LOOP_FILE
                        Path to the loop file generated by neoloop-caller.
                        (default: None)
  -G GENE_NAME, --gene-name GENE_NAME
                        Gene name. (default: None)
  --ensembl-release ENSEMBL_RELEASE
                        Release number of the Ensembl database. The reference
                        genome assembly should be consistent with your Hi-C
                        data used in neoloop-caller. (default: 93)
  --species SPECIES     Species name of your cell line. (default: human)
```


## neoloop_correct-cnv

### Tool Description
Remove copy number variation effect from cancer Hi-C.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: correct-cnv [-h] [-v] [-H HIC] [--cnv-file CNV_FILE]
                   [--mad-max MAD_MAX] [--min-nnz MIN_NNZ]
                   [--ignore-diags IGNORE_DIAGS] [--nproc NPROC] [-f]
                   [--logFile LOGFILE]

Remove copy number variation effect from cancer Hi-C.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -H HIC, --hic HIC     Cool URI. (default: None)
  --cnv-file CNV_FILE   Copy number segmentation in bedGraph format. (default:
                        None)
  --mad-max MAD_MAX     Ignore bins from the contact matrix using the 'MAD-
                        max' filter. Increase the value of this parameter to
                        include more bins to be considered in matrix
                        balancing. Setting this parameter to 0 will ignore the
                        'MAD-max' filter. (default: 5)
  --min-nnz MIN_NNZ     Ignore bins from the contact matrix whose marginal
                        number of nonzeros is less than this number. (default:
                        10)
  --ignore-diags IGNORE_DIAGS
                        Number of diagonals of the contact matrix to ignore.
                        For example, 0 ignores nothing, 1 ignores the main
                        diagonal, and 2 ignores diagonals (-1, 0, 1).
                        (default: 1)
  --nproc NPROC         Number of worker processes. (default: 1)
  -f, --force           When specified, overwrite the target bias vector,
                        "sweight", if it already exists. (default: False)
  --logFile LOGFILE     Logging file name. (default: cnv-norm.log)
```

## neoloop_plot-cnv

### Tool Description
Plot genome-wide CNV profiles and segments.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot-cnv [-h] [-v] [--cnv-profile CNV_PROFILE]
                [--cnv-segment CNV_SEGMENT]
                [--output-figure-name OUTPUT_FIGURE_NAME] [-C [CHROMS ...]]
                [--dot-size DOT_SIZE] [--dot-alpha DOT_ALPHA]
                [--line-width LINE_WIDTH] [--boundary-width BOUNDARY_WIDTH]
                [--label-size LABEL_SIZE] [--tick-label-size TICK_LABEL_SIZE]
                [--maximum-value MAXIMUM_VALUE]
                [--minimum-value MINIMUM_VALUE] [--fig-width FIG_WIDTH]
                [--fig-height FIG_HEIGHT] [--dpi DPI] [--clean-mode]

Plot genome-wide CNV profiles and segments.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  --cnv-profile CNV_PROFILE
                        Copy number profile in bedGraph format. (default:
                        None)
  --cnv-segment CNV_SEGMENT
                        Copy number segmentation in bedGraph format. Optional
                        (default: None)
  --output-figure-name OUTPUT_FIGURE_NAME
                        Output file path. (default: None)
  -C [CHROMS ...], --chroms [CHROMS ...]
                        List of chromosome labels. Only Hi-C data within the
                        specified chromosomes will be included. Specially, "#"
                        stands for chromosomes with numerical labels. "--
                        chroms" with zero argument will include all chromosome
                        data. (default: ['#', 'X'])
  --dot-size DOT_SIZE   Size of the dots. (default: 0.5)
  --dot-alpha DOT_ALPHA
                        The alpha blending value of the dots, between 0
                        (transparent) and 1 (opaque). (default: 0.1)
  --line-width LINE_WIDTH
                        Width of the CNV segment lines. (default: 1)
  --boundary-width BOUNDARY_WIDTH
                        Width of the chromosome boundaries. (default: 1)
  --label-size LABEL_SIZE
                        Label fontsize. (default: 6)
  --tick-label-size TICK_LABEL_SIZE
                        Fontsize of the tick labels. (default: 3)
  --maximum-value MAXIMUM_VALUE
                        Maximum value. (default: None)
  --minimum-value MINIMUM_VALUE
                        Minimum value. (default: None)
  --fig-width FIG_WIDTH
                        Width of the figure. (default: 5)
  --fig-height FIG_HEIGHT
                        Height of the figure. (default: 1)
  --dpi DPI
  --clean-mode
```

## neoloop_simulate-cnv

### Tool Description
Generate a Hi-C matrix given a normal Hi-C cool file and a genomic CNV profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simulate-cnv [-h] [-v] [--normal-cool NORMAL_COOL]
                    [--cancer-cool CANCER_COOL] [--cnv-file CNV_FILE]
                    [--output OUTPUT] [--exclude [EXCLUDE ...]]
                    [--ploidy PLOIDY] [--nproc NPROC] [--logFile LOGFILE]

Generate a Hi-C matrix given a normal Hi-C cool file and a genomic CNV profile
in bedGraph format.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  --normal-cool NORMAL_COOL
                        Cool URI of a normal cell (default: None)
  --cancer-cool CANCER_COOL
                        Cool URI of a cancer cell (default: None)
  --cnv-file CNV_FILE   Copy number profile from the same cancer cell.
                        (default: None)
  --output OUTPUT       Output folder name. (default: None)
  --exclude [EXCLUDE ...]
                        List of chromosomes to exclude. (default: ['chrY',
                        'chrM'])
  --ploidy PLOIDY       Ploidy of the cancer genome (default: 3)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: cnvsim.log)
```

## neoloop_add_prefix_to_cool

### Tool Description
Add the chr prefix to the chromosome names of a cool file in place.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: add_prefix_to_cool.py <cool file>   (adds the chr prefix to all chromosome names in place)
```

## neoloop_prepare-SV-breakpoints

### Tool Description
Convert an SV table to the break point list used by assemble-complexSVs.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: python prepare-SV-breakpoints.py <input SV table> <output break points>
```

## Metadata
- **Skill**: generated
