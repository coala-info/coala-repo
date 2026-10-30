cwlVersion: v1.2
class: CommandLineTool
baseCommand: alchemy
label: tinker_alchemy
doc: "Tinker free energy perturbation: computes the free energy difference for a small change of the lambda coupling parameter by Boltzmann weighting the potential energy difference over the snapshots of a trajectory stored as numbered coordinate files.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: snapshot_files
    type: File[]
    doc: "Numbered coordinate files of the trajectory snapshots (<name>.001, <name>.002, ...)"
  - id: first_file
    type: int
    doc: "Number of the first snapshot file to analyze"
    default: 1
  - id: last_file
    type: int
    doc: "Number of the last snapshot file to analyze"
    default: 1
  - id: lambda_increment
    type: float
    doc: "Lambda increment for the perturbation"
    default: 0.1
  - id: temperature
    type: float
    doc: "System temperature in K"
    default: 300.0
  - id: number_of_blocks
    type: int
    doc: "Number of blocks for sub-averages"
    default: 1
  - id: intermolecular_only
    type: boolean
    doc: "Consider only the intermolecular perturbation energy"
    default: false
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
        (inputs.snapshot_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f, "writable": false}); });
        l.push({"entryname": "tinker_stdin.txt", "entry": [inputs.first_file + " " + inputs.last_file, String(inputs.lambda_increment), String(inputs.temperature), String(inputs.number_of_blocks), inputs.intermolecular_only ? "Y" : "N"].join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_alchemy.out
