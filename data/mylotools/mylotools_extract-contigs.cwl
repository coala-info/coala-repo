cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mylotools
  - extract-contigs
label: mylotools_extract-contigs
doc: "Extract contigs based on minimum length from a Myloasm fasta file.\n\nTool homepage:
  https://github.com/bluenote-1577/mylotools"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: Myloasm fasta file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Minimum contig length to extract
    inputBinding:
      position: 101
      prefix: --min-contig-length
  - id: output_folder
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --output-folder
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mylotools:2.0.0--pyh7e72e81_0
stdout: mylotools_extract-contigs.out
