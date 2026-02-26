cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2zarr
label: bio2zarr_vcf2zarr
doc: "Convert VCF file(s) to VCF Zarr format.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: convert
    type:
      - 'null'
      - boolean
    doc: Convert input VCF(s) directly to VCF Zarr (not...
    inputBinding:
      position: 101
  - id: dencode_finalise
    type:
      - 'null'
      - boolean
    doc: Final step for distributed conversion of ICF to VCF...
    inputBinding:
      position: 101
  - id: dencode_init
    type:
      - 'null'
      - boolean
    doc: Initialise conversion of intermediate format to VCF...
    inputBinding:
      position: 101
  - id: dencode_partition
    type:
      - 'null'
      - boolean
    doc: Convert a partition from intermediate columnar...
    inputBinding:
      position: 101
  - id: dexplode_finalise
    type:
      - 'null'
      - boolean
    doc: Final step for distributed conversion of VCF(s) to...
    inputBinding:
      position: 101
  - id: dexplode_init
    type:
      - 'null'
      - boolean
    doc: Initial step for distributed conversion of VCF(s)...
    inputBinding:
      position: 101
  - id: dexplode_partition
    type:
      - 'null'
      - boolean
    doc: Convert a VCF partition to intermediate columnar...
    inputBinding:
      position: 101
  - id: encode
    type:
      - 'null'
      - boolean
    doc: Convert intermediate columnar format to VCF Zarr.
    inputBinding:
      position: 101
  - id: explode
    type:
      - 'null'
      - boolean
    doc: Convert VCF(s) to intermediate columnar format
    inputBinding:
      position: 101
  - id: inspect
    type:
      - 'null'
      - boolean
    doc: Inspect an intermediate columnar format or Zarr path.
    inputBinding:
      position: 101
  - id: mkschema
    type:
      - 'null'
      - boolean
    doc: Generate a schema for zarr encoding
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
stdout: bio2zarr_vcf2zarr.out
