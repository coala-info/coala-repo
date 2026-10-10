cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtnucratio
label: mtnucratio
doc: "Calculates the ratio of reads mapping to the mitochondrial genome versus the nuclear genome from a coordinate-sorted SAM/BAM file.\n\nTool homepage: https://github.com/apeltzer/MTNucRatioCalculator"
inputs:
  - id: input_sam_file
    type: File
    doc: Coordinate-sorted input SAM/BAM file (with an appropriate header).
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: mt_identifier
    type: string
    doc: The identifier for the mitochondrial chromosome (e.g., 'MT', 'chrM').
    inputBinding:
      position: 2
outputs:
  - id: report
    type: File
    doc: Text report with the mitochondrial and nuclear read counts and their ratio
    outputBinding:
      glob: '*.mtnucratio'
  - id: json_report
    type: File
    doc: JSON report (MultiQC format) with the read counts
    outputBinding:
      glob: '*.json'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.input_sam_file.basename)
        entry: $(inputs.input_sam_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtnucratio:0.7.1--hdfd78af_0
