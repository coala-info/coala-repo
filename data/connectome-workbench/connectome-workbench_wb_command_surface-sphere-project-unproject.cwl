cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-sphere-project-unproject
label: connectome-workbench_wb_command_surface-sphere-project-unproject
doc: "Each vertex of <sphere-in> is projected to <sphere-project-to> to obtain barycentric weights, which are then used to unproject from <sphere-unproject-from>. This results in a sphere with the topology of <sphere-in>, but coordinates shifted by the deformation between <sphere-project-to> and <sphere-unproject-from>. <sphere-project-to> and <sphere-unproject-from> must have the same topology as each other, but <sphere-in> may have different topology.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: sphere_in
    type: File
    doc: "the sphere with the desired output mesh"
    inputBinding:
      position: 1
  - id: sphere_project_to
    type: File
    doc: "a sphere that aligns with sphere-in"
    inputBinding:
      position: 2
  - id: sphere_unproject_from
    type: File
    doc: "sphere-project-to deformed to the output space"
    inputBinding:
      position: 3
  - id: sphere_out
    type: string
    doc: "output - the output sphere"
    inputBinding:
      position: 4
outputs:
  - id: output_sphere
    type: File
    doc: "the output sphere"
    outputBinding:
      glob: $(inputs.sphere_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
