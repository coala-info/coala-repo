cwlVersion: v1.2
class: CommandLineTool
baseCommand: pipits_funits
label: pipits_pipits_funits
doc: "PIPITS_FUNITS v4.0: Extract ITS1 or ITS2 regions.\n\nTool homepage: https://github.com/hsgweon/pipits"
inputs:
  - id: input_file
    type: File
    doc: Input FASTA file (e.g., from pipits_prep).
    inputBinding:
      position: 101
      prefix: -i
  - id: itsx_processes
    type:
      - 'null'
      - int
    doc: Number of parallel ITSx *processes* to run
    inputBinding:
      position: 101
      prefix: -t
  - id: itsx_threads
    type:
      - 'null'
      - int
    doc: Number of threads *per* ITSx process. Total threads used = -t * 
      --itsx-threads.
    inputBinding:
      position: 101
      prefix: --itsx-threads
  - id: retain_intermediate_files
    type:
      - 'null'
      - boolean
    doc: Retain intermediate files.
    inputBinding:
      position: 101
      prefix: -r
  - id: subregion
    type: string
    doc: Subregion (ITS1 or ITS2).
    inputBinding:
      position: 101
      prefix: -x
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (more detailed logging).
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_dir
    type: Directory
    doc: Directory to output results.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pipits:4.0--pyhdfd78af_0
