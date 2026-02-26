cwlVersion: v1.2
class: CommandLineTool
baseCommand: HDMI index
label: hdmi_index
doc: "Index a genome for HDMI analysis.\n\nTool homepage: https://github.com/HaoranPeng21/HDMI"
inputs:
  - id: genome_path
    type: Directory
    doc: Directory containing genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome_path
  - id: group_info
    type: File
    doc: Group info file
    inputBinding:
      position: 101
      prefix: --group_info
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for bowtie2-build
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
