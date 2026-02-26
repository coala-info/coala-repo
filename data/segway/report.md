# segway CWL Generation Report

## segway_train

### Tool Description
Train a Segway model.

### Metadata
- **Docker Image**: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
- **Homepage**: http://segway.hoffmanlab.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Total Downloads**: 51.8K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: segway train [args] GENOMEDATA TRAINDIR

positional arguments:
  archives
  traindir

options:
  -h, --help            show this help message and exit

Data selection (train-init):
  -t track, --track track
                        append track to list of tracks to use (default all)
  --tracks-from FILE    append tracks from newline-delimited FILE to list of
                        tracks to use
  --include-coords FILE
                        limit to genomic coordinates in FILE (default all)
                        (Note: does not apply to --validation-coords)
  --exclude-coords FILE
                        filter out genomic coordinates in FILE (default none)
  --resolution RES      downsample to every RES bp (default 1)
  --minibatch-fraction FRAC
                        Use a random fraction FRAC positions for each EM
                        iteration. Removes the likelihood stopping criterion,
                        so training always runs to the number of rounds
                        specified by --max-train-rounds.
  --validation-fraction FRAC
                        Use a random held out set of size FRAC of the included
                        genomic regions to validate the parameters learned by
                        each training round. The instance/round with the best
                        likelihood as validated by the holdout set will be
                        chosen as the winner after the specified --max-train-
                        rounds.
  --validation-coords FILE
                        Use genomic coordinates in FILE as a validation set
                        (default none)

Model files (train-init):
  -i FILE, --input-master FILE
                        use or create input master in FILE (default
                        WORKDIR/params/input.master)
  -s FILE, --structure FILE
                        use or create structure in FILE (default
                        WORKDIR/segway.str)
  -p FILE, --trainable-params FILE
                        use or create trainable parameters in FILE (default
                        WORKDIR/params/params.params)
  --dont-train FILE     use FILE as list of parameters not to train (default
                        WORKDIR/auxiliary/dont_train.list)
  --seg-table FILE      load segment hyperparameters from FILE (default none)
  --semisupervised FILE
                        semisupervised segmentation with labels in FILE
                        (default none)

Modeling variables (train-init):
  -D DIST, --distribution DIST
                        use DIST distribution (default asinh_norm)
  --mixture-components MIXTURE_COMPONENTS
                        Number of Gaussian mixture components (default 1)
  --num-instances NUM   run NUM training instances, randomizing start
                        parameters NUM times (default 1)
  -N SLICE, --num-labels SLICE
                        make SLICE segment labels (default 2)
  --num-sublabels NUM   make NUM segment sublabels (default 1)
  --ruler-scale SCALE   ruler marking every SCALE bp (default the resolution
                        multiplied by 10)
  --prior-strength RATIO
                        use RATIO times the number of data counts as the
                        number of pseudocounts for the segment length prior
                        (default 0.000000)
  --segtransition-weight-scale SCALE
                        exponent for segment transition probability (default
                        1.000000)
  --track-weight TRACK_WEIGHT
                        exponent for all input track probabilities (default 1)
  --virtual-evidence-weight VIRTUAL_EVIDENCE_WEIGHT
                        exponent for virtual evidence probability (default
                        1.000000)
  --reverse-world WORLD
                        reverse sequences in concatenated world WORLD
                        (0-based)
  --var-floor VAR_FLOOR
                        Sets the variance floor, meaning that if any of the
                        variances of a track falls below this value, then the
                        variance is "floored" (prohibited from falling below
                        the floor value). If not using a mixture of Gaussians,
                        default unused, else default 0.000010

Flags (train-init):
  -c, --clobber         delete any preexisting files and assumes any model
                        filesspecified in options as output to be overwritten

Modeling Variables (train-run):
  --max-train-rounds NUM
                        each training instance runs a maximum of NUM rounds
                        (default 100)

Intermediate files (train-run, annotate-run):
  -o DIR, --observations DIR
                        DEPRECATED - temp files are now used and recommended.
                        Previously would use or create observations in DIR
                        (default WORKDIR/observations)
  -r DIR, --recover DIR
                        continue from interrupted run in DIR

Virtual Evidence (train-init, train-run):
  --virtual-evidence FILE
                        virtual evidence with priors for labels at each
                        position in FILE (default none)
```


## segway_annotate

### Tool Description
Annotates genomic data using a trained model.

### Metadata
- **Docker Image**: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
- **Homepage**: http://segway.hoffmanlab.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Validation**: PASS

### Original Help Text
```text
usage: segway annotate [args] GENOMEDATA TRAINDIR ANNOTATEDIR

positional arguments:
  archives
  traindir
  annotatedir

options:
  -h, --help            show this help message and exit

Flags (annotate-init, posterior-init):
  -c, --clobber         delete any preexisting files and assumes any model
                        filesspecified in options as output to be overwritten

Data selection (annotate-init, posterior-init):
  --include-coords FILE
                        limit to genomic coordinates in FILE (default all)
                        (Note: does not apply to --validation-coords)
  --exclude-coords FILE
                        filter out genomic coordinates in FILE (default none)
  --output-label OUTPUT_LABEL
                        in the segmentation file, for each coordinate print
                        only its superlabel ("seg"), only its sublabel
                        ("subseg"), or both ("full") (default seg)
  --seg-table FILE      load segment hyperparameters from FILE (default none)

Intermediate files (train-run, annotate-run):
  -r DIR, --recover DIR
                        continue from interrupted run in DIR

Virtual Evidence (annotate-init, posterior-init, annotate-run, posterior-run):
  --virtual-evidence FILE
                        virtual evidence with priors for labels at each
                        position in FILE (default none)

Output files (annotate-finish):
  -b FILE, --bed FILE   create identification BED track in FILE (default
                        WORKDIR/segway.bed.gz)
  --bigBed FILE         specify layered bigBed filename
```


## segway_posterior

### Tool Description
Compute posterior probabilities for Segway segmentation.

### Metadata
- **Docker Image**: quay.io/biocontainers/segway:3.0.4--pyh7cba7a3_1
- **Homepage**: http://segway.hoffmanlab.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/segway/overview
- **Validation**: PASS

### Original Help Text
```text
usage: segway posterior [args] GENOMEDATA TRAINDIR POSTDIR

positional arguments:
  archives
  traindir
  annotatedir

options:
  -h, --help            show this help message and exit

Flags (annotate-init, posterior-init):
  -c, --clobber         delete any preexisting files and assumes any model
                        filesspecified in options as output to be overwritten

Data selection (annotate-init, posterior-init):
  --include-coords FILE
                        limit to genomic coordinates in FILE (default all)
                        (Note: does not apply to --validation-coords)
  --exclude-coords FILE
                        filter out genomic coordinates in FILE (default none)
  --output-label OUTPUT_LABEL
                        in the segmentation file, for each coordinate print
                        only its superlabel ("seg"), only its sublabel
                        ("subseg"), or both ("full") (default seg)
  --seg-table FILE      load segment hyperparameters from FILE (default none)

Virtual Evidence (annotate-init, posterior-init, annotate-run, posterior-run):
  --virtual-evidence FILE
                        virtual evidence with priors for labels at each
                        position in FILE (default none)

Intermediate files (train-run, annotate-run):
  -r DIR, --recover DIR
                        continue from interrupted run in DIR

Output files (annotate-finish):
  -b FILE, --bed FILE   create identification BED track in FILE (default
                        WORKDIR/segway.bed.gz)
  --bigBed FILE         specify layered bigBed filename
```

