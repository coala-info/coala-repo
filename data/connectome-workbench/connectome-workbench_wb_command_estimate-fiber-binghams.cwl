cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-estimate-fiber-binghams'
label: connectome-workbench_wb_command_estimate-fiber-binghams
doc: "Estimate fiber orientation distributions from bedpostx samples. Estimates a bingham distribution for each fiber orientation in each voxel which is labeled a structure identifier in <label-volume>.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: merged_f1samples
    type: File
    doc: fiber 1 strength samples
    inputBinding:
      position: 1
  - id: merged_th1samples
    type: File
    doc: fiber 1 theta samples
    inputBinding:
      position: 2
  - id: merged_ph1samples
    type: File
    doc: fiber 1 phi samples
    inputBinding:
      position: 3
  - id: merged_f2samples
    type: File
    doc: fiber 2 strength samples
    inputBinding:
      position: 4
  - id: merged_th2samples
    type: File
    doc: fiber 2 theta samples
    inputBinding:
      position: 5
  - id: merged_ph2samples
    type: File
    doc: fiber 2 phi samples
    inputBinding:
      position: 6
  - id: merged_f3samples
    type: File
    doc: fiber 3 strength samples
    inputBinding:
      position: 7
  - id: merged_th3samples
    type: File
    doc: fiber 3 theta samples
    inputBinding:
      position: 8
  - id: merged_ph3samples
    type: File
    doc: fiber 3 phi samples
    inputBinding:
      position: 9
  - id: label_volume
    type: File
    doc: volume of cifti structure labels
    inputBinding:
      position: 10
  - id: cifti_out
    type: string
    doc: output - output cifti fiber distributions file
    inputBinding:
      position: 11
outputs:
  - id: fiber_distributions
    type: File
    doc: output cifti fiber distributions file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
