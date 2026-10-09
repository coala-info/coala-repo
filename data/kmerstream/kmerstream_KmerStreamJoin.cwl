cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerStreamJoin
label: kmerstream_KmerStreamJoin
doc: "Creates union of many stream estimates\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs:
  - id: output_path
    type: ['null', string]
    doc: "Filename for output (the merged sketch)"
    inputBinding:
      position: 1
      prefix: "--output"
  - id: verbose
    type: ['null', boolean]
    doc: "Print output at the end"
    inputBinding:
      position: 1
      prefix: "--verbose"
  - id: files
    type:
      type: array
      items: File
    doc: "KmerStream binary sketch files (_Q_<q>_k_<k>) to join, or one merged file to print"
    inputBinding:
      position: 50
outputs:
  - id: output
    type: ['null', File]
    doc: "Merged sketch written with --output"
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
stdout: kmerstream_join.out
