cwlVersion: v1.2
class: CommandLineTool
baseCommand: testhess
label: tinker_testhess
doc: "Tinker Hessian test: computes the analytical and numerical Hessian matrix of the potential energy and compares them.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: analytical
    type: string
    doc: "Compute the analytical Hessian matrix (Y or N)"
    default: "Y"
    inputBinding:
      position: 2
  - id: numerical
    type:
      - 'null'
      - string
    doc: "Compute the numerical Hessian matrix (Y or N); asked only for systems of up to 300 atoms"
    inputBinding:
      position: 3
  - id: numerical_source
    type:
      - 'null'
      - string
    doc: "Build the numerical Hessian from G gradients or E energies; asked only when the numerical Hessian is computed"
    inputBinding:
      position: 4
  - id: step_size
    type:
      - 'null'
      - float
    doc: "Finite difference step size in Angstroms; asked only when the numerical Hessian is computed"
    inputBinding:
      position: 5
  - id: list_components
    type:
      - 'null'
      - string
    doc: "List the individual Hessian components (Y or N); asked only for numerical Hessians of up to 20 atoms"
    inputBinding:
      position: 6
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
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_testhess.out
