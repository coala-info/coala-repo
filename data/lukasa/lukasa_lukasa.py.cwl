cwlVersion: v1.2
class: CommandLineTool
baseCommand: lukasa.py
label: lukasa_lukasa.py
doc: "Wrapper to simplify running the lukasa protein evidence mapping workflow on
  the command line\n\nTool homepage: https://github.com/pvanheus/lukasa"
inputs:
  - id: contigs_filename
    type: File
    doc: File with genomic contigs
    inputBinding:
      position: 1
  - id: proteins_filename
    type: File
    doc: File with proteins to map
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug for cwltool
    inputBinding:
      position: 103
      prefix: --debug
  - id: eval
    type:
      - 'null'
      - float
    doc: Maximum E-value for MetaEuk
    inputBinding:
      position: 103
      prefix: --eval
  - id: leave_outputs
    type:
      - 'null'
      - boolean
    doc: Leave intermediate outputs
    inputBinding:
      position: 103
      prefix: --leave_outputs
  - id: max_intron
    type:
      - 'null'
      - int
    doc: Maximum intron length
    inputBinding:
      position: 103
      prefix: --max_intron
  - id: min_coverage
    type:
      - 'null'
      - float
    doc: Minimum proportion of a gene that is exons
    inputBinding:
      position: 103
      prefix: --min_coverage
  - id: min_intron
    type:
      - 'null'
      - int
    doc: Minimum intron length
    inputBinding:
      position: 103
      prefix: --min_intron
  - id: output_filename
    type:
      - 'null'
      - string
    doc: Output filename
    inputBinding:
      position: 103
      prefix: --output_filename
  - id: species_table
    type:
      - 'null'
      - File
    doc: spaln species table to use
    inputBinding:
      position: 103
      prefix: --species_table
  - id: workflow_dir
    type:
      - 'null'
      - Directory
    doc: Workflow directory
    inputBinding:
      position: 103
      prefix: --workflow_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lukasa:0.15.0--py310hdfd78af_0
stdout: lukasa_lukasa.py.out
