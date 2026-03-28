# poppunk CWL Generation Report

## poppunk_create-db

### Tool Description
PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

### Metadata
- **Docker Image**: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
- **Homepage**: https://github.com/johnlees/PopPUNK
- **Package**: https://anaconda.org/channels/bioconda/packages/poppunk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poppunk/overview
- **Total Downloads**: 70.5K
- **Last updated**: 2026-01-12
- **GitHub**: https://github.com/johnlees/PopPUNK
- **Stars**: N/A
### Original Help Text
```text
usage: poppunk [-h]
               (--create-db | --qc-db | --fit-model {bgmm,dbscan,refine,lineage,threshold} | --use-model)
               [--ref-db REF_DB] [--r-files R_FILES] [--distances DISTANCES]
               [--external-clustering EXTERNAL_CLUSTERING] [--output OUTPUT]
               [--plot-fit PLOT_FIT] [--overwrite] [--graph-weights]
               [--min-k MIN_K] [--max-k MAX_K] [--k-step K_STEP]
               [--sketch-size SKETCH_SIZE] [--codon-phased]
               [--min-kmer-count MIN_KMER_COUNT] [--exact-count]
               [--strand-preserved] [--qc-keep]
               [--remove-samples REMOVE_SAMPLES] [--retain-failures]
               [--max-a-dist MAX_A_DIST] [--max-pi-dist MAX_PI_DIST]
               [--max-zero-dist MAX_ZERO_DIST] [--length-sigma LENGTH_SIGMA]
               [--length-range LENGTH_RANGE LENGTH_RANGE] [--prop-n PROP_N]
               [--upper-n UPPER_N] [--model-subsample MODEL_SUBSAMPLE]
               [--assign-subsample ASSIGN_SUBSAMPLE] [--for-refine] [--K K]
               [--D D] [--min-cluster-prop MIN_CLUSTER_PROP]
               [--threshold THRESHOLD] [--pos-shift POS_SHIFT]
               [--neg-shift NEG_SHIFT] [--manual-start MANUAL_START]
               [--model-dir MODEL_DIR] [--score-idx {0,1,2}]
               [--summary-sample SUMMARY_SAMPLE]
               [--betweenness-sample BETWEENNESS_SAMPLE]
               [--unconstrained | --multi-boundary MULTI_BOUNDARY | --indiv-refine {both,core,accessory}]
               [--ranks RANKS] [--count-unique-distances] [--reciprocal-only]
               [--max-search-depth MAX_SEARCH_DEPTH]
               [--write-lineage-networks] [--use-accessory]
               [--lineage-resolution LINEAGE_RESOLUTION] [--threads THREADS]
               [--gpu-sketch] [--gpu-dist] [--gpu-model] [--gpu-graph]
               [--deviceid DEVICEID] [--no-plot] [--no-local] [--version]
               [--citation]

PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

options:
  -h, --help            show this help message and exit

Mode of operation:
  --create-db           Create pairwise distances database between reference
                        sequences
  --qc-db               Run quality control on a reference database
  --fit-model {bgmm,dbscan,refine,lineage,threshold}
                        Fit a model to a (QCed) reference database
  --use-model           Apply a fitted model to a reference database to
                        restore database files

Input files:
  --ref-db REF_DB       Location of built reference database
  --r-files R_FILES     File listing reference input assemblies
  --distances DISTANCES
                        Prefix of input pickle of pre-calculated distances
  --external-clustering EXTERNAL_CLUSTERING
                        File with cluster definitions or other labels
                        generated with any other method.

Output options:
  --output OUTPUT       Prefix for output files
  --plot-fit PLOT_FIT   Create this many plots of some fits relating k-mer to
                        core/accessory distances [default = 0]
  --overwrite           Overwrite any existing database files
  --graph-weights       Save within-strain Euclidean distances into the graph

Create DB options:
  --min-k MIN_K         Minimum kmer length [default = 13]
  --max-k MAX_K         Maximum kmer length [default = 29]
  --k-step K_STEP       K-mer step size [default = 4]
  --sketch-size SKETCH_SIZE
                        Kmer sketch size [default = 10000]
  --codon-phased        Used codon phased seeds X--X--X [default = False]
  --min-kmer-count MIN_KMER_COUNT
                        Minimum k-mer count when using reads as input [default
                        = 0]
  --exact-count         Use the exact k-mer counter with reads [default = use
                        countmin counter]
  --strand-preserved    Treat input as being on the same strand, and ignore
                        reverse complement k-mers [default = use canonical
                        k-mers]

Quality control options:
  --qc-keep             Only write failing sequences to a file, don't remove
                        them from the database file
  --remove-samples REMOVE_SAMPLES
                        A list of names to remove from the database
                        (regardless of any other QC)
  --retain-failures     Retain sketches of genomes that do not pass QC filters
                        in separate database [default = False]
  --max-a-dist MAX_A_DIST
                        Maximum accessory distance to permit [default = 0.5]
  --max-pi-dist MAX_PI_DIST
                        Maximum core distance to permit [default = 0.1]
  --max-zero-dist MAX_ZERO_DIST
                        Maximum proportion of zero distances to permit
                        [default = 0.05]
  --length-sigma LENGTH_SIGMA
                        Number of standard deviations of length distribution
                        beyond which sequences will be excluded [default = 5]
  --length-range LENGTH_RANGE LENGTH_RANGE
                        Allowed length range, outside of which sequences will
                        be excluded [two values needed - lower and upper
                        bounds]
  --prop-n PROP_N       Threshold ambiguous base proportion above which
                        sequences will be excluded [default = 0.1]
  --upper-n UPPER_N     Threshold ambiguous base count above which sequences
                        will be excluded

Model fit options:
  --model-subsample MODEL_SUBSAMPLE
                        Number of pairwise distances used to fit model
                        [default = 100000]
  --assign-subsample ASSIGN_SUBSAMPLE
                        Number of pairwise distances in each assignment batch
                        [default = 5000]
  --for-refine          Fit a BGMM or DBSCAN model without assigning all
                        points to initialise a refined model
  --K K                 Maximum number of mixture components [default = 2]
  --D D                 Maximum number of clusters in DBSCAN fitting [default
                        = 100]
  --min-cluster-prop MIN_CLUSTER_PROP
                        Minimum proportion of points in a cluster in DBSCAN
                        fitting [default = 0.0001]
  --threshold THRESHOLD
                        Cutoff if using --fit-model threshold

Network analysis and model refinement options:
  --pos-shift POS_SHIFT
                        Maximum amount to move the boundary right past
                        between-strain mean
  --neg-shift NEG_SHIFT
                        Maximum amount to move the boundary left past within-
                        strain mean]
  --manual-start MANUAL_START
                        A file containing information for a start point. See
                        documentation for help.
  --model-dir MODEL_DIR
                        Directory containing model to use for assigning
                        queries to clusters [default = reference database
                        directory]
  --score-idx {0,1,2}   Index of score to use [default = 0]
  --summary-sample SUMMARY_SAMPLE
                        Number of sequences used to estimate graph properties
                        [default = all]
  --betweenness-sample BETWEENNESS_SAMPLE
                        Number of sequences used to estimate betweeness with a
                        GPU [default = 100]
  --unconstrained       Optimise both boundary gradient and intercept
  --multi-boundary MULTI_BOUNDARY
                        Produce multiple sets of clusters at different
                        boundary positions. This argument sets thenumber of
                        boundary positions between n-1 clusters and the refine
                        optimum.
  --indiv-refine {both,core,accessory}
                        Also run refinement for core and accessory
                        individually

Lineage analysis options:
  --ranks RANKS         Comma separated list of ranks used in lineage
                        clustering [default = 1,2,3]
  --count-unique-distances
                        kNN enumerates number of unique distances rather than
                        number of neighbours
  --reciprocal-only     Only use reciprocal kNN matches for lineage
                        definitions
  --max-search-depth MAX_SEARCH_DEPTH
                        Number of kNN distances per sequence to filter when
                        counting neighbours or using only reciprocal matches
  --write-lineage-networks
                        Save all lineage networks
  --use-accessory       Use accessory distances for lineage definitions
                        [default = use core distances]
  --lineage-resolution LINEAGE_RESOLUTION
                        Minimum genetic separation between isolates required
                        to initiate a new lineage

Other options:
  --threads THREADS     Number of threads to use [default = 1]
  --gpu-sketch          Use a GPU when calculating sketches (read data only)
                        [default = False]
  --gpu-dist            Use a GPU when calculating distances [default = False]
  --gpu-model           Use a GPU when fitting a model [default = False]
  --gpu-graph           Use a GPU when calculating networks [default = False]
  --deviceid DEVICEID   CUDA device ID, if using GPU [default = 0]
  --no-plot             Switch off model plotting, which can be slow for large
                        datasets
  --no-local            Do not perform the local optimization step in model
                        refinement (speed up on very large datasets)
  --version             show program's version number and exit
  --citation            Give a citation, and possible methods paragraph based
                        on the command line
```


