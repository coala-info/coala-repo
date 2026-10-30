cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_isZero
doc: "Test whether a track is zero everywhere: prints nothing and exits with 1 at the first non-zero value (unary operator isZero). The wrapper saves the exit status in a file.\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
requirements:
  - class: ShellCommandRequirement
arguments:
  - position: 1
    valueFrom: isZero
  - position: 3
    valueFrom: ";"
    shellQuote: false
  - position: 4
    valueFrom: echo
    shellQuote: false
  - position: 5
    valueFrom: $?
    shellQuote: false
  - position: 6
    valueFrom: ">"
    shellQuote: false
  - position: 7
    valueFrom: $(inputs.output_name)
    shellQuote: false
inputs:
  - id: input_file
    type: File
    doc: Input track (wig, bigWig, bedGraph, bed, bigBed, bam, cram, vcf, bcf), recognised by suffix.
    inputBinding:
      position: 2
  - id: output_name
    type: string
    doc: Name of the file that receives the exit status of wiggletools (0 if the track is zero everywhere, 1 otherwise).
    default: is_zero_exit_status.txt
outputs:
  - id: exit_status
    type: File
    doc: Text file with the exit status of 'wiggletools isZero'.
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
