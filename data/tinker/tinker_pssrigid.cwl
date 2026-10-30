cwlVersion: v1.2
class: CommandLineTool
baseCommand: pssrigid
label: tinker_pssrigid
doc: "Tinker potential smoothing and search for rigid bodies: follows a structure of rigid molecules along a smoothing schedule with optional local searches; every level is written as name.000, name.001, ...\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: smoothing_parameter
    type: float
    doc: "Potential smoothing deformation parameter asked by the smoothing setup (0 means no smoothing)"
    default: 0.0
    inputBinding:
      position: 2
  - id: smoothing_steps
    type: int
    doc: "Number of steps in the smoothing schedule"
    default: 100
    inputBinding:
      position: 3
  - id: local_search
    type: string
    doc: "Use a local search at each smoothing level (Y or N)"
    default: "N"
    inputBinding:
      position: 4
  - id: search_directions
    type:
      - 'null'
      - int
    doc: "Number of directions for the local search; required when local_search is Y"
    inputBinding:
      position: 5
  - id: search_smoothing_limit
    type:
      - 'null'
      - float
    doc: "Largest smoothing value at which local searches are made; required when local_search is Y"
    inputBinding:
      position: 6
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per rigid body convergence criterion"
    default: 0.0001
    inputBinding:
      position: 7
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
    doc: "Numbered coordinate files written by the program (name.000, name.001, ...)"
    outputBinding:
      glob: "*.[0-9][0-9][0-9]"
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
stdout: tinker_pssrigid.out
