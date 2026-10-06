cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - dexplode-finalise
label: bio2zarr_vcf2zarr_dexplode_finalise
doc: "Final step for distributed conversion of VCF(s) to intermediate columnar format.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: icf
    type: Directory
    doc: 'ICF directory with all partitions exploded; staged writable and finalised in place'
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: icf_out
    type: Directory
    doc: 'Finalised ICF directory'
    outputBinding:
      glob: $(inputs.icf.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.icf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
