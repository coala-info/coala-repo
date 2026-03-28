# ccsmeth CWL Generation Report

## ccsmeth_call_hifi

### Tool Description
call hifi reads with kinetics from subreads.bam using CCS, save in bam/sam format.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PengNi/ccsmeth
- **Stars**: N/A
### Original Help Text
```text
usage: ccsmeth call_hifi [-h] --subreads SUBREADS [--output OUTPUT]
                         [--path_to_ccs PATH_TO_CCS] [--threads THREADS]
                         [--min-passes MIN_PASSES] [--by-strand] [--hd-finder]
                         [--log-level LOG_LEVEL]
                         [--path_to_samtools PATH_TO_SAMTOOLS]

call hifi reads with kinetics from subreads.bam using CCS, save in bam/sam
format. cmd: ccsmeth call_hifi -i input.subreads.bam

options:
  -h, --help            show this help message and exit
  --path_to_samtools PATH_TO_SAMTOOLS
                        full path to the executable binary samtools file. If
                        not specified, it is assumed that samtools is in the
                        PATH.

INPUT:
  --subreads SUBREADS, -i SUBREADS
                        path to subreads.bam file as input

OUTPUT:
  --output OUTPUT, -o OUTPUT
                        output file path for alignment results, bam/sam
                        supported. If not specified, the results will be saved
                        in input_file_prefix.hifi.bam by default.

CCS ARG:
  --path_to_ccs PATH_TO_CCS
                        full path to the executable binary ccs(PBCCS) file. If
                        not specified, it is assumed that ccs is in the PATH.
  --threads THREADS, -t THREADS
                        number of threads to call hifi reads, default None ->
                        means using all available processors
  --min-passes MIN_PASSES
                        CCS: Minimum number of full-length subreads required
                        to generate CCS for a ZMW. default None -> means using
                        a default value set by CCS
  --by-strand           CCS: Generate a consensus for each strand.
  --hd-finder           CCS: Enable heteroduplex finder and splitting.
  --log-level LOG_LEVEL
                        CCS: Set log level. Valid choices: (TRACE, DEBUG,
                        INFO, WARN, FATAL). [WARN]
```


## ccsmeth_call_mods

### Tool Description
call modifications

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth call_mods [-h] --input INPUT [--holes_batch HOLES_BATCH]
                         --output OUTPUT [--gzip] [--keep_pulse] [--no_sort]
                         --model_file MODEL_FILE
                         [--model_type {attbilstm2s,attbigru2s,transencoder2s,attbilstm2s2,attbigru2s2}]
                         [--seq_len SEQ_LEN] [--is_npass IS_NPASS]
                         [--is_stds IS_STDS] [--is_sn IS_SN] [--is_map IS_MAP]
                         [--class_num CLASS_NUM] [--dropout_rate DROPOUT_RATE]
                         [--batch_size BATCH_SIZE] [--layer_rnn LAYER_RNN]
                         [--hid_rnn HID_RNN] [--layer_trans LAYER_TRANS]
                         [--nhead NHEAD] [--d_model D_MODEL] [--dim_ff DIM_FF]
                         [--mode {denovo,align}] [--holeids_e HOLEIDS_E]
                         [--holeids_ne HOLEIDS_NE] [--motifs MOTIFS]
                         [--mod_loc MOD_LOC] [--methy_label {1,0}]
                         [--norm {zscore,min-mean,min-max,mad,none}]
                         [--no_decode] [--ref REF] [--mapq MAPQ]
                         [--identity IDENTITY] [--no_supplementary]
                         [--skip_unmapped SKIP_UNMAPPED] [--threads THREADS]
                         [--threads_call THREADS_CALL] [--tseed TSEED]
                         [--use_compile USE_COMPILE]

call modifications

options:
  -h, --help            show this help message and exit
  --threads THREADS, -p THREADS
                        number of threads to be used, default 10.
  --threads_call THREADS_CALL
                        number of threads used to call modifications with
                        trained models, no more than threads/3 is suggested.
                        default 3.
  --tseed TSEED         random seed for torch
  --use_compile USE_COMPILE
                        if using torch.compile, yes or no, default no ('yes'
                        only works in pytorch>=2.0)

INPUT:
  --input INPUT, -i INPUT
                        input file, can be bam/sam, or features.tsv generated
                        by extract_features.py.
  --holes_batch HOLES_BATCH
                        number of holes/hifi-reads in an batch to get/put in
                        queues, default 50. only used when --input is bam/sam

