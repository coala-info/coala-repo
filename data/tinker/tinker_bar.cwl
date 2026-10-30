cwlVersion: v1.2
class: CommandLineTool
baseCommand: bar
label: tinker_bar
doc: "Tinker thermodynamic perturbation utility: creates a BAR file with the potential energies of two trajectories in two states, and computes free energy (FEP and Bennett acceptance ratio), enthalpy and entropy differences from it.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: mode
    type: int
    doc: "Utility mode: 1 create a BAR file with perturbed potential energies, 2 compute thermodynamic values from a BAR file"
    default: 2
    inputBinding:
      position: 1
  - id: primary_file
    type: File
    doc: "Mode 1: coordinate archive of trajectory A (.arc); mode 2: BAR file (.bar)"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: temperature_a
    type:
      - 'null'
      - float
    doc: "Mode 1: temperature of trajectory A in K"
    inputBinding:
      position: 3
  - id: trajectory_b
    type:
      - 'null'
      - File
    doc: "Mode 1: coordinate archive of trajectory B (.arc); a key file with the potential of state B must be given as key_file_b"
    inputBinding:
      position: 4
      valueFrom: $(self.basename)
  - id: temperature_b
    type:
      - 'null'
      - float
    doc: "Mode 1: temperature of trajectory B in K"
    inputBinding:
      position: 5
  - id: use_logs
    type:
      - 'null'
      - string
    doc: "Mode 1: obtain energies from trajectory log files if available (Y or N)"
    inputBinding:
      position: 6
  - id: frame_range_a
    type:
      - 'null'
      - int[]
    doc: "Mode 2: first frame, last frame and step of trajectory A"
    inputBinding:
      position: 3
  - id: frame_range_b
    type:
      - 'null'
      - int[]
    doc: "Mode 2: first frame, last frame and step of trajectory B"
    inputBinding:
      position: 4
  - id: key_file
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file of trajectory A (state 0), staged as <name of primary_file>.key"
  - id: key_file_b
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file of trajectory B (state 1), staged as <name of trajectory_b>.key"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: bar_file
    type: File?
    doc: "BAR file with the perturbed potential energies (mode 1)"
    outputBinding:
      glob: "$(inputs.mode == 1 ? inputs.primary_file.nameroot + \".bar\" : \"no_bar_file_in_this_mode\")"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.primary_file.basename, "entry": inputs.primary_file, "writable": true});
        if (inputs.trajectory_b) { l.push({"entryname": inputs.trajectory_b.basename, "entry": inputs.trajectory_b, "writable": true}); }
        if (inputs.key_file) { l.push({"entryname": inputs.primary_file.nameroot + ".key", "entry": inputs.key_file}); }
        if (inputs.key_file_b && inputs.trajectory_b) { l.push({"entryname": inputs.trajectory_b.nameroot + ".key", "entry": inputs.key_file_b}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_bar.out
