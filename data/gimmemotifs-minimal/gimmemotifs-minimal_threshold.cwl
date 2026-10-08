cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gimme
  - threshold
label: gimmemotifs-minimal_threshold
doc: "Calculate motif scan threshold\n\nTool homepage: https://github.com/vanheeringen-lab/gimmemotifs"
inputs:
  - id: pfmfile
    type: File
    doc: "File with pfms"
    inputBinding:
      position: 100
  - id: fafile
    type: File
    doc: "FASTA file with background sequences"
    inputBinding:
      position: 101
  - id: fpr
    type: float
    doc: "Desired fpr"
    inputBinding:
      position: 102
  - id: output_name
    type: string
    doc: "Name of the file that receives the thresholds (standard output)"
    default: threshold.txt
outputs:
  - id: output
    type: File
    doc: "Motif thresholds"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gimmemotifs-minimal:0.18.1--py39hbcbf7aa_0
stdout: $(inputs.output_name)
