cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg statistics
label: hicberg_statistics
doc: "Extract statistics from non ambiguous Hi-C data.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: genome
    type: string
    doc: Genome
    inputBinding:
      position: 1
  - id: bins
    type:
      - 'null'
      - int
    doc: Genomic resolution.
    inputBinding:
      position: 102
      prefix: --bins
  - id: blacklist
    type:
      - 'null'
      - string
    doc: Blacklisted coordintaes to exclude reads for statistical learning. 
      Provide either a bed file or a list of coordinates coma separated using 
      UCSC format.
    inputBinding:
      position: 102
      prefix: --blacklist
  - id: circular
    type:
      - 'null'
      - string
    doc: Name of the chromosome to consider as circular.
    inputBinding:
      position: 102
      prefix: --circular
  - id: cpus
    type:
      - 'null'
      - int
    doc: Threads to use for analysis.
    inputBinding:
      position: 102
      prefix: --cpus
  - id: deviation
    type:
      - 'null'
      - float
    doc: Standard deviation for contact density estimation.
    inputBinding:
      position: 102
      prefix: --deviation
  - id: enzyme
    type:
      - 'null'
      - string
    doc: Enzymes to use for genome digestion.
    inputBinding:
      position: 102
      prefix: --enzyme
  - id: kernel_size
    type:
      - 'null'
      - int
    doc: Size of the gaussian kernel for contact density estimation.
    inputBinding:
      position: 102
      prefix: --kernel-size
  - id: mode
    type:
      - 'null'
      - string
    doc: Statistical model to use for ambiguous reads assignment.
    inputBinding:
      position: 102
      prefix: --mode
  - id: rate
    type:
      - 'null'
      - float
    doc: Rate to use for sub-sampling restriction map.
    inputBinding:
      position: 102
      prefix: --rate
outputs:
  - id: output_folder
    type:
      - 'null'
      - File
    doc: Output folder to save results.
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
