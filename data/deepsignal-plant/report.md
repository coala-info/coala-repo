# deepsignal-plant CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| deepsignal-plant_call_freq | PASS | synthetic data: planted call_mods results; bedMethyl frequencies 75, 0 and 50 percent match the plan. |
| deepsignal-plant_call_mods | Failed | image problem: call_mods imports h5py, which fails with undefined symbol H5Pset_fapl_ros3. |
| deepsignal-plant_denoise | PASS | synthetic data: planted CpG features; one round keeps 142 of 300 positives and all negatives in the denoised file. |
| deepsignal-plant_extract | Failed | image problem: h5py fails to import (undefined symbol H5Pset_fapl_ros3), so extract crashes on tombo-resquiggled SARS-CoV-2 fast5 reads. |
| deepsignal-plant_train | PASS | synthetic data: planted CpG features (extract is broken in the image); 2 epochs reach 0.855 validation accuracy and write .ckpt models. |

## deepsignal-plant_extract

### Tool Description
extract features from corrected (tombo) fast5s for training or testing.

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/deepsignal-plant
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/deepsignal-plant
- **Stars**: N/A
### Original Help Text
```text
usage: deepsignal_plant extract [-h] --fast5_dir FAST5_DIR
                                [--recursively RECURSIVELY]
                                [--corrected_group CORRECTED_GROUP]
                                [--basecall_subgroup BASECALL_SUBGROUP]
                                [--is_dna IS_DNA]
                                [--reference_path REFERENCE_PATH]
                                [--normalize_method {mad,zscore}]
                                [--methy_label {1,0}] [--seq_len SEQ_LEN]
                                [--signal_len SIGNAL_LEN] [--motifs MOTIFS]
                                [--mod_loc MOD_LOC] [--region REGION]
                                [--positions POSITIONS] --write_path
                                WRITE_PATH [--w_is_dir W_IS_DIR]
                                [--w_batch_num W_BATCH_NUM] [--gzip]
                                [--nproc NPROC]
                                [--f5_batch_size F5_BATCH_SIZE]

extract features from corrected (tombo) fast5s for training or testing. It is
suggested that running this module 1 flowcell a time, or a group of flowcells
a time, if the whole data is extremely large.

optional arguments:
  -h, --help            show this help message and exit
  --nproc NPROC, -p NPROC
                        number of processes to be used, default 1
  --f5_batch_size F5_BATCH_SIZE
                        number of files to be processed by each process one
                        time, default 30

INPUT:
  --fast5_dir FAST5_DIR, -i FAST5_DIR
                        the directory of fast5 files
  --recursively RECURSIVELY, -r RECURSIVELY
                        is to find fast5 files from fast5_dir recursively.
                        default true, t, yes, 1
  --corrected_group CORRECTED_GROUP
                        the corrected_group of fast5 files after tombo re-
                        squiggle. default RawGenomeCorrected_000
  --basecall_subgroup BASECALL_SUBGROUP
                        the corrected subgroup of fast5 files. default
                        BaseCalled_template
  --is_dna IS_DNA       whether the fast5 files from DNA sample or not.
                        default true, t, yes, 1. set this option to no/false/0
                        if the fast5 files are from RNA sample.
  --reference_path REFERENCE_PATH
                        the reference file to be used, usually is a .fa file.
                        (not necessary)

EXTRACTION:
  --normalize_method {mad,zscore}
                        the way for normalizing signals in read level. mad or
                        zscore, default mad
  --methy_label {1,0}   the label of the interested modified bases, this is
                        for training. 0 or 1, default 1
  --seq_len SEQ_LEN     len of kmer. default 13
  --signal_len SIGNAL_LEN
                        the number of signals of one base to be used in
                        deepsignal_plant, default 16
  --motifs MOTIFS       motif seq to be extracted, default: CG. can be multi
                        motifs splited by comma (no space allowed in the input
                        str), or use IUPAC alphabet, the mod_loc of all motifs
                        must be the same
  --mod_loc MOD_LOC     0-based location of the targeted base in the motif,
                        default 0
  --region REGION       region of interest, e.g.: chr1, chr1:0, chr1:0-10000.
                        0-based, half-open interval: [start, end). default
                        None, means processing all sites in genome
  --positions POSITIONS
                        file with a list of positions interested (must be
                        formatted as tab-separated file with chromosome,
                        position (in fwd strand), and strand. motifs/mod_loc
                        are still need to be set. --positions is used to
                        narrow down the range of the trageted motif locs.
                        default None

OUTPUT:
  --write_path WRITE_PATH, -o WRITE_PATH
                        file path to save the features
  --w_is_dir W_IS_DIR   if using a dir to save features into multiple files
  --w_batch_num W_BATCH_NUM
                        features batch num to save in a single writed file
                        when --is_dir is true
  --gzip                if compressing the output using gzip
```