OUTPUT:
  --output OUTPUT, -o OUTPUT
                        the prefix of output files to save the predicted
                        results. output files will be
                        [--output].per_readsite.tsv/.modbam.bam
  --gzip                if compressing .per_readsite.tsv when --input is not
                        in bam/sam format.
  --keep_pulse          if keeping ipd/pw tags in .modbam.bam when --input is
                        in bam/sam format.
  --no_sort             don't sort .modbam.bam when --input is in bam/sam
                        format.

CALL:
  --model_file MODEL_FILE, -m MODEL_FILE
                        file path of the trained model (.ckpt)
  --model_type {attbilstm2s,attbigru2s,transencoder2s,attbilstm2s2,attbigru2s2}
                        type of model to use, 'attbilstm2s', 'attbigru2s',
                        'transencoder2s', 'attbilstm2s2', 'attbigru2s2',
                        default: attbigru2s
  --seq_len SEQ_LEN     len of kmer. default 21
  --is_npass IS_NPASS   if using num_pass features, yes or no, default yes
  --is_stds IS_STDS     if using std features, yes or no, default no
  --is_sn IS_SN         if using signal-to-noise-ratio features, yes or no,
                        default no. Effects both MODEL input and feature
                        EXTRACTION
  --is_map IS_MAP       if using mapping features, yes or no, default no.
                        Effects both MODEL input and feature EXTRACTION, only
                        works in EXTRACTION-ALIGN-MODE
  --class_num CLASS_NUM
  --dropout_rate DROPOUT_RATE
  --batch_size BATCH_SIZE, -b BATCH_SIZE
                        batch size, default 512

CALL MODEL_HYPER RNN:
  --layer_rnn LAYER_RNN
                        BiRNN layer num, default 3
  --hid_rnn HID_RNN     BiRNN hidden_size, default 256

CALL MODEL_HYPER TRANSFORMER:
  --layer_trans LAYER_TRANS
                        TransformerEncoder nlayers, default 6
  --nhead NHEAD         TransformerEncoder nhead, default 4
  --d_model D_MODEL     TransformerEncoder input feature numbers, default 256
  --dim_ff DIM_FF       TransformerEncoder dim_feedforward, default 512

EXTRACTION:
  --mode {denovo,align}
                        denovo mode: extract features from unaligned/aligned
                        hifi.bam without reference position info; align mode:
                        extract features from aligned hifi.bam with reference
                        position info. default: denovo
  --holeids_e HOLEIDS_E
                        file contains holeids to be extracted, default None
  --holeids_ne HOLEIDS_NE
                        file contains holeids not to be extracted, default
                        None
  --motifs MOTIFS       motif seq to be extracted, default: CG. can be multi
                        motifs splited by comma (no space allowed in the input
                        str), or use IUPAC alphabet, the mod_loc of all motifs
                        must be the same
  --mod_loc MOD_LOC     0-based location of the targeted base in the motif,
                        default 0
  --methy_label {1,0}   the label of the interested modified bases, this is
                        for training. 0 or 1, default 1
  --norm {zscore,min-mean,min-max,mad,none}
                        method for normalizing ipd/pw in subread level.
                        zscore, min-mean, min-max, mad, or none. default
                        zscore
  --no_decode           not use CodecV1 to decode ipd/pw

EXTRACTION ALIGN_MODE:
  --ref REF             path to genome reference to be aligned, in fasta/fa
                        format.
  --mapq MAPQ           MAPping Quality cutoff for selecting alignment items,
                        default 1
  --identity IDENTITY   identity cutoff for selecting alignment items, [0.0,
                        1.0], default 0.0
  --no_supplementary    not use supplementary alignment
  --skip_unmapped SKIP_UNMAPPED
                        if skipping unmapped sites in reads, yes or no,
                        default yes
