cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - region
label: crossmap_region
doc: "CrossMap converts genome regions in BED format between assemblies. A region is lifted over as a whole; it is reported only when the ratio of bases that remap is at least the minimum ratio.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_bed
    type: File
    doc: The input BED file. The first 3 columns must be "chrom", "start", and "end".
      The file can be plain text or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2).
    inputBinding:
      position: 2
  - id: out_bed
    type: string
    default: output.bed
    doc: Output BED file. If the argument is missing, CrossMap writes the BED file
      to STDOUT.
    inputBinding:
      position: 3
  - id: chromid
    type:
      - 'null'
      - type: enum
        symbols:
          - a
          - s
          - l
          - n
    doc: 'The style of the output chromosome IDs. "a" = "as-is", "l" = "long style",
      "s" = "short style", and "n" = "no-change".'
    inputBinding:
      position: 104
      prefix: --chromid
  - id: min_map_ratio
    type:
      - 'null'
      - float
    doc: Minimum ratio of bases that must remap.
    inputBinding:
      position: 104
      prefix: --ratio
outputs:
  - id: output_bed
    type: File
    doc: Lifted-over regions, with a map_ratio column.
    outputBinding:
      glob: $(inputs.out_bed)
  - id: unmapped_bed
    type:
      - 'null'
      - File
    doc: Regions that could not be lifted over.
    outputBinding:
      glob: $(inputs.out_bed).unmap
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
