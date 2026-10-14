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
    type: File
    doc: identifier map of current FASTA names (col1) and desired FASTA names 
      (col2)
    inputBinding:
      position: 102
      prefix: --idmap
  - id: output
    type: string
    doc: name used for the renamed fasta file; the tool adds the suffix 
      ".renamed.fa" to it (so --output x.fa writes x.fa.renamed.fa)
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
    type: File
    doc: renamed fasta file (output name plus the suffix ".renamed.fa")
    outputBinding:
      glob: $(inputs.output).renamed.fa
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
