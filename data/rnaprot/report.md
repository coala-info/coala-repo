# rnaprot CWL Generation Report

## rnaprot_train

### Tool Description
Model training

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
- **Homepage**: https://github.com/BackofenLab/RNAProt
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaprot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnaprot/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BackofenLab/RNAProt
- **Stars**: N/A
### Original Help Text
```text
usage: rnaprot train [-h] --in IN_FOLDER --out OUT_FOLDER [--only-seq]
                     [--use-phastcons] [--use-phylop] [--use-eia] [--use-tra]
                     [--use-rra] [--use-str] [--str-mode {1,2,3,4}]
                     [--use-add-feat] [--cv] [--cv-k {5,10}]
                     [--val-size float] [--add-test] [--test-ids str]
                     [--keep-order] [--seed int] [--plot-lc] [--verbose-train]
                     [--force-cpu] [--epochs int] [--patience int]
                     [--batch-size int] [--lr float] [--weight-decay float]
                     [--n-rnn-layers int] [--n-hidden-dim int] [--dr float]
                     [--n-fc-layers {1,2}] [--model-type {1,2,3,4}] [--embed]
                     [--embed-dim int] [--run-bohb] [--bohb-n int]
                     [--bohb-min-budget int] [--bohb-max-budget int]
                     [--bohb-workers int] [--verbose-bohb]

optional arguments:
  -h, --help            show this help message and exit

required arguments:
  --in IN_FOLDER        Input training data folder (output of rnaprot gt)
  --out OUT_FOLDER      Model training results output folder

feature definition arguments:
  --only-seq            Use only sequence feature. By default all features
                        present in --in are used (default: False)
  --use-phastcons       Add phastCons conservation scores. Set --use-xxx to
                        define which features to add on top of sequence
                        feature (by default all --in features are used)
  --use-phylop          Add phyloP conservation scores. Set --use-xxx to
                        define which features to add on top of sequence
                        feature (by default all --in features are used)
  --use-eia             Add exon-intron annotations. Set --use-xxx to define
                        which features to add on top of sequence feature (by
                        default all --in features are used)
  --use-tra             Add transcript region annotations. Set --use-xxx to
                        define which features to add on top of sequence
                        feature (by default all --in features are used)
  --use-rra             Add repeat region annotations. Set --use-xxx to define
                        which features to add on top of sequence feature (by
                        default all --in features are used)
  --use-str             Add secondary structure features (type defined by
                        --str-mode). Set --use-xxx to define which features to
                        add on top of sequence feature (by default all --in
                        features are used)
  --str-mode {1,2,3,4}  Define secondary structure feature representation: 1)
                        use probabilities of five structural elements
                        (E,I,H,M,S) 2) same as 1) but encoded as one-hot
                        (element with highest probability gets 1, others 0) 3)
                        use unpaired probabilities 4) same as 3) but encoded
                        as one-hot (default: 1)
  --use-add-feat        Add additional feature annotations. Set --use-xxx to
                        define which features to add on top of sequence
                        feature (by default all --in features are used)

model definition arguments:
  --cv                  Run cross validation in combination with set
                        hyperparameters to evaluate model generalization
                        performance (default: False)
  --cv-k {5,10}         Cross validation k for evaluating generalization
                        performance (use together with --cv) (default: 10)
  --val-size float      Validation set size for training final model as
                        percentage of all training sites. NOTE that if --add-
                        test is set, the test set will have the same size (so
                        if --val-size 0.2, train on 60 percent, validate on 20
                        percent, and test on 20 percent) (default: 0.2)
  --add-test            Use a part of the training set as a test set to
                        evaluate final model. Test set size is controlled by
                        --val-size (default: False)
  --test-ids str        Provide file with test IDs to be used as a test set
                        for testing final model. Test IDs need to be part of
                        --in training set. Not compatible with --add-test or
                        --cv
  --keep-order          Use same train-validation(-test) split for each call
                        to train final model. Test split only if --add-test or
                        --test-ids (default: False)
  --seed int            Set a fixed random seed number (e.g. --seed 1) to
                        obtain identical model results for identical rnaprot
                        train runs
  --plot-lc             Plot learning curves (training vs validation loss) for
                        each tested hyperparameter combination (default:
                        False)
  --verbose-train       Enable verbose output during model training to show
                        performance over epochs (default: False)
  --force-cpu           Run on CPU regardless of CUDA available or not
                        (default: False)
  --epochs int          Maximum number of training epochs (default: 200)
  --patience int        Number of epochs to wait for further improvement on
                        validation set before stopping (default: 30)
  --batch-size int      Gradient descent batch size (default: 50)
  --lr float            Learning rate of optimizer (default: 0.001)
  --weight-decay float  Weight decay of optimizer (default: 0.0005)
  --n-rnn-layers int    Number of RNN layers (default: 1)
  --n-hidden-dim int    Number of RNN layer dimensions (default: 32)
  --dr float            Rate of dropout applied after RNN layers (default:
                        0.5)
  --n-fc-layers {1,2}   Number of fully connected layers following RNN layers
                        (default: 1)
  --model-type {1,2,3,4}
                        RNN model type to use. 1: GRU, 2: LSTM, 3: biGRU, 4:
                        biLSTM (default: 1)
  --embed               Use embedding layer for sequence feature, instead of
                        one-hot encoding (default: False)
  --embed-dim int       Dimension of embedding layer (default: 10)
  --run-bohb            Use BOHB to run a hyperparameter optimization. NOTE
                        that this will overwrite set hyperparameters, and
                        trains the final model with the found best
                        hyperparameter setting. ALSO NOTE that this will take
                        some time (!) (default: False)
  --bohb-n int          Number of BOHB iterations (default: 80)
  --bohb-min-budget int
                        BOHB minimum budget (default: 5)
  --bohb-max-budget int
                        BOHB maximum budget (default: 40)
  --bohb-workers int    Number of BOHB worker threads for local multi-core
                        parallel computing (default: 1)
  --verbose-bohb        Enable verbose output for BOHB hyperparameter
                        optimization. By default only warnings are print out
                        (default: False)
```


