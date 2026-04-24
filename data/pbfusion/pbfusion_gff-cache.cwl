cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pbfusion
  - gff-cache
label: pbfusion_gff-cache
doc: "Cache exonic information from a gtf/gff file in binary format for faster `pbfusion
  discover` invocations.\n\nTool homepage: https://github.com/PacificBiosciences/pbfusion"
inputs:
  - id: gtf
    type: File
    doc: Input GTF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: gtf_transcript_allow_lncrna
    type:
      - 'null'
      - boolean
    doc: Allow fusion partners to contain lncRNA annotations
    inputBinding:
      position: 101
      prefix: --gtf-transcript-allow-lncRNA
  - id: log_level
    type:
      - 'null'
      - string
    doc: 'Alternative to repeated -v/--verbose: set log level via key. Values: "error",
      "warn" (default), "info", "debug", "trace".'
    inputBinding:
      position: 101
      prefix: --log-level
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: gtf_out
    type:
      - 'null'
      - File
    doc: Output binary GTF file
    outputBinding:
      glob: $(inputs.gtf_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbfusion:0.5.1--hdfd78af_0
