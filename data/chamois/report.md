# chamois CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| chamois_annotate | PASS | Repo test BGC0000703 (kanamycin cluster) gave a feature table in HDF5. |
| chamois_compare | Not completed | The command needs the ClassyFire web service to classify query compounds, and the server was down. |
| chamois_cv | PASS | 3-fold random cross-validation on the native dataset gave AUROC 0.81 and a best model. |
| chamois_cvi | PASS | 3-fold group cross-validation on the native dataset gave AUROC 0.82; sampling random stops with a tool error (groups is None). |
| chamois_explain_class | PASS | Aminoglycosides class gave a domain weight table led by the DegT aminotransferase domain. |
| chamois_explain_cluster | PASS | Repo test BGC0000703 gave a gene contribution table per predicted class. |
| chamois_explain_feature | PASS | PF01041.24 gave a class weight table that includes Aminoglycosides. |
| chamois_predict | PASS | Repo test BGC0000703 gave aminoglycoside classes, as in the README. |
| chamois_render | PASS | The predict output renders the README class tree (Aminoglycosides 0.918). |
| chamois_search | PASS | BGC0000703 against the MIBiG 3.1 class catalog ranks kanamycin first. |
| chamois_train | PASS | The repo native dataset (70 BGCs) trained a model with training AUROC 0.96. |
| chamois_validate | PASS | The trained model on the native dataset gave metrics and a per-class report. |

## chamois_annotate

### Tool Description
Annotate BGC sequences with protein domains and gene features.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Total Downloads**: 344
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/zellerlab/CHAMOIS
- **Stars**: N/A
### Original Help Text
```text
Usage: chamois annotate [-h] -i INPUT [-H HMM] [--disentangle] [--cds] -o
                        OUTPUT

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -i, --input INPUT     The input BGC sequences to process. (default: None)
  -H, --hmm HMM         The path to the HMM file containing protein domains
                        for annotation. (default: None)
  --disentangle         Remove overlapping domains by best P-value. (default:
                        False)

Gene Finding:
  Parameters for controlling gene extraction from clusters.

  --cds                 Use CDS features in the GenBank input as genes instead
                        of running Pyrodigal. (default: False)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the sequence annotations in
                        HDF5 format. (default: None)
```


## chamois_cv

### Tool Description
Train a predictor and evaluate it using cross-validation.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois cv [-h] -f FEATURES -c CLASSES
                  [--min-class-occurrences MIN_CLASS_OCCURRENCES]
                  [--min-feature-occurrences MIN_FEATURE_OCCURRENCES]
                  [--min-class-groups MIN_CLASS_GROUPS]
                  [--min-feature-groups MIN_FEATURE_GROUPS]
                  [--min-cluster-length MIN_CLUSTER_LENGTH]
                  [--min-genes MIN_GENES] [--mismatch]
                  [--model {ridge,logistic,dummy,rf}] [--alpha ALPHA]
                  [--variance VARIANCE] [-k KFOLDS]
                  [--sampling {group,kennard-stone,random}] -o OUTPUT
                  [--metrics METRICS] [--report REPORT]
                  [--best-model BEST_MODEL]

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -f, --features FEATURES
                        The feature table in HDF5 format to use for training
                        the predictor. (default: None)
  -c, --classes CLASSES
                        The classes table in HDF5 format to use for training
                        the predictor. (default: None)

Preprocessing:
  Parameters controling data preprocessing, including features and labels
  filtering.

  --min-class-occurrences MIN_CLASS_OCCURRENCES
                        The minimum of occurences for a class to be retained.
                        (default: 0)
  --min-feature-occurrences MIN_FEATURE_OCCURRENCES
                        The minimum of occurences for a feature to be
                        retained. (default: 0)
  --min-class-groups MIN_CLASS_GROUPS
                        The minimum number of groups for a class to be
                        retained. (default: 5)
  --min-feature-groups MIN_FEATURE_GROUPS
                        The minimum number of groups for a feature to be
                        retained. (default: 5)
  --min-cluster-length MIN_CLUSTER_LENGTH
                        The nucleotide length threshold for retaining a
                        cluster. (default: 0)
  --min-genes MIN_GENES
                        The gene count threshold for retaining a cluster.
                        (default: 0)
  --mismatch            Whether to correct mismatching observations. (default:
                        False)

