cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtools
  - maskfasta
label: bedtools_maskfasta
doc: Mask a fasta file based on feature coordinates.
inputs:
  - id: bed_file
    type: File
    doc: BED/GFF/VCF file of ranges to mask in -fi
    inputBinding:
      position: 101
      prefix: -bed
  - id: fasta_input
    type:
      - 'null'
      - File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: -fi
  - id: fasta_output
    type: string
    doc: Output FASTA file
    inputBinding:
      position: 101
      prefix: -fo
  - id: full_header
    type:
      - 'null'
      - boolean
    doc: Use full fasta header. By default, only the word before the first space
      or tab is used.
    inputBinding:
      position: 101
      prefix: -fullHeader
  - id: masking_character
    type:
      - 'null'
      - string
    doc: Replace masking character. Use another character, instead of masking 
      with Ns.
    inputBinding:
      position: 101
      prefix: -mc
  - id: soft_masking
    type:
      - 'null'
      - boolean
    doc: Enforce "soft" masking. Mask with lower-case bases, instead of masking 
      with Ns.
    inputBinding:
      position: 101
      prefix: -soft
outputs:
  - id: output_fasta_output
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: $(inputs.fasta_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtools:2.31.1--h13024bc_3
s:url: http://bedtools.readthedocs.org/
$namespaces:
  s: https://schema.org/
