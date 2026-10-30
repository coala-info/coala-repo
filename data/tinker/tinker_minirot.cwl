cwlVersion: v1.2
class: CommandLineTool
baseCommand: minirot
label: tinker_minirot
doc: "Tinker limited-memory BFGS energy minimization in torsional space; reads a Z-matrix internal coordinate file (.int) and writes the minimized internal coordinates to a new version (<name>.int_2).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: internal_coordinate_file
    type: File
    doc: "Z-matrix internal coordinate file (.int)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: torsion_selection
    type: int
    doc: "Selection of torsional angles: 0 automatic, 1 manual selection of angles to rotate, 2 manual selection of angles to freeze"
    default: 0
    inputBinding:
      position: 2
  - id: rms_gradient
    type: float
    doc: "RMS gradient per torsion termination criterion"
    default: 0.01
    inputBinding:
      position: 3
  - id: stdin_answers
    type:
      - 'null'
      - string[]
    doc: "Atom pairs of the rotatable (mode 1) or frozen (mode 2) bonds, one pair per line; an empty line ends the list"
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
  - id: minimized_coordinates
    type: File[]
    doc: "Minimized internal coordinates (new versions of the .int file)"
    outputBinding:
      glob: $(inputs.internal_coordinate_file.nameroot).int_*
arguments:
  - position: 1000
    shellQuote: false
    valueFrom: "< tinker_stdin.txt"
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.internal_coordinate_file.basename, "entry": inputs.internal_coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.internal_coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        l.push({"entryname": "tinker_stdin.txt", "entry": (inputs.stdin_answers || []).join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_minirot.out
