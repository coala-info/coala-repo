cwlVersion: v1.2
class: CommandLineTool
baseCommand: AXTConvertor
label: kakscalculator2_AXTConvertor
doc: "Convert Clustal/Msf/Nexus/Phylip/Pir format sequence alignments to AXT ones, the input format of KaKs_Calculator.\n\nTool homepage: https://github.com/kullrich/kakscalculator2"
inputs:
  - id: alignment_file
    type: File
    doc: Alignment file in Clustal, Msf, Nexus, Phylip or Pir format
    inputBinding:
      position: 1
  - id: axt_file_path
    type: string
    doc: Name of the AXT file to write
    inputBinding:
      position: 2
outputs:
  - id: axt_file
    type: File
    doc: Alignment in AXT format
    outputBinding:
      glob: $(inputs.axt_file_path)
  - id: stdout
    type: stdout
    doc: Standard output
successCodes:
  - 0
  - 1
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kakscalculator2:2.0.1--h9948957_6
stdout: kakscalculator2_AXTConvertor.out