Training:
  Hyperparameters to use for training the model.

  --model {ridge,logistic,dummy,rf}
                        The kind of model to train. (default: logistic)
  --alpha ALPHA         The strength of the parameters regularization.
                        (default: 1.0)
  --variance VARIANCE   The variance threshold for filtering features.
                        (default: None)

Cross-Validation:
  Parameters controlling the cross-validation.

  -k, --kfolds KFOLDS   The number of cross-validation folds to run. (default:
                        5)
  --sampling {group,kennard-stone,random}
                        The algorithm to use for partitioning folds. (default:
                        group)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the probabilities for each
                        test fold. (default: None)
  --metrics METRICS     The path to an optional metrics file to write in
                        DVC/JSON format. (default: None)
  --report REPORT       An optional file where to generate a label-wise
                        evaluation report. (default: None)
  --best-model BEST_MODEL
                        An optional file where to write the model with highest
                        macro-average-precision. (default: None)
```


## chamois_cvi

### Tool Description
Trains a predictor based on features and classes, with options for preprocessing, training, cross-validation, and output.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois cvi [-h] -f FEATURES -c CLASSES
                   [--min-class-occurrences MIN_CLASS_OCCURRENCES]
                   [--min-feature-occurrences MIN_FEATURE_OCCURRENCES]
                   [--min-class-groups MIN_CLASS_GROUPS]
                   [--min-feature-groups MIN_FEATURE_GROUPS]
                   [--min-cluster-length MIN_CLUSTER_LENGTH]
                   [--min-genes MIN_GENES] [--mismatch]
                   [--model {ridge,logistic,dummy,rf}] [--alpha ALPHA]
                   [--variance VARIANCE] [-k KFOLDS]
                   [--sampling {group,random,kennard-stone}] -o OUTPUT
                   [--metrics METRICS] [--report REPORT]

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -f, --features FEATURES
                        The feature table in HDF5 format to use for training
                        the predictor. (default: None)
  -c, --classes CLASSES
                        The classes table in HDF5 format to use for training
                        the predictor. (default: None)

Preprocessing:
  Parameters controling data preprocessing, including features and labels
  filtering.

  --min-class-occurrences MIN_CLASS_OCCURRENCES
                        The minimum of occurences for a class to be retained.
                        (default: 0)
  --min-feature-occurrences MIN_FEATURE_OCCURRENCES
                        The minimum of occurences for a feature to be
                        retained. (default: 0)
  --min-class-groups MIN_CLASS_GROUPS
                        The minimum number of groups for a class to be
                        retained. (default: 5)
  --min-feature-groups MIN_FEATURE_GROUPS
                        The minimum number of groups for a feature to be
                        retained. (default: 5)
  --min-cluster-length MIN_CLUSTER_LENGTH
                        The nucleotide length threshold for retaining a
                        cluster. (default: 0)
  --min-genes MIN_GENES
                        The gene count threshold for retaining a cluster.
                        (default: 0)
  --mismatch            Whether to correct mismatching observations. (default:
                        False)

Training:
  Hyperparameters to use for training the model.

  --model {ridge,logistic,dummy,rf}
                        The kind of model to train. (default: logistic)
  --alpha ALPHA         The strength of the parameters regularization.
                        (default: 1.0)
  --variance VARIANCE   The variance threshold for filtering features.
                        (default: None)

Cross-Validation:
  Parameters controlling the cross-validation.

  -k, --kfolds KFOLDS   The number of cross-validation folds to run. (default:
                        5)
  --sampling {group,random,kennard-stone}
                        The algorithm to use for partitioning folds. (default:
                        group)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the probabilities for each
                        test fold. (default: None)
  --metrics METRICS     The path to an optional metrics file to write in
                        DVC/JSON format. (default: None)
  --report REPORT       An optional file where to generate a label-wise
                        evaluation report. (default: None)
```


## chamois_predict