## rnaprot_eval

### Tool Description
Evaluation of trained models

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
- **Homepage**: https://github.com/BackofenLab/RNAProt
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaprot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnaprot eval [-h] --train-in IN_TRAIN_FOLDER --gt-in IN_GT_FOLDER --out
                    OUT_FOLDER [--nr-top-profiles int]
                    [--lookup-profile LIST_LOOKUP_IDS [LIST_LOOKUP_IDS ...]]
                    [--bottom-up]
                    [--nr-top-sites LIST_NR_TOP_SITES [LIST_NR_TOP_SITES ...]]
                    [--motif-size LIST_MOTIF_SIZES [LIST_MOTIF_SIZES ...]]
                    [--report] [--add-train-in str] [--theme {1,2}]
                    [--plot-format {1,2}]

optional arguments:
  -h, --help            show this help message and exit
  --nr-top-profiles int
                        Specify number of top predicted sites to plot profiles
                        for (default: 25)
  --lookup-profile LIST_LOOKUP_IDS [LIST_LOOKUP_IDS ...]
                        Provide site ID(s) for which to plot the feature
                        profile in addition to --nr-top-profiles (e.g.
                        --lookup-profile site_id1 site_id2 ). Site ID needs to
                        be in positive set from --gt-in
  --bottom-up           Plot bottom profiles as well (default: False)
  --nr-top-sites LIST_NR_TOP_SITES [LIST_NR_TOP_SITES ...]
                        Specify number(s) of top-predicted sites used for
                        motif extraction. Provide multiple numbers (e.g. --nr-
                        top-sites 100 200 500) to extract one motif plot from
                        each site set (default: 200)
  --motif-size LIST_MOTIF_SIZES [LIST_MOTIF_SIZES ...]
                        Motif size(s) (widths) for extracting and plotting
                        motifs. Provide multiple sizes (e.g. --motif-size 5 7
                        9) to extract a motif for each size (default: 7)
  --report              Generate an .html report containing various additional
                        statistics and plots (default: False)
  --add-train-in str    Second model training folder (output of rnaprot train)
                        for comparing prediction scores of both models on
                        --gt-in positive dataset. Note that if dataset
                        features of the two models are not identical,
                        comparison might be less informative
  --theme {1,2}         Set theme for .html report (1: palm beach, 2: midnight
                        sunset) (default: 1)
  --plot-format {1,2}   Plotting format of motifs and profiles (does not
                        affect plots generated for --report). 1: png, 2: pdf
                        (default: 1)

