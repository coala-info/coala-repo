cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - annotate
label: cnvetti_annotate
doc: "Perform annotate called CNV result BCF files\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: io_threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use for (de)compression in I/O.
    inputBinding:
      position: 101
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
stdout: cnvetti_annotate.out
