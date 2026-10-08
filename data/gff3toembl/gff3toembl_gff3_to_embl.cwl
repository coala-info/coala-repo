cwlVersion: v1.2
class: CommandLineTool
baseCommand: gff3_to_embl
label: gff3toembl_gff3_to_embl
doc: "Converts prokaryote GFF3 annotations to EMBL for ENA submission. Cite http://dx.doi.org/10.21105/joss.00080\n\
  \nTool homepage: https://github.com/sanger-pathogens/gff3toembl/"
inputs:
  - id: organism
    type: string
    doc: Organism
    inputBinding:
      position: 1
  - id: taxonid
    type: int
    doc: Taxon id
    inputBinding:
      position: 2
  - id: project_accession
    type: string
    doc: Accession number for the project
    inputBinding:
      position: 3
  - id: description
    type: string
    doc: Genus species subspecies strain of organism
    inputBinding:
      position: 4
  - id: file
    type: File
    doc: GFF3 filename
    inputBinding:
      position: 5
  - id: authors
    type:
      - 'null'
      - string
    doc: Authors (in the EMBL RA line style)
    inputBinding:
      position: 106
      prefix: --authors
  - id: chromosome_list
    type:
      - 'null'
      - string
    doc: Create a chromosome list file, and use the supplied name
    inputBinding:
      position: 106
      prefix: --chromosome_list
  - id: classification
    type:
      - 'null'
      - string
    doc: Classification (PROK/UNC/..)
    inputBinding:
      position: 106
      prefix: --classification
  - id: genome_type
    type:
      - 'null'
      - string
    doc: Genome type (linear/circular)
    inputBinding:
      position: 106
      prefix: --genome_type
  - id: locus_tag
    type:
      - 'null'
      - string
    doc: Overwrite the locus tag in the annotation file
    inputBinding:
      position: 106
      prefix: --locus_tag
  - id: publication
    type:
      - 'null'
      - string
    doc: Publication or journal name (in the EMBL RL line style)
    inputBinding:
      position: 106
      prefix: --publication
  - id: title
    type:
      - 'null'
      - string
    doc: Title of paper (in the EMBL RT line style)
    inputBinding:
      position: 106
      prefix: --title
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table
    inputBinding:
      position: 106
      prefix: --translation_table
  - id: output_filename_path
    type: string
    default: output.embl
    doc: Output filename
    inputBinding:
      position: 107
      prefix: --output_filename
outputs:
  - id: chromosome_list_file
    type:
      - 'null'
      - File
    doc: Chromosome list file, written when chromosome_list is given.
    outputBinding:
      glob: $(inputs.chromosome_list)
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gff3toembl:1.1.4--pyh864c0ab_2
