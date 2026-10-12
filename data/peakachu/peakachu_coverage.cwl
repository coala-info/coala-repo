cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakachu
  - coverage
label: peakachu_coverage
doc: "Calculate coverage for a project folder.\n\nTool homepage: https://github.com/tbischler/PEAKachu"
inputs:
  - id: project_folder
    type: Directory
    doc: The project folder made by peakachu window or adaptive (it holds parameters.json and the peak tables).
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
  - id: project_folder_out
    type: Directory
    doc: The project folder with the files written by the command (normalized_coverage wiggle files).
    outputBinding:
      glob: $(inputs.project_folder.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project_folder)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakachu:0.2.0--py38h0020b31_4
stdout: peakachu_coverage.out
