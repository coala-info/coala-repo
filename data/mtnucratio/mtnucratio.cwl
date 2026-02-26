cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtnucratio
label: mtnucratio
doc: "Calculates the nucleotide ratio for mitochondrial DNA from a coordinate-sorted
  SAM/BAM file.\n\nTool homepage: https://github.com/apeltzer/MTNucRatioCalculator"
inputs:
  - id: input_sam_file
    type: File
    doc: Coordinate-sorted input SAM/BAM file.
    inputBinding:
      position: 1
  - id: mt_identifier
    type: string
    doc: The identifier for the mitochondrial chromosome (e.g., 'MT', 'chrM').
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtnucratio:0.7.1--hdfd78af_0
stdout: mtnucratio.out
