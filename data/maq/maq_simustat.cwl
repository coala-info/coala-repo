cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - simustat
label: maq_simustat
doc: "Evaluate alignment based on simulation\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: simu_align_map
    type: File
    doc: Alignment (.map) of simulated reads
    inputBinding:
      position: 1
  - id: quality_threshold
    type:
      - 'null'
      - int
    doc: Mapping quality threshold Q (default 100)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_simustat.out
