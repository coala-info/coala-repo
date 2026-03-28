# deepnog CWL Generation Report

## deepnog_train

### Tool Description
Train a DeepNOG model.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepnog:1.2.4--pyh7e72e81_0
- **Homepage**: https://github.com/univieCUBE/deepnog
- **Package**: https://anaconda.org/channels/bioconda/packages/deepnog/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepnog/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/univieCUBE/deepnog
- **Stars**: N/A
### Original Help Text
```text
usage: deepnog train [-h] [-ff FILEFORMAT] [-V VERBOSE] [-d {auto,cpu,gpu}]
                     [-nw NUM_WORKERS] [-a {deepnog,deepfam,deepfam_light}]
                     [-w WEIGHTS_FILE] [-bs BATCH_SIZE] -o OUT_DIR
                     -db DATABASE_NAME -t TAXONOMIC_LEVEL [-e N_EPOCHS] [-s]
                     [-lr LEARNING_RATE] [-g LEARNING_RATE_DECAY] [-l2 λ]
                     [-r RANDOM_SEED] [--save-each-epoch]
                     TRAIN_SEQUENCE_FILE VAL_SEQUENCE_FILE TRAIN_LABELS_FILE
                     VAL_LABELS_FILE

positional arguments:
  TRAIN_SEQUENCE_FILE   File containing protein sequences training set.
  VAL_SEQUENCE_FILE     File containing protein sequences validation set.
  TRAIN_LABELS_FILE     Orthologous group labels for training set protein
                        sequences.
  VAL_LABELS_FILE       Orthologous group labels for training and validation
                        set protein sequences. Both training and validation
                        labels Must be in CSV files that are parseable by
                        pandas.read_csv(..., index_col=1). The first column
                        must be a numerical index. The other columns should be
                        named 'protein_id' and 'eggnog_id', or be in order
                        sequence_identifier first, label_identifier second.

options:
  -h, --help            show this help message and exit
  -ff, --fformat FILEFORMAT
                        File format of protein sequences. Must be supported by
                        Biopythons Bio.SeqIO class.
  -V, --verbose VERBOSE
                        Define verbosity of DeepNOGs output written to stdout
                        or stderr. 0 only writes errors to stderr which cause
                        DeepNOG to abort and exit. 1 also writes warnings to
                        stderr if e.g. a protein without an ID was found and
                        skipped. 2 additionally writes general progress
                        messages to stdout. 3 includes a dynamic progress bar
                        of the prediction stage using tqdm.
  -d, --device {auto,cpu,gpu}
                        Define device for calculating protein sequence
                        classification. Auto chooses GPU if available,
                        otherwise CPU.
  -nw, --num-workers NUM_WORKERS
                        Number of subprocesses (workers) to use for data
                        loading. Set to a value <= 0 to use single-process
                        data loading. Note: Only use multi-process data
                        loading if you are calculating on a gpu (otherwise
                        inefficient)!
  -a, --architecture {deepnog,deepfam,deepfam_light}
                        Network architecture to use for classification.
  -w, --weights WEIGHTS_FILE
                        Custom weights file path (optional)
  -bs, --batch-size BATCH_SIZE
                        The batch size determines how many sequences are
                        processed by the network at once. If 1, process the
                        protein sequences sequentially (recommended on CPUs).
                        Larger batch sizes speed up the inference and training
                        on GPUs. Batch size can influence the learning
                        process.
  -o, --out OUT_DIR     Store training results to files in the given
                        directory. Results include the trained
                        model,training/validation loss and accuracy values,and
                        the ground truth plus predicted classes per training
                        epoch, if requested.
  -db, --database DATABASE_NAME
                        Orthologous group database name
  -t, --tax TAXONOMIC_LEVEL
                        Taxonomic level in specified database
  -e, --n-epochs N_EPOCHS
                        Number of training epochs, that is, passes over the
                        complete data set.
  -s, --shuffle         Shuffle the training sequences. Note that a shuffle
                        buffer is used in combination with an iterable
                        dataset. That is, not all sequences have equal
                        probability to be chosen. If you have highly
                        structured sequence files consider shuffling them in
                        advance. Default buffer size = 65536
  -lr, --learning-rate LEARNING_RATE
                        Initial learning rate, subject to adaptations by
                        chosen optimizer and scheduler.
  -g, --gamma LEARNING_RATE_DECAY
                        Decay for learning rate step scheduler. (lr_epoch_t2 =
                        gamma * lr_epoch_t1)
  -l2, --l2-coeff λ     Regularization coefficient λ for L2 regularization. If
                        None, L2 regularization is disabled.
  -r, --random-seed RANDOM_SEED
                        Seed the random number generators of numpy and PyTorch
                        during training for reproducibility. Also affects
                        cuDNN determinism. Default: None (disables
                        reproducibility)
  --save-each-epoch     Save the model after each epoch.
```


