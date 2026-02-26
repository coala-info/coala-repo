cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesapp abundance
label: treesapp_abundance
doc: "Calculate query sequence abundances from read coverage.\n\nTool homepage: https://github.com/hallamlab/TreeSAPP"
inputs:
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete all intermediate files to save disk space.
    inputBinding:
      position: 101
      prefix: --delete
  - id: metric
    type:
      - 'null'
      - string
    doc: Selects which normalization metric to use, FPKM or TPM.
    default: tpm
    inputBinding:
      position: 101
      prefix: --metric
  - id: num_threads
    type:
      - 'null'
      - int
    doc: The number of CPU threads or parallel processes to use in various 
      pipeline steps
    default: 2
    inputBinding:
      position: 101
      prefix: --num_procs
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrites previously written output files and directories
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: pairing
    type:
      - 'null'
      - string
    doc: Indicating whether the reads are paired-end (pe) or single-end (se).
    default: pe
    inputBinding:
      position: 101
      prefix: --pairing
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file containing to be aligned to predicted genes using BWA MEM
    inputBinding:
      position: 101
      prefix: --reads
  - id: refpkg_dir
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing reference package pickle (.pkl) files.
    default: treesapp/data/
    inputBinding:
      position: 101
      prefix: --refpkg_dir
  - id: report
    type:
      - 'null'
      - string
    doc: What should be done with the abundance values? The TreeSAPP 
      classification table can be overwritten (update), appended or left 
      unchanged.
    default: append
    inputBinding:
      position: 101
      prefix: --report
  - id: reverse
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTQ file containing to reverse mate-pair reads to be aligned using 
      BWA MEM
    inputBinding:
      position: 101
      prefix: --reverse
  - id: stage
    type:
      - 'null'
      - string
    doc: The stage(s) for TreeSAPP to execute
    default: continue
    inputBinding:
      position: 101
      prefix: --stage
  - id: treesapp_output
    type: Directory
    doc: Path to the directory containing TreeSAPP outputs, including sequences 
      to be used for the update.
    inputBinding:
      position: 101
      prefix: --treesapp_output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Prints a more verbose runtime log
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesapp:0.11.4--py39h2de1943_2
stdout: treesapp_abundance.out
