cwlVersion: v1.2
class: CommandLineTool
baseCommand: panaroo-extract-gene
label: panaroo_extract_gene
doc: "Extract fasta files for given gene names from a Panaroo pangenome graph.

Tool homepage: https://gtonkinhill.github.io/panaroo"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.out_dir, "listing": []})'
        writable: true
inputs:
  - id: queries
    type:
      type: array
      items: string
    doc: "A list of gene names to extract."
    inputBinding:
      prefix: --queries
  - id: pa
    type: File
    doc: "The 'gene_presence_absence.csv' file output by Panaroo."
    inputBinding:
      prefix: --pa
  - id: gene
    type: File
    doc: "The 'gene_data.csv' file output by Panaroo."
    inputBinding:
      prefix: --gene
  - id: out_dir
    type: string
    doc: "Location of an output directory."
    inputBinding:
      prefix: --out_dir
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "Output nucleotide sequence instead of protein sequence."
    inputBinding:
      prefix: --dna
  - id: idtype
    type:
      - 'null'
      - string
    doc: "The id type in the output multifasta: 'gene' (default), 'isolate' or 'both'."
    inputBinding:
      prefix: --idtype
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with one fasta file per gene."
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_extract_gene.out
