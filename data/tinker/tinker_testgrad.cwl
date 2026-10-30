cwlVersion: v1.2
class: CommandLineTool
baseCommand: testgrad
label: tinker_testgrad
doc: "Tinker gradient test: computes the analytical and numerical gradient of the potential energy and compares them.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: analytical
    type: string
    doc: "Compute the analytical gradient vector (Y or N)"
    default: "Y"
    inputBinding:
      position: 2
  - id: numerical
    type: string
    doc: "Compute the numerical gradient vector (Y or N)"
    default: "Y"
    inputBinding:
      position: 3
  - id: step_size
    type: float
    doc: "Finite difference step size in Angstroms"
    default: 1e-05
    inputBinding:
      position: 4
  - id: component_breakdown
    type:
      - 'null'
      - string
    doc: "Output the breakdown by gradient component (Y or N); asked only for systems of more than 100 atoms"
    inputBinding:
      position: 5
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
stdout: tinker_testgrad.out
