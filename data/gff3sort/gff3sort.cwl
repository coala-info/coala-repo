cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3sort.pl
label: gff3sort
doc: "Sort a GFF3 file for tabix indexing. Parent features are placed before their
  children at the same chromosome and start position.\n\nTool homepage:
  https://github.com/billzt/gff3sort"
inputs:
  - id: input_file
    type: File
    doc: Input GFF3 file to be sorted
    inputBinding:
      position: 1
  - id: chr_order
    type:
      - 'null'
      - string
    doc: "Select how the chromosome IDs should be sorted. Acceptable values are: alphabet, natural, original [Default: alphabet]"
    inputBinding:
      position: 102
      prefix: --chr_order
  - id: extract_fasta
    type:
      - 'null'
      - boolean
    doc: If the input GFF3 file contains FASTA sequence at the end, extract it
      and place it in a separate file with the extension '.fasta'. By default,
      the FASTA sequences are discarded.
    inputBinding:
      position: 102
      prefix: --extract_FASTA
  - id: precise
    type:
      - 'null'
      - boolean
    doc: Run in precise mode, about 2X~3X slower than the default mode. Only
      needed if the original GFF3 file has parent features appearing behind
      their children features.
    inputBinding:
      position: 102
      prefix: --precise
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
outputs:
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: FASTA sequences extracted from the input, written with extract_fasta.
    outputBinding:
      glob: $(inputs.input_file.basename).fasta
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3sort:0.1.a1a2bc9--pl526_0
stdout: gff3sort.out
