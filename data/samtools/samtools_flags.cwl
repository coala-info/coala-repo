cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- flags
label: samtools_flags
doc: "Convert between textual and numeric flag representation\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InlineJavascriptRequirement
inputs:
- id: flags
  type: string
  doc: Each FLAGS argument is either an INT (in decimal/hexadecimal/octal) or a 
    comma-separated string of flag names (e.g., PAIRED,UNMAP).
  inputBinding:
    position: 1
outputs:
- id: stdout
  type: stdout
  doc: Standard output
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_flags.out