## poppunk_qc-db

### Tool Description
PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

### Metadata
- **Docker Image**: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
- **Homepage**: https://github.com/johnlees/PopPUNK
- **Package**: https://anaconda.org/channels/bioconda/packages/poppunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: poppunk [-h]
               (--create-db | --qc-db | --fit-model {bgmm,dbscan,refine,lineage,threshold} | --use-model)
               [--ref-db REF_DB] [--r-files R_FILES] [--distances DISTANCES]
               [--external-clustering EXTERNAL_CLUSTERING] [--output OUTPUT]
               [--plot-fit PLOT_FIT] [--overwrite] [--graph-weights]
               [--min-k MIN_K] [--max-k MAX_K] [--k-step K_STEP]
               [--sketch-size SKETCH_SIZE] [--codon-phased]
               [--min-kmer-count MIN_KMER_COUNT] [--exact-count]
               [--strand-preserved] [--qc-keep]
               [--remove-samples REMOVE_SAMPLES] [--retain-failures]
               [--max-a-dist MAX_A_DIST] [--max-pi-dist MAX_PI_DIST]
               [--max-zero-dist MAX_ZERO_DIST] [--length-sigma LENGTH_SIGMA]
               [--length-range LENGTH_RANGE LENGTH_RANGE] [--prop-n PROP_N]
               [--upper-n UPPER_N] [--model-subsample MODEL_SUBSAMPLE]
               [--assign-subsample ASSIGN_SUBSAMPLE] [--for-refine] [--K K]
               [--D D] [--min-cluster-prop MIN_CLUSTER_PROP]
               [--threshold THRESHOLD] [--pos-shift POS_SHIFT]
               [--neg-shift NEG_SHIFT] [--manual-start MANUAL_START]
               [--model-dir MODEL_DIR] [--score-idx {0,1,2}]
               [--summary-sample SUMMARY_SAMPLE]
               [--betweenness-sample BETWEENNESS_SAMPLE]
               [--unconstrained | --multi-boundary MULTI_BOUNDARY | --indiv-refine {both,core,accessory}]
               [--ranks RANKS] [--count-unique-distances] [--reciprocal-only]
               [--max-search-depth MAX_SEARCH_DEPTH]
               [--write-lineage-networks] [--use-accessory]
               [--lineage-resolution LINEAGE_RESOLUTION] [--threads THREADS]
               [--gpu-sketch] [--gpu-dist] [--gpu-model] [--gpu-graph]
               [--deviceid DEVICEID] [--no-plot] [--no-local] [--version]
               [--citation]

PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

options:
  -h, --help            show this help message and exit

Mode of operation:
  --create-db           Create pairwise distances database between reference
                        sequences
  --qc-db               Run quality control on a reference database
  --fit-model {bgmm,dbscan,refine,lineage,threshold}
                        Fit a model to a (QCed) reference database
  --use-model           Apply a fitted model to a reference database to
                        restore database files

Input files:
  --ref-db REF_DB       Location of built reference database
  --r-files R_FILES     File listing reference input assemblies
  --distances DISTANCES
                        Prefix of input pickle of pre-calculated distances
  --external-clustering EXTERNAL_CLUSTERING
                        File with cluster definitions or other labels
                        generated with any other method.

Output options:
  --output OUTPUT       Prefix for output files
  --plot-fit PLOT_FIT   Create this many plots of some fits relating k-mer to
                        core/accessory distances [default = 0]
  --overwrite           Overwrite any existing database files
  --graph-weights       Save within-strain Euclidean distances into the graph

Create DB options:
  --min-k MIN_K         Minimum kmer length [default = 13]
  --max-k MAX_K         Maximum kmer length [default = 29]
  --k-step K_STEP       K-mer step size [default = 4]
  --sketch-size SKETCH_SIZE
                        Kmer sketch size [default = 10000]
  --codon-phased        Used codon phased seeds X--X--X [default = False]
  --min-kmer-count MIN_KMER_COUNT
                        Minimum k-mer count when using reads as input [default
                        = 0]
  --exact-count         Use the exact k-mer counter with reads [default = use
                        countmin counter]
  --strand-preserved    Treat input as being on the same strand, and ignore
                        reverse complement k-mers [default = use canonical
                        k-mers]

