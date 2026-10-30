cwlVersion: v1.2
class: CommandLineTool
baseCommand: intedit
label: tinker_intedit
doc: "Tinker Z-matrix internal coordinate editor: shows and changes bond lengths, bond angles, dihedral angles, chirality and atom types in an internal coordinate file; the commands are read from standard input and EXIT writes a new version of the file (<name>.int_2).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: internal_coordinate_file
    type: File
    doc: "Z-matrix internal coordinate file (.int)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: commands
    type: string[]
    doc: "Editor commands, one per entry, as typed at the INTEDIT prompt: an atom number shows an atom, two atoms a bond (a following line gives the new value, an empty line keeps it), three atoms an angle, four atoms a dihedral, SHOW prints the Z-matrix, EXIT writes the new file, QUIT stops without writing"
    default: ["SHOW", "EXIT"]
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
  - id: edited_coordinates
    type: File[]
    doc: "Edited internal coordinates (new versions of the .int file)"
    outputBinding:
      glob: $(inputs.internal_coordinate_file.nameroot).int_*
arguments:
  - position: 1000
    shellQuote: false
    valueFrom: "< tinker_stdin.txt"
requirements:
  - class: InlineJavascriptRequirement
  - class: ShellCommandRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.internal_coordinate_file.basename, "entry": inputs.internal_coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.internal_coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        l.push({"entryname": "tinker_stdin.txt", "entry": (inputs.commands).join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_intedit.out
