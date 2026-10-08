cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcfpartition
label: bio2zarr_vcfpartition
doc: "Output bcftools region strings that partition the indexed VCF/BCF files into
  either an approximate number of parts (-n), or parts of approximately a given
  size (-s). One of -n or -s must be supplied. If multiple VCF/BCF files are
  provided, the number of parts (-n) is interpreted as the total number of
  partitions across all the files.\n\nTool homepage: https://sgkit-dev.github.io/bio2zarr/"
inputs:
  - id: vcfs
    type: File[]
    doc: Indexed VCF/BCF files (each with a .tbi or .csi index beside it)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .csi
        required: false
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
  - id: num_partitions
    type:
      - 'null'
      - int
    doc: 'Target number of partitions to split into [x>=1]'
    inputBinding:
      position: 1
      prefix: --num-partitions
  - id: partition_size
    type:
      - 'null'
      - string
    doc: 'Target (compressed) size of VCF partitions, e.g. 100KB, 10MiB, 1G.'
    inputBinding:
      position: 1
      prefix: --partition-size
  - id: output_name
    type: string
    doc: Name of the file that receives the region list written to stdout
    default: partitions.txt
outputs:
  - id: partitions
    type: File
    doc: 'Region strings, one partition per line, with the VCF file each belongs to'
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
