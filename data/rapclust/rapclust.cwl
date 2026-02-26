cwlVersion: v1.2
class: CommandLineTool
baseCommand: rapclust
label: rapclust
doc: "A tool for clustering transcript sequences based on quantification results.\n\
  \nTool homepage: https://github.com/COMBINE-lab/RapClust"
inputs:
  - id: input
    type: Directory
    doc: The input directory containing the quantification results (e.g., from 
      Salmon or Sailfish).
    inputBinding:
      position: 101
      prefix: --input
  - id: mode
    type:
      - 'null'
      - string
    doc: The clustering mode to use (e.g., 'rapclust' or 'flat').
    default: rapclust
    inputBinding:
      position: 101
      prefix: --mode
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads to use for processing.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: The output directory where the clustering results will be written.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rapclust:0.1.2--py35_0
