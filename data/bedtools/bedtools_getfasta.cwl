cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - getfasta
label: bedtools_getfasta
doc: Extract DNA sequences from a fasta file based on feature coordinates.
inputs:
  - id: bed
    type: File
    doc: BED/GFF/VCF file of ranges to extract from -fi
    inputBinding:
      position: 101
      prefix: -bed
  - id: bed_out
    type:
      - 'null'
      - boolean
    doc: Report extract sequences in a tab-delimited BED format instead of in 
      FASTA format.
    inputBinding:
      position: 101
      prefix: -bedOut
  - id: fasta
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -fi
  - id: force_strandedness
    type:
      - 'null'
      - boolean
    doc: Force strandedness. If the feature occupies the antisense, strand, the 
      sequence will be reverse complemented.
    inputBinding:
      position: 101
      prefix: -s
  - id: full_header
    type:
      - 'null'
      - boolean
    doc: Use full fasta header.
    inputBinding:
      position: 101
      prefix: -fullHeader
  - id: name
    type:
      - 'null'
      - boolean
    doc: Use the name field and coordinates for the FASTA header
    inputBinding:
      position: 101
      prefix: -name
  - id: name_only
    type:
      - 'null'
      - boolean
    doc: Use the name field for the FASTA header
    inputBinding:
      position: 101
      prefix: -nameOnly
  - id: name_plus
    type:
      - 'null'
      - boolean
    doc: (deprecated) Use the name field and coordinates for the FASTA header
    inputBinding:
      position: 101
      prefix: -name+
  - id: output
    type: string
    doc: Output file (opt., default is STDOUT)
    inputBinding:
      position: 101
      prefix: -fo
  - id: rna
    type:
      - 'null'
      - boolean
    doc: The FASTA is RNA not DNA. Reverse complementation handled accordingly.
    inputBinding:
      position: 101
      prefix: -rna
  - id: split
    type:
      - 'null'
      - boolean
    doc: Given BED12 fmt., extract and concatenate the sequences from the BED 
      "blocks" (e.g., exons)
    inputBinding:
      position: 101
      prefix: -split
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Write output in TAB delimited format.
    inputBinding:
      position: 101
      prefix: -tab
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output file (opt., default is STDOUT)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
