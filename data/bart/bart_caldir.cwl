cwlVersion: v1.2
class: CommandLineTool
baseCommand: [bart, caldir]
requirements:
  - class: InlineJavascriptRequirement
label: bart_caldir
doc: "Estimates coil sensitivities from the k-space center using a direct method (McKenzie
  et al.). The size of the fully-sampled calibration region is automatically determined
  but limited by {cal_size} (e.g. in the readout direction).\n\nTool homepage: https://github.com/mrirecon/bart"
inputs:
  - id: cal_size
    type: string
    doc: The size of the fully-sampled calibration region is automatically 
      determined but limited by {cal_size} (e.g. in the readout direction).
    inputBinding:
      position: 10
  - id: input
    type: File
    doc: Input file
    secondaryFiles:
      - ^.hdr
    inputBinding:
      position: 11
      valueFrom: $(self.path.replace(/\.cfl$/, ''))
  - id: output_name
    type: string
    doc: Output name without extension (writes <name>.cfl and <name>.hdr)
    inputBinding:
      position: 12
outputs:
  - id: output
    type: File
    doc: Output file
    secondaryFiles:
      - ^.hdr
    outputBinding:
      glob: $(inputs.output_name).cfl
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bart:v0.4.04-2-deb_cv1
