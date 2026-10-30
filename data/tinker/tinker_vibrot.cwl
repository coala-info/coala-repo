cwlVersion: v1.2
class: CommandLineTool
baseCommand: vibrot
label: tinker_vibrot
doc: "Tinker torsional vibrational analysis: builds the torsional Hessian and prints its diagonal and eigenvalues.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Internal coordinate (Z-matrix) file (.int), for example written by xyzint"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: torsion_selection
    type: int
    doc: "Selection of rotatable torsions: 0 automatic, 1 manual rotate, 2 manual freeze (manual bonds are given in stdin_answers)"
    default: 0
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
  - id: stdin_answers
    type: File
    doc: "Text file sent to standard input with the atom number pairs of the bonds to rotate or freeze, one pair per line; only needed for torsion_selection 1 or 2"
    default:
      class: File
      basename: stdin_answers.txt
      contents: "\n"
outputs:
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
stdin: $(inputs.stdin_answers.path)
stdout: tinker_vibrot.out
