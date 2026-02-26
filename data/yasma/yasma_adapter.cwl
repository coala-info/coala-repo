cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - adapter
label: yasma_adapter
doc: "Tool to check untrimmed-libraries for 3' adapter content.\n\nTool homepage:
  https://github.com/NateyJay/YASMA"
inputs:
  - id: min_adapter_content
    type:
      - 'null'
      - float
    doc: Min proportion of reads containing the adapter, 0.0 to 1.0.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --min_adapter_content
  - id: num_reads_to_check
    type:
      - 'null'
      - int
    doc: Number of reads to check for adapter
    default: 10000
    inputBinding:
      position: 101
      prefix: -n
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    default: current directory
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: override
    type:
      - 'null'
      - boolean
    doc: Overrides config file changes without prompting.
    inputBinding:
      position: 101
      prefix: --override
  - id: override_pretrim
    type:
      - 'null'
      - boolean
    doc: Ignores flagging a library as pretrimmed if it has variation in read 
      length and detectable adapter sequences.
    inputBinding:
      position: 101
      prefix: --override_pretrim
  - id: untrimmed_libraries
    type: string
    doc: Path to untrimmed libraries. Accepts wildcards (*).
    inputBinding:
      position: 101
      prefix: --untrimmed_libraries
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yasma:1.1.0--pyh7e72e81_0
stdout: yasma_adapter.out
