cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- PrintBGZFBlockInformation
label: gatk_PrintBGZFBlockInformation
doc: |-
  Print information about the compressed blocks in a BGZF format file

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: bgzf_file
  type: File
  doc: The BGZF-format file for which to print block information
  inputBinding:
    prefix: --bgzf-file
- id: output
  type:
  - 'null'
  - string
  doc: File to which to write block information (if not specified, prints to standard
    output)
  inputBinding:
    prefix: --output
outputs:
- id: output_output
  type:
  - 'null'
  - File
  doc: File to which to write block information (if not specified, prints to standard
    output)
  outputBinding:
    glob: $(inputs.output)
- id: block_info
  type: stdout
  doc: Standard output of the tool
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
stdout: bgzf_block_info.txt
