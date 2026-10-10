cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfa1tofasta.py
label: mtglink_gfa1tofasta.py
doc: "Convert a GFA file (GFA 1.0) to a FASTA file (gaps are returned as 'N's regions).\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: gfa
    type: File
    doc: "GFA 1.0 file (format: xxx.gfa)"
    inputBinding:
      prefix: "-in"
  - id: out_dir
    type: string
    doc: "Directory to save the output FASTA file"
    inputBinding:
      prefix: "-out"
outputs:
  - id: out_directory
    type: Directory
    doc: Directory with the output FASTA file
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
