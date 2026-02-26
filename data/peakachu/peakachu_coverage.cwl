cwlVersion: v1.2
class: CommandLineTool
baseCommand: peakachu coverage
label: peakachu_coverage
doc: "Calculate coverage for a project folder.\n\nTool homepage: https://github.com/tbischler/PEAKachu"
inputs:
  - id: project_folder
    type: Directory
    doc: The project folder containing coverage data.
    inputBinding:
      position: 1
  - id: max_proc
    type:
      - 'null'
      - int
    doc: Maximum number of processes to use.
    inputBinding:
      position: 102
      prefix: --max_proc
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
stdout: peakachu_coverage.out
