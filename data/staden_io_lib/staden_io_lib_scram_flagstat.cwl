cwlVersion: v1.2
class: CommandLineTool
baseCommand: scram_flagstat
label: staden_io_lib_scram_flagstat
doc: "Calculates flag statistics for BAM, SAM, or CRAM files.\n\nTool homepage: https://github.com/jkbonfield/io_lib/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input BAM, SAM, or CRAM file. If not specified, reads from stdin.
    inputBinding:
      position: 1
  - id: input_format
    type:
      - 'null'
      - string
    doc: 'Set input format: "bam", "sam" or "cram".'
    inputBinding:
      position: 102
      prefix: -I
  - id: range
    type:
      - 'null'
      - string
    doc: '[Cram] Specifies the refseq:start-end range'
    inputBinding:
      position: 102
      prefix: -R
  - id: reference_file
    type:
      - 'null'
      - File
    doc: '[Cram] Specifies the reference file.'
    inputBinding:
      position: 102
      prefix: -r
  - id: threads
    type:
      - 'null'
      - int
    doc: Use N threads (availability varies by format)
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/staden-io-lib-utils:v1.14.11-6-deb_cv1
stdout: staden_io_lib_scram_flagstat.out