## deepsignal-plant_call_mods

### Tool Description
call modifications

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/deepsignal-plant
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/deepsignal-plant
- **Stars**: N/A
### Original Help Text
```text
usage: deepsignal_plant call_mods [-h] --input_path INPUT_PATH
                                  [--f5_batch_size F5_BATCH_SIZE] --model_path
                                  MODEL_PATH
                                  [--model_type {both_bilstm,seq_bilstm,signal_bilstm}]
                                  [--seq_len SEQ_LEN]
                                  [--signal_len SIGNAL_LEN]
                                  [--layernum1 LAYERNUM1]
                                  [--layernum2 LAYERNUM2]
                                  [--class_num CLASS_NUM]
                                  [--dropout_rate DROPOUT_RATE]
                                  [--n_vocab N_VOCAB] [--n_embed N_EMBED]
                                  [--is_base IS_BASE]
                                  [--is_signallen IS_SIGNALLEN]
                                  [--batch_size BATCH_SIZE]
                                  [--hid_rnn HID_RNN] --result_file
                                  RESULT_FILE [--gzip]
                                  [--recursively RECURSIVELY]
                                  [--corrected_group CORRECTED_GROUP]
                                  [--basecall_subgroup BASECALL_SUBGROUP]
                                  [--is_dna IS_DNA]
                                  [--normalize_method {mad,zscore}]
                                  [--motifs MOTIFS] [--mod_loc MOD_LOC]
                                  [--region REGION] [--positions POSITIONS]
                                  [--reference_path REFERENCE_PATH]
                                  [--nproc NPROC] [--nproc_gpu NPROC_GPU]

call modifications

optional arguments:
  -h, --help            show this help message and exit
  --nproc NPROC, -p NPROC
                        number of processes to be used, default 10.
  --nproc_gpu NPROC_GPU
                        number of processes to use gpu (if gpu is available),
                        1 or a number less than nproc-1, no more than nproc/4
                        is suggested. default 2.

INPUT:
  --input_path INPUT_PATH, -i INPUT_PATH
                        the input path, can be a signal_feature file from
                        extract_features.py, or a directory of fast5 files. If
                        a directory of fast5 files is provided, args in
                        FAST5_EXTRACTION should be provided.
  --f5_batch_size F5_BATCH_SIZE
                        number of reads/files to be processed by each process
                        one time, default 30

CALL:
  --model_path MODEL_PATH, -m MODEL_PATH
                        file path of the trained model (.ckpt)
  --model_type {both_bilstm,seq_bilstm,signal_bilstm}
                        type of model to use, 'both_bilstm', 'seq_bilstm' or
                        'signal_bilstm', 'both_bilstm' means to use both seq
                        and signal bilstm, default: both_bilstm
  --seq_len SEQ_LEN     len of kmer. default 13
  --signal_len SIGNAL_LEN
                        signal num of one base, default 16
  --layernum1 LAYERNUM1
                        lstm layer num for combined feature, default 3
  --layernum2 LAYERNUM2
                        lstm layer num for seq feature (and for signal feature
                        too), default 1
  --class_num CLASS_NUM
  --dropout_rate DROPOUT_RATE
  --n_vocab N_VOCAB     base_seq vocab_size (15 base kinds from iupac)
  --n_embed N_EMBED     base_seq embedding_size
  --is_base IS_BASE     is using base features in seq model, default yes
  --is_signallen IS_SIGNALLEN
                        is using signal length feature of each base in seq
                        model, default yes
  --batch_size BATCH_SIZE, -b BATCH_SIZE
                        batch size, default 512
  --hid_rnn HID_RNN     BiLSTM hidden_size for combined feature

OUTPUT:
  --result_file RESULT_FILE, -o RESULT_FILE
                        the file path to save the predicted result
  --gzip                if compressing the output using gzip

FAST5_EXTRACTION:
  --recursively RECURSIVELY, -r RECURSIVELY
                        is to find fast5 files from fast5 dir recursively.
                        default true, t, yes, 1
  --corrected_group CORRECTED_GROUP
                        the corrected_group of fast5 files after tombo re-
                        squiggle. default RawGenomeCorrected_000
  --basecall_subgroup BASECALL_SUBGROUP
                        the corrected subgroup of fast5 files. default
                        BaseCalled_template
  --is_dna IS_DNA       whether the fast5 files from DNA sample or not.
                        default true, t, yes, 1. setting this option to
                        no/false/0 means the fast5 files are from RNA sample.
  --normalize_method {mad,zscore}
                        the way for normalizing signals in read level. mad or
                        zscore, default mad
  --motifs MOTIFS       motif seq to be extracted, default: CG. can be multi
                        motifs splited by comma (no space allowed in the input
                        str), or use IUPAC alphabet, the mod_loc of all motifs
                        must be the same
  --mod_loc MOD_LOC     0-based location of the targeted base in the motif,
                        default 0
  --region REGION       region of interest, e.g.: chr1, chr1:0, chr1:0-10000.
                        0-based, half-open interval: [start, end). default
                        None, means processing the whole sites in genome
  --positions POSITIONS
                        file with a list of positions interested (must be
                        formatted as tab-separated file with chromosome,
                        position (in fwd strand), and strand. motifs/mod_loc
                        are still need to be set. --positions is used to
                        narrow down the range of the trageted motif locs.
                        default None
  --reference_path REFERENCE_PATH
                        the reference file to be used, usually is a .fa file.
                        (not necessary)
```

