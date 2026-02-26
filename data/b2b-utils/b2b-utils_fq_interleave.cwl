cwlVersion: v1.2
class: CommandLineTool
baseCommand: fq_interleave
label: b2b-utils_fq_interleave
doc: "A simple script to interleave two paired FASTQ files (alternate forward/reverse
  reads in a single output file). This requires that the two files correspond exactly
  in terms of number and order of the paired reads ('--check' will make sure of this
  and throw an error otherwise). Interleaved FASTQ is sent to STDOUT.\n\nTool homepage:
  https://github.com/jvolkening/b2b-utils"
inputs:
  - id: reads1
    type: File
    doc: Name of input file for forward reads
    inputBinding:
      position: 1
  - id: reads2
    type: File
    doc: Name of input file for reverse reads
    inputBinding:
      position: 2
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check each pair of input reads to make sure names match (slower but 
      more rigorous)
    inputBinding:
      position: 103
      prefix: --check
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of output file even if it exists
    inputBinding:
      position: 103
      prefix: --force
  - id: rename
    type:
      - 'null'
      - boolean
    doc: Renames forward and reverse reads to follow the ".../1" and .../2" 
      naming convention (required for some programs). Everything at and after 
      the first whitespace or end-of-line is replaced with the corresponding tag
      above.
    inputBinding:
      position: 103
      prefix: --rename
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output file to write to (instead of the default STDOUT)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
