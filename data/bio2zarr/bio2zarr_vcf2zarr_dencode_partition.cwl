cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - dencode-partition
label: bio2zarr_vcf2zarr_dencode_partition
doc: "Convert a partition from intermediate columnar format to VCF Zarr. Must be called after the Zarr path has been initialised with dencode_init. By default, partition indexes are from 0 to the number of partitions N (returned by dencode_init), exclusive. If the --one-based option is specifed, partition indexes are in the range 1 to N, inclusive.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: zarr
    type: Directory
    doc: 'VCF Zarr directory initialised by dencode-init; staged writable and updated in place'
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
  - id: partition
    type: int
    doc: Partition index (0 to N-1, or 1 to N with --one-based).
    inputBinding:
      position: 11
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
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: 'Partition indexes are interpreted as one-based'
    inputBinding:
      position: 1
      prefix: --one-based
outputs:
  - id: zarr_out
    type: Directory
    doc: 'VCF Zarr directory with the partition written'
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
