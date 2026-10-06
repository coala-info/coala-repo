cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - inspect
label: bio2zarr_vcf2zarr_inspect
doc: "Inspect an intermediate columnar format or Zarr path.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: input_path
    type: Directory
    doc: Intermediate columnar format (ICF) or VCF Zarr directory to inspect
    inputBinding:
      position: 10
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity'
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: summary
    type: stdout
    doc: Table describing the fields or arrays in the store
stdout: $(inputs.input_path.basename).inspect.tsv
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
