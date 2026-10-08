cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - extract_species_contigs.py
label: desman_extract_species_contigs.py
doc: "Print the FASTA records of an assembly whose identifiers are listed in a
  contig list file (one identifier per line).\n\nTool homepage: https://github.com/chrisquince/DESMAN"
inputs:
  - id: assembly
    type: File
    doc: Assembly FASTA file
    inputBinding:
      position: 1
  - id: contig_list
    type: File
    doc: File with the contig identifiers to extract, one per line
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name of the file that receives the selected contigs written to stdout
    default: selected_contigs.fa
outputs:
  - id: selected_contigs
    type: File
    doc: Selected contigs (FASTA)
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/desman:2.1--py39h4747326_10