required arguments:
  --train-in IN_TRAIN_FOLDER
                        Input model training folder (output of rnaprot train)
  --gt-in IN_GT_FOLDER  Input training data folder (output of rnaprot gt)
  --out OUT_FOLDER      Evaluation results output folder
```


## rnaprot_predict

### Tool Description
Predict binding sites on longer sequences using moving window predictions

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
- **Homepage**: https://github.com/BackofenLab/RNAProt
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaprot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnaprot predict [-h] --in IN_FOLDER --train-in IN_TRAIN_FOLDER --out
                       str [--mode {1,2}] [--plot-top-profiles]
                       [--plot-format {1,2}] [--thr {1,2,3}]
                       [--site-id LIST_SITE_IDS [LIST_SITE_IDS ...]]

optional arguments:
  -h, --help            show this help message and exit
  --mode {1,2}          Define prediction mode. (1) predict whole sites, (2)
                        predict binding sites on longer sequences using moving
                        window predictions (default: 1)
  --plot-top-profiles   Plot top window profiles (default: False)
  --plot-format {1,2}   Plotting format of top window profiles. 1: png, 2: pdf
                        (default: 1)
  --thr {1,2,3}         Define site score threshold level for reporting peak
                        regions in --mode 2 (window prediction). 1: relaxed,
                        2: standard, 3: strict (default: 2)
  --site-id LIST_SITE_IDS [LIST_SITE_IDS ...]
                        Provide site ID(s) on which to predict (e.g. --site-id
                        site_id1 site_id2). By default predict on all --in
                        sites

required arguments:
  --in IN_FOLDER        Input prediction data folder (output of rnaprot gp)
  --train-in IN_TRAIN_FOLDER
                        Input model training folder containing model file and
                        parameters (output of rnaprot train)
  --out str             Prediction results output folder
```


## rnaprot_gt

### Tool Description
Generate training data for RNA binding protein motif discovery.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
- **Homepage**: https://github.com/BackofenLab/RNAProt
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaprot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnaprot gt [-h] --in str --out str [--gtf str] [--gen str]
                  [--mode {1,2,3}] [--mask-bed str] [--seq-ext int]
                  [--thr float] [--rev-filter] [--max-len int] [--min-len int]
                  [--keep-ids] [--allow-overlaps] [--no-gene-filter]
                  [--neg-comp-thr float] [--neg-factor {2,3,4,5}]
                  [--keep-add-neg] [--neg-in str] [--shuffle-k {1,2,3}]
                  [--seed int] [--report] [--theme {1,2}] [--eia] [--eia-ib]
                  [--eia-n] [--eia-all-ex] [--tr-list str] [--phastcons str]
                  [--phylop str] [--tra] [--tra-codons] [--tra-borders]
                  [--rra] [--str] [--plfold-u int] [--plfold-l int]
                  [--plfold-w int] [--feat-in str] [--feat-in-1h]