### Tool Description
Predicts BGC classes and associated domains.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois predict [-h] -i INPUT [-H HMM] [--disentangle] [-m MODEL]
                       [--cds] -o OUTPUT [--render]

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -i, --input INPUT     The input BGC sequences to process. (default: None)
  -H, --hmm HMM         The path to the HMM file containing protein domains
                        for annotation. (default: None)
  --disentangle         Remove overlapping domains by best P-value. (default:
                        False)
  -m, --model MODEL     The path to an alternative model for predicting
                        classes. (default: None)

Gene Finding:
  Parameters for controlling gene extraction from clusters.

  --cds                 Use CDS features in the GenBank input as genes instead
                        of running Pyrodigal. (default: False)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the predicted class
                        probabilities in HDF5 format. (default: None)
  --render              Display prediction results in tree format for each
                        input BGC. (default: False)
```


## chamois_render

### Tool Description
Render probabilities from a predictor.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois render [-h] -i INPUT [-m MODEL] [-p] [-c]

Options:
  -h, --help            show this help message and exit
  -i, --input INPUT     The input probabilites obtained from the predictor.
                        (default: None)
  -m, --model MODEL     The path to an alternative predictor with classes
                        metadata. (default: None)
  -p, --pager           Use the given pager to display results. (default:
                        False)
  -c, --color           Use colored input in pager. (default: False)
```


## chamois_train

### Tool Description
Train a predictor model using feature and class tables.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois train [-h] -f FEATURES -c CLASSES
                     [--min-class-occurrences MIN_CLASS_OCCURRENCES]
                     [--min-feature-occurrences MIN_FEATURE_OCCURRENCES]
                     [--min-class-groups MIN_CLASS_GROUPS]
                     [--min-feature-groups MIN_FEATURE_GROUPS]
                     [--min-cluster-length MIN_CLUSTER_LENGTH]
                     [--min-genes MIN_GENES] [--mismatch]
                     [--model {ridge,logistic,dummy,rf}] [--alpha ALPHA]
                     [--variance VARIANCE] -o OUTPUT [--metrics METRICS]

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -f, --features FEATURES
                        The feature table in HDF5 format to use for training
                        the predictor. (default: None)
  -c, --classes CLASSES
                        The classes table in HDF5 format to use for training
                        the predictor. (default: None)

Preprocessing:
  Parameters controling data preprocessing, including features and labels
  filtering.

  --min-class-occurrences MIN_CLASS_OCCURRENCES
                        The minimum of occurences for a class to be retained.
                        (default: 0)
  --min-feature-occurrences MIN_FEATURE_OCCURRENCES
                        The minimum of occurences for a feature to be
                        retained. (default: 0)
  --min-class-groups MIN_CLASS_GROUPS
                        The minimum number of groups for a class to be
                        retained. (default: 5)
  --min-feature-groups MIN_FEATURE_GROUPS
                        The minimum number of groups for a feature to be
                        retained. (default: 5)
  --min-cluster-length MIN_CLUSTER_LENGTH
                        The nucleotide length threshold for retaining a
                        cluster. (default: 0)
  --min-genes MIN_GENES
                        The gene count threshold for retaining a cluster.
                        (default: 0)
  --mismatch            Whether to correct mismatching observations. (default:
                        False)

Training:
  Hyperparameters to use for training the model.

  --model {ridge,logistic,dummy,rf}
                        The kind of model to train. (default: logistic)
  --alpha ALPHA         The strength of the parameters regularization.
                        (default: 1.0)
  --variance VARIANCE   The variance threshold for filtering features.
                        (default: None)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the trained model in JSON
                        format. (default: None)
  --metrics METRICS     The path to an optional metrics file to write in
                        DVC/JSON format. (default: None)
```


## chamois_search

### Tool Description
Searches a compound class catalog for predicted chemical classes.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois search [-h] -i INPUT [-m MODEL] -c CATALOG [-o OUTPUT]
                      [-d DISTANCE_MATRIX] [--rank RANK] [--render]

Options:
  -h, --help            show this help message and exit
  -m, --model MODEL     The path to an alternative model used for predicting
                        classes. (default: None)

Input:
  Mandatory input files required by the command.

  -i, --input INPUT     The chemical classes predicted by CHAMOIS for BGCs.
                        (default: None)
  -c, --catalog CATALOG
                        The path to the compound class catalog to compare
                        predictions to. (default: None)

Output:
  Parameters for controlling command output.

  -o, --output OUTPUT   The path where to write the catalog search results in
                        TSV format. (default: None)
  -d, --distance-matrix DISTANCE_MATRIX
                        The path where to write the generated pairwise
                        distance matrix. (default: None)
  --rank RANK           The maximum search rank to record in the table output.
                        (default: 10)
  --render              Display best match for each query. (default: False)
```


