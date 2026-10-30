cwlVersion: v1.2
class: CommandLineTool
baseCommand: critical
label: tinker_critical
doc: "Tinker search for critical points (minima, maxima and saddle points) of the potential energy surface by least-squares minimization of the gradient; the result is written to a new version of the coordinate file (<name>.xyz_2).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: rms_gradient
    type: float
    doc: "Residual gradient convergence criterion"
    default: 0.01
    inputBinding:
      position: 2
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
  - id: critical_point_coordinates
    type: File[]
    doc: "Coordinates of the critical point (new versions of the .xyz file)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).xyz_*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_critical.out
