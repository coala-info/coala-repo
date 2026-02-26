cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - umis
  - subset_bamfile
label: umis_subset_bamfile
doc: "Subset a SAM/BAM file, keeping only alignments from given cellular barcodes\n\
  \nTool homepage: https://github.com/vals/umis"
inputs:
  - id: sam_barcodes
    type: File
    doc: SAM/BAM file
    inputBinding:
      position: 1
  - id: barcodes
    type: File
    doc: File containing cellular barcodes
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/umis:1.0.9--py310h1fe012e_5
stdout: umis_subset_bamfile.out