```


## ccsmeth_align_hifi

### Tool Description
align hifi reads using pbmm2/minimap2/bwa, default pbmm2

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth align_hifi [-h] --hifireads HIFIREADS --ref REF
                          [--output OUTPUT] [--header]
                          [--path_to_pbmm2 PATH_TO_PBMM2] [--minimap2]
                          [--path_to_minimap2 PATH_TO_MINIMAP2]
                          [--bestn BESTN] [--bwa] [--path_to_bwa PATH_TO_BWA]
                          [--path_to_samtools PATH_TO_SAMTOOLS]
                          [--threads THREADS]

align hifi reads using pbmm2/minimap2/bwa, default pbmm2

options:
  -h, --help            show this help message and exit

INPUT:
  --hifireads HIFIREADS, -i HIFIREADS
                        path to hifireads.bam/sam/fastq_with_pulseinfo file as
                        input
  --ref REF             path to genome reference to be aligned, in fasta/fa
                        format. If using bwa, the reference must have already
                        been indexed.

OUTPUT:
  --output OUTPUT, -o OUTPUT
                        output file path for alignment results, bam/sam
                        supported. If not specified, the results will be saved
                        in input_file_prefix.bam by default.
  --header              save header annotations from bam/sam. DEPRECATED

ALIGN:
  --path_to_pbmm2 PATH_TO_PBMM2
                        full path to the executable binary pbmm2 file. If not
                        specified, it is assumed that pbmm2 is in the PATH.
  --minimap2            use minimap2 instead of pbmm2 for alignment
  --path_to_minimap2 PATH_TO_MINIMAP2
                        full path to the executable binary minimap2 file. If
                        not specified, it is assumed that minimap2 is in the
                        PATH.
  --bestn BESTN, -n BESTN
                        retain at most n alignments in minimap2. default 3,
                        which means 2 secondary alignments are retained. Do
                        not use 2, cause -N1 is not suggested for high
                        accuracy of alignment. [This arg is for further
                        extension.]
  --bwa                 use bwa instead of pbmm2 for alignment
  --path_to_bwa PATH_TO_BWA
                        full path to the executable binary bwa file. If not
                        specified, it is assumed that bwa is in the PATH.
  --path_to_samtools PATH_TO_SAMTOOLS
                        full path to the executable binary samtools file. If
                        not specified, it is assumed that samtools is in the
                        PATH.
  --threads THREADS, -t THREADS
                        number of threads, default 5
```


## ccsmeth_call_freqt

### Tool Description
call frequency of modifications at genome level from per_readsite text files

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth call_freqt [-h] --input_path INPUT_PATH [--file_uid FILE_UID]
                          --result_file RESULT_FILE [--bed] [--sort] [--gzip]
                          [--prob_cf PROB_CF] [--rm_1strand] [--refsites_only]
                          [--motifs MOTIFS] [--mod_loc MOD_LOC] [--ref REF]
                          [--contigs CONTIGS] [--threads THREADS]

call frequency of modifications at genome level from per_readsite text files

options:
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

CALL_FREQ:
  --prob_cf PROB_CF     this is to remove ambiguous calls. if
                        abs(prob1-prob0)>=prob_cf, then we use the call. e.g.,
                        proc_cf=0 means use all calls. range [0, 1], default
                        0.0.
  --rm_1strand          abandon ccs reads with only 1 strand subreads
                        [DEPRECATED]
  --refsites_only       only keep sites which are target motifs in both
                        reference and reads
  --motifs MOTIFS       motif seq to be extracted, default: CG. can be multi
                        motifs splited by comma (no space allowed in the input
                        str), or use IUPAC alphabet, the mod_loc of all motifs
                        must be the same. [Only useful when --refsites_only is
                        True]
  --mod_loc MOD_LOC     0-based location of the targeted base in the motif,
                        default 0. [Only useful when --refsites_only is True]
  --ref REF             path to genome reference, in fasta/fa format. [Only
                        useful when --refsites_only is True]

PARALLEL:
  --contigs CONTIGS     a reference genome file (.fa/.fasta/.fna), used for
                        extracting all contig names for parallel; or path of a
                        file containing chromosome/contig names, one name each
                        line; or a string contains multiple chromosome names
                        splited by comma.default None, which means all
                        chromosomes will be processed at one time. If not
                        None, one chromosome will be processed by one
                        subprocess.
  --threads THREADS     number of subprocesses used when --contigs is set.
                        i.e., number of contigs processed in parallel. default
                        1
