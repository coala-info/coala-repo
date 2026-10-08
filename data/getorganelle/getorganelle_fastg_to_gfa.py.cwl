cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastg_to_gfa.py
label: getorganelle_fastg_to_gfa.py
doc: "Convert a SPAdes FASTG assembly graph to GFA.\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: fastg_file
    type: File
    doc: "Input FASTG file. The result is written next to it as <input name>.gfa."
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: "Converted file named <input name>.gfa"
    outputBinding:
      glob: "$(inputs.fastg_file.basename).gfa"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fastg_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
