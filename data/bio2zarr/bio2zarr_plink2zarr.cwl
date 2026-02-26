cwlVersion: v1.2
class: CommandLineTool
baseCommand: plink2zarr
label: bio2zarr_plink2zarr
doc: "Convert plink fileset(s) to VCF Zarr format\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: command
    type: string
    doc: Command to execute (e.g., convert)
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
stdout: bio2zarr_plink2zarr.out
