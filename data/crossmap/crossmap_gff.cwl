cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - CrossMap
  - gff
label: crossmap_gff
doc: "CrossMap converts genome coordinates in GFF or GTF format files between assemblies.\n\nTool homepage: https://crossmap.sourceforge.net"
inputs:
  - id: chain_file
    type: File
    doc: Chain file (https://genome.ucsc.edu/goldenPath/help/chain.html) describes
      pairwise alignments between two genomes. The input chain file can be a plain
      text file or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2) file.
    inputBinding:
      position: 1
  - id: input_gff
    type: File
    doc: The input GFF (General Feature Format) or GTF (Gene Transfer Format) file.
      The file can be plain text or compressed (.gz, .Z, .z, .bz, .bz2, .bzip2).
    inputBinding:
      position: 2
  - id: out_gff
    type: string
    default: output.gtf
    doc: Output GFF/GTF file. If the argument is missing, CrossMap writes the GFF/GTF
      file to STDOUT.
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
  - id: output_gff
    type: File
    doc: Lifted-over GFF/GTF file.
    outputBinding:
      glob: $(inputs.out_gff)
  - id: unmapped_gff
    type:
      - 'null'
      - File
    doc: Features that could not be lifted over (written as <out_gff>.<random>.unmap).
    outputBinding:
      glob: $(inputs.out_gff).*unmap
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crossmap:0.7.3--pyhdfd78af_0
