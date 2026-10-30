cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtalmin
label: tinker_xtalmin
doc: "Tinker crystal minimization: minimizes the energy of a crystal with respect to the atom positions and the lattice dimensions.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it; the key file must define the crystal cell"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per atom convergence criterion"
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
  - id: structure_files
    type: File[]
    doc: "New version of the coordinate file written by the program (name.xyz_2)"
    outputBinding:
      glob: "*.xyz_*"
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
stdout: tinker_xtalmin.out