## deepsignal-plant_call_freq

### Tool Description
call frequency of modifications at genome level

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/deepsignal-plant
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/deepsignal-plant
- **Stars**: N/A
### Original Help Text
```text
usage: deepsignal_plant call_freq [-h] --input_path INPUT_PATH
                                  [--file_uid FILE_UID] --result_file
                                  RESULT_FILE [--bed] [--sort] [--gzip]
                                  [--prob_cf PROB_CF] [--contigs CONTIGS]
                                  [--nproc NPROC]

call frequency of modifications at genome level

optional arguments:
  -h, --help            show this help message and exit

INPUT:
  --input_path INPUT_PATH, -i INPUT_PATH
                        an output file from call_mods/call_modifications.py,
                        or a directory contains a bunch of output files. this
                        arg is in "append" mode, can be used multiple times
  --file_uid FILE_UID   a unique str which all input files has, this is for
                        finding all input files and ignoring the not-input-
                        files in a input directory. if input_path is a file,
                        ignore this arg.

OUTPUT:
  --result_file RESULT_FILE, -o RESULT_FILE
                        the file path to save the result
  --bed                 save the result in bedMethyl format
  --sort                sort items in the result
  --gzip                if compressing the output using gzip

CAlCULATE:
  --prob_cf PROB_CF     this is to remove ambiguous calls. if
                        abs(prob1-prob0)>=prob_cf, then we use the call. e.g.,
                        proc_cf=0 means use all calls. range [0, 1], default
                        0.5.

PARALLEL:
  --contigs CONTIGS     a reference genome file (.fa/.fasta/.fna), used for
                        extracting all contig names for parallel; or path of a
                        file containing chromosome/contig names, one name each
                        line; or a string contains multiple chromosome names
                        splited by comma.default None, which means all
                        chromosomes will be processed at one time. If not
                        None, one chromosome will be processed by one
                        subprocess.
  --nproc NPROC         number of subprocesses used when --contigs is set.
                        i.e., number of contigs processed in parallel. default
                        1
```