Quality control options:
  --qc-keep             Only write failing sequences to a file, don't remove
                        them from the database file
  --remove-samples REMOVE_SAMPLES
                        A list of names to remove from the database
                        (regardless of any other QC)
  --retain-failures     Retain sketches of genomes that do not pass QC filters
                        in separate database [default = False]
  --max-a-dist MAX_A_DIST
                        Maximum accessory distance to permit [default = 0.5]
  --max-pi-dist MAX_PI_DIST
                        Maximum core distance to permit [default = 0.1]
  --max-zero-dist MAX_ZERO_DIST
                        Maximum proportion of zero distances to permit
                        [default = 0.05]
  --length-sigma LENGTH_SIGMA
                        Number of standard deviations of length distribution
                        beyond which sequences will be excluded [default = 5]
  --length-range LENGTH_RANGE LENGTH_RANGE
                        Allowed length range, outside of which sequences will
                        be excluded [two values needed - lower and upper
                        bounds]
  --prop-n PROP_N       Threshold ambiguous base proportion above which
                        sequences will be excluded [default = 0.1]
  --upper-n UPPER_N     Threshold ambiguous base count above which sequences
                        will be excluded

Model fit options:
  --model-subsample MODEL_SUBSAMPLE
                        Number of pairwise distances used to fit model
                        [default = 100000]
  --assign-subsample ASSIGN_SUBSAMPLE
                        Number of pairwise distances in each assignment batch
                        [default = 5000]
  --for-refine          Fit a BGMM or DBSCAN model without assigning all
                        points to initialise a refined model
  --K K                 Maximum number of mixture components [default = 2]
  --D D                 Maximum number of clusters in DBSCAN fitting [default
                        = 100]
  --min-cluster-prop MIN_CLUSTER_PROP
                        Minimum proportion of points in a cluster in DBSCAN
                        fitting [default = 0.0001]
  --threshold THRESHOLD
                        Cutoff if using --fit-model threshold

Network analysis and model refinement options:
  --pos-shift POS_SHIFT
                        Maximum amount to move the boundary right past
                        between-strain mean
  --neg-shift NEG_SHIFT
                        Maximum amount to move the boundary left past within-
                        strain mean]
  --manual-start MANUAL_START
                        A file containing information for a start point. See
                        documentation for help.
  --model-dir MODEL_DIR
                        Directory containing model to use for assigning
                        queries to clusters [default = reference database
                        directory]
  --score-idx {0,1,2}   Index of score to use [default = 0]
  --summary-sample SUMMARY_SAMPLE
                        Number of sequences used to estimate graph properties
                        [default = all]
  --betweenness-sample BETWEENNESS_SAMPLE
                        Number of sequences used to estimate betweeness with a
                        GPU [default = 100]
  --unconstrained       Optimise both boundary gradient and intercept
  --multi-boundary MULTI_BOUNDARY
                        Produce multiple sets of clusters at different
                        boundary positions. This argument sets thenumber of
                        boundary positions between n-1 clusters and the refine
                        optimum.
  --indiv-refine {both,core,accessory}
                        Also run refinement for core and accessory
                        individually

Lineage analysis options:
  --ranks RANKS         Comma separated list of ranks used in lineage
                        clustering [default = 1,2,3]
  --count-unique-distances
                        kNN enumerates number of unique distances rather than
                        number of neighbours
  --reciprocal-only     Only use reciprocal kNN matches for lineage
                        definitions
  --max-search-depth MAX_SEARCH_DEPTH
                        Number of kNN distances per sequence to filter when
                        counting neighbours or using only reciprocal matches
  --write-lineage-networks
                        Save all lineage networks
  --use-accessory       Use accessory distances for lineage definitions
                        [default = use core distances]
  --lineage-resolution LINEAGE_RESOLUTION
                        Minimum genetic separation between isolates required
                        to initiate a new lineage

Other options:
  --threads THREADS     Number of threads to use [default = 1]
  --gpu-sketch          Use a GPU when calculating sketches (read data only)
                        [default = False]
  --gpu-dist            Use a GPU when calculating distances [default = False]
  --gpu-model           Use a GPU when fitting a model [default = False]
  --gpu-graph           Use a GPU when calculating networks [default = False]
  --deviceid DEVICEID   CUDA device ID, if using GPU [default = 0]
  --no-plot             Switch off model plotting, which can be slow for large
                        datasets
  --no-local            Do not perform the local optimization step in model
                        refinement (speed up on very large datasets)
  --version             show program's version number and exit
  --citation            Give a citation, and possible methods paragraph based
                        on the command line
