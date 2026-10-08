cwlVersion: v1.2
class: CommandLineTool
baseCommand: tama_orf_seeker.py
label: gs-tama_tama_orf_seeker.py
doc: "This script finds open reading frames from transcript sequences\n\nTool homepage: https://github.com/sguizard/gs-tama"
inputs:
  - id: fasta_file
    type: File
    doc: Fasta file (required)
    inputBinding:
      position: 101
      prefix: -f
  - id: output_file_name
    type: string
    doc: Output file name (required)
    inputBinding:
      position: 101
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type: File
    doc: Fasta file of the open reading frames found
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gs-tama:1.0.3--hdfd78af_0
stdout: gs-tama_tama_orf_seeker.py.out
