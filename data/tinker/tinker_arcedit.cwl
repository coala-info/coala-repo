cwlVersion: v1.2
class: CommandLineTool
baseCommand: arcedit
label: tinker_arcedit
doc: "Tinker coordinate archive editing utility: creates an archive from numbered files, extracts frames, trims atoms, folds or unfolds molecules in the periodic box, and converts between the formatted archive and the DCD binary format.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: archive_file
    type: File
    doc: "Coordinate archive file (.arc)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: mode
    type: int
    doc: "Operation: 1 create an archive from numbered coordinate files, 2 extract frames to numbered coordinate files, 3 trim atoms from the frames, 4 fold molecules into the periodic box, 5 unfold molecules, 6 remove periodic boundary wrapping, 7 convert to DCD binary, 8 convert from DCD binary"
    default: 2
    inputBinding:
      position: 2
  - id: removed_atoms
    type:
      - 'null'
      - int[]
    doc: "Mode 3: numbers of the atoms to remove; a negative first number starts a range (the list is closed with a 0 by the wrapper)"
    inputBinding:
      position: 3
      valueFrom: "${ return self === null ? null : self.concat([0]); }"
  - id: first
    type: int
    doc: "Number of the first frame (or file) to use"
    default: 1
    inputBinding:
      position: 4
  - id: last
    type: int
    doc: "Number of the last frame (or file) to use"
    default: 1
    inputBinding:
      position: 5
  - id: step
    type: int
    doc: "Step increment between frames"
    default: 1
    inputBinding:
      position: 6
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
  - id: frame_files
    type:
      - 'null'
      - File[]
    doc: "Mode 1: numbered coordinate files (<name>.001, ...) to combine into the archive"
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: extracted_frames
    type: File[]
    doc: "Numbered coordinate files and new archive versions written by the program"
    outputBinding:
      glob: $(inputs.archive_file.nameroot).[0-9][0-9][0-9]*
  - id: trimmed_archive
    type: File[]
    doc: "New versions of the archive (modes 3 to 8)"
    outputBinding:
      glob: $(inputs.archive_file.nameroot).arc_*
  - id: dcd_file
    type: File[]
    doc: "DCD binary archive (mode 7)"
    outputBinding:
      glob: $(inputs.archive_file.nameroot).dcd
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
        l.push({"entryname": inputs.archive_file.basename, "entry": inputs.archive_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.archive_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.frame_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        l.push({"entryname": "tinker_stdin.txt", "entry": "\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_arcedit.out
