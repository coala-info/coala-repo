cwlVersion: v1.2
class: CommandLineTool
baseCommand: intxyz
label: tinker_intxyz
doc: "Tinker conversion of a Z-matrix internal coordinate file (.int) to a Cartesian coordinate file (.xyz).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: internal_coordinate_file
    type: File
    doc: "Z-matrix internal coordinate file (.int)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: key_file
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file; it is staged as <base name>.key beside the main input file"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: xyz_file
    type: File[]
    doc: "Cartesian coordinates (<name>.xyz, or a new version if that file exists)"
    outputBinding:
      glob: $(inputs.internal_coordinate_file.nameroot).xyz*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.internal_coordinate_file.basename, "entry": inputs.internal_coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.internal_coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_intxyz.out