## deepsignal-plant_train

### Tool Description
train a model, need two independent datasets for training and validating

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/deepsignal-plant
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/deepsignal-plant
- **Stars**: N/A
### Original Help Text
```text
usage: deepsignal_plant train [-h] --train_file TRAIN_FILE --valid_file
                              VALID_FILE --model_dir MODEL_DIR
                              [--model_type {both_bilstm,seq_bilstm,signal_bilstm}]
                              [--seq_len SEQ_LEN] [--signal_len SIGNAL_LEN]
                              [--layernum1 LAYERNUM1] [--layernum2 LAYERNUM2]
                              [--class_num CLASS_NUM]
                              [--dropout_rate DROPOUT_RATE]
                              [--n_vocab N_VOCAB] [--n_embed N_EMBED]
                              [--is_base IS_BASE]
                              [--is_signallen IS_SIGNALLEN]
                              [--hid_rnn HID_RNN]
                              [--optim_type {Adam,RMSprop,SGD,Ranger}]
                              [--batch_size BATCH_SIZE] [--lr LR]
                              [--lr_decay LR_DECAY]
                              [--lr_decay_step LR_DECAY_STEP]
                              [--max_epoch_num MAX_EPOCH_NUM]
                              [--min_epoch_num MIN_EPOCH_NUM]
                              [--step_interval STEP_INTERVAL]
                              [--pos_weight POS_WEIGHT]
                              [--init_model INIT_MODEL] [--tmpdir TMPDIR]

train a model, need two independent datasets for training and validating

optional arguments:
  -h, --help            show this help message and exit

INPUT:
  --train_file TRAIN_FILE
  --valid_file VALID_FILE

OUTPUT:
  --model_dir MODEL_DIR

TRAIN:
  --model_type {both_bilstm,seq_bilstm,signal_bilstm}
                        type of model to use, 'both_bilstm', 'seq_bilstm' or
                        'signal_bilstm', 'both_bilstm' means to use both seq
                        and signal bilstm, default: both_bilstm
  --seq_len SEQ_LEN     len of kmer. default 13
  --signal_len SIGNAL_LEN
                        the number of signals of one base to be used in
                        deepsignal_plant, default 16
  --layernum1 LAYERNUM1
                        lstm layer num for combined feature, default 3
  --layernum2 LAYERNUM2
                        lstm layer num for seq feature (and for signal feature
                        too), default 1
  --class_num CLASS_NUM
  --dropout_rate DROPOUT_RATE
  --n_vocab N_VOCAB     base_seq vocab_size (15 base kinds from iupac)
  --n_embed N_EMBED     base_seq embedding_size
  --is_base IS_BASE     is using base features in seq model, default yes
  --is_signallen IS_SIGNALLEN
                        is using signal length feature of each base in seq
                        model, default yes
  --hid_rnn HID_RNN     BiLSTM hidden_size for combined feature
  --optim_type {Adam,RMSprop,SGD,Ranger}
                        type of optimizer to use, 'Adam' or 'SGD' or 'RMSprop'
                        or 'Ranger', default Adam
  --batch_size BATCH_SIZE
  --lr LR
  --lr_decay LR_DECAY
  --lr_decay_step LR_DECAY_STEP
  --max_epoch_num MAX_EPOCH_NUM
                        max epoch num, default 10
  --min_epoch_num MIN_EPOCH_NUM
                        min epoch num, default 5
  --step_interval STEP_INTERVAL
  --pos_weight POS_WEIGHT
  --init_model INIT_MODEL
                        file path of pre-trained model parameters to load
                        before training
  --tmpdir TMPDIR
```

