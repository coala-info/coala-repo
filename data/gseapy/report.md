# gseapy CWL Generation Report

## gseapy_gsea

### Tool Description
Run Gene Set Enrichment Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Total Downloads**: 251.7K
- **Last updated**: 2026-02-14
- **GitHub**: https://github.com/zqfang/gseapy
- **Stars**: N/A
### Original Help Text
```text
usage: gseapy gsea [-h] -d DATA -c CLS -g GMT [-t perType] [-o] [-f]
                   [--fs width height] [--graph int] [--no-plot] [-v]
                   [-n nperm] [--min-size int] [--max-size int] [-w float]
                   [-m] [-a] [-s] [-p procs]

options:
  -h, --help            show this help message and exit

Input files arguments:
  -d DATA, --data DATA  Input gene expression dataset file in txt format.Same
                        with GSEA.
  -c CLS, --cls CLS     Input class vector (phenotype) file in CLS format.
                        Same with GSEA.
  -g GMT, --gmt GMT     Gene set database in GMT format. Same with GSEA.
  -t perType, --permu-type perType
                        Type of permutation reshuffling, Choose from
                        {'phenotype': 'sample.labels' , 'gene_set' :
                        gene.labels}. Default: phenotype

Output arguments:
  -o , --outdir         The GSEApy output directory. Default: the current
                        working directory
  -f , --format         File extensions supported by Matplotlib active
                        backend, choose from {'pdf', 'png', 'jpeg','ps',
                        'eps','svg'}. Default: 'pdf'.
  --fs width height, --figsize width height
                        The figsize keyword argument need two parameters to
                        define. Default: (6.5, 6)
  --graph int           Numbers of top graphs produced. Default: 20
  --no-plot             Speed up computing by suppressing the plot output.This
                        is useful only if data are interested. Default: False.
  -v, --verbose         Increase output verbosity, print out progress of your
                        job

GSEA advanced arguments:
  -n nperm, --permu-num nperm
                        Number of random permutations. For calculating
                        esnulls. Default: 1000
  --min-size int        Min size of input genes presented in Gene Sets.
                        Default: 15
  --max-size int        Max size of input genes presented in Gene Sets.
                        Default: 500
  -w float, --weight float
                        Weighted_score of rank_metrics. For weighting input
                        genes. Choose from {0, 1, 1.5, 2}. Default: 1
  -m , --method         Methods to calculate correlations of ranking metrics.
                        Choose from {'signal_to_noise', 'abs_signal_to_noise',
                        't_test', 'ratio_of_classes',
                        'diff_of_classes','log2_ratio_of_classes'}. Default:
                        'signal_to_noise'
  -a, --ascending       Rank metric sorting order. If the -a flag was chosen,
                        then ascending equals to True. Default: False.
  -s , --seed           Number of random seed. Default: 123
  -p procs, --threads procs
                        Number of threads you are going to use. Default: 4
```


## gseapy_prerank

### Tool Description
GSEA prerank module

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gseapy prerank [-h] -r RNK -g GMT [-l pos neg] [-o] [-f]
                      [--fs width height] [--graph int] [--no-plot] [-v]
                      [-n nperm] [--min-size int] [--max-size int] [-w float]
                      [-a] [-s] [-p procs]

options:
  -h, --help            show this help message and exit

Input files arguments:
  -r RNK, --rnk RNK     Ranking metric file in .rnk format. Same with GSEA.
  -g GMT, --gmt GMT     Gene set database in GMT format. Same with GSEA.
  -l pos neg, --label pos neg
                        The phenotype label argument need two parameters to
                        define. Default: ('Pos','Neg')

Output arguments:
  -o , --outdir         The GSEApy output directory. Default: the current
                        working directory
  -f , --format         File extensions supported by Matplotlib active
                        backend, choose from {'pdf', 'png', 'jpeg','ps',
                        'eps','svg'}. Default: 'pdf'.
  --fs width height, --figsize width height
                        The figsize keyword argument need two parameters to
                        define. Default: (6.5, 6)
  --graph int           Numbers of top graphs produced. Default: 20
  --no-plot             Speed up computing by suppressing the plot output.This
                        is useful only if data are interested. Default: False.
  -v, --verbose         Increase output verbosity, print out progress of your
                        job