## chamois_compare

### Tool Description
Compare chemical classes predicted by CHAMOIS for BGCs against a set of queries.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois compare [-h] -i INPUT [-m MODEL] -q QUERIES [-o OUTPUT]
                       [-d DISTANCE_MATRIX] [--rank RANK] [--render]

Options:
  -h, --help            show this help message and exit
  -m, --model MODEL     The path to an alternative model used for predicting
                        classes. (default: None)

Input:
  Mandatory input files required by the command.

  -i, --input INPUT     The chemical classes predicted by CHAMOIS for BGCs.
                        (default: None)
  -q, --query QUERIES   The compounds to search in the predictions, as a
                        SMILES, InChi, or InChiKey. (default: None)

Output:
  Parameters for controlling command output.

  -o, --output OUTPUT   The path where to write the catalog search results in
                        TSV format. (default: None)
  -d, --distance-matrix DISTANCE_MATRIX
                        The path where to write the generated pairwise
                        distance matrix. (default: None)
  --rank RANK           The maximum search rank to record in the table output.
                        (default: 10)
  --render              Display best match for each query. (default: False)
```


## chamois_validate

### Tool Description
Validate a chamois model

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: chamois validate [-h] -f FEATURES -c CLASSES [-m MODEL]
                        [--min-class-occurrences MIN_CLASS_OCCURRENCES]
                        [--min-feature-occurrences MIN_FEATURE_OCCURRENCES]
                        [--min-class-groups MIN_CLASS_GROUPS]
                        [--min-feature-groups MIN_FEATURE_GROUPS]
                        [--min-cluster-length MIN_CLUSTER_LENGTH]
                        [--min-genes MIN_GENES] [--mismatch] -o OUTPUT
                        [--metrics METRICS] [--report REPORT]

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -f, --features FEATURES
                        The feature table in HDF5 format to use for training
                        the predictor. (default: None)
  -c, --classes CLASSES
                        The classes table in HDF5 format to use for training
                        the predictor. (default: None)
  -m, --model MODEL     The path to an alternative model to predict classes
                        with. (default: None)

Preprocessing:
  Parameters controling data preprocessing, including features and labels
  filtering.

  --min-class-occurrences MIN_CLASS_OCCURRENCES
                        The minimum of occurences for a class to be retained.
                        (default: 0)
  --min-feature-occurrences MIN_FEATURE_OCCURRENCES
                        The minimum of occurences for a feature to be
                        retained. (default: 0)
  --min-class-groups MIN_CLASS_GROUPS
                        The minimum number of groups for a class to be
                        retained. (default: 5)
  --min-feature-groups MIN_FEATURE_GROUPS
                        The minimum number of groups for a feature to be
                        retained. (default: 5)
  --min-cluster-length MIN_CLUSTER_LENGTH
                        The nucleotide length threshold for retaining a
                        cluster. (default: 0)
  --min-genes MIN_GENES
                        The gene count threshold for retaining a cluster.
                        (default: 0)
  --mismatch            Whether to correct mismatching observations. (default:
                        False)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the computed probabilities.
                        (default: None)
  --metrics METRICS     The path to an optional metrics file to write in
                        DVC/JSON format. (default: None)
  --report REPORT       An optional file where to generate a label-wise
                        evaluation report. (default: None)
```


## chamois_explain_class

