cwlVersion: v1.2
class: CommandLineTool
baseCommand: xtalfit
label: tinker_xtalfit
doc: "Tinker crystal parameter fitting: fits van der Waals, charge, dipole and polarizability parameters to the lattice energies and structures of one or more crystals.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Crystal structure file (.xyz) named in the standard input answers; it is staged with its key file, and the key file must define the crystal cell"
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
    doc: "Text file sent to standard input, one answer per line: parameter type and atom class lines ending with 0, the RMS gradient criterion, the number of structures, then the structure file name and the target lattice energy of each structure"
    default:
      class: File
      basename: stdin_answers.txt
      contents: "\n"
outputs:
  - id: fit_key_file
    type: File[]
    doc: "Key file with the fitted parameters"
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
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdin: $(inputs.stdin_answers.path)
stdout: tinker_xtalfit.out
