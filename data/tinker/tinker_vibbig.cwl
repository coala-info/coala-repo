cwlVersion: v1.2
class: CommandLineTool
baseCommand: vibbig
label: tinker_vibbig
doc: "Tinker vibrational analysis of large systems: finds normal modes by an iterative block method (starting at the lowest or highest frequency); the number of roots comes from the vib-roots keyword.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: start_mode
    type: string
    doc: "Start at the Lowest (L) or Highest (H) frequency normal mode"
    default: "L"
    inputBinding:
      position: 2
  - id: frequency_cutoff
    type: float
    doc: "Frequency cutoff in cm-1 (must be positive)"
    default: 1000.0
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
outputs:
  - id: restart_files
    type: File[]
    doc: "Binary scratch and restart files written by the program (name.vb1, name.vb2, name.blk, ...)"
    outputBinding:
      glob: "*.vb?"
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
stdout: tinker_vibbig.out