```


## poppunk_fit-model

### Tool Description
PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

### Metadata
- **Docker Image**: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
- **Homepage**: https://github.com/johnlees/PopPUNK
- **Package**: https://anaconda.org/channels/bioconda/packages/poppunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: poppunk [-h]
               (--create-db | --qc-db | --fit-model {bgmm,dbscan,refine,lineage,threshold} | --use-model)
               [--ref-db REF_DB] [--r-files R_FILES] [--distances DISTANCES]
               [--external-clustering EXTERNAL_CLUSTERING] [--output OUTPUT]
               [--plot-fit PLOT_FIT] [--overwrite] [--graph-weights]
               [--min-k MIN_K] [--max-k MAX_K] [--k-step K_STEP]
               [--sketch-size SKETCH_SIZE] [--codon-phased]
               [--min-kmer-count MIN_KMER_COUNT] [--exact-count]
               [--strand-preserved] [--qc-keep]
               [--remove-samples REMOVE_SAMPLES] [--retain-failures]
               [--max-a-dist MAX_A_DIST] [--max-pi-dist MAX_PI_DIST]
               [--max-zero-dist MAX_ZERO_DIST] [--length-sigma LENGTH_SIGMA]
               [--length-range LENGTH_RANGE LENGTH_RANGE] [--prop-n PROP_N]
               [--upper-n UPPER_N] [--model-subsample MODEL_SUBSAMPLE]
               [--assign-subsample ASSIGN_SUBSAMPLE] [--for-refine] [--K K]
               [--D D] [--min-cluster-prop MIN_CLUSTER_PROP]
               [--threshold THRESHOLD] [--pos-shift POS_SHIFT]
               [--neg-shift NEG_SHIFT] [--manual-start MANUAL_START]
               [--model-dir MODEL_DIR] [--score-idx {0,1,2}]
               [--summary-sample SUMMARY_SAMPLE]
               [--betweenness-sample BETWEENNESS_SAMPLE]
               [--unconstrained | --multi-boundary MULTI_BOUNDARY | --indiv-refine {both,core,accessory}]
               [--ranks RANKS] [--count-unique-distances] [--reciprocal-only]
               [--max-search-depth MAX_SEARCH_DEPTH]
               [--write-lineage-networks] [--use-accessory]
               [--lineage-resolution LINEAGE_RESOLUTION] [--threads THREADS]
               [--gpu-sketch] [--gpu-dist] [--gpu-model] [--gpu-graph]
               [--deviceid DEVICEID] [--no-plot] [--no-local] [--version]
               [--citation]

PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

options:
  -h, --help            show this help message and exit

Mode of operation:
  --create-db           Create pairwise distances database between reference
                        sequences
  --qc-db               Run quality control on a reference database
  --fit-model {bgmm,dbscan,refine,lineage,threshold}
                        Fit a model to a (QCed) reference database
  --use-model           Apply a fitted model to a reference database to
                        restore database files

Input files:
  --ref-db REF_DB       Location of built reference database
  --r-files R_FILES     File listing reference input assemblies
  --distances DISTANCES
                        Prefix of input pickle of pre-calculated distances
  --external-clustering EXTERNAL_CLUSTERING
                        File with cluster definitions or other labels
                        generated with any other method.

Output options:
  --output OUTPUT       Prefix for output files
  --plot-fit PLOT_FIT   Create this many plots of some fits relating k-mer to
                        core/accessory distances [default = 0]
  --overwrite           Overwrite any existing database files
  --graph-weights       Save within-strain Euclidean distances into the graph

Create DB options:
  --min-k MIN_K         Minimum kmer length [default = 13]
  --max-k MAX_K         Maximum kmer length [default = 29]
  --k-step K_STEP       K-mer step size [default = 4]
  --sketch-size SKETCH_SIZE
                        Kmer sketch size [default = 10000]
  --codon-phased        Used codon phased seeds X--X--X [default = False]
  --min-kmer-count MIN_KMER_COUNT
                        Minimum k-mer count when using reads as input [default
                        = 0]
  --exact-count         Use the exact k-mer counter with reads [default = use
                        countmin counter]
  --strand-preserved    Treat input as being on the same strand, and ignore
                        reverse complement k-mers [default = use canonical
                        k-mers]

Quality control options:
  --qc-keep             Only write failing sequences to a file, don't remove
                        them from the database file
  --remove-samples REMOVE_SAMPLES
                        A list of names to remove from the database
                        (regardless of any other QC)
  --retain-failures     Retain sketches of genomes that do not pass QC filters
                        in separate database [default = False]
  --max-a-dist MAX_A_DIST
                        Maximum accessory distance to permit [default = 0.5]
  --max-pi-dist MAX_PI_DIST
                        Maximum core distance to permit [default = 0.1]
  --max-zero-dist MAX_ZERO_DIST
                        Maximum proportion of zero distances to permit
                        [default = 0.05]
  --length-sigma LENGTH_SIGMA
                        Number of standard deviations of length distribution
                        beyond which sequences will be excluded [default = 5]
  --length-range LENGTH_RANGE LENGTH_RANGE
                        Allowed length range, outside of which sequences will
                        be excluded [two values needed - lower and upper
                        bounds]
  --prop-n PROP_N       Threshold ambiguous base proportion above which
                        sequences will be excluded [default = 0.1]
  --upper-n UPPER_N     Threshold ambiguous base count above which sequences
                        will be excluded

Model fit options:
  --model-subsample MODEL_SUBSAMPLE
                        Number of pairwise distances used to fit model
                        [default = 100000]
  --assign-subsample ASSIGN_SUBSAMPLE
                        Number of pairwise distances in each assignment batch
                        [default = 5000]
  --for-refine          Fit a BGMM or DBSCAN model without assigning all
                        points to initialise a refined model
  --K K                 Maximum number of mixture components [default = 2]
  --D D                 Maximum number of clusters in DBSCAN fitting [default
                        = 100]
  --min-cluster-prop MIN_CLUSTER_PROP
                        Minimum proportion of points in a cluster in DBSCAN
                        fitting [default = 0.0001]
  --threshold THRESHOLD
                        Cutoff if using --fit-model threshold

Network analysis and model refinement options:
  --pos-shift POS_SHIFT
                        Maximum amount to move the boundary right past
                        between-strain mean
  --neg-shift NEG_SHIFT
                        Maximum amount to move the boundary left past within-
                        strain mean]
  --manual-start MANUAL_START
                        A file containing information for a start point. See
                        documentation for help.
  --model-dir MODEL_DIR
                        Directory containing model to use for assigning
                        queries to clusters [default = reference database
                        directory]
  --score-idx {0,1,2}   Index of score to use [default = 0]
  --summary-sample SUMMARY_SAMPLE
                        Number of sequences used to estimate graph properties
                        [default = all]
  --betweenness-sample BETWEENNESS_SAMPLE
                        Number of sequences used to estimate betweeness with a
                        GPU [default = 100]
  --unconstrained       Optimise both boundary gradient and intercept
  --multi-boundary MULTI_BOUNDARY
                        Produce multiple sets of clusters at different
                        boundary positions. This argument sets thenumber of
                        boundary positions between n-1 clusters and the refine
                        optimum.
  --indiv-refine {both,core,accessory}
                        Also run refinement for core and accessory
                        individually

Lineage analysis options:
  --ranks RANKS         Comma separated list of ranks used in lineage
                        clustering [default = 1,2,3]
  --count-unique-distances
                        kNN enumerates number of unique distances rather than
                        number of neighbours
  --reciprocal-only     Only use reciprocal kNN matches for lineage
                        definitions
  --max-search-depth MAX_SEARCH_DEPTH
                        Number of kNN distances per sequence to filter when
                        counting neighbours or using only reciprocal matches
  --write-lineage-networks
                        Save all lineage networks
  --use-accessory       Use accessory distances for lineage definitions
                        [default = use core distances]
  --lineage-resolution LINEAGE_RESOLUTION
                        Minimum genetic separation between isolates required
                        to initiate a new lineage

Other options:
  --threads THREADS     Number of threads to use [default = 1]
  --gpu-sketch          Use a GPU when calculating sketches (read data only)
                        [default = False]
  --gpu-dist            Use a GPU when calculating distances [default = False]
  --gpu-model           Use a GPU when fitting a model [default = False]
  --gpu-graph           Use a GPU when calculating networks [default = False]
  --deviceid DEVICEID   CUDA device ID, if using GPU [default = 0]
  --no-plot             Switch off model plotting, which can be slow for large
                        datasets
  --no-local            Do not perform the local optimization step in model
                        refinement (speed up on very large datasets)
  --version             show program's version number and exit
  --citation            Give a citation, and possible methods paragraph based
                        on the command line
```


