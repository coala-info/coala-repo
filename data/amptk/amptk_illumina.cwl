cwlVersion: v1.2
class: CommandLineTool
baseCommand: amptk-process_illumina_folder.py
label: amptk_illumina
doc: "Script that takes De-mulitplexed Illumina data from a folder and processes it
  for amptk (merge PE reads, strip primers, trim/pad to set length.\n\nTool homepage:
  https://github.com/nextgenusfs/amptk"
inputs:
  - id: barcode_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches allowed in index
    default: 1
    inputBinding:
      position: 101
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files
    default: false
    inputBinding:
      position: 101
  - id: cpus
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. Default: auto'
    default: None
    inputBinding:
      position: 101
  - id: full_length
    type:
      - 'null'
      - boolean
    doc: Keep only full length reads (no trimming/padding)
    default: false
    inputBinding:
      position: 101
  - id: fwd_primer
    type:
      - 'null'
      - string
    doc: Forward Primer (fITS7)
    default: fITS7
    inputBinding:
      position: 101
      prefix: --fwd_primer
  - id: input_folder
    type: Directory
    doc: Folder of Illumina Data
    inputBinding:
      position: 101
      prefix: --input
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: 'Mapping file: QIIME format can have extra meta data columns'
    default: None
    inputBinding:
      position: 101
      prefix: --mapping_file
  - id: merge_method
    type:
      - 'null'
      - string
    doc: Software to use for PE read merging
    default: vsearch
    inputBinding:
      position: 101
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum read length to keep
    default: 100
    inputBinding:
      position: 101
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Name for output folder
    default: amptk-illumina
    inputBinding:
      position: 101
      prefix: --out
  - id: pad
    type:
      - 'null'
      - string
    doc: Pad with Ns to a set length
    default: off
    inputBinding:
      position: 101
      prefix: -p
  - id: primer_mismatch
    type:
      - 'null'
      - int
    doc: Number of mis-matches in primer
    default: 2
    inputBinding:
      position: 101
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length, i.e. 2 x 300 bp = 300
    default: None
    inputBinding:
      position: 101
  - id: reads
    type:
      - 'null'
      - string
    doc: PE or forward reads
    default: paired
    inputBinding:
      position: 101
  - id: require_primer
    type:
      - 'null'
      - string
    doc: Require Fwd primer to be present
    default: on
    inputBinding:
      position: 101
  - id: rescue_forward
    type:
      - 'null'
      - string
    doc: Rescue Not-merged forward reads
    default: on
    inputBinding:
      position: 101
  - id: rev_primer
    type:
      - 'null'
      - string
    doc: Reverse Primer (ITS4)
    default: ITS4
    inputBinding:
      position: 101
      prefix: --rev_primer
  - id: sra
    type:
      - 'null'
      - boolean
    doc: Input files are from NCBI SRA not direct from illumina
    default: false
    inputBinding:
      position: 101
  - id: trim_len
    type:
      - 'null'
      - int
    doc: Trim length for reads
    default: 300
    inputBinding:
      position: 101
      prefix: --trim_len
  - id: usearch
    type:
      - 'null'
      - string
    doc: USEARCH executable
    default: usearch9
    inputBinding:
      position: 101
      prefix: --usearch
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
stdout: amptk_illumina.out
