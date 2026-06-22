cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - rename_fasta_entries
label: phykit_rename_fasta_entries
doc: Renames fasta entries based on a tab-delimited identifier map.
inputs:
  - id: fasta
    type: File
    doc: first argument after function name should be a fasta file
    inputBinding:
      position: 1
  - id: idmap
    type:
      - 'null'
      - File
    doc: identifier map of current FASTA names (col1) and desired FASTA names 
      (col2)
    inputBinding:
      position: 102
      prefix: --idmap
  - id: output
    type: string
    doc: optional argument to write the renamed fasta file to. Default output 
      has the same name as the input file with the suffix ".renamed.fa" added to
      it.
    inputBinding:
      position: 102
      prefix: --output
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: optional argument to write the renamed fasta file to. Default output 
      has the same name as the input file with the suffix ".renamed.fa" added to
      it.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
