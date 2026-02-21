cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwa
  - bwtupdate
label: bwa-aln-interactive_bwtupdate
doc: "Update or regenerate the BWT (Burrows-Wheeler Transform) file.\n\nTool homepage:
  https://github.com/fulcrumgenomics/bwa-aln-interactive"
inputs:
  - id: bwt_file
    type: File
    doc: The BWT file to update
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bwa-aln-interactive:0.7.18--h577a1d6_2
stdout: bwa-aln-interactive_bwtupdate.out
