cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract_miRNAs.pl
label: mirdeep2_extract_miRNAs.pl
doc: "Extract the miRNA entries of one or more species (three-letter codes) from a miRBase fasta file; sequences are written in DNA alphabet\n\nTool homepage: https://github.com/rajewsky-lab/mirdeep2"
inputs:
  - id: mirbase_fasta
    type: File
    doc: miRBase fasta file (for example mature.fa)
    inputBinding:
      position: 1
  - id: species
    type: string
    doc: Species code such as cel, or a comma separated list of species codes
    inputBinding:
      position: 2
  - id: type
    type:
      - 'null'
      - string
    doc: "Entry type to extract: mature (default) or star"
    inputBinding:
      position: 3
outputs:
  - id: mirnas
    type: stdout
    doc: Extracted miRNA sequences in fasta format
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: extracted_mirnas.fa