GSEA advanced arguments:
  -n nperm, --permu-num nperm
                        Number of random permutations. For calculating
                        esnulls. Default: 1000
  --min-size int        Min size of input genes presented in Gene Sets.
                        Default: 15
  --max-size int        Max size of input genes presented in Gene Sets.
                        Default: 500
  -w float, --weight float
                        Weighted_score of rank_metrics. For weighting input
                        genes. Choose from {0, 1, 1.5, 2}. Default: 1
  -a, --ascending       Rank metric sorting order. If the -a flag was chosen,
                        then ascending equals to True. Default: False.
  -s , --seed           Number of random seed. Default: 123
  -p procs, --threads procs
                        Number of threads you are going to use. Default: 4
```


## gseapy_ssgsea

### Tool Description
Single Sample GSEA

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gseapy ssgsea [-h] -d DATA -g GMT [-o] [-f] [--fs width height]
                     [--graph int] [--no-plot] [-v] [--sn normalize]
                     [-c transform] [--ns] [-n nperm] [--min-size int]
                     [--max-size int] [-w float] [-a] [-s] [-p procs]

options:
  -h, --help            show this help message and exit

Input files arguments:
  -d DATA, --data DATA  Input gene expression dataset file in txt format. Same
                        with GSEA.
  -g GMT, --gmt GMT     Gene set database in GMT format. Same with GSEA.

Output arguments:
  -o , --outdir         The GSEApy output directory. Default: the current
                        working directory
  -f , --format         File extensions supported by Matplotlib active
                        backend, choose from {'pdf', 'png', 'jpeg','ps',
                        'eps','svg'}. Default: 'pdf'.
  --fs width height, --figsize width height
                        The figsize keyword argument need two parameters to
                        define. Default: (6.5, 6)
  --graph int           Numbers of top graphs produced. Default: 20
  --no-plot             Speed up computing by suppressing the plot output.This
                        is useful only if data are interested. Default: False.
  -v, --verbose         Increase output verbosity, print out progress of your
                        job

Single Sample GSEA advanced arguments:
  --sn normalize, --sample-norm normalize
                        Sample normalization method. Choose from {'rank',
                        'log', 'log_rank','custom'}. Default: rank
  -c transform, --correl-type transform
                        Input data transformation after sample normalization.
                        Choose from {'rank','symrank', 'zscore'}. Default:
                        rank
  --ns, --no-scale      If the flag was set, don't normalize the enrichment
                        scores by number of genes.
  -n nperm, --permu-num nperm
                        Number of random permutations. For calculating
                        esnulls. Default: 0
  --min-size int        Min size of input genes presented in Gene Sets.
                        Default: 15
  --max-size int        Max size of input genes presented in Gene Sets.
                        Default: 2000
  -w float, --weight float
                        Weighted_score of rank_metrics. For weighting input
                        genes. Default: 0.25
  -a, --ascending       Rank metric sorting order. If the -a flag was chosen,
                        then ascending equals to True. Default: False.
  -s , --seed           Number of random seed. Default: 123
  -p procs, --threads procs
                        Number of Processes you are going to use. Default: 4
```


## gseapy_gsva

### Tool Description
Performs Gene Set Variation Analysis (GSVA)

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gseapy gsva [-h] -d DATA -g GMT [-o] [-v] [-m] [-k] [-a]
                   [--min-size int] [--max-size int] [-w float] [-s] [-p int]

options:
  -h, --help            show this help message and exit

Input files arguments:
  -d DATA, --data DATA  Input gene expression dataset file in txt format. Same
                        with GSEA.
  -g GMT, --gmt GMT     Gene set database in GMT format. Same with GSEA.

Output arguments:
  -o , --outdir         The GSEApy output directory. Default: the current
                        working directory
  -v, --verbose         Increase output verbosity, print out progress of your
                        job

GSVA advanced arguments:
  -m, --mx-diff         When set, ES is calculated as the maximum distance of
                        the random walk from 0. Default: False
  -k , --kernel-cdf     Gaussian is suitable when input expression values are
                        continuous. If input integer counts, then this
                        argument should be set to 'Poisson'
  -a, --abs-ranking     Flag used only when --mx-diff is not set. When set,
                        the original Kuiper statistic is used
  --min-size int        Min size of input genes presented in Gene Sets.
                        Default: 15
  --max-size int        Max size of input genes presented in Gene Sets.
                        Default: 2000
  -w float, --weight float
                        tau in the random walk performed by the gsva. Default:
                        1
  -s , --seed           Number of random seed. Default: 123
  -p int, --threads int
                        Number of Processes you are going to use. Default: 4
