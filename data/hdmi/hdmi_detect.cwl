cwlVersion: v1.2
class: CommandLineTool
baseCommand: hdmi_detect
label: hdmi_detect
doc: "Directory containing genome FASTA files\n\nTool homepage: https://github.com/HaoranPeng21/HDMI"
inputs:
  - id: count_only
    type:
      - 'null'
      - boolean
    doc: Only count genome pairs and estimate performance without running 
      detection
    inputBinding:
      position: 101
      prefix: --count-only
  - id: genome_path
    type: Directory
    doc: Directory containing genome FASTA files
    inputBinding:
      position: 101
      prefix: --genome_path
  - id: group_info
    type: File
    doc: Group info file (Group_info_test.txt format)
    inputBinding:
      position: 101
      prefix: --group_info
  - id: task_number
    type:
      - 'null'
      - int
    doc: Task number for parallel processing (1-indexed)
    default: 1
    inputBinding:
      position: 101
      prefix: --task_number
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: total_tasks
    type:
      - 'null'
      - int
    doc: Total number of parallel tasks
    default: 1
    inputBinding:
      position: 101
      prefix: --total_tasks
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory for detection results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdmi:1.0.0--pyhdfd78af_0
