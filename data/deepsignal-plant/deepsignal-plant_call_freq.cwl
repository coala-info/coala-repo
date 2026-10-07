cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepsignal_plant
  - call_freq
label: deepsignal-plant_call_freq
doc: "call frequency of modifications at genome level\n\nTool homepage: https://github.com/PengNi/deepsignal-plant"
inputs:
  - id: input_path
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --input_path
    doc: "output files from call_mods/call_modifications.py (the option is in \"append\" mode, used once per file)"
    inputBinding:
      position: 101
  - id: input_dir
    type:
      - 'null'
      - Directory
    doc: "a directory contains a bunch of call_mods output files"
    inputBinding:
      position: 101
      prefix: --input_path
  - id: file_uid
    type:
      - 'null'
      - string
    doc: "a unique str which all input files has, this is for finding all input files and ignoring the not-input-files in a input directory. if input_path is a file, ignore this arg."
    inputBinding:
      position: 101
      prefix: --file_uid
  - id: result_file
    type: string
    doc: "the file path to save the result"
    inputBinding:
      position: 101
      prefix: --result_file
  - id: bed
    type:
      - 'null'
      - boolean
    doc: "save the result in bedMethyl format"
    inputBinding:
      position: 101
      prefix: --bed
  - id: sort
    type:
      - 'null'
      - boolean
    doc: "sort items in the result"
    inputBinding:
      position: 101
      prefix: --sort
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: "if compressing the output using gzip"
    inputBinding:
      position: 101
      prefix: --gzip
  - id: prob_cf
    type:
      - 'null'
      - float
    doc: "this is to remove ambiguous calls. if abs(prob1-prob0)>=prob_cf, then we use the call. e.g., proc_cf=0 means use all calls. range [0, 1], default 0.5."
    inputBinding:
      position: 101
      prefix: --prob_cf
  - id: contigs
    type:
      - 'null'
      - string
    doc: "a reference genome file (.fa/.fasta/.fna), used for extracting all contig names for parallel; or path of a file containing chromosome/contig names, one name each line; or a string contains multiple chromosome names splited by comma.default None, which means all chromosomes will be processed at one time. If not None, one chromosome will be processed by one subprocess."
    inputBinding:
      position: 101
      prefix: --contigs
  - id: contigs_file
    type:
      - 'null'
      - File
    doc: "a reference genome file or a file of contig names (alternative to the contigs string)"
    inputBinding:
      position: 101
      prefix: --contigs
  - id: nproc
    type:
      - 'null'
      - int
    doc: "number of subprocesses used when --contigs is set. i.e., number of contigs processed in parallel. default 1"
    inputBinding:
      position: 101
      prefix: --nproc
outputs:
  - id: result
    type: File
    doc: the modification frequency result
    outputBinding:
      glob: $(inputs.result_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepsignal-plant:0.1.6--pyhdfd78af_0
