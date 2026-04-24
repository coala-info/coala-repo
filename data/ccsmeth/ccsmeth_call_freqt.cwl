cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth call_freqt
label: ccsmeth_call_freqt
doc: "call frequency of modifications at genome level from per_readsite text files\n\
  \nTool homepage: https://github.com/PengNi/ccsmeth"
inputs:
  - id: bed
    type:
      - 'null'
      - boolean
    doc: save the result in bedMethyl format
    inputBinding:
      position: 101
      prefix: --bed
  - id: contigs
    type:
      - 'null'
      - File
    doc: a reference genome file (.fa/.fasta/.fna), used for extracting all 
      contig names for parallel; or path of a file containing chromosome/contig 
      names, one name each line; or a string contains multiple chromosome names 
      splited by comma.default None, which means all chromosomes will be 
      processed at one time. If not None, one chromosome will be processed by 
      one subprocess.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: file_uid
    type:
      - 'null'
      - string
    doc: a unique str which all input files has, this is for finding all input 
      files and ignoring the not-input-files in a input directory. if input_path
      is a file, ignore this arg.
    inputBinding:
      position: 101
      prefix: --file_uid
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: if compressing the output using gzip
    inputBinding:
      position: 101
      prefix: --gzip
  - id: input_path
    type:
      type: array
      items: File
    doc: an output file from call_mods/call_modifications.py, or a directory 
      contains a bunch of output files. this arg is in "append" mode, can be 
      used multiple times
    inputBinding:
      position: 101
      prefix: --input_path
  - id: mod_loc
    type:
      - 'null'
      - int
    doc: 0-based location of the targeted base in the motif, default 0. [Only 
      useful when --refsites_only is True]
    inputBinding:
      position: 101
      prefix: --mod_loc
  - id: motifs
    type:
      - 'null'
      - string
    doc: 'motif seq to be extracted, default: CG. can be multi motifs splited by comma
      (no space allowed in the input str), or use IUPAC alphabet, the mod_loc of all
      motifs must be the same. [Only useful when --refsites_only is True]'
    inputBinding:
      position: 101
      prefix: --motifs
  - id: prob_cf
    type:
      - 'null'
      - float
    doc: this is to remove ambiguous calls. if abs(prob1-prob0)>=prob_cf, then 
      we use the call. e.g., proc_cf=0 means use all calls. range [0, 1], 
      default 0.0.
    inputBinding:
      position: 101
      prefix: --prob_cf
  - id: ref
    type:
      - 'null'
      - File
    doc: path to genome reference, in fasta/fa format. [Only useful when 
      --refsites_only is True]
    inputBinding:
      position: 101
      prefix: --ref
  - id: refsites_only
    type:
      - 'null'
      - boolean
    doc: only keep sites which are target motifs in both reference and reads
    inputBinding:
      position: 101
      prefix: --refsites_only
  - id: rm_1strand
    type:
      - 'null'
      - boolean
    doc: abandon ccs reads with only 1 strand subreads [DEPRECATED]
    inputBinding:
      position: 101
      prefix: --rm_1strand
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort items in the result
    inputBinding:
      position: 101
      prefix: --sort
  - id: threads
    type:
      - 'null'
      - int
    doc: number of subprocesses used when --contigs is set. i.e., number of 
      contigs processed in parallel. default 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: result_file
    type: File
    doc: the file path to save the result
    outputBinding:
      glob: $(inputs.result_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