```


## ccsmeth_call_freqb

### Tool Description
call frequency of modifications at genome level from modbam.bam file

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth call_freqb [-h] [--threads THREADS] --input_bam INPUT_BAM --ref
                          REF [--contigs CONTIGS] [--chunk_len CHUNK_LEN]
                          --output OUTPUT [--bed] [--sort] [--gzip]
                          [--modtype {5mC}] [--call_mode {count,aggregate}]
                          [--prob_cf PROB_CF] [--no_amb_cov]
                          [--hap_tag HAP_TAG] [--mapq MAPQ]
                          [--identity IDENTITY] [--no_supplementary]
                          [--motifs MOTIFS] [--mod_loc MOD_LOC] [--no_comb]
                          [--refsites_only] [--refsites_all] [--no_hap]
                          [--base_clip BASE_CLIP] [--aggre_model AGGRE_MODEL]
                          [--model_type {attbilstm,attbigru}]
                          [--seq_len SEQ_LEN] [--class_num CLASS_NUM]
                          [--layer_rnn LAYER_RNN] [--hid_rnn HID_RNN]
                          [--bin_size BIN_SIZE] [--cov_cf COV_CF]
                          [--only_close] [--discrete] [--tseed TSEED]

call frequency of modifications at genome level from modbam.bam file

options:
  -h, --help            show this help message and exit
  --threads THREADS     number of subprocesses used. default 5

INPUT:
  --input_bam INPUT_BAM
                        input bam, should be aligned and sorted
  --ref REF             path to genome reference, in fasta/fa format.
  --contigs CONTIGS     path of a file containing chromosome/contig names, one
                        name each line; or a string contains multiple
                        chromosome names splited by comma.default None, which
                        means all chromosomes will be processed.
  --chunk_len CHUNK_LEN
                        chunk length, default 500000

OUTPUT:
  --output OUTPUT, -o OUTPUT
                        prefix of output file to save the results
  --bed                 save the result in bedMethyl format
  --sort                sort items in the result
  --gzip                if compressing the output using gzip

CALL_FREQ:
  --modtype {5mC}       modification type, default 5mC.
  --call_mode {count,aggregate}
                        call mode: count, aggregate. default count.
  --prob_cf PROB_CF     this is to remove ambiguous calls (only for count-mode
                        now). if abs(prob1-prob0)>=prob_cf, then we use the
                        call. e.g., proc_cf=0 means use all calls. range [0,
                        1], default 0.0.
  --no_amb_cov          when using prob_cf>0, DO NOT count ambiguous calls for
                        calculating reads coverage
  --hap_tag HAP_TAG     haplotype tag, default HP
  --mapq MAPQ           MAPping Quality cutoff for selecting alignment items,
                        default 1
  --identity IDENTITY   identity cutoff for selecting alignment items, [0.0,
                        1.0], default 0.0
  --no_supplementary    not use supplementary alignment
  --motifs MOTIFS       motif seq to be extracted, default: CG. can be multi
                        motifs splited by comma (no space allowed in the input
                        str), or use IUPAC alphabet, the mod_loc of all motifs
                        must be the same
  --mod_loc MOD_LOC     0-based location of the targeted base in the motif,
                        default 0
  --no_comb             don't combine fwd/rev reads of one CG. [Only works
                        when motifs is CG]
  --refsites_only       only keep sites which are target motifs in both
                        reference and reads
  --refsites_all        output all covered sites which are target motifs in
                        reference. --refsites_all is True, also means we do
                        not output sites which are target motifs only in
                        reads.
  --no_hap              don't call_freq on haplotypes
  --base_clip BASE_CLIP
                        number of base clipped in each read, default 0

AGGREGATE_MODE:
  --aggre_model AGGRE_MODEL, -m AGGRE_MODEL
                        file path of the aggregate model (.ckpt)
  --model_type {attbilstm,attbigru}
                        type of model to use, 'attbigru', 'attbilstm',
                        default: attbigru
  --seq_len SEQ_LEN     len of sites used. default 11
  --class_num CLASS_NUM
  --layer_rnn LAYER_RNN
                        BiRNN layer num, default 1
  --hid_rnn HID_RNN     BiRNN hidden_size, default 32
  --bin_size BIN_SIZE   histogram bin size, default 20
  --cov_cf COV_CF       coverage cutoff, to consider if use aggregate model to
                        re-predict the modstate of the site
  --only_close          [EXPERIMENTAL]
  --discrete            [EXPERIMENTAL]
  --tseed TSEED         random seed for torch
```


## ccsmeth_extract

