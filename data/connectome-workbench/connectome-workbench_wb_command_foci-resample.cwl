cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-foci-resample'
label: connectome-workbench_wb_command_foci-resample
doc: "Project foci to a different surface. Unprojects foci from the <current-surf> for the structure, then projects them to <new-surf>. If the foci should be on the surface, use registered spheres and the options -discard-distance-from-surface and -restore-xyz.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: foci_in
    type: File
    doc: the input foci file
    inputBinding:
      position: 1
  - id: foci_out
    type: string
    doc: output - the output foci file
    inputBinding:
      position: 2
  - id: left_surfaces
    type:
      - 'null'
      - type: array
        items: File
    doc: 'the left surfaces for resampling; two files: current surface, new surface'
    inputBinding:
      position: 3
      prefix: '-left-surfaces'
  - id: right_surfaces
    type:
      - 'null'
      - type: array
        items: File
    doc: 'the right surfaces for resampling; two files: current surface, new surface'
    inputBinding:
      position: 4
      prefix: '-right-surfaces'
  - id: cerebellum_surfaces
    type:
      - 'null'
      - type: array
        items: File
    doc: 'the cerebellum surfaces for resampling; two files: current surface, new surface'
    inputBinding:
      position: 5
      prefix: '-cerebellum-surfaces'
  - id: discard_distance_from_surface
    type:
      - 'null'
      - boolean
    doc: ignore the distance the foci are above or below the current surface
    inputBinding:
      position: 6
      prefix: '-discard-distance-from-surface'
  - id: restore_xyz
    type:
      - 'null'
      - boolean
    doc: put the original xyz coordinates into the foci, rather than the coordinates obtained from unprojection
    inputBinding:
      position: 7
      prefix: '-restore-xyz'
outputs:
  - id: resampled_foci
    type: File
    doc: the output foci file
    outputBinding:
      glob: $(inputs.foci_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
