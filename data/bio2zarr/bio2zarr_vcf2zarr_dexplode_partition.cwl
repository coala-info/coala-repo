cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcf2zarr
  - dexplode-partition
label: bio2zarr_vcf2zarr_dexplode_partition
doc: "Convert a VCF partition to intermediate columnar format. Must be called after the ICF path has been initialised with dexplode_init. By default, partition indexes are from 0 to the number of partitions N (returned by dexplode_init), exclusive. If the --one-based option is specifed, partition indexes are in the range 1 to N, inclusive.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: icf
    type: Directory
    doc: 'ICF directory initialised by dexplode-init; staged writable and updated in place'
    inputBinding:
      position: 10
      valueFrom: $(self.basename)
  - id: partition
    type: int
    doc: Partition index (0 to N-1, or 1 to N with --one-based).
    inputBinding:
      position: 11
  - id: vcfs
    type:
      type: array
      items: File
    doc: The VCF/BCF file(s) given to dexplode-init (same names), staged in the 
      working directory so the paths stored in the ICF resolve.
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
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
  - id: icf_out
    type: Directory
    doc: 'ICF directory with the partition written'
    outputBinding:
      glob: $(inputs.icf.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.icf)
        writable: true
      - $(inputs.vcfs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
