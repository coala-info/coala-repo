cwlVersion: v1.2
class: CommandLineTool
baseCommand: mol2xyz
label: tinker_mol2xyz
doc: "Tinker conversion of a Tripos MOL2 structure to a Cartesian coordinate file (.xyz).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: molecule_file
    type: File
    doc: "Tripos MOL2 file (.mol2)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: xyz_file
    type: File[]
    doc: "Cartesian coordinates (<name>.xyz, or a new version if that file exists)"
    outputBinding:
      glob: $(inputs.molecule_file.nameroot).xyz*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.molecule_file.basename, "entry": inputs.molecule_file, "writable": false});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_mol2xyz.out
