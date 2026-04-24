cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - test
label: circlator_test
doc: "Run Circlator on a small test dataset\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: outdir
    type: Directory
    doc: Name of output directory
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_test.out
