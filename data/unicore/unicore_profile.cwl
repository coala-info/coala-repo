cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - profile
label: unicore_profile
doc: "Create core structures from Foldseek database\n\nTool homepage: https://github.com/steineggerlab/unicore"
inputs:
  - id: input_db
    type: File
    doc: Input database (createdb output)
    inputBinding:
      position: 1
  - id: input_tsv
    type: File
    doc: Input tsv file (cluster or search output)
    inputBinding:
      position: 2
  - id: output_directory
    type: Directory
    doc: Output directory
    inputBinding:
      position: 3
  - id: print_copiness
    type:
      - 'null'
      - boolean
    doc: Generate tsv with copy number statistics
    inputBinding:
      position: 104
      prefix: --print-copiness
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use; 0 to use all
    default: 0
    inputBinding:
      position: 104
      prefix: --threads
  - id: threshold
    type:
      - 'null'
      - int
    doc: Coverage threshold for core structures. [0 - 100]
    default: 80
    inputBinding:
      position: 104
      prefix: --threshold
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug)'
    default: 3
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore_profile.out
