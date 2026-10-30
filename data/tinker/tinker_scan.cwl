cwlVersion: v1.2
class: CommandLineTool
baseCommand: scan
label: tinker_scan
doc: "Tinker potential surface scan: finds local minima of a structure by normal mode searches and writes each minimum as a numbered structure file or to an archive.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: torsion_selection
    type: int
    doc: "Selection of rotatable torsions: 0 automatic, 1 manual rotate, 2 manual freeze (manual bonds are given in stdin_answers)"
    default: 0
    inputBinding:
      position: 2
  - id: eigenvectors
    type: int
    doc: "Number of eigenvectors for the local search"
    default: 5
    inputBinding:
      position: 3
  - id: energy_threshold
    type: float
    doc: "Energy threshold in kcal/mole above the global minimum for local minima"
    default: 100.0
    inputBinding:
      position: 4
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per atom convergence criterion"
    default: 0.0001
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
  - id: stdin_answers
    type: File
    doc: "Text file sent to standard input with the atom number pairs of the bonds to rotate or freeze, one pair per line; only needed for torsion_selection 1 or 2"
    default:
      class: File
      basename: stdin_answers.txt
      contents: "\n"
outputs:
  - id: archive_files
    type: File[]
    doc: "Archive of minima (name.arc), written when the archive keyword is active"
    outputBinding:
      glob: "*.arc"
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
stdout: tinker_scan.out
