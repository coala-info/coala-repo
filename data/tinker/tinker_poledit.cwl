cwlVersion: v1.2
class: CommandLineTool
baseCommand: poledit
label: tinker_poledit
doc: "Tinker multipole editing utility: sets up atomic multipoles from quantum mechanical output, alters local coordinate frames, or removes the intramolecular polarization; writes a new coordinate file and a new key file with the multipole and polarization parameters.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: mode
    type: int
    doc: "Utility mode: 1 use multipoles from Stone GDMA output, 2 use multipoles from Multiwfn MBIS output, 3 alter local coordinate frame definitions, 4 remove the intramolecular polarization"
    default: 4
    inputBinding:
      position: 1
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: stdin_answers
    type:
      - 'null'
      - string[]
    doc: "Answers to the questions the program asks on standard input, one per line (mode 4: Y or N to condense symmetric atoms to equivalent types, then sets of equivalent atoms; an empty line accepts the default or ends the input)"
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
  - id: new_coordinates
    type: File[]
    doc: "New version of the coordinate file"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).xyz_*
  - id: new_key
    type: File[]
    doc: "New version of the key file with the multipole parameters"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).key_*
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
        l.push({"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        l.push({"entryname": "tinker_stdin.txt", "entry": (inputs.stdin_answers || []).join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_poledit.out
