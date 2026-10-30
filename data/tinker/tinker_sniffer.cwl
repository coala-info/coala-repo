cwlVersion: v1.2
class: CommandLineTool
baseCommand: sniffer
label: tinker_sniffer
doc: "Tinker global optimization by the discrete generalized descent method (SNIFFER): searches for the global energy minimum of a structure.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: initial_steps
    type: int
    doc: "Number of steps in the initial set"
    default: 100
    inputBinding:
      position: 2
  - id: target_energy
    type: float
    doc: "Target energy for the global minimum; the search stops when it is reached"
    default: 0.0
    inputBinding:
      position: 3
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per atom convergence criterion"
    default: 1.0
    inputBinding:
      position: 4
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
stdout: tinker_sniffer.out
