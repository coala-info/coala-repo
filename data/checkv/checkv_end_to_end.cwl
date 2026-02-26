cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkv end_to_end
label: checkv_end_to_end
doc: "Run full pipeline to estimate completeness, contamination, and identify closed
  genomes\n\nTool homepage: https://bitbucket.org/berkeleylab/checkv"
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
      prefix: --reference_database_path
  - id: remove_tmp
    type:
      - 'null'
      - boolean
    doc: Delete intermediate files from the output directory
    inputBinding:
      position: 102
      prefix: --remove_tmp
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
      prefix: -t
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/checkv:1.0.3--pyhdfd78af_0