### Tool Description
Explain which domains contribute to a class prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Total Downloads**: 344
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/zellerlab/CHAMOIS
- **Stars**: N/A
### Original Help Text
```text
Usage: chamois explain [-h] [-m MODEL] {class,feature,cluster} ...

Positional Arguments:
  {class,feature,cluster}
    class               Explain which domains contribute to a class
                        prediction.
    feature             Explain which features contribute to a class
                        prediction.
    cluster             Explain which genes of a cluster contribute to which
                        predicted classes.

Options:
  -h, --help            show this help message and exit
  -m, --model MODEL     The path to an alternative model to extract weights
                        from. (default: None)

Usage: chamois explain class [-h] [--nonzero | --min-weight MIN_WEIGHT]
                             [-o OUTPUT] [--render]
                             class_id

Positional Arguments:
  class_id              The class to explain

Options:
  -h, --help            show this help message and exit

Weights:
  Control which weights are displayed in the output.

  --nonzero             Display non-zero weights instead of only positive
                        weights. (default: False)
  --min-weight MIN_WEIGHT
                        The minimum weight to filter the table with. (default:
                        0.0)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the cluster contribution table
                        in TSV format. (default: None)
  --render              Display the cluster contribution table in the console.
                        (default: False)
```

## chamois_explain_feature

### Tool Description
Explain which features contribute to a class prediction.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Total Downloads**: 344
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/zellerlab/CHAMOIS
- **Stars**: N/A
### Original Help Text
```text
Usage: chamois explain [-h] [-m MODEL] {class,feature,cluster} ...

Positional Arguments:
  {class,feature,cluster}
    class               Explain which domains contribute to a class
                        prediction.
    feature             Explain which features contribute to a class
                        prediction.
    cluster             Explain which genes of a cluster contribute to which
                        predicted classes.

Options:
  -h, --help            show this help message and exit
  -m, --model MODEL     The path to an alternative model to extract weights
                        from. (default: None)

Usage: chamois explain feature [-h] [--nonzero | --min-weight MIN_WEIGHT]
                               [-o OUTPUT] [--render]
                               feature_id

Positional Arguments:
  feature_id            The feature to explain

Options:
  -h, --help            show this help message and exit

Weights:
  Control which weights are displayed in the output.

  --nonzero             Display non-zero weights instead of only positive
                        weights. (default: False)
  --min-weight MIN_WEIGHT
                        The minimum weight to filter the table with. (default:
                        0.0)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the cluster contribution table
                        in TSV format. (default: None)
  --render              Display the cluster contribution table in the console.
                        (default: False)
```

## chamois_explain_cluster

### Tool Description
Explain which genes of a cluster contribute to which predicted classes.

### Metadata
- **Docker Image**: quay.io/biocontainers/chamois:0.2.2--pyhdfd78af_0
- **Homepage**: https://chamois.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chamois/overview
- **Total Downloads**: 344
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/zellerlab/CHAMOIS
- **Stars**: N/A
### Original Help Text
```text
Usage: chamois explain [-h] [-m MODEL] {class,feature,cluster} ...

Positional Arguments:
  {class,feature,cluster}
    class               Explain which domains contribute to a class
                        prediction.
    feature             Explain which features contribute to a class
                        prediction.
    cluster             Explain which genes of a cluster contribute to which
                        predicted classes.

Options:
  -h, --help            show this help message and exit
  -m, --model MODEL     The path to an alternative model to extract weights
                        from. (default: None)

Usage: chamois explain cluster [-h] -i INPUT [-H HMM] [--disentangle] [--cds]
                               [-o OUTPUT] [--render]
                               [cluster_id]

Positional Arguments:
  cluster_id            The cluster to explain (default: None)

Options:
  -h, --help            show this help message and exit

Input:
  Mandatory input files required by the command.

  -i, --input INPUT     The input BGC sequences to process. (default: None)
  -H, --hmm HMM         The path to the HMM file containing protein domains
                        for annotation. (default: None)
  --disentangle         Remove overlapping domains by best P-value. (default:
                        False)

Gene Finding:
  Parameters for controlling gene extraction from clusters.

  --cds                 Use CDS features in the GenBank input as genes instead
                        of running Pyrodigal. (default: False)

Output:
  Mandatory and optional outputs.

  -o, --output OUTPUT   The path where to write the cluster contribution table
                        in TSV format. (default: None)
  --render              Display the cluster contribution table in the console.
                        (default: False)
```

## Metadata
- **Skill**: generated
