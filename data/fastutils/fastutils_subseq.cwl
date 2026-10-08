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
      position: 200
  - id: input_file
    type: File
    doc: input file in fastx format. Use - for stdin.
    inputBinding:
      position: 102
      prefix: -i
  - id: output_file_path
    type: string
    doc: Name of the output file. The tool ignores -o with a file name and writes to
      standard output, so the wrapper runs it with -o - and stores standard output here.
outputs:
  - id: output_file
    type: stdout
    doc: Extracted subsequence in fasta/q format
arguments:
  - position: 103
    prefix: -o
    valueFrom: '-'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastutils:0.3--h077b44d_5
stdout: $(inputs.output_file_path)
