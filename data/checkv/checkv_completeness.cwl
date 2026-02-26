cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv_completeness
label: checkv_completeness
doc: "Estimate completeness for genome fragments\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
inputs:
  - id: input
    type: File
    doc: Input nucleotide sequences in FASTA format (.gz, .bz2 and .xz files are
      supported)
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress logging messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reference_database_path
    type:
      - 'null'
      - Directory
    doc: Reference database path. By default the CHECKVDB environment variable 
      is used
    inputBinding:
      position: 102
      prefix: --reference-database-path
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Overwrite existing intermediate files. By default CheckV continues 
      where program left off
    inputBinding:
      position: 102
      prefix: --restart
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for prodigal-gv and DIAMOND
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
