cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ProgramFile
  - contigs
label: assemblyutility_AssemblyStatistics
doc: "A tool to calculate assembly statistics for a given contigs file with a specified
  length cutoff.\n\nTool homepage: https://github.com/yechengxi/AssemblyUtility"
inputs:
  - id: contigs_filename
    type: File
    doc: The input contigs file (e.g., FASTA format).
    inputBinding:
      position: 1
  - id: length_keyword
    type: string
    doc: Fixed keyword 'LenTh' required by the command structure.
    default: LenTh
    inputBinding:
      position: 2
  - id: cut_off_length
    type: int
    doc: The minimum length threshold for including contigs in the statistics.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblyutility:20160209--h077b44d_9
stdout: assemblyutility_AssemblyStatistics.out
