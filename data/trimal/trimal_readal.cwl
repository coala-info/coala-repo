cwlVersion: v1.2
class: CommandLineTool
baseCommand: readal
label: trimal_readal
doc: "Convert alignment formats and report basic information about sequence files (readAl, part of trimAl).\n\nTool homepage: https://trimal.readthedocs.io"
inputs:
  - id: input_file
    type: File
    doc: "Input file in several formats."
    inputBinding:
      position: 1
      prefix: -in
  - id: output_file
    type:
      - 'null'
      - string
    doc: "Output file name (default STDOUT)."
    inputBinding:
      position: 1
      prefix: -out
  - id: format_info
    type:
      - 'null'
      - boolean
    doc: "Print information about input file format and if sequences are aligned or not."
    inputBinding:
      position: 2
      prefix: -format
  - id: type_info
    type:
      - 'null'
      - boolean
    doc: "Print information about biological sequences datatype (nucleotides:dna, nucleotides:rna, aminoacids, ...)"
    inputBinding:
      position: 2
      prefix: -type
  - id: info
    type:
      - 'null'
      - boolean
    doc: "Print information about sequences number, average sequence length, max and min sequence length"
    inputBinding:
      position: 2
      prefix: -info
  - id: onlyseqs
    type:
      - 'null'
      - boolean
    doc: "Generate output with only residues from input file"
    inputBinding:
      position: 2
      prefix: -onlyseqs
  - id: html
    type:
      - 'null'
      - boolean
    doc: "Output residues colored according their physicochemical properties. HTML file."
    inputBinding:
      position: 2
      prefix: -html
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: "Output the reverse of sequences in input file."
    inputBinding:
      position: 2
      prefix: -reverse
  - id: nbrf
    type:
      - 'null'
      - boolean
    doc: "Output file in NBRF/PIR format"
    inputBinding:
      position: 2
      prefix: -nbrf
  - id: mega
    type:
      - 'null'
      - boolean
    doc: "Output file in MEGA format"
    inputBinding:
      position: 2
      prefix: -mega
  - id: nexus
    type:
      - 'null'
      - boolean
    doc: "Output file in NEXUS format"
    inputBinding:
      position: 2
      prefix: -nexus
  - id: clustal
    type:
      - 'null'
      - boolean
    doc: "Output file in CLUSTAL format"
    inputBinding:
      position: 2
      prefix: -clustal
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Output file in FASTA format"
    inputBinding:
      position: 2
      prefix: -fasta
  - id: fasta_m10
    type:
      - 'null'
      - boolean
    doc: "Output file in FASTA format. Sequences name up to 10 characters."
    inputBinding:
      position: 2
      prefix: -fasta_m10
  - id: phylip
    type:
      - 'null'
      - boolean
    doc: "Output file in PHYLIP/PHYLIP4 format"
    inputBinding:
      position: 2
      prefix: -phylip
  - id: phylip_m10
    type:
      - 'null'
      - boolean
    doc: "Output file in PHYLIP/PHYLIP4 format. Sequences name up to 10 characters."
    inputBinding:
      position: 2
      prefix: -phylip_m10
  - id: phylip_paml
    type:
      - 'null'
      - boolean
    doc: "Output file in PHYLIP format compatible with PAML"
    inputBinding:
      position: 2
      prefix: -phylip_paml
  - id: phylip_paml_m10
    type:
      - 'null'
      - boolean
    doc: "Output file in PHYLIP format compatible with PAML. Sequences name up to 10 characters."
    inputBinding:
      position: 2
      prefix: -phylip_paml_m10
  - id: phylip32
    type:
      - 'null'
      - boolean
    doc: "Output file in PHYLIP3.2 format"
    inputBinding:
      position: 2
      prefix: -phylip3.2
  - id: phylip32_m10
    type:
      - 'null'
      - boolean
    doc: "Output file in PHYLIP3.2 format. Sequences name up to 10 characters."
    inputBinding:
      position: 2
      prefix: -phylip3.2_m10
outputs:
  - id: stdout
    type: stdout
    doc: "Converted alignment or information printed to the console"
  - id: output
    type:
      - 'null'
      - File
    doc: "Output file written with -out"
    outputBinding:
      glob: $(inputs.output_file)
stdout: trimal_readal.out
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trimal:1.5.1--h9948957_0
