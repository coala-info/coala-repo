cwlVersion: v1.2
class: CommandLineTool
baseCommand: metfrag
label: metfrag
doc: "MetFrag command line tool for metabolite identification from MS/MS data. All settings are in a parameter file (key = value lines). Files named in the parameter file (peak list, local candidate database, ...) must be given in data_files so they are staged in the working directory and can be referred to by name. Set ResultsPath = results in the parameter file: the wrapper creates that folder and returns it.\n\nTool homepage: http://c-ruttkies.github.io/MetFrag/"
inputs:
  - id: parameter_file
    type: File
    doc: "Parameter file (ParameterFile=path_to_parameterfile)"
    inputBinding:
      position: 101
      prefix: "ParameterFile="
      separate: false
  - id: data_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files referred to by name in the parameter file (peak list, local database, ...)"
outputs:
  - id: results_dir
    type: Directory
    doc: "Result folder (ResultsPath = results in the parameter file)"
    outputBinding:
      glob: results
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: results
        entry: "$({class: 'Directory', listing: []})"
        writable: true
      - $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metfrag:2.4.5--3
stdout: metfrag.out
