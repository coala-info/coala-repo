cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cnvetti
  - cmd
label: cnvetti_cmd
doc: "Low-level access to the CNVetti primitives. This section of commands provides
  access to the individual, atomic steps of CNVetti.\n\nTool homepage: https://github.com/bihealth/cnvetti"
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (coverage, normalize, segment, merge-seg, 
      genotype, filter, merge-cov, de-bias, build-model-pool, build-model-wis, 
      mod-coverage, discover, ratio)
    inputBinding:
      position: 1
  - id: io_threads
    type:
      - 'null'
      - int
    doc: Number of additional threads to use for (de)compression in I/O.
    inputBinding:
      position: 102
      prefix: --io-threads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease verbosity
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cnvetti:0.2.0--he4cf2ce_0
stdout: cnvetti_cmd.out
