cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- quickcheck
label: samtools_quickcheck
doc: 'Quickly check that input files appear intact


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
arguments:
- position: 103
  valueFrom: '$(inputs.verbose ? ''-'' + ''v''.repeat(inputs.verbose) : null)'
inputs:
- id: input_files
  type:
    type: array
    items: File
  doc: Input SAM/BAM/CRAM files to check.
  inputBinding:
    position: 104
- id: verbose
  type:
  - 'null'
  - int
  doc: Verbose output; the value is the number of v letters (1 lists failing files).
- id: quiet
  type:
  - 'null'
  - boolean
  doc: Suppress warning messages.
  inputBinding:
    position: 103
    prefix: -q
- id: unmapped_input
  type:
  - 'null'
  - boolean
  doc: Unmapped input (do not require targets in header).
  inputBinding:
    position: 103
    prefix: -u
outputs:
- id: output
  type: stdout
  doc: Names of files that fail the check (with -v); empty when all pass.
stdout: quickcheck.txt
successCodes:
- 0
- 1
- 2
- 3
- 4
- 5
- 6
- 7
- 8
- 9
- 10
- 11
- 12
- 13
- 14
- 15
- 16
- 17
- 18
- 19
- 20
- 21
- 22
- 23
- 24
- 25
- 26
- 27
- 28
- 29
- 30
- 31
- 32
- 33
- 34
- 35
- 36
- 37
- 38
- 39
- 40
- 41
- 42
- 43
- 44
- 45
- 46
- 47
- 48
- 49
- 50
- 51
- 52
- 53
- 54
- 55
- 56
- 57
- 58
- 59
- 60
- 61
- 62
- 63