## deepnog_infer

### Tool Description
Infer orthologous groups for protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepnog:1.2.4--pyh7e72e81_0
- **Homepage**: https://github.com/univieCUBE/deepnog
- **Package**: https://anaconda.org/channels/bioconda/packages/deepnog/overview
- **Validation**: PASS

### Original Help Text
```text
usage: deepnog infer [-h] [-ff FILEFORMAT] [-V VERBOSE] [-d {auto,cpu,gpu}]
                     [-nw NUM_WORKERS] [-a {deepnog,deepfam,deepfam_light}]
                     [-w WEIGHTS_FILE] [-bs BATCH_SIZE] [-o OUT_FILE]
                     [-db {eggNOG5,cog2020}] [-t TAXONOMIC_LEVEL]
                     [--test_labels TEST_LABELS_FILE] [-of {csv,tsv,legacy}]
                     [-c CONFIDENCE]
                     SEQUENCE_FILE

positional arguments:
  SEQUENCE_FILE         File containing protein sequences for orthology
                        inference.

options:
  -h, --help            show this help message and exit
  -ff, --fformat FILEFORMAT
                        File format of protein sequences. Must be supported by
                        Biopythons Bio.SeqIO class.
  -V, --verbose VERBOSE
                        Define verbosity of DeepNOGs output written to stdout
                        or stderr. 0 only writes errors to stderr which cause
                        DeepNOG to abort and exit. 1 also writes warnings to
                        stderr if e.g. a protein without an ID was found and
                        skipped. 2 additionally writes general progress
                        messages to stdout. 3 includes a dynamic progress bar
                        of the prediction stage using tqdm.
  -d, --device {auto,cpu,gpu}
                        Define device for calculating protein sequence
                        classification. Auto chooses GPU if available,
                        otherwise CPU.
  -nw, --num-workers NUM_WORKERS
                        Number of subprocesses (workers) to use for data
                        loading. Set to a value <= 0 to use single-process
                        data loading. Note: Only use multi-process data
                        loading if you are calculating on a gpu (otherwise
                        inefficient)!
  -a, --architecture {deepnog,deepfam,deepfam_light}
                        Network architecture to use for classification.
  -w, --weights WEIGHTS_FILE
                        Custom weights file path (optional)
  -bs, --batch-size BATCH_SIZE
                        The batch size determines how many sequences are
                        processed by the network at once. If 1, process the
                        protein sequences sequentially (recommended on CPUs).
                        Larger batch sizes speed up the inference and training
                        on GPUs. Batch size can influence the learning
                        process.
  -o, --out OUT_FILE    Store orthologous group predictions to outputfile. Per
                        default, write predictions to stdout.
  -db, --database {eggNOG5,cog2020}
                        Orthologous group/family database to use.
  -t, --tax TAXONOMIC_LEVEL
                        Taxonomic level to use in specified database, e.g. 1 =
                        root, 2 = bacteria
  --test_labels TEST_LABELS_FILE
                        Measure model performance on a test set. If provided,
                        this file must contain the ground-truth labels for the
                        provided sequences. Otherwise, only perform inference.
  -of, --outformat {csv,tsv,legacy}
                        Output file format
  -c, --confidence-threshold CONFIDENCE
                        If provided, predictions below the threshold are
                        discarded.By default, any confidence threshold stored
                        in the model is applied, if present.
```


## Metadata
- **Skill**: generated
