cwlVersion: v1.2
class: CommandLineTool
baseCommand: mira
label: mira
doc: "A multi-pass sequencing data assembler or mapper for small genomes and\nEST/RNASeq
  projects.\n\nTool homepage: https://github.com/DrMicrobit/mira"
inputs:
  - id: manifest_files
    type:
      type: array
      items: File
    doc: Manifest file(s) to process
    inputBinding:
      position: 1
  - id: change_working_directory
    type:
      - 'null'
      - Directory
    doc: Change working directory
    inputBinding:
      position: 102
      prefix: --cwd
  - id: check_manifest_and_data
    type:
      - 'null'
      - boolean
    doc: Like -m, but also check existence of data files.
    inputBinding:
      position: 102
      prefix: --mdcheck
  - id: check_manifest_only
    type:
      - 'null'
      - boolean
    doc: Only check the manifest file, then exit.
    inputBinding:
      position: 102
      prefix: --mcheck
  - id: resume_assembly
    type:
      - 'null'
      - boolean
    doc: Resume/restart an interrupted assembly
    inputBinding:
      position: 102
      prefix: --resume
  - id: threads
    type:
      - 'null'
      - int
    doc: Force number of threads (overrides equivalent -GE:not manifest entry)
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mira:5.0.0rc2--hb5a7bbe_0
stdout: mira.out
