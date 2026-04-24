cwlVersion: v1.2
class: CommandLineTool
baseCommand: tag pep2nuc
label: tag_pep2nuc
doc: "Converts protein-coordinate GFF3 features to their corresponding nucleotide
  coordinates in a genome-coordinate GFF3 file.\n\nTool homepage: https://github.com/standage/tag/"
inputs:
  - id: genome
    type: File
    doc: GFF3 file with CDS/protein features on a genomic coordinate system.
    inputBinding:
      position: 1
  - id: protein
    type: File
    doc: GFF3 file with features on a protein coordinate system.
    inputBinding:
      position: 2
  - id: attr
    type:
      - 'null'
      - string
    doc: CDS/protein attribute in the genome GFF3 file that corresponds to the 
      protein identifier (column 1) of the protein GFF3 file.
    inputBinding:
      position: 103
      prefix: --attr
  - id: keep_prot
    type:
      - 'null'
      - string
    doc: Keep the original protein ID and write it to the specified attribute in
      the output.
    inputBinding:
      position: 103
      prefix: --keep-prot
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to which output will be written; by default, output is written to 
      the terminal (stdout).
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tag:0.5.1--py_0