### Tool Description
extract features from hifi reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth extract [-h] --input INPUT [--holeids_e HOLEIDS_E]
                       [--holeids_ne HOLEIDS_NE] [--output OUTPUT] [--gzip]
                       [--mode {denovo,align}] [--seq_len SEQ_LEN]
                       [--motifs MOTIFS] [--mod_loc MOD_LOC]
                       [--methy_label {1,0}]
                       [--norm {zscore,min-mean,min-max,mad,none}]
                       [--no_decode] [--holes_batch HOLES_BATCH]
                       [--is_sn IS_SN] [--is_map IS_MAP] [--ref REF]
                       [--mapq MAPQ] [--identity IDENTITY]
                       [--no_supplementary] [--skip_unmapped SKIP_UNMAPPED]
                       [--threads THREADS]

extract features from hifi reads.

options:
  -h, --help            show this help message and exit
  --threads THREADS     number of threads, default 5

INPUT:
  --input INPUT, -i INPUT
                        input file in bam/sam format, can be unaligned
                        hifi.bam/sam and aligned sorted hifi.bam/sam.
  --holeids_e HOLEIDS_E
                        file contains holeids/hifiids to be extracted, default
                        None
  --holeids_ne HOLEIDS_NE
                        file contains holeids/hifiids not to be extracted,
                        default None

OUTPUT:
  --output OUTPUT, -o OUTPUT
                        output file path to save the extracted features. If
                        not specified, use input_prefix.tsv as default.
  --gzip                if compressing the output using gzip

EXTRACTION:
  --mode {denovo,align}
                        denovo mode: extract features from unaligned/aligned
                        hifi.bam without reference position info; align mode:
                        extract features from aligned hifi.bam with reference
                        position info. default: denovo
  --seq_len SEQ_LEN     len of kmer. default 21
  --motifs MOTIFS       motif seq to be extracted, default: CG. can be multi
                        motifs splited by comma (no space allowed in the input
                        str), or use IUPAC alphabet, the mod_loc of all motifs
                        must be the same
  --mod_loc MOD_LOC     0-based location of the targeted base in the motif,
                        default 0
  --methy_label {1,0}   the label of the interested modified bases, this is
                        for training. 0 or 1, default 1
  --norm {zscore,min-mean,min-max,mad,none}
                        method for normalizing ipd/pw in subread level.
                        zscore, min-mean, min-max, mad, or none. default
                        zscore
  --no_decode           not use CodecV1 to decode ipd/pw
  --holes_batch HOLES_BATCH
                        number of holes/hifi-reads in an batch to get/put in
                        queues, default 50
  --is_sn IS_SN         if extracting signal-to-noise features, yes or no,
                        default no
  --is_map IS_MAP       if extracting mapping features, yes or no, default no.
                        only works in ALIGN-MODE

EXTRACTION ALIGN_MODE:
  --ref REF             path to genome reference to be aligned, in fasta/fa
                        format.
  --mapq MAPQ           MAPping Quality cutoff for selecting alignment items,
                        default 1
  --identity IDENTITY   identity cutoff for selecting alignment items, [0.0,
                        1.0], default 0.0
  --no_supplementary    not use supplementary alignment
  --skip_unmapped SKIP_UNMAPPED
                        if skipping unmapped sites in reads, yes or no,
                        default yes
