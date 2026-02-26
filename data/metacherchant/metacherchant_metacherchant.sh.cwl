cwlVersion: v1.2
class: CommandLineTool
baseCommand: metacherchant
label: metacherchant_metacherchant.sh
doc: "genomic environment analysis tool\n\nTool homepage: https://github.com/ctlab/metacherchant"
inputs:
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: continue the previous run from last succeed stage, saved in working 
      directory (optional)
    inputBinding:
      position: 101
      prefix: --continue
  - id: force_run
    type:
      - 'null'
      - boolean
    doc: force run with rewriting old results (optional)
    inputBinding:
      position: 101
      prefix: --force
  - id: k_mer_size
    type: int
    doc: k-mer size (MANDATORY)
    inputBinding:
      position: 101
      prefix: --k
  - id: memory
    type:
      - 'null'
      - string
    doc: 'memory to use (for example: 1500M, 4G, etc.) (optional, default: 2 Gb)'
    default: 2 Gb
    inputBinding:
      position: 101
      prefix: --memory
  - id: sequences_file
    type: File
    doc: FASTA file with sequences (MANDATORY)
    inputBinding:
      position: 101
      prefix: --seq
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: 'working directory (optional, default: workDir)'
    default: workDir
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: output_directory
    type: Directory
    doc: output directory (MANDATORY)
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
