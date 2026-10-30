cwlVersion: v1.2
class: CommandLineTool
baseCommand: pss
label: tinker_pss
doc: "Tinker potential smoothing and search: follows a structure along a smoothing schedule (forward and backward) and optionally runs local searches at each smoothing level; every level is written as name.000, name.001, ...\n\nTool homepage: https://dasher.wustl.edu/tinker/"
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
  - id: forward_smoothing
    type: string
    doc: "Perform forward smoothing from the input structure (Y or N)"
    default: "Y"
    inputBinding:
      position: 4
  - id: schedule_type
    type: string
    doc: "Smoothing schedule: Q quadratic, C cubic or S sigmoidal"
    default: "C"
    inputBinding:
      position: 5
  - id: local_search
    type: string
    doc: "Local search type: C Cartesian, T torsional or N none"
    default: "N"
    inputBinding:
      position: 6
  - id: search_directions
    type:
      - 'null'
      - int[]
    doc: "First and last local search directions (1 is the highest frequency mode); required when local_search is C or T"
    inputBinding:
      position: 7
  - id: search_smoothing_limit
    type:
      - 'null'
      - float
    doc: "Largest smoothing level at which local searches are made; required when local_search is C or T"
    inputBinding:
      position: 8
  - id: restrict_to_children
    type:
      - 'null'
      - string
    doc: "Restrict local search to children of the input structure (Y or N); asked only with a local search and no forward smoothing"
    inputBinding:
      position: 9
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per atom convergence criterion"
    default: 0.0001
    inputBinding:
      position: 10
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
stdout: tinker_pss.out
