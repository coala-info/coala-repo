cwlVersion: v1.2
class: CommandLineTool
baseCommand: vibrate
label: tinker_vibrate
doc: "Tinker normal mode vibrational analysis: prints the vibrational frequencies and writes the coordinates of the selected modes to numbered files (<name>.001, ...).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: modes
    type: string[]
    doc: "Vibrations to write: A for all, or a list of mode numbers (a negative number starts a range)"
    default: ["A"]
    inputBinding:
      position: 2
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
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: mode_files
    type: File[]
    doc: "Coordinates of the output vibrational modes"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).[0-9][0-9][0-9]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_vibrate.out
