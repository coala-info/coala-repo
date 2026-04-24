cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - yasma
  - trim
label: yasma_trim
doc: "Wrapper for trimming using cutadapt.\n\nTool homepage: https://github.com/NateyJay/YASMA"
inputs:
  - id: adapter
    type:
      - 'null'
      - string
    doc: Adapter sequence which is meant to be trimmed.
    inputBinding:
      position: 101
      prefix: --adapter
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Removes download and untrimmed data to save space
    inputBinding:
      position: 101
      prefix: --cleanup
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use. 0 has cutadapt "autodetect" the number of 
      cores
    inputBinding:
      position: 101
      prefix: --cores
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maxiumum allowed size for a trimmed read.
    inputBinding:
      position: 101
      prefix: --max_length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum allowed size for a trimmed read.
    inputBinding:
      position: 101
      prefix: --min_length
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory name for annotation output. Defaults to the current 
      directory, with this directory name as the project name.
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: untrimmed_libraries
    type:
      - 'null'
      - type: array
        items: string
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
stdout: yasma_trim.out
