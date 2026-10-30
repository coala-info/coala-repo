cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyzint
label: tinker_xyzint
doc: "Tinker Cartesian to internal coordinates: converts a Cartesian coordinate file into an internal coordinate (Z-matrix) file.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: method
    type: string
    doc: "Z-matrix construction: A automatic, M manual, T template from an existing .int file, D dihedrals"
    default: "A"
    inputBinding:
      position: 2
  - id: key_file
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file; it is staged as <coordinate base name>.key beside the coordinate file"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: internal_file
    type: File[]
    doc: "Internal coordinate file (name.int, or name.int_2 when one exists)"
    outputBinding:
      glob: "*.int*"
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_xyzint.out
