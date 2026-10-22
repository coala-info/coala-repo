cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimize
label: tinker_minimize
doc: "Tinker limited-memory BFGS energy minimization of a structure; the minimized coordinates are written to a new version of the coordinate file (<name>.xyz_2).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: rms_gradient
    type: float
    doc: "Termination criterion as the RMS gradient per atom (kcal/mole/A)"
    default: 0.01
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
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: minimized_coordinates
    type: File[]
    doc: "Minimized coordinates (new version of the .xyz file)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).xyz_*
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
stdout: tinker_minimize.out
