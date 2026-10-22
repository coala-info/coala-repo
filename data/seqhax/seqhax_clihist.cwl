cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - clihist
label: seqhax_clihist
doc: "Records a histogram of stdin: counts how many times each input line occurs.\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_file
    type: File
    doc: Text file read on standard input
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdin: $(inputs.input_file.path)
stdout: seqhax_clihist.out
