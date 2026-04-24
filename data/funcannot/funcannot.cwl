cwlVersion: v1.2
class: CommandLineTool
baseCommand: funcannot
label: funcannot
doc: "Annotates each line of a VCF file to show codon, protein, and mutation for each
  gene given in the genelist\n\nTool homepage: https://github.com/BioTools-Tek/funcannot"
inputs:
  - id: input_vcf_files
    type:
      type: array
      items: File
    doc: VCF file, or list seperated with '+' (NO SPACES)
    inputBinding:
      position: 1
  - id: genemap_file
    type: File
    doc: Genemap for positions of genes/exons
    inputBinding:
      position: 2
  - id: dnamap_file
    type: File
    doc: 'DNA codon map of format: Alu[TAB]AAC,AGC,GCA'
    inputBinding:
      position: 3
  - id: fasta_folder
    type: Directory
    doc: Folder containing FASTA .fa files for each chromosome
    inputBinding:
      position: 4
  - id: geneid_identifier
    type:
      - 'null'
      - string
    doc: specifies common genelist identifier in VCF file(s)
    inputBinding:
      position: 105
      prefix: --geneid
outputs:
  - id: annotated_folder
    type: Directory
    doc: each of the annotated VCF files will be placed here
    outputBinding:
      glob: '*.out'
  - id: rejects_folder
    type: Directory
    doc: each of the corresponding rejects will be placed here
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/funcannot:v2.8--0
