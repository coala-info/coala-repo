cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-fafrag
label: ucsc-fafrag
doc: "Extracts a fragment from a FASTA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: region
    type: string
    doc: Region to extract (e.g., chr1:100-200)
    inputBinding:
      position: 2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name [stdout]
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fafrag:482--h0b57e2e_0
