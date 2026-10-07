cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ccphylo
  - union
label: ccphylo_union
doc: "CCPhylo union finds the union between templates in res files created by e.g.
  KMA.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: create_reference_fasta_file
    type:
      - 'null'
      - string
    doc: Create a reference FASTA file with this name (needs --database)
    inputBinding:
      position: 101
      prefix: --reference_file
  - id: input_files
    type:
      type: array
      items: File
    doc: Input file(s)
    inputBinding:
      position: 101
      prefix: --input
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Minimum coverage
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum overlapping length
    inputBinding:
      position: 101
      prefix: --min_len
  - id: print_ordered_wrt_template_db_filename
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: ^.length.b
        required: false
      - pattern: ^.seq.b
        required: false
    doc: KMA template database .name file; output is ordered by this database
    inputBinding:
      position: 101
      prefix: --database
      valueFrom: $(self.path.replace(/\.name$/, ''))
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: Reference FASTA file
    outputBinding:
      glob: $(inputs.create_reference_fasta_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
