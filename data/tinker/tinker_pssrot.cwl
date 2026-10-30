cwlVersion: v1.2
class: CommandLineTool
baseCommand: pssrot
label: tinker_pssrot
doc: "Tinker potential smoothing and search in torsional space: follows a structure along a smoothing schedule with optional local searches; every level is written as name.000, name.001, ...\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Internal coordinate (Z-matrix) file (.int), for example written by xyzint"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: smoothing_parameter
    type: float
    doc: "Potential smoothing deformation parameter asked by the smoothing setup (0 means no smoothing)"
    default: 0.0
    inputBinding:
      position: 2
  - id: torsion_selection
    type: int
    doc: "Selection of rotatable torsions: 0 automatic, 1 manual choice of rotatable bonds, 2 manual choice of frozen bonds (manual bonds are given in stdin_answers)"
    default: 0
    inputBinding:
      position: 3
  - id: smoothing_steps
    type: int
    doc: "Number of steps in the smoothing schedule"
    default: 100
    inputBinding:
      position: 4
  - id: local_search
    type: string
    doc: "Use a local search at each smoothing level (Y or N)"
    default: "N"
    inputBinding:
      position: 5
  - id: search_directions
    type:
      - 'null'
      - int
    doc: "Number of directions for the local search; required when local_search is Y"
    inputBinding:
      position: 6
  - id: search_smoothing_limit
    type:
      - 'null'
      - float
    doc: "Largest smoothing value at which local searches are made; required when local_search is Y"
    inputBinding:
      position: 7
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per atom convergence criterion"
    default: 0.0001
    inputBinding:
      position: 8
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
  - id: stdin_answers
    type: File
    doc: "Text file sent to standard input with the atom number pairs of the bonds to rotate or freeze, one pair per line; only needed for torsion_selection 1 or 2"
    default:
      class: File
      basename: stdin_answers.txt
      contents: "\n"
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
stdin: $(inputs.stdin_answers.path)
stdout: tinker_pssrot.out