## deepsignal-plant_denoise

### Tool Description
denoise training samples by deep-learning, filter false positive samples (and false negative samples).

### Metadata
- **Docker Image**: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/deepsignal-plant
- **Package**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deepsignal-plant/overview
- **Total Downloads**: 13.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/deepsignal-plant
- **Stars**: N/A
### Original Help Text
```text
usage: deepsignal_plant denoise [-h] --train_file TRAIN_FILE
                                [--is_filter_fn IS_FILTER_FN]
                                [--model_type {both_bilstm,seq_bilstm,signal_bilstm}]
                                [--seq_len SEQ_LEN] [--signal_len SIGNAL_LEN]
                                [--layernum1 LAYERNUM1]
                                [--layernum2 LAYERNUM2]
                                [--class_num CLASS_NUM]
                                [--dropout_rate DROPOUT_RATE]
                                [--n_vocab N_VOCAB] [--n_embed N_EMBED]
                                [--is_base IS_BASE]
                                [--is_signallen IS_SIGNALLEN]
                                [--hid_rnn HID_RNN] [--pos_weight POS_WEIGHT]
                                [--batch_size BATCH_SIZE] [--lr LR]
                                [--epoch_num EPOCH_NUM]
                                [--step_interval STEP_INTERVAL]
                                [--iterations ITERATIONS] [--rounds ROUNDS]
                                [--score_cf SCORE_CF]
                                [--kept_ratio KEPT_RATIO] [--fst_iter_prob]

denoise training samples by deep-learning, filter false positive samples (and
false negative samples).

optional arguments:
  -h, --help            show this help message and exit

INPUT:
  --train_file TRAIN_FILE
                        file containing (combined positive and negative)
                        samples for training. better been balanced in kmer
                        level.

TRAIN:
  --is_filter_fn IS_FILTER_FN
                        is filter false negative samples, , 'yes' or 'no',
                        default no
  --model_type {both_bilstm,seq_bilstm,signal_bilstm}
                        type of model to use, 'both_bilstm', 'seq_bilstm' or
                        'signal_bilstm', 'both_bilstm' means to use both seq
                        and signal bilstm, default: signal_bilstm
  --seq_len SEQ_LEN     len of kmer. default 13
  --signal_len SIGNAL_LEN
                        the number of signals of one base to be used in
                        deepsignal_plant, default 16
  --layernum1 LAYERNUM1
                        lstm layer num for combined feature, default 3
  --layernum2 LAYERNUM2
                        lstm layer num for seq feature (and for signal feature
                        too), default 1
  --class_num CLASS_NUM
  --dropout_rate DROPOUT_RATE
  --n_vocab N_VOCAB     base_seq vocab_size (15 base kinds from iupac)
  --n_embed N_EMBED     base_seq embedding_size
  --is_base IS_BASE     is using base features in seq model, default yes
  --is_signallen IS_SIGNALLEN
                        is using signal length feature of each base in seq
                        model, default yes
  --hid_rnn HID_RNN     BiLSTM hidden_size for combined feature
  --pos_weight POS_WEIGHT
  --batch_size BATCH_SIZE
  --lr LR
  --epoch_num EPOCH_NUM
  --step_interval STEP_INTERVAL

DENOISE:
  --iterations ITERATIONS
  --rounds ROUNDS
  --score_cf SCORE_CF   score cutoff to keep high quality (which
                        prob>=score_cf) positive samples. (0, 0.5], default
                        0.5
  --kept_ratio KEPT_RATIO
                        kept ratio of samples, to end denoise process. default
                        0.99
  --fst_iter_prob       if output probs of samples after 1st iteration
```