optional arguments:
  -h, --help            show this help message and exit
  --gtf str             Genomic annotations GTF file (.gtf or .gtf.gz)
  --gen str             Genomic sequences .2bit file
  --mode {1,2,3}        Define mode for --in BED site extraction. (1) Take the
                        center of each site, (2) Take the complete site, (3)
                        Take the upstream end for each site. Note that --min-
                        len applies only for --mode 2 (default: 1)
  --mask-bed str        Additional BED regions file (6-column format) for
                        masking negatives (e.g. all positive RBP CLIP sites)
  --seq-ext int         Up- and downstream sequence extension length of sites
                        (site definition by --mode) (default: 40)
  --thr float           Minimum site score (--in BED column 5) for filtering
                        (assuming higher score == better site) (default: None)
  --rev-filter          Reverse --thr filtering (i.e. the lower the better,
                        e.g. for p-values) (default: False)
  --max-len int         Maximum length of --in sites (default: 300)
  --min-len int         Minimum length of --in sites (only effective for
                        --mode 2). If length < --min-len, take center and
                        extend to --min-len. Use uneven numbers for equal up-
                        and downstream extension (default: 21)
  --keep-ids            Keep --in BED column 4 site IDs. Note that site IDs
                        have to be unique (default: False)
  --allow-overlaps      Do not select for highest-scoring sites in case of
                        overlapping sites (default: False)
  --no-gene-filter      Do not filter positives based on gene coverage (gene
                        annotations from --gtf) (default: False)
  --neg-comp-thr float  Sequence complexity (Shannon entropy) threshold for
                        filtering random negative regions (default: 0.5)
  --neg-factor {2,3,4,5}
                        Determines number of initial random negatives to be
                        extracted (== --neg-factor n times # positives)
                        (default: 2)
  --keep-add-neg        Keep additional negatives (# controlled by --neg-
                        factor) instead of outputting same numbers of positive
                        and negative sites (default: False)
  --neg-in str          Negative genomic or transcript sites in BED (6-column
                        format) or FASTA format (unique IDs required). Use
                        with --in BED/FASTA. If not set, negatives are
                        generated by shuffling --in sequences (if --in FASTA)
                        or random selection of genomic or transcript sites (if
                        --in BED)
  --shuffle-k {1,2,3}   Supply k for k-nucleotide shuffling of --in sequences
                        to generate negative sequences (if no --neg-in
                        supplied) (default: 2)
  --seed int            Set a fixed random seed number (e.g. --seed 1) to
                        obtain the same random negative set for identical
                        rnaprot gt runs
  --report              Output an .html report providing various training set
                        statistics and plots (default: False)
  --theme {1,2}         Set theme for .html report (1: palm beach, 2: midnight
                        sunset) (default: 1)

required arguments:
  --in str              Genomic or transcript RBP binding sites file in BED
                        (6-column format) or FASTA format. If --in FASTA, only
                        --str is supported as additional feature. If --in BED,
                        --gtf and --gen become mandatory
  --out str             Output training data folder (== input folder to
                        rnaprot train)

additional annotation arguments:
  --eia                 Add exon-intron annotations to genomic regions
                        (default: False)
  --eia-ib              Add intron border annotations to genomic regions (in
                        combination with --eia) (default: False)
  --eia-n               Label regions not covered by intron or exon regions as
                        N instead of labelling them as introns (I) (in
                        combination with --eia) (default: False)
  --eia-all-ex          Use all annotated exons in --gtf file, instead of
                        exons of most prominent transcripts defined by --tr-
                        list. Set this and --tr-list will be effective only
                        for --tra (default: False)
  --tr-list str         Supply file with transcript IDs (one ID per row) for
                        exon-intron labeling (using the corresponding exon
                        regions from --gtf). By default, exon regions of the
                        most prominent transcripts (automatically selected
                        from --gtf) are used (default: False)
  --phastcons str       Genomic .bigWig file with phastCons conservation
                        scores to add as annotations
  --phylop str          Genomic .bigWig file with phyloP conservation scores
                        to add as annotations
  --tra                 Add transcript region annotations (5'UTR, CDS, 3'UTR,
                        None) to genomic and transcript regions (default:
                        False)
  --tra-codons          Add start and stop codon annotations to genomic or
                        transcript regions (in combination with --tra)
                        (default: False)
  --tra-borders         Add transcript and exon border annotations to
                        transcript regions (in combination with --tra)
                        (default: False)
  --rra                 Add repeat region annotations for genomic or
                        transcript regions retrieved from --gen .2bit
                        (default: False)
  --str                 Add secondary structure probabilities feature
                        (calculate with RNAplfold) (default: False)
  --plfold-u int        RNAplfold -u parameter value (default: 3)
  --plfold-l int        RNAplfold -L parameter value (default: 50)
  --plfold-w int        RNAplfold -W parameter value (default: 70)
  --feat-in str         Provide tabular file with additional position-wise
                        genomic region features (infos and paths to BED files)
                        to add. NOTE that if --in == FASTA sequences, input
                        file format changes from BED to tabular (see
                        documentation)
  --feat-in-1h          Use one-hot encoding for all additional position-wise
                        features from --feat-in table, ignoring type
                        definitions in --feat-in table (default: False)
```


## rnaprot_gp

### Tool Description
Predicts RBP binding sites using a trained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/rnaprot:0.5--pyhdfd78af_1
- **Homepage**: https://github.com/BackofenLab/RNAProt
- **Package**: https://anaconda.org/channels/bioconda/packages/rnaprot/overview
- **Validation**: PASS

### Original Help Text
```text
usage: rnaprot gp [-h] --in str --train-in str --out str [--gtf str]
                  [--gen str] [--mode {1,2,3}] [--seq-ext int] [--gene-filter]
                  [--report] [--theme {1,2}] [--tr-list str] [--eia-all-ex]
                  [--phastcons str] [--phylop str] [--feat-in str]

optional arguments:
  -h, --help       show this help message and exit
  --gtf str        Genomic annotations GTF file (.gtf or .gtf.gz)
  --gen str        Genomic sequences .2bit file
  --mode {1,2,3}   Define mode for --in BED site extraction. (1) Take the
                   center of each site, (2) Take the complete site, (3) Take
                   the upstream end for each site. Use --seq-ext to extend
                   center sites again (default: 2)
  --seq-ext int    Up- and downstream sequence extension length of --in sites
                   (if --in BED, site definition by --mode) (default: False)
  --gene-filter    Filter --in sites based on gene coverage (gene annotations
                   from --gtf) (default: False)
  --report         Output an .html report providing various training set
                   statistics and plots (default: False)
  --theme {1,2}    Set theme for .html report (1: palm beach, 2: midnight
                   sunset) (default: 1)

required arguments:
  --in str         Genomic or transcript RBP binding sites file in BED
                   (6-column format) or FASTA format. If --in FASTA, only
                   --str is supported as additional feature. If --in BED,
                   --gtf and --gen become mandatory
  --train-in str   Training input folder (output folder of rnaprot train) to
                   extract the same features for --in sites which were used to
                   train the model (info stored in --train-in folder)
  --out str        Output prediction dataset folder (== input folder to
                   rnaprot predict)

additional annotation arguments:
  --tr-list str    Supply file with transcript IDs (one ID per row) for exon-
                   intron labeling (using the corresponding exon regions from
                   --gtf). By default, exon regions of the most prominent
                   transcripts (automatically selected from --gtf) are used
                   (default: False)
  --eia-all-ex     Use all annotated exons in --gtf file, instead of exons of
                   most prominent transcripts or exon defined by --tr-list.
                   Set this and --tr-list will be effective only for --tra.
                   NOTE that by default --eia-all-ex is disabled, even if
                   --train-in model was trained with --eia-all-ex (default:
                   False)
  --phastcons str  Genomic .bigWig file with phastCons conservation scores to
                   add as annotations
  --phylop str     Genomic .bigWig file with phyloP conservation scores to add
                   as annotations
  --feat-in str    Provide tabular file with additional position-wise genomic
                   region features (infos and paths to BED files) to add. BE
                   SURE to use the same file as used for generating the
                   training dataset (rnaprot gt --feat-in) for training the
                   model from --train-in! NOTE that this does not apply if
                   --in == FASTA sequences. Here input file format changes
                   from BED to tabular (see documentation), and files need to
                   contain values for --in sequences
```

