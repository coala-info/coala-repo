cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methurator
  - plot
label: methurator_plot
doc: "Plot the sequencing saturation curve from downsampling results.\n\nTool homepage:
  https://github.com/VIBTOBIlab/methurator"
inputs:
  - id: summary
    type: File
    doc: File (yml) containing summary results of downsample command.
    inputBinding:
      position: 101
      prefix: --summary
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Default output directory.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methurator:2.1.1--pyhdfd78af_0
