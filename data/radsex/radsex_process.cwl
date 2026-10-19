cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - radsex
  - process
label: radsex_process
doc: "Computes a table of marker depths from a set of demultiplexed reads files.\n\
  \nTool homepage: https://github.com/SexGenomicsToolkit/radsex"
inputs:
  - id: input_dir
    type: Directory
    doc: Path to a directory contains demultiplexed sequence files
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 1)
    inputBinding:
      position: 101
      prefix: --threads
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to consider a marker present in an individual (default 1)
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: output_file_path
    type: string
    doc: Path to the output file (table of marker depths in each individual)
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Path to the output file (table of marker depths in each individual)
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radsex:1.2.0--h43eeafb_3