```


## ccsmeth_train

### Tool Description
train a model, need two independent datasets for training and validating

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth train [-h] --train_file TRAIN_FILE --valid_file VALID_FILE
                     --model_dir MODEL_DIR
                     [--model_type {attbilstm2s,attbigru2s,transencoder2s,attbilstm2s2,attbigru2s2}]
                     [--seq_len SEQ_LEN] [--is_npass IS_NPASS] [--is_sn IS_SN]
                     [--is_map IS_MAP] [--is_stds IS_STDS]
                     [--class_num CLASS_NUM] [--dropout_rate DROPOUT_RATE]
                     [--layer_rnn LAYER_RNN] [--hid_rnn HID_RNN]
                     [--layer_trans LAYER_TRANS] [--nhead NHEAD]
                     [--d_model D_MODEL] [--dim_ff DIM_FF]
                     [--optim_type {Adam,RMSprop,SGD,Ranger,LookaheadAdam}]
                     [--batch_size BATCH_SIZE]
                     [--lr_scheduler {StepLR,ReduceLROnPlateau}] [--lr LR]
                     [--lr_decay LR_DECAY] [--lr_decay_step LR_DECAY_STEP]
                     [--lr_patience LR_PATIENCE]
                     [--lr_mode_strategy {last,mean,max}]
                     [--max_epoch_num MAX_EPOCH_NUM]
                     [--min_epoch_num MIN_EPOCH_NUM] [--pos_weight POS_WEIGHT]
                     [--step_interval STEP_INTERVAL]
                     [--dl_num_workers DL_NUM_WORKERS] [--dl_offsets]
                     [--init_model INIT_MODEL] [--tseed TSEED]
                     [--use_compile USE_COMPILE]

train a model, need two independent datasets for training and validating

options:
  -h, --help            show this help message and exit

INPUT:
  --train_file TRAIN_FILE
  --valid_file VALID_FILE

OUTPUT:
  --model_dir MODEL_DIR

TRAIN MODEL_HYPER:
  --model_type {attbilstm2s,attbigru2s,transencoder2s,attbilstm2s2,attbigru2s2}
                        type of model to use, 'attbilstm2s', 'attbigru2s',
                        'transencoder2s', 'attbilstm2s2', 'attbigru2s2',
                        default: attbigru2s
  --seq_len SEQ_LEN     len of kmer. default 21
  --is_npass IS_NPASS   if using num_pass features, yes or no, default yes
  --is_sn IS_SN         if using signal-to-noise-ratio features, yes or no,
                        default no
  --is_map IS_MAP       if using mapping features, yes or no, default no
  --is_stds IS_STDS     if using std features, yes or no, default no
  --class_num CLASS_NUM
  --dropout_rate DROPOUT_RATE

TRAIN MODEL_HYPER RNN:
  --layer_rnn LAYER_RNN
                        BiRNN layer num, default 3
  --hid_rnn HID_RNN     BiRNN hidden_size, default 256

TRAIN MODEL_HYPER TRANSFORMER:
  --layer_trans LAYER_TRANS
                        TransformerEncoder nlayers, default 6
  --nhead NHEAD         TransformerEncoder nhead, default 4
  --d_model D_MODEL     TransformerEncoder input feature numbers, default 256
  --dim_ff DIM_FF       TransformerEncoder dim_feedforward, default 512

TRAINING:
  --optim_type {Adam,RMSprop,SGD,Ranger,LookaheadAdam}
                        type of optimizer to use, 'Adam', 'SGD', 'RMSprop',
                        'Ranger' or 'LookaheadAdam', default Adam
  --batch_size BATCH_SIZE
  --lr_scheduler {StepLR,ReduceLROnPlateau}
                        StepLR or ReduceLROnPlateau, default StepLR
  --lr LR               default 0.001
  --lr_decay LR_DECAY   default 0.1
  --lr_decay_step LR_DECAY_STEP
                        effective in StepLR. default 1
  --lr_patience LR_PATIENCE
                        effective in ReduceLROnPlateau. default 0
  --lr_mode_strategy {last,mean,max}
                        effective in ReduceLROnPlateau. last, mean, or max,
                        default last
  --max_epoch_num MAX_EPOCH_NUM
                        max epoch num, default 50
  --min_epoch_num MIN_EPOCH_NUM
                        min epoch num, default 10
  --pos_weight POS_WEIGHT
  --step_interval STEP_INTERVAL
  --dl_num_workers DL_NUM_WORKERS
                        default 0
  --dl_offsets          use file offsets loader
  --init_model INIT_MODEL
                        file path of pre-trained model parameters to load
                        before training
  --tseed TSEED         random seed for pytorch
  --use_compile USE_COMPILE
                        if using torch.compile, yes or no, default no ('yes'
                        only works in pytorch>=2.0)
```


## ccsmeth_trainm

### Tool Description
[EXPERIMENTAL]train a model using multi gpus

### Metadata
- **Docker Image**: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/PengNi/ccsmeth
- **Package**: https://anaconda.org/channels/bioconda/packages/ccsmeth/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ccsmeth trainm [-h] --train_file TRAIN_FILE --valid_file VALID_FILE
                      --model_dir MODEL_DIR
                      [--model_type {attbilstm2s,attbigru2s,transencoder2s,attbilstm2s2,attbigru2s2}]
                      [--seq_len SEQ_LEN] [--is_npass IS_NPASS]
                      [--is_sn IS_SN] [--is_map IS_MAP] [--is_stds IS_STDS]
                      [--class_num CLASS_NUM] [--dropout_rate DROPOUT_RATE]
                      [--layer_rnn LAYER_RNN] [--hid_rnn HID_RNN]
                      [--layer_trans LAYER_TRANS] [--nhead NHEAD]
                      [--d_model D_MODEL] [--dim_ff DIM_FF]
                      [--optim_type {Adam,RMSprop,SGD,Ranger,LookaheadAdam}]
                      [--batch_size BATCH_SIZE]
                      [--lr_scheduler {StepLR,ReduceLROnPlateau}] [--lr LR]
                      [--lr_decay LR_DECAY] [--lr_decay_step LR_DECAY_STEP]
                      [--lr_patience LR_PATIENCE]
                      [--max_epoch_num MAX_EPOCH_NUM]
                      [--min_epoch_num MIN_EPOCH_NUM]
                      [--pos_weight POS_WEIGHT]
                      [--step_interval STEP_INTERVAL]
                      [--dl_num_workers DL_NUM_WORKERS]
                      [--init_model INIT_MODEL] [--tseed TSEED]
                      [--use_compile USE_COMPILE] [--nodes NODES]
                      [--ngpus_per_node NGPUS_PER_NODE] [--dist-url DIST_URL]
                      [--node_rank NODE_RANK] [--epoch_sync]

