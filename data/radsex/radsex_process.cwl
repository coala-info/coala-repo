cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - radsex
  - process
label: radsex_process
doc: "Process raw fastq files and generate a table of marker depths.\n\nTool homepage:
  https://github.com/RomainFeron/RadSex"
inputs:
  - id: groups_file
    type: File
    doc: File describing groups for each individual
    inputBinding:
      position: 101
      prefix: --groups-file
  - id: input_dir
    type: Directory
    doc: Directory containing fastq files
    inputBinding:
      position: 101
      prefix: --input-dir
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth to consider a marker
    default: 1
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Output table file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/radsex:1.2.0--h43eeafb_3
