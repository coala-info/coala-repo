cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacpage_profile
label: bacpage_profile
doc: "Reconstructs maximum likelihood phylogeny from consensus sequences.\n\nTool
  homepage: https://github.com/CholGen/bacpage"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Path to valid project directory
    default: current directory
    inputBinding:
      position: 1
  - id: configfile
    type:
      - 'null'
      - File
    doc: Path to assembly configuration file
    default: config.yaml
    inputBinding:
      position: 102
      prefix: --configfile
  - id: database
    type:
      - 'null'
      - string
    doc: Database to use for antimicrobial resistance profiling.
    inputBinding:
      position: 102
      prefix: --database
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads available for command
    default: all
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print lots of stuff to screen.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacpage:2025.08.21--pyhdfd78af_0
stdout: bacpage_profile.out