[EXPERIMENTAL]train a model using multi gpus

options:
  -h, --help            show this help message and exit

INPUT:
  --train_file TRAIN_FILE
  --valid_file VALID_FILE

OUTPUT:
  --model_dir MODEL_DIR

TRAIN MODEL_HYPER:
  --model_type {attbilstm2s,attbigru2s,transencoder2s,attbilstm2s2,attbigru2s2}
                        type of model to use, 'attbilstm2s', 'attbigru2s',
                        'transencoder2s', 'attbilstm2s2', 'attbigru2s2',
                        default: attbigru2s
  --seq_len SEQ_LEN     len of kmer. default 21
  --is_npass IS_NPASS   if using num_pass features, yes or no, default yes
  --is_sn IS_SN         if using signal-to-noise-ratio features, yes or no,
                        default no
  --is_map IS_MAP       if using mapping features, yes or no, default no
  --is_stds IS_STDS     if using std features, yes or no, default no
  --class_num CLASS_NUM
  --dropout_rate DROPOUT_RATE

TRAIN MODEL_HYPER RNN:
  --layer_rnn LAYER_RNN
                        BiRNN layer num, default 3
  --hid_rnn HID_RNN     BiRNN hidden_size, default 256

TRAIN MODEL_HYPER TRANSFORMER:
  --layer_trans LAYER_TRANS
                        TransformerEncoder nlayers, default 6
  --nhead NHEAD         TransformerEncoder nhead, default 4
  --d_model D_MODEL     TransformerEncoder input feature numbers, default 256
  --dim_ff DIM_FF       TransformerEncoder dim_feedforward, default 512

TRAINING:
  --optim_type {Adam,RMSprop,SGD,Ranger,LookaheadAdam}
                        type of optimizer to use, 'Adam', 'SGD', 'RMSprop',
                        'Ranger' or 'LookaheadAdam', default Adam
  --batch_size BATCH_SIZE
  --lr_scheduler {StepLR,ReduceLROnPlateau}
                        StepLR or ReduceLROnPlateau, default StepLR
  --lr LR               default 0.001. [lr should be lr*world_size when using
                        multi gpus? or lower batch_size?]
  --lr_decay LR_DECAY   default 0.1
  --lr_decay_step LR_DECAY_STEP
                        effective in StepLR. default 1
  --lr_patience LR_PATIENCE
                        effective in ReduceLROnPlateau. default 0
  --max_epoch_num MAX_EPOCH_NUM
                        max epoch num, default 50
  --min_epoch_num MIN_EPOCH_NUM
                        min epoch num, default 10
  --pos_weight POS_WEIGHT
  --step_interval STEP_INTERVAL
  --dl_num_workers DL_NUM_WORKERS
                        default 0
  --init_model INIT_MODEL
                        file path of pre-trained model parameters to load
                        before training
  --tseed TSEED         random seed for pytorch
  --use_compile USE_COMPILE
                        if using torch.compile, yes or no, default no ('yes'
                        only works in pytorch>=2.0)

TRAINING PARALLEL:
  --nodes NODES         number of nodes for distributed training, default 1
  --ngpus_per_node NGPUS_PER_NODE
                        number of GPUs per node for distributed training,
                        default 2
  --dist-url DIST_URL   url used to set up distributed training
  --node_rank NODE_RANK
                        node rank for distributed training, default 0
  --epoch_sync          if sync model params of gpu0 to other local gpus after
                        per epoch
```


## Metadata
- **Skill**: generated
