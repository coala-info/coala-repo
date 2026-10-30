cwlVersion: v1.2
class: CommandLineTool
baseCommand: torsfit
label: tinker_torsfit
doc: "Tinker torsion parameter fitting: fits torsional force field parameters to relative quantum mechanical conformational energies from Gaussian output files.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it; the force field must define the torsions across the central bond"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: central_atoms_first
    type: string
    doc: "Numbers of the two central atoms of the first torsion, given as one argument with the numbers separated by a space (for example '1 2')"
    inputBinding:
      position: 2
  - id: central_atoms_second
    type:
      - 'null'
      - string
    doc: "Numbers of the two central atoms of an optional second torsion, given as one argument with the numbers separated by a space"
    inputBinding:
      position: 3
  - id: gaussian_logs
    type: File[]
    doc: "Gaussian output files (.log) of the conformations, staged in the working directory"
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
    doc: "Text file sent to standard input, one answer per line: an empty line for the second-torsion question when central_atoms_second is not given, the numbers of the torsions to fit (one line), the number of conformations, then the Gaussian output file name of each conformation"
    default:
      class: File
      basename: stdin_answers.txt
      contents: "\n"
outputs:
  - id: fit_key_file
    type: File[]
    doc: "Key file with the fitted torsion parameters"
    outputBinding:
      glob: "*.key_*"
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
        (inputs.gaussian_logs || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdin: $(inputs.stdin_answers.path)
stdout: tinker_torsfit.out
