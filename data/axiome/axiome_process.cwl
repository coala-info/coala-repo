cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - axiome
  - process
label: axiome_process
doc: "Axiome process command for data processing\n\nTool homepage: https://github.com/ujjwalredd/Axiomeer"
inputs:
  - id: input
    type: File
    doc: Input to be processed
    inputBinding:
      position: 101
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Working directory <input name>.axiome with the Makefile and report
    outputBinding:
      glob: $(inputs.input.nameroot).axiome
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/axiome:2.0.4--py27_0
stdout: axiome_process.out
