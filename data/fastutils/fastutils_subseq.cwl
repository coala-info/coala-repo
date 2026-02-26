cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastutils
  - subseq
label: fastutils_subseq
doc: "Extract subsequences from FASTX files.\n\nTool homepage: https://github.com/haghshenas/fastutils"
inputs:
  - id: name_start_end
    type: string
    doc: Sequence name and start-end coordinates (e.g., 'seq1:100-200')
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: input file in fastx format. Use - for stdin.
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: output_file
    type: File
    doc: output file. Use - for stdout.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
