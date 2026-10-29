cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - build_model
  - estimate_scale
label: ont-tombo_build_model_estimate_scale
doc: "Estimate a global scaling parameter from a sub-set of reads.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: fast5s_basedir
    type: Directory
    doc: "Directory containing fast5 files. All files ending in \"fast5\" found recursively within this base directory will be processed."
    inputBinding:
      position: 1
      valueFrom: "$(self.basename)"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
stderr: ont-tombo_build_model_estimate_scale.stderr.txt
outputs:
  - id: scale_estimate
    type: stderr
    doc: "Status messages including the global scale estimate (the tool prints it to standard error)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fast5s_basedir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
