cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_apply_helical_symmetry
label: relion-bin_applyHelicalSymmetry
doc: "Apply helical symmetry to a 3D map. (Note: The provided help text contained
  only container runtime error messages and no usage information; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/3dem/relion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/relion-bin:v1.4dfsg-4-deb_cv1
stdout: relion-bin_applyHelicalSymmetry.out
