cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacpage_assemble
label: bacpage_assemble
doc: "Assembles consensus sequence from raw sequencing reads.\n\nTool homepage: https://github.com/CholGen/bacpage"
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
  - id: delim
    type:
      - 'null'
      - string
    doc: deliminator to extract sample name from file name
    default: _
    inputBinding:
      position: 102
      prefix: --delim
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: Perform de novo assembly rather than reference-based assembly.
    inputBinding:
      position: 102
      prefix: --denovo
  - id: index
    type:
      - 'null'
      - int
    doc: index of sample name after splitting file name by delim
    default: 0
    inputBinding:
      position: 102
      prefix: --index
  - id: no_qa
    type:
      - 'null'
      - boolean
    doc: Whether to skip quality assessment of assemblies
    default: false
    inputBinding:
      position: 102
      prefix: --no-qa
  - id: samples
    type:
      - 'null'
      - File
    doc: Path to file detailing raw sequencing reads for all samples
    default: sample_data.csv
    inputBinding:
      position: 102
      prefix: --samples
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads available for assembly
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
stdout: bacpage_assemble.out
