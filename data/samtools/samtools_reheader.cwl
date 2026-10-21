cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- reheader
label: samtools_reheader
doc: 'Replace the header in an alignment file


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.input_file)
    writable: true
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: header_file
  type:
  - 'null'
  - File
  doc: New header in SAM format (not needed with command).
  inputBinding:
    position: 104
- id: input_file
  type: File
  doc: Input BAM/CRAM file (staged so that in_place can modify it).
  inputBinding:
    position: 105
- id: no_pg
  type:
  - 'null'
  - boolean
  doc: Do not generate a @PG header line.
  inputBinding:
    position: 103
    prefix: --no-PG
- id: in_place
  type:
  - 'null'
  - boolean
  doc: Modify the CRAM file directly, if possible (default outputs to standard output).
  inputBinding:
    position: 103
    prefix: --in-place
- id: command
  type:
  - 'null'
  - string
  doc: Pass the header in SAM format to external program CMD.
  inputBinding:
    position: 103
    prefix: --command
- id: output_filename
  type: string
  doc: Name of the file that receives standard output (the reheadered file).
  default: reheadered.bam
outputs:
- id: output
  type: stdout
  doc: Reheadered alignment file.
- id: in_place_output
  type:
  - 'null'
  - File
  doc: The modified input file when in_place is used.
  outputBinding:
    glob: $(inputs.input_file.basename)
    outputEval: '$(inputs.in_place ? self : null)'
stdout: $(inputs.output_filename)
