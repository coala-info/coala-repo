cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsignal_plant
  - call_mods
label: deepsignal-plant_call_mods
doc: "call modifications\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
inputs:
  - id: input_path
    type:
      - 'null'
      - File
    doc: "the input path, a signal_feature file from extract (use input_dir for a directory of fast5 files)"
    inputBinding:
      position: 101
      prefix: --input_path
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "a directory of fast5 files; if given, the FAST5_EXTRACTION args should be provided"
    inputBinding:
      position: 101
      prefix: --input_path
  - id: f5_batch_size
    type:
      - 'null'
      - int
    doc: "number of reads/files to be processed by each process one time, default 30"
    inputBinding:
      position: 101
      prefix: --f5_batch_size
  - id: model_path
    type: File
    doc: "file path of the trained model (.ckpt)"
    inputBinding:
      position: 101
      prefix: --model_path
  - id: model_type
    type:
      - 'null'
      - string
    doc: "type of model to use, 'both_bilstm', 'seq_bilstm' or 'signal_bilstm', 'both_bilstm' means to use both seq and signal bilstm, default: both_bilstm"
    inputBinding:
      position: 101
      prefix: --model_type
  - id: seq_len
    type:
      - 'null'
      - int
    doc: "len of kmer. default 13"
    inputBinding:
      position: 101
      prefix: --seq_len
  - id: signal_len
    type:
      - 'null'
      - int
    doc: "the number of signals of one base to be used in deepsignal_plant, default 16"
    inputBinding:
      position: 101
      prefix: --signal_len
  - id: layernum1
    type:
      - 'null'
      - int
    doc: "lstm layer num for combined feature, default 3"
    inputBinding:
      position: 101
      prefix: --layernum1
  - id: layernum2
    type:
      - 'null'
      - int
    doc: "lstm layer num for seq feature (and for signal feature too), default 1"
    inputBinding:
      position: 101
      prefix: --layernum2
  - id: class_num
    type:
      - 'null'
      - int
    doc: "number of classes"
    inputBinding:
      position: 101
      prefix: --class_num
  - id: dropout_rate
    type:
      - 'null'
      - float
    doc: "dropout rate"
    inputBinding:
      position: 101
      prefix: --dropout_rate
  - id: n_vocab
    type:
      - 'null'
      - int
    doc: "base_seq vocab_size (15 base kinds from iupac)"
    inputBinding:
      position: 101
      prefix: --n_vocab
  - id: n_embed
    type:
      - 'null'
      - int
    doc: "base_seq embedding_size"
    inputBinding:
      position: 101
      prefix: --n_embed
  - id: is_base
    type:
      - 'null'
      - string
    doc: "is using base features in seq model, default yes"
    inputBinding:
      position: 101
      prefix: --is_base
  - id: is_signallen
    type:
      - 'null'
      - string
    doc: "is using signal length feature of each base in seq model, default yes"
    inputBinding:
      position: 101
      prefix: --is_signallen
  - id: hid_rnn
    type:
      - 'null'
      - int
    doc: "BiLSTM hidden_size for combined feature"
    inputBinding:
      position: 101
      prefix: --hid_rnn
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "batch size, default 512"
    inputBinding:
      position: 101
      prefix: --batch_size
  - id: result_file
    type: string
    doc: "the file path to save the predicted result"
    inputBinding:
      position: 101
      prefix: --result_file
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "if compressing the output using gzip"
    inputBinding:
      position: 101
      prefix: --gzip
  - id: recursively
    type:
      - 'null'
      - string
    doc: "is to find fast5 files from fast5_dir recursively. default true, t, yes, 1"
    inputBinding:
      position: 101
      prefix: --recursively
  - id: corrected_group
    type:
      - 'null'
      - string
    doc: "the corrected_group of fast5 files after tombo re-squiggle. default RawGenomeCorrected_000"
    inputBinding:
      position: 101
      prefix: --corrected_group
  - id: basecall_subgroup
    type:
      - 'null'
      - string
    doc: "the corrected subgroup of fast5 files. default BaseCalled_template"
    inputBinding:
      position: 101
      prefix: --basecall_subgroup
  - id: is_dna
    type:
      - 'null'
      - string
    doc: "whether the fast5 files from DNA sample or not. default true, t, yes, 1. set this option to no/false/0 if the fast5 files are from RNA sample."
    inputBinding:
      position: 101
      prefix: --is_dna
  - id: reference_path
    type:
      - 'null'
      - File
    doc: "the reference file to be used, usually is a .fa file. (not necessary)"
    inputBinding:
      position: 101
      prefix: --reference_path
  - id: normalize_method
    type:
      - 'null'
      - string
    doc: "the way for normalizing signals in read level. mad or zscore, default mad"
    inputBinding:
      position: 101
      prefix: --normalize_method
  - id: motifs
    type:
      - 'null'
      - string
    doc: "motif seq to be extracted, default: CG. can be multi motifs splited by comma (no space allowed in the input str), or use IUPAC alphabet, the mod_loc of all motifs must be the same"
    inputBinding:
      position: 101
      prefix: --motifs
  - id: mod_loc
    type:
      - 'null'
      - int
    doc: "0-based location of the targeted base in the motif, default 0"
    inputBinding:
      position: 101
      prefix: --mod_loc
  - id: region
    type:
      - 'null'
      - string
    doc: "region of interest, e.g.: chr1, chr1:0, chr1:0-10000. 0-based, half-open interval: [start, end). default None, means processing all sites in genome"
    inputBinding:
      position: 101
      prefix: --region
  - id: positions
    type:
      - 'null'
      - File
    doc: "file with a list of positions interested (must be formatted as tab-separated file with chromosome, position (in fwd strand), and strand. motifs/mod_loc are still need to be set. --positions is used to narrow down the range of the trageted motif locs. default None"
    inputBinding:
      position: 101
      prefix: --positions
  - id: nproc
    type:
      - 'null'
      - int
    doc: "number of processes to be used, default 10."
    inputBinding:
      position: 101
      prefix: --nproc
  - id: nproc_gpu
    type:
      - 'null'
      - int
    doc: "number of processes to use gpu (if gpu is available), 1 or a number less than nproc-1, no more than nproc/4 is suggested. default 2."
    inputBinding:
      position: 101
      prefix: --nproc_gpu
outputs:
  - id: result
    type: File
    doc: the predicted result
    outputBinding:
      glob: $(inputs.result_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
