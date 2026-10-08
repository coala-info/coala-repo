cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- stag
- convert_ali
label: stag_convert_ali
doc: 'Convert between 1-hot-encoding and fasta alignments, and vice versa.


  Tool homepage: https://github.com/zellerlab/stag'
inputs:
- id: file_in
  type: File
  doc: Input file, either a 1-hot-encoding created by stag align, or a fasta file of aligned sequences created by hmmalign. The input type is detected automatically
  inputBinding:
    position: 1
    prefix: -i
- id: file_out
  type: string
  doc: A 1-hot-encoding if the input was fasta, or a fasta file if the input was 1-hot-encoding
  inputBinding:
    position: 1
    prefix: -o
- id: verbose_level
  type:
  - 'null'
  - int
  doc: 'verbose level: 1=error, 2=warning, 3=message, 4+=debugging [3]'
  inputBinding:
    position: 1
    prefix: -v
outputs:
- id: file_out_result
  type: File
  doc: A 1-hot-encoding if the input was fasta, or a fasta file if the input was 1-hot-encoding
  outputBinding:
    glob: $(inputs.file_out)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/stag:0.8.3--pyhdfd78af_1
