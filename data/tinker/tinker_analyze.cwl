cwlVersion: v1.2
class: CommandLineTool
baseCommand: analyze
label: tinker_analyze
doc: "Tinker energy analysis utility: total potential energy and its components, energy breakdown over atoms, system information, force field parameters, electrostatic moments, virial and connectivity lists.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: analysis_options
    type: string
    doc: "Analysis types as letters: G system info, P parameters, E energy components, A energy per atom, L large interactions, D details, M moments, V virial, C connectivity"
    default: "E"
    inputBinding:
      position: 2
  - id: atoms
    type:
      - 'null'
      - int[]
    doc: "Atom numbers for which output is wanted (types A, P and C); a negative first number starts a range"
    inputBinding:
      position: 3
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
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_analyze.out