## poppunk_use-model

### Tool Description
PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

### Metadata
- **Docker Image**: quay.io/biocontainers/poppunk:2.7.8--py310h4d0eb5b_0
- **Homepage**: https://github.com/johnlees/PopPUNK
- **Package**: https://anaconda.org/channels/bioconda/packages/poppunk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: poppunk [-h]
               (--create-db | --qc-db | --fit-model {bgmm,dbscan,refine,lineage,threshold} | --use-model)
               [--ref-db REF_DB] [--r-files R_FILES] [--distances DISTANCES]
               [--external-clustering EXTERNAL_CLUSTERING] [--output OUTPUT]
               [--plot-fit PLOT_FIT] [--overwrite] [--graph-weights]
               [--min-k MIN_K] [--max-k MAX_K] [--k-step K_STEP]
               [--sketch-size SKETCH_SIZE] [--codon-phased]
               [--min-kmer-count MIN_KMER_COUNT] [--exact-count]
               [--strand-preserved] [--qc-keep]
               [--remove-samples REMOVE_SAMPLES] [--retain-failures]
               [--max-a-dist MAX_A_DIST] [--max-pi-dist MAX_PI_DIST]
               [--max-zero-dist MAX_ZERO_DIST] [--length-sigma LENGTH_SIGMA]
               [--length-range LENGTH_RANGE LENGTH_RANGE] [--prop-n PROP_N]
               [--upper-n UPPER_N] [--model-subsample MODEL_SUBSAMPLE]
               [--assign-subsample ASSIGN_SUBSAMPLE] [--for-refine] [--K K]
               [--D D] [--min-cluster-prop MIN_CLUSTER_PROP]
               [--threshold THRESHOLD] [--pos-shift POS_SHIFT]
               [--neg-shift NEG_SHIFT] [--manual-start MANUAL_START]
               [--model-dir MODEL_DIR] [--score-idx {0,1,2}]
               [--summary-sample SUMMARY_SAMPLE]
               [--betweenness-sample BETWEENNESS_SAMPLE]
               [--unconstrained | --multi-boundary MULTI_BOUNDARY | --indiv-refine {both,core,accessory}]
               [--ranks RANKS] [--count-unique-distances] [--reciprocal-only]
               [--max-search-depth MAX_SEARCH_DEPTH]
               [--write-lineage-networks] [--use-accessory]
               [--lineage-resolution LINEAGE_RESOLUTION] [--threads THREADS]
               [--gpu-sketch] [--gpu-dist] [--gpu-model] [--gpu-graph]
               [--deviceid DEVICEID] [--no-plot] [--no-local] [--version]
               [--citation]

