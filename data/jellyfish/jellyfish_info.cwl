cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jellyfish
  - info
label: jellyfish_info
doc: "Display information about a jellyfish file\n\nTool homepage: http://www.genome.umd.edu/jellyfish.html"
inputs:
  - id: input_file
    type: File
    doc: path to jellyfish file
    inputBinding:
      position: 1
  - id: cmd
    type:
      - 'null'
      - boolean
    doc: Display only the command line
    default: false
    inputBinding:
      position: 102
      prefix: --cmd
  - id: json
    type:
      - 'null'
      - boolean
    doc: Dump full header in JSON format
    default: false
    inputBinding:
      position: 102
      prefix: --json
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Skip header and dump remainder of file
    default: false
    inputBinding:
      position: 102
      prefix: --skip
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/jellyfish:v2.2.10-2-deb_cv1
stdout: jellyfish_info.out
