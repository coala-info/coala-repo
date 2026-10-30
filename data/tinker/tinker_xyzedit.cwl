cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyzedit
label: tinker_xyzedit
doc: "Tinker coordinate file editor: applies one editing operation (renumber, remove or insert atoms, change atom types, assign connectivity, translate, rotate, trim or fill a periodic box, append structures and more) to a coordinate file and writes a new version.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: edit_mode
    type: int
    doc: "Number of the editing function: 1 offset atom numbers, 2 remove atoms, 3 remove atom types, 4 delete inactive atoms beyond a cutoff, 5 insert atoms, 6 replace atom type, 7 linear chain connectivity, 8 distance connectivity, 9 BASIC atom types, 10 transfer atom types, 11 Bohr to Angstrom, 12 mirror image, 13 translate by vector, 14 center of mass to origin, 15 atom to origin, 16 inertial frame, 17 rotate about axis, 18 rigid body coordinates, 19 stray molecules into box, 20 trim box, 21 truncated octahedron, 22 rhombic dodecahedron, 23 append second file, 24 create and fill a box, 25 soak in solvent, 26 place ions"
    inputBinding:
      position: 2
  - id: mode_arguments
    type:
      - 'null'
      - string[]
    doc: "Command-line answers of the chosen function, in order (for example the offset for mode 1, the old and new atom types for mode 6, the x y z vector for mode 13, the axis and angle for mode 17, the box edges for mode 20, the template file for mode 10)"
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
  - id: stdin_answers
    type: File
    doc: "Text file sent to standard input with the answers to the questions the chosen function asks, one per line (for example the atom numbers of mode 2 or 5, the atom types of mode 3); empty ends the program"
    default:
      class: File
      basename: stdin_answers.txt
      contents: "\n"
outputs:
  - id: edited_structures
    type: File[]
    doc: "Edited coordinate file(s) written by the program (name.xyz_2 and later versions)"
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
stdin: $(inputs.stdin_answers.path)
stdout: tinker_xyzedit.out