PopPUNK (POPulation Partitioning Using Nucleotide Kmers)

options:
  -h, --help            show this help message and exit

Mode of operation:
  --create-db           Create pairwise distances database between reference
                        sequences
  --qc-db               Run quality control on a reference database
  --fit-model {bgmm,dbscan,refine,lineage,threshold}
                        Fit a model to a (QCed) reference database
  --use-model           Apply a fitted model to a reference database to
                        restore database files

Input files:
  --ref-db REF_DB       Location of built reference database
  --r-files R_FILES     File listing reference input assemblies
  --distances DISTANCES
                        Prefix of input pickle of pre-calculated distances
  --external-clustering EXTERNAL_CLUSTERING
                        File with cluster definitions or other labels
                        generated with any other method.

Output options:
  --output OUTPUT       Prefix for output files
  --plot-fit PLOT_FIT   Create this many plots of some fits relating k-mer to
                        core/accessory distances [default = 0]
  --overwrite           Overwrite any existing database files
  --graph-weights       Save within-strain Euclidean distances into the graph

Create DB options:
  --min-k MIN_K         Minimum kmer length [default = 13]
  --max-k MAX_K         Maximum kmer length [default = 29]
  --k-step K_STEP       K-mer step size [default = 4]
  --sketch-size SKETCH_SIZE
                        Kmer sketch size [default = 10000]
  --codon-phased        Used codon phased seeds X--X--X [default = False]
  --min-kmer-count MIN_KMER_COUNT
                        Minimum k-mer count when using reads as input [default
                        = 0]
  --exact-count         Use the exact k-mer counter with reads [default = use
                        countmin counter]
  --strand-preserved    Treat input as being on the same strand, and ignore
                        reverse complement k-mers [default = use canonical
                        k-mers]

