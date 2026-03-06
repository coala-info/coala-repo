cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- reference
label: samtools_reference
doc: "Extract the reference sequence from a CRAM file\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_file
  type: File
  doc: Input CRAM file
  inputBinding:
    position: 103
- id: e_flag
  type: boolean?
  doc: Enable specific reference extraction option (-e)
  inputBinding:
    position: 102
    prefix: -e
- id: quiet
  type: boolean?
  doc: Quiet mode
  inputBinding:
    position: 102
    prefix: -q
- id: region
  type: string?
  doc: Region to extract
  inputBinding:
    position: 102
    prefix: -r
- id: threads
  type: int?
  doc: Number of threads
  inputBinding:
    position: 102
    prefix: -@
outputs:
- id: output_file
  type: stdout
  doc: Captured reference sequence from stdout
stdout: reference.fa
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
