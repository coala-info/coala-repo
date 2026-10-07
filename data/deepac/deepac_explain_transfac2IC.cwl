cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - explain
  - transfac2IC
label: deepac_explain_transfac2IC
doc: "Calculate information content from transfac files.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: in_file
    type: File
    doc: "File containing all filter motifs in transfac format"
    inputBinding:
      position: 101
      prefix: --in-file
  - id: train
    type: File
    doc: "Training data set (.npy) to normalize for GC-content"
    inputBinding:
      position: 101
      prefix: --train
  - id: out_file
    type: string
    doc: "Name of the output file"
    default: "motifs_ic.txt"
    inputBinding:
      position: 101
      prefix: --out-file
outputs:
  - id: ic_file
    type: File
    doc: "Information content per filter motif"
    outputBinding:
      glob: $(inputs.out_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
