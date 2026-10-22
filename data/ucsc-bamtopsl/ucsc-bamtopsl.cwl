cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamToPsl
label: ucsc-bamtopsl
doc: "Convert a bam file to a psl and optionally also a fasta file that contains the\
  \ reads.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: in_bam
    type: File
    doc: Input BAM file (a SAM file also works)
    inputBinding:
      position: 11
  - id: out_psl_path
    type: string
    doc: Name of the output PSL file
    inputBinding:
      position: 12
  - id: fasta_path
    type:
      - 'null'
      - string
    doc: Output query sequences to the specified file
    inputBinding:
      position: 1
      prefix: -fasta=
      separate: false
  - id: chrom_alias
    type:
      - 'null'
      - File
    doc: 'Specifies a two-column file: 1: alias, 2: other name, for target name
      translation from column 1 name to column 2 name; names not found are passed
      through intact'
    inputBinding:
      position: 2
      prefix: -chromAlias=
      separate: false
  - id: no_head
    type:
      - 'null'
      - boolean
    doc: Do not output the PSL header, default has header output
    inputBinding:
      position: 3
      prefix: -nohead
  - id: dots
    type:
      - 'null'
      - int
    doc: Output progress dot(.) every N alignments processed
    inputBinding:
      position: 4
      prefix: -dots=
      separate: false
outputs:
  - id: out_psl
    type: File
    doc: Output PSL file
    outputBinding:
      glob: $(inputs.out_psl_path)
  - id: out_fasta
    type:
      - 'null'
      - File
    doc: Output query sequences in FASTA format
    outputBinding:
      glob: $(inputs.fasta_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bamtopsl:482--h0b57e2e_0
