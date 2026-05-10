cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastutils
  - cutN
label: fastutils_cutN
doc: "Cut Ns from fastx sequences\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: input_file
    type: File
    doc: input file in fastx format. Use - for stdin.
    inputBinding:
      position: 101
      prefix: -i
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: output file in fasta format. Use - for stdout.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
