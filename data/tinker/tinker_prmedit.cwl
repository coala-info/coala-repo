cwlVersion: v1.2
class: CommandLineTool
baseCommand: prmedit
label: tinker_prmedit
doc: "Tinker force field parameter editing facility: formats, reorders and renumbers the records of a parameter file, and sorts multipole or biotype parameters; writes parameter.prm, multipole.prm or biotype.prm.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: parameter_file
    type: File
    doc: "Force field parameter file to edit (.prm)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: mode
    type: int
    doc: "Edit mode: 1 format parameter records, 2 reorder records, 3 renumber atom types, 4 renumber atom classes, 5 renumber types and classes, 6 sort and format multipole parameters, 7 renumber and format biotype parameters"
    default: 1
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: parameter_output
    type: File[]
    doc: "Edited parameter file (parameter.prm)"
    outputBinding:
      glob: parameter.prm*
  - id: multipole_output
    type: File[]
    doc: "Sorted multipole parameters (multipole.prm), mode 6"
    outputBinding:
      glob: multipole.prm*
  - id: biotype_output
    type: File[]
    doc: "Renumbered biotype parameters (biotype.prm), mode 7"
    outputBinding:
      glob: biotype.prm*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.parameter_file.basename, "entry": inputs.parameter_file, "writable": false});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_prmedit.out
