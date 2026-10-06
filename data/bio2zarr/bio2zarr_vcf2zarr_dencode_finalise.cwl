cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - dencode-finalise
label: bio2zarr_vcf2zarr_dencode_finalise
doc: "Final step for distributed conversion of ICF to VCF Zarr.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: zarr
    type: Directory
    doc: 'VCF Zarr directory with all partitions encoded; staged writable and finalised in place'
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
  - id: icf
    type: Directory
    doc: The ICF directory given to dencode-init (same name), staged in the 
      working directory so the path stored in the Zarr resolves.
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: progress
    type:
      - 'null'
      - boolean
    doc: 'Show progress bars (default: show)'
    inputBinding:
      position: 1
      prefix: --progress
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: 'Do not show progress bars'
    inputBinding:
      position: 1
      prefix: --no-progress
outputs:
  - id: zarr_out
    type: Directory
    doc: 'Finalised VCF Zarr store'
    outputBinding:
      glob: $(inputs.zarr.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.zarr)
        writable: true
      - entry: $(inputs.icf)
        writable: false
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
