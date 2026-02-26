# mokapot CWL Generation Report

## mokapot

### Tool Description
mokapot version 0.10.0.
Written by William E. Fondrie (wfondrie@talus.bio) while in the
Department of Genome Sciences at the University of Washington.

Official code website: https://github.com/wfondrie/mokapot

More documentation and examples: https://mokapot.readthedocs.io

### Metadata
- **Docker Image**: quay.io/biocontainers/mokapot:0.10.0--pyhdfd78af_0
- **Homepage**: https://github.com/wfondrie/mokapot
- **Package**: https://anaconda.org/channels/bioconda/packages/mokapot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mokapot/overview
- **Total Downloads**: 41.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wfondrie/mokapot
- **Stars**: N/A
### Original Help Text
```text
usage: mokapot [-h] [-d DEST_DIR] [-w MAX_WORKERS] [-r FILE_ROOT]
               [--proteins PROTEINS] [--decoy_prefix DECOY_PREFIX]
               [--enzyme ENZYME] [--missed_cleavages MISSED_CLEAVAGES]
               [--clip_nterm_methionine] [--min_length MIN_LENGTH]
               [--max_length MAX_LENGTH] [--semi] [--train_fdr TRAIN_FDR]
               [--test_fdr TEST_FDR] [--max_iter MAX_ITER] [--seed SEED]
               [--direction DIRECTION] [--aggregate]
               [--subset_max_train SUBSET_MAX_TRAIN] [--override]
               [--save_models] [--load_models LOAD_MODELS [LOAD_MODELS ...]]
               [--plugin PLUGIN] [--keep_decoys] [--folds FOLDS]
               [--open_modification_bin_size OPEN_MODIFICATION_BIN_SIZE]
               [-v {0,1,2,3}]
               psm_files [psm_files ...]

mokapot version 0.10.0.
Written by William E. Fondrie (wfondrie@talus.bio) while in the
Department of Genome Sciences at the University of Washington.

Official code website: https://github.com/wfondrie/mokapot

More documentation and examples: https://mokapot.readthedocs.io

positional arguments:
  psm_files             A collection of PSMs in the Percolator tab-delimited
                        or PepXML format.

options:
  -h, --help            show this help message and exit
  -d DEST_DIR, --dest_dir DEST_DIR
                        The directory in which to write the result files.
                        Defaults to the current working directory
  -w MAX_WORKERS, --max_workers MAX_WORKERS
                        The number of processes to use for model training.
                        Note that using more than one worker will result in
                        garbled logging messages.
  -r FILE_ROOT, --file_root FILE_ROOT
                        The prefix added to all file names.
  --proteins PROTEINS   The FASTA file used for the database search. Using
                        this option enable protein-level confidence estimates
                        using the 'picked-protein' approach. Note that the
                        FASTA file must contain both target and decoy
                        sequences. Additionally, verify that the '--enzyme', '
                        --missed_cleavages, '--min_length', '--max_length', '
                        --semi', '--clip_nterm_methionine', and '--
                        decoy_prefix' parameters match your search engine
                        conditions.
  --decoy_prefix DECOY_PREFIX
                        The prefix used to indicate a decoy protein in the
                        FASTA file. For mokapot to provide accurate confidence
                        estimates, decoy proteins should have same description
                        as the target proteins they were generated from, but
                        this string prepended.
  --enzyme ENZYME       A regular expression defining the enzyme specificity.
                        The cleavage site is interpreted as the end of the
                        match. The default is trypsin, without proline
                        suppression: [KR]
  --missed_cleavages MISSED_CLEAVAGES
                        The allowed number of missed cleavages
  --clip_nterm_methionine
                        Remove methionine residues that occur at the protein
                        N-terminus.
  --min_length MIN_LENGTH
                        The minimum peptide length to consider.
  --max_length MAX_LENGTH
                        The maximum peptide length to consider.
  --semi                Was a semi-enzymatic digest used to assign PSMs? If
                        so, the protein database will likely contain shared
                        peptides and yield unhelpful protein-level confidence
                        estimates. We do not recommend using this option.
  --train_fdr TRAIN_FDR
                        The maximum false discovery rate at which to consider
                        a target PSM as a positive example during model
                        training.
  --test_fdr TEST_FDR   The false-discovery rate threshold at which to
                        evaluate the learned models.
  --max_iter MAX_ITER   The number of iterations to use for training.
  --seed SEED           An integer to use as the random seed.
  --direction DIRECTION
                        The name of the feature to use as the initial
                        direction for ranking PSMs. The default automatically
                        selects the feature that finds the most PSMs below the
                        `train_fdr`.
  --aggregate           If used, PSMs from multiple PIN files will be
                        aggregated and analyzed together. Otherwise, a joint
                        model will be trained, but confidence estimates will
                        be calculated separately for each PIN file. This flag
                        only has an effect when multiple PIN files are
                        provided.
  --subset_max_train SUBSET_MAX_TRAIN
                        Maximum number of PSMs to use during the training of
                        each of the cross validation folds in the model. This
                        is useful for very large datasets and will be ignored
                        if less PSMS are available.
  --override            Use the learned model even if it performs worse than
                        the best feature.
  --save_models         Save the models learned by mokapot as pickled Python
                        objects.
  --load_models LOAD_MODELS [LOAD_MODELS ...]
                        Load previously saved models and skip model
                        training.Note that the number of models must match the
                        value of --folds.
  --plugin PLUGIN       The names of the plugins to use.
  --keep_decoys         Keep the decoys in the output .txt files
  --folds FOLDS         The number of cross-validation folds to use. PSMs
                        originating from the same mass spectrum are always in
                        the same fold.
  --open_modification_bin_size OPEN_MODIFICATION_BIN_SIZE
                        This parameter only affect reading PSMs from PepXML
                        files. If specified, modification masses are binned
                        according to the value. The binned mass difference is
                        appended to the end of the peptide and will be used
                        when grouping peptides for peptide-level confidence
                        estimation. Using this option for open modification
                        search results. We recommend 0.01 as a good starting
                        point.
  -v {0,1,2,3}, --verbosity {0,1,2,3}
                        Specify the verbosity of the current process. Each
                        level prints the following messages, including all
                        those at a lower verbosity: 0-errors, 1-warnings,
                        2-messages, 3-debug info.
```

