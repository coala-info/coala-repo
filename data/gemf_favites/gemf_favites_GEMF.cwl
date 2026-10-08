cwlVersion: v1.2
class: CommandLineTool
baseCommand: GEMF
label: gemf_favites_GEMF
doc: "GEMF (General Epidemic Modeling Framework): simulates the spread of an epidemic over a contact network. It reads a parameter file (default para.txt) that names the network file, the status file and the output file.\n\nTool homepage: https://github.com/niemasd/GEMF"
inputs:
  - id: para_file
    type: File
    doc: "Parameter file with the transition matrices and the names of the network, status and output files, for example para.txt"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: project_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files named in the parameter file, such as the network file and the status file, staged in the working directory"
  - id: out_file
    type:
      - 'null'
      - string
    doc: "Name of the simulation output file; it must match [OUT_FILE] in the parameter file (default output.txt)"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: simulation_output
    type:
      - 'null'
      - File
    doc: Simulation output written to the file named in [OUT_FILE]
    outputBinding:
      glob: '$(inputs.out_file ? inputs.out_file : "output.txt")'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.para_file)
      - '$(inputs.project_files ? inputs.project_files : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemf_favites:1.0.3--h7b50bb2_1
stdout: gemf_favites_GEMF.out
