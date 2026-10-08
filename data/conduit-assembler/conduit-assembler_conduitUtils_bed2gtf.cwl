cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - conduitUtils
  - bed2gtf
label: conduit-assembler_conduitUtils_bed2gtf
doc: "Converts BED12 files to well structured GTF file suitable for use in GFFcompare\n\nTool homepage: https://github.com/NatPRoach/conduit"
inputs:
  - id: infile
    type: File
    doc: "BED12 infile to be converted in to GTF format"
    inputBinding:
      position: 1
      prefix: -i
  - id: outfile
    type: string
    doc: "GTF outfile"
    default: "outfile.gtf"
    inputBinding:
      position: 1
      prefix: -o
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: "Report gtf fields with strand information"
    inputBinding:
      position: 1
      prefix: --stranded
outputs:
  - id: gtf
    type: File
    doc: "GTF outfile"
    outputBinding:
      glob: $(inputs.outfile)
  - id: stdout
    type: stdout
    doc: "log messages"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/conduit-assembler:0.1.2--h14cfee4_1
stdout: conduit-assembler_conduitUtils_bed2gtf.out
