cwlVersion: v1.2
class: CommandLineTool
baseCommand: generatemigrationtrees
label: machina_generatemigrationtrees
doc: "Generates migration trees for anatomical sites.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: anatomical_sites
    type:
      type: array
      items: string
    doc: Anatomical site labels, at least three. The first is the primary site, the
      others are the metastatic sites.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_generatemigrationtrees.out