Quality control options:
  --qc-keep             Only write failing sequences to a file, don't remove
                        them from the database file
  --remove-samples REMOVE_SAMPLES
                        A list of names to remove from the database
                        (regardless of any other QC)
  --retain-failures     Retain sketches of genomes that do not pass QC filters
                        in separate database [default = False]
  --max-a-dist MAX_A_DIST
                        Maximum accessory distance to permit [default = 0.5]
  --max-pi-dist MAX_PI_DIST
                        Maximum core distance to permit [default = 0.1]
  --max-zero-dist MAX_ZERO_DIST
                        Maximum proportion of zero distances to permit
                        [default = 0.05]
  --length-sigma LENGTH_SIGMA
                        Number of standard deviations of length distribution
                        beyond which sequences will be excluded [default = 5]
  --length-range LENGTH_RANGE LENGTH_RANGE
                        Allowed length range, outside of which sequences will
                        be excluded [two values needed - lower and upper
                        bounds]
  --prop-n PROP_N       Threshold ambiguous base proportion above which
                        sequences will be excluded [default = 0.1]
  --upper-n UPPER_N     Threshold ambiguous base count above which sequences
                        will be excluded

Model fit options:
  --model-subsample MODEL_SUBSAMPLE
                        Number of pairwise distances used to fit model
                        [default = 100000]
  --assign-subsample ASSIGN_SUBSAMPLE
                        Number of pairwise distances in each assignment batch
                        [default = 5000]
  --for-refine          Fit a BGMM or DBSCAN model without assigning all
                        points to initialise a refined model
  --K K                 Maximum number of mixture components [default = 2]
  --D D                 Maximum number of clusters in DBSCAN fitting [default
                        = 100]
  --min-cluster-prop MIN_CLUSTER_PROP
                        Minimum proportion of points in a cluster in DBSCAN
                        fitting [default = 0.0001]
  --threshold THRESHOLD
                        Cutoff if using --fit-model threshold

Network analysis and model refinement options:
  --pos-shift POS_SHIFT
                        Maximum amount to move the boundary right past
                        between-strain mean
  --neg-shift NEG_SHIFT
                        Maximum amount to move the boundary left past within-
                        strain mean]
  --manual-start MANUAL_START
                        A file containing information for a start point. See
                        documentation for help.
  --model-dir MODEL_DIR
                        Directory containing model to use for assigning
                        queries to clusters [default = reference database
                        directory]
  --score-idx {0,1,2}   Index of score to use [default = 0]
  --summary-sample SUMMARY_SAMPLE
                        Number of sequences used to estimate graph properties
                        [default = all]
  --betweenness-sample BETWEENNESS_SAMPLE
                        Number of sequences used to estimate betweeness with a
                        GPU [default = 100]
  --unconstrained       Optimise both boundary gradient and intercept
  --multi-boundary MULTI_BOUNDARY
                        Produce multiple sets of clusters at different
                        boundary positions. This argument sets thenumber of
                        boundary positions between n-1 clusters and the refine
                        optimum.
  --indiv-refine {both,core,accessory}
                        Also run refinement for core and accessory
                        individually

Lineage analysis options:
  --ranks RANKS         Comma separated list of ranks used in lineage
                        clustering [default = 1,2,3]
  --count-unique-distances
                        kNN enumerates number of unique distances rather than
                        number of neighbours
  --reciprocal-only     Only use reciprocal kNN matches for lineage
                        definitions
  --max-search-depth MAX_SEARCH_DEPTH
                        Number of kNN distances per sequence to filter when
                        counting neighbours or using only reciprocal matches
  --write-lineage-networks
                        Save all lineage networks
  --use-accessory       Use accessory distances for lineage definitions
                        [default = use core distances]
  --lineage-resolution LINEAGE_RESOLUTION
                        Minimum genetic separation between isolates required
                        to initiate a new lineage

Other options:
  --threads THREADS     Number of threads to use [default = 1]
  --gpu-sketch          Use a GPU when calculating sketches (read data only)
                        [default = False]
  --gpu-dist            Use a GPU when calculating distances [default = False]
  --gpu-model           Use a GPU when fitting a model [default = False]
  --gpu-graph           Use a GPU when calculating networks [default = False]
  --deviceid DEVICEID   CUDA device ID, if using GPU [default = 0]
  --no-plot             Switch off model plotting, which can be slow for large
                        datasets
  --no-local            Do not perform the local optimization step in model
                        refinement (speed up on very large datasets)
  --version             show program's version number and exit
  --citation            Give a citation, and possible methods paragraph based
                        on the command line
```


## Metadata
- **Skill**: generated
