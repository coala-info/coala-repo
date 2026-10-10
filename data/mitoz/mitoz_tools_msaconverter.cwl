cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mitoz-tools
  - msaconverter
label: mitoz_tools_msaconverter
doc: "Convert a multiple-sequence-alignment into a different format (see https://biopython.org/wiki/AlignIO).\n\nTool homepage: https://github.com/linzhi2013/MitoZ"
inputs:
  - id: input_msa
    type:
      - 'null'
      - File
    doc: "input msa file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_msa
    type: string
    doc: "output msa file"
    inputBinding:
      position: 2
      prefix: -o
  - id: input_format
    type:
      - 'null'
      - string
    doc: "input msa format (fasta, clustal, stockholm, nexus, phylip, phylip-sequential, phylip-relaxed, mauve or maf) [fasta]"
    inputBinding:
      position: 3
      prefix: -p
  - id: output_format
    type:
      - 'null'
      - string
    doc: "output msa format (fasta, clustal, stockholm, nexus, phylip, phylip-sequential, phylip-relaxed, mauve or maf) [phylip-relaxed]"
    inputBinding:
      position: 4
      prefix: -q
  - id: molecule_type
    type:
      - 'null'
      - string
    doc: "Molecule types (DNA, RNA or protein) [DNA]"
    inputBinding:
      position: 5
      prefix: -t
outputs:
  - id: converted_msa
    type: File
    doc: "Converted alignment."
    outputBinding:
      glob: $(inputs.output_msa)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mitoz:3.6--pyhdfd78af_1
