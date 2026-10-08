cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macse
  - -prog
  - multiPrograms
label: macse_multiprograms
doc: "sequentially executes multiple MACSE commands contained in a text file (one per line).\n\nTool homepage: https://bioweb.supagro.inra.fr/macse/"
inputs:
  - id: MACSE_command_file
    type: File
    doc: "a file containing a list of MACSE commands. Each line contains a single MACSE command starting by \"-prog\" (i.e. omitting \"java -jar macse.jar\"). The character '@' can be used before each file path to point towards the directory containing this command file."
    inputBinding:
      position: 102
      prefix: -MACSE_command_file
  - id: input_files
    type:
      - 'null'
      - File[]
    doc: "Data files named in the MACSE command file; they are staged in the working directory so the relative names in the command file resolve"
outputs:
  - id: output_files
    type: File[]
    doc: "All files in the working directory after the run (the outputs named in the command file)"
    outputBinding:
      glob: "*"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.input_files ? inputs.input_files : [])'
  - class: ResourceRequirement
    ramMin: 4096
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macse:2.07--hdfd78af_0
