cwlVersion: v1.2
class: CommandLineTool
baseCommand: fixelcfestats
label: mrtrix3_fixelcfestats
doc: "Statistical analysis of fixel-based data using Connectivity-based Fixel Enhancement
  (CFE).\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: fixel_directory
    type: Directory
    doc: The input fixel directory
    inputBinding:
      position: 1
  - id: design_matrix
    type: File
    doc: The design matrix
    inputBinding:
      position: 2
  - id: contrast_matrix
    type: File
    doc: The contrast matrix
    inputBinding:
      position: 3
  - id: tracks_file
    type: File
    doc: The tracks file (e.g. .tck file)
    inputBinding:
      position: 4
  - id: fwe_p
    type:
      - 'null'
      - boolean
    doc: Output FWE-corrected p-value images
    inputBinding:
      position: 105
      prefix: -fwe_p
  - id: mask
    type:
      - 'null'
      - File
    doc: Only perform computation within the specified mask
    inputBinding:
      position: 105
      prefix: -mask
  - id: nshuf
    type:
      - 'null'
      - int
    doc: The number of permutations to perform
    default: 5000
    inputBinding:
      position: 105
      prefix: -nshuf
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 105
      prefix: -nthreads
  - id: tfce
    type:
      - 'null'
      - boolean
    doc: Perform Threshold-Free Cluster Enhancement
    inputBinding:
      position: 105
      prefix: -tfce
outputs:
  - id: output_directory
    type: Directory
    doc: The output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
