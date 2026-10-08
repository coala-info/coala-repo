cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - callNovelNonCanonical
label: conduit-assembler_conduitUtils_callNovelNonCanonical
doc: "Compares introns described by reference GTF file to introns described by a list of readIDs in the format produced by `bedtools getfasta -name` function, outputs the novel introns in BED format (only introns supported by at least 5 reads, taken from the _<count> suffix of the name, are considered)\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: reference
    type: File
    doc: "Reference GTF file specifying the introns to compare against"
    inputBinding:
      position: 1
      prefix: -r
  - id: infile
    type: File
    doc: "Read IDs specifying intron structure in the format produced by `bedtools getfasta -name`"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "Output of introns found in the noncanonical.txt file but not found in the reference, in BED format"
    default: "novel.bed"
    inputBinding:
      position: 1
      prefix: -o
outputs:
  - id: novel
    type: File
    doc: "novel introns (BED)"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "counts of introns above threshold and novel introns"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_callNovelNonCanonical.out
