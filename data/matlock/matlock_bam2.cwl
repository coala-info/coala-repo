cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - matlock
  - bam2
label: matlock_bam2
doc: "Convert Hi-C alignments to several useful Hi-C formats (binmat, lachesis, juicer
  or counts). The input format (cram, bam or sam) is detected automatically. Use a
  bam made by matlock bamfilt.\n\nTool homepage: https://github.com/phasegenomics/matlock"
inputs:
  - id: format
    type: string
    doc: Output format, one of binmat, lachesis, juicer, counts.
    inputBinding:
      position: 1
  - id: input
    type: File
    doc: Input alignments (cram, bam or sam).
    inputBinding:
      position: 2
  - id: output_path
    type: string
    doc: Output file name, written as given (no extension is added).
    inputBinding:
      position: 3
outputs:
  - id: output
    type: File
    doc: Converted Hi-C data
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matlock:20181227--h665f8ca_8
