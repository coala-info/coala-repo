cwlVersion: v1.2
class: CommandLineTool
baseCommand: potential
label: tinker_potential
doc: "Tinker electrostatic potential utility: creates grid points around a molecule, reads a quantum mechanical potential from a Gaussian CUBE file, calculates the model potential on a grid, compares potentials, or fits electrostatic parameters to a target grid.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: mode
    type: int
    doc: "Utility mode: 1 create grid points, 2 read a QM potential from a Gaussian CUBE file, 3 calculate the model potential, 4 compare two model potentials, 5 compare a model potential to a target grid, 6 fit electrostatic parameters to a target grid"
    default: 3
    inputBinding:
      position: 1
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: second_coordinate_file
    type:
      - 'null'
      - File
    doc: "Second coordinate file (.xyz) for mode 4"
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: target_potential_file
    type:
      - 'null'
      - File
    doc: "Target grid and potential file (.pot) for modes 5 and 6"
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: output_each_point
    type:
      - 'null'
      - string
    doc: "Output the potential value at each grid point (Y or N) for modes 3 to 5"
    inputBinding:
      position: 4
  - id: rms_gradient
    type:
      - 'null'
      - float
    doc: "RMS gradient termination criterion of the parameter fit in mode 6"
    inputBinding:
      position: 5
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
  - id: grid_file
    type: File?
    doc: "Grid points for Gaussian CUBEGEN (mode 1)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).grid
  - id: potential_file
    type: File[]
    doc: "Calculated potential values on the grid"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).pot*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true});
        if (inputs.second_coordinate_file) { l.push({"entryname": inputs.second_coordinate_file.basename, "entry": inputs.second_coordinate_file, "writable": true}); }
        if (inputs.target_potential_file) { l.push({"entryname": inputs.target_potential_file.basename, "entry": inputs.target_potential_file, "writable": true}); }
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_potential.out
