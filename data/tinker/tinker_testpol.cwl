cwlVersion: v1.2
class: CommandLineTool
baseCommand: testpol
label: tinker_testpol
doc: "Tinker polarization test: compares the induced dipoles from direct, PCG, OPT and TCG polarization solvers against the exact mutual polarization.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it; the force field must use polarization (for example AMOEBA)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: dipole_components
    type:
      - 'null'
      - string
    doc: "Output induced dipole components by atom (Y or N); asked only for systems of more than 100 atoms"
    inputBinding:
      position: 2
  - id: optimize_opt_coefficients
    type: string
    doc: "Optimize the OPT coefficients for the current system (Y or N)"
    default: "N"
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
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_testpol.out
