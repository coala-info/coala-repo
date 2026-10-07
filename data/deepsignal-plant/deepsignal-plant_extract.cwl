cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsignal_plant
  - extract
label: deepsignal-plant_extract
doc: "extract features from corrected (tombo) fast5s for training or testing. It is suggested that running this module 1 flowcell a time, or a group of flowcells a time, if the whole data is extremely large.\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
inputs:
  - id: fast5_dir
    type: Directory
    doc: "the directory of fast5 files"
    inputBinding:
      position: 101
      prefix: --fast5_dir
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
  - id: methy_label
    type:
      - 'null'
      - int
    doc: "the label of the interested modified bases, this is for training. 0 or 1, default 1"
    inputBinding:
      position: 101
      prefix: --methy_label
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
  - id: write_path
    type: string
    doc: "file path to save the features"
    inputBinding:
      position: 101
      prefix: --write_path
  - id: w_is_dir
    type:
      - 'null'
      - string
    doc: "if using a dir to save features into multiple files"
    inputBinding:
      position: 101
      prefix: --w_is_dir
  - id: w_batch_num
    type:
      - 'null'
      - int
    doc: "features batch num to save in a single writed file when --is_dir is true"
    inputBinding:
      position: 101
      prefix: --w_batch_num
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "if compressing the output using gzip"
    inputBinding:
      position: 101
      prefix: --gzip
  - id: nproc
    type:
      - 'null'
      - int
    doc: "number of processes to be used, default 1"
    inputBinding:
      position: 101
      prefix: --nproc
  - id: f5_batch_size
    type:
      - 'null'
      - int
    doc: "number of files to be processed by each process one time, default 30"
    inputBinding:
      position: 101
      prefix: --f5_batch_size
outputs:
  - id: features
    type:
      - File
      - Directory
    doc: extracted features (a file, or a directory when --w_is_dir is set)
    outputBinding:
      glob: $(inputs.write_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
