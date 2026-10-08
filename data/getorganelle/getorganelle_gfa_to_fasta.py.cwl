cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfa_to_fasta.py
label: getorganelle_gfa_to_fasta.py
doc: "Convert a GFA assembly graph to FASTA (one record per segment).\n\nTool homepage: http://github.com/Kinggerm/GetOrganelle"
inputs:
  - id: gfa_file
    type: File
    doc: "Input GFA file. The result is written next to it as <input name>.fasta."
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type: File
    doc: "Converted file named <input name>.fasta"
    outputBinding:
      glob: "$(inputs.gfa_file.basename).fasta"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.gfa_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/getorganelle:1.7.7.1--pyhdfd78af_0
