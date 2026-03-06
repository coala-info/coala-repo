cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- cram-size
label: samtools_cram_size
doc: "Calculate the size of CRAM files\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: input_cram
  type: File
  doc: Input CRAM file
  inputBinding:
    position: 101
- id: extended
  type: boolean?
  doc: Extended output
  inputBinding:
    position: 1
    prefix: -e
- id: verbose
  type: boolean?
  doc: Verbose output
  inputBinding:
    position: 2
    prefix: -v
outputs:
- id: output_file
  type: stdout
  doc: Output file containing cram-size results
stdout: cram_size.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
