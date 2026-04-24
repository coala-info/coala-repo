cwlVersion: v1.2
class: CommandLineTool
baseCommand: kleborate
label: kleborate
doc: "Kleborate: a tool for characterising virulence and resistance in pathogen assemblies\n\
  \nTool homepage: https://github.com/katholt/Kleborate"
inputs:
  - id: assemblies
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA file(s) for assemblies
    inputBinding:
      position: 101
      prefix: --assemblies
  - id: list_modules
    type:
      - 'null'
      - boolean
    doc: Print a list of all available modules and then quit
    inputBinding:
      position: 101
      prefix: --list_modules
  - id: modules
    type:
      - 'null'
      - string
    doc: Comma-delimited list of Kleborate modules to use
    inputBinding:
      position: 101
      prefix: --modules
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory for storing output files
    inputBinding:
      position: 101
      prefix: --outdir
  - id: preset
    type:
      - 'null'
      - string
    doc: 'Module presets, choose from: kpsc, kosc, escherichia'
    inputBinding:
      position: 101
      prefix: --preset
  - id: resume
    type:
      - 'null'
      - boolean
    doc: append the output files
    inputBinding:
      position: 101
      prefix: --resume
  - id: trim_headers
    type:
      - 'null'
      - boolean
    doc: Trim headers in the output files
    inputBinding:
      position: 101
      prefix: --trim_headers
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kleborate:3.2.4--pyhdfd78af_0
stdout: kleborate.out
