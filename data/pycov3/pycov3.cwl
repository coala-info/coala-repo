cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycov3
label: pycov3
doc: "Calculate coverage from SAM files.\n\nTool homepage: https://github.com/Ulthran/pycov3"
inputs:
  - id: fasta_dir
    type: Directory
    doc: the directory containing the binned fasta file(s)
    inputBinding:
      position: 101
      prefix: --fasta_dir
  - id: log_level
    type:
      - 'null'
      - int
    doc: Sets the log level, default is info, 10 for debug
    default: 20
    inputBinding:
      position: 101
      prefix: --log_level
  - id: mapl_cutoff
    type:
      - 'null'
      - int
    doc: cutoff of mapping length when calculating coverages
    default: 50
    inputBinding:
      position: 101
      prefix: --mapl_cutoff
  - id: mapq_cutoff
    type:
      - 'null'
      - int
    doc: cutoff of mapping quality when calculating coverages
    default: 5
    inputBinding:
      position: 101
      prefix: --mapq_cutoff
  - id: max_mismatch_ratio
    type:
      - 'null'
      - float
    doc: maximum of mismatch ratio for each read as a hit
    default: 0.03
    inputBinding:
      position: 101
      prefix: --max_mismatch_ratio
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: overwrites any existing outputs
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: sam_dir
    type: Directory
    doc: the directory containing the sam file(s)
    inputBinding:
      position: 101
      prefix: --sam_dir
  - id: thread_num
    type:
      - 'null'
      - int
    doc: set number of threads for parallel running
    default: 1
    inputBinding:
      position: 101
      prefix: --thread_num
  - id: window_size
    type:
      - 'null'
      - int
    doc: size (nt) of window for calculation of coverage
    default: 5000
    inputBinding:
      position: 101
      prefix: --window_size
  - id: window_step
    type:
      - 'null'
      - int
    doc: step (nt) of window for calculation of coverage
    default: 100
    inputBinding:
      position: 101
      prefix: --window_step
outputs:
  - id: out_dir
    type: Directory
    doc: the output directory
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycov3:2.1.1--pyh7e72e81_0
