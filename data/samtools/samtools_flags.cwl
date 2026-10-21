cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- flags
label: samtools_flags
doc: 'Convert between textual and numeric flag representation


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: flags
  type:
    type: array
    items: string
  doc: 'FLAGS arguments: an INT (decimal/hex/octal) or comma-separated flag names (e.g. PAIRED,UNMAP).'
  inputBinding:
    position: 1
outputs:
- id: output
  type: stdout
  doc: Flag conversions.
stdout: flags.txt