```


## gseapy_replot

### Tool Description
Reproduce GSEA figures from GSEA desktop results directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gseapy replot [-h] -i GSEA_dir [-o] [-f] [--fs width height]
                     [--graph int] [--no-plot] [-v] [-w float]

options:
  -h, --help            show this help message and exit

Input arguments:
  -i GSEA_dir, --indir GSEA_dir
                        The GSEA desktop results directroy that you want to
                        reproduce the figure
  -o , --outdir         The GSEApy output directory. Default: the current
                        working directory
  -f , --format         File extensions supported by Matplotlib active
                        backend, choose from {'pdf', 'png', 'jpeg','ps',
                        'eps','svg'}. Default: 'pdf'.
  --fs width height, --figsize width height
                        The figsize keyword argument need two parameters to
                        define. Default: (6.5, 6)
  --graph int           Numbers of top graphs produced. Default: 20
  --no-plot             Speed up computing by suppressing the plot output.This
                        is useful only if data are interested. Default: False.
  -v, --verbose         Increase output verbosity, print out progress of your
                        job
  -w float, --weight float
                        Weighted_score of rank_metrics. Please Use the same
                        value in GSEA. Choose from (0, 1, 1.5, 2),default: 1
```


## gseapy_enrichr

### Tool Description
Enrichr uses a list of gene names as input.

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gseapy enrichr [-h] -i IDs -g GMT [--org ORGANISM] [--ds STRING]
                      [--cut float] [--bg BG] [-t int] [-o] [-f]
                      [--fs width height] [--graph int] [--no-plot] [-v]

options:
  -h, --help            show this help message and exit

Input arguments:
  -i IDs, --input-list IDs
                        Enrichr uses a list of gene names as input.
  -g GMT, --gene-sets GMT
                        Enrichr library name(s) required. Separate each name
                        by comma.
  --org ORGANISM, --organism ORGANISM
                        Enrichr supported organism name. Default: human. See
                        here: https://amp.pharm.mssm.edu/modEnrichr.
  --ds STRING, --description STRING
                        It is recommended to enter a short description for
                        your list so that multiple lists can be differentiated
                        from each other if you choose to save or share your
                        list.
  --cut float, --cut-off float
                        Adjust-Pval cutoff, used for generating plots.
                        Default: 0.05.
  --bg BG, --background BG
                        Choose background from one of the following. (1) A
                        BioMart Dataset name, e.g. 'hsapiens_gene_ensembl' .
                        (2) A total gene number, e.g. 20000. Only works for
                        GMT file input. (3) A text file contains the
                        background gene list (one gene per row). Gene
                        identifier should be the same to your input (-i). (4)
                        Default: None. It means all genes in the (-g) input as
                        the background.
  -t int, --top-term int
                        Numbers of top terms shown in the plot. Default: 10

Output figure arguments:
  -o , --outdir         The GSEApy output directory. Default: the current
                        working directory
  -f , --format         File extensions supported by Matplotlib active
                        backend, choose from {'pdf', 'png', 'jpeg','ps',
                        'eps','svg'}. Default: 'pdf'.
  --fs width height, --figsize width height
                        The figsize keyword argument need two parameters to
                        define. Default: (6.5, 6)
  --graph int           Numbers of top graphs produced. Default: 20
  --no-plot             Speed up computing by suppressing the plot output.This
                        is useful only if data are interested. Default: False.
  -v, --verbose         Increase output verbosity, print out progress of your
                        job
```


## gseapy_biomart

### Tool Description
Query Ensembl biomart database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gseapy:1.1.11--py311h5e00ca1_1
- **Homepage**: https://github.com/zqfang/gseapy
- **Package**: https://anaconda.org/channels/bioconda/packages/gseapy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gseapy biomart [-h] -f NAME VALUE -a ATTR -o OFILE [-d DATA]
                      [--host HOST] [-m MART] [-v]

options:
  -h, --help            show this help message and exit

Input arguments:
  -f NAME VALUE, --filter NAME VALUE
                        Which filter to use. Input filter name, and value. If
                        multi-value required, separate each value by comma. If
                        value is a txt file, then one ID per row, exclude
                        header.
  -a ATTR, --attributes ATTR
                        Which attribute(s) to retrieve. Separate each attr by
                        comma.
  -o OFILE, --ofile OFILE
                        Output file name
  -d DATA, --dataset DATA
                        Which dataset to use. Default: hsapiens_gene_ensembl
  --host HOST           Which host to use. Select from {'www.ensembl.org',
                        'asia.ensembl.org', 'useast.ensembl.org'}.
  -m MART, --mart MART  Which mart to use. Default: ENSEMBL_MART_ENSEMBL.
  -v, --verbose         Increase output verbosity, print out progress of your
                        job
```

