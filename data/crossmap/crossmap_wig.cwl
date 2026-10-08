cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - wig
label: crossmap_wig
doc: "CrossMap converts genome coordinates in wiggle or bedGraph format files between assemblies. Both variableStep and fixedStep wiggle lines are supported. Regardless of the input, the output is written as bedGraph and bigWig.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_wig
    type: File
    doc: The input wiggle/bedGraph format file. Both "variableStep" and "fixedStep"
      wiggle lines are supported. The file can be plain text or compressed (.gz, .Z,
      .z, .bz, .bz2, .bzip2).
    inputBinding:
      position: 2
  - id: out_wig
    type: string
    doc: Output prefix. CrossMap writes <prefix>.sorted.bgr (bedGraph) and <prefix>.bw
      (bigWig). Regardless of the input is wiggle or bedGraph, the output is in bedGraph
      format.
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
outputs:
  - id: output_bigwig
    type: File
    doc: Lifted-over signal in bigWig format (<prefix>.bw).
    outputBinding:
      glob: $(inputs.out_wig).bw
  - id: output_bedgraph
    type: File
    doc: Lifted-over, merged and sorted signal in bedGraph format (<prefix>.sorted.bgr).
    outputBinding:
      glob: $(inputs.out_wig).sorted.bgr
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
