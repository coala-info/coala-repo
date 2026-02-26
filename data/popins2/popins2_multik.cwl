cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - popins2
  - multik
label: popins2_multik
doc: "Multi-k framework for a colored and compacted de Bruijn Graph (CCDBG)\n\nTool
  homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: delta_k
    type:
      - 'null'
      - int
    doc: Step size to increase k
    default: 20
    inputBinding:
      position: 101
      prefix: --delta-k
  - id: k_init
    type:
      - 'null'
      - int
    doc: Initial kmer length to start the multi-k iteration
    default: 27
    inputBinding:
      position: 101
      prefix: --k-init
  - id: k_max
    type:
      - 'null'
      - int
    doc: Maximal kmer length to build a dBG with
    default: 127
    inputBinding:
      position: 101
      prefix: --k-max
  - id: outputfile_prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix for the output files
    default: ccdbg
    inputBinding:
      position: 101
      prefix: --outputfile-prefix
  - id: sample_path
    type: Directory
    doc: Source directory with FASTA/Q files
    inputBinding:
      position: 101
      prefix: --sample-path
  - id: temp_path
    type:
      - 'null'
      - Directory
    doc: Auxiliary directory for temporary files.
    default: auxMultik
    inputBinding:
      position: 101
      prefix: --temp-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_multik.out
