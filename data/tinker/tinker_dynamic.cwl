cwlVersion: v1.2
class: CommandLineTool
baseCommand: dynamic
label: tinker_dynamic
doc: "Tinker molecular dynamics simulation; writes a restart file (.dyn) and a trajectory archive (.arc).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: cartesian_coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: steps
    type: int
    doc: "Number of dynamics steps"
    inputBinding:
      position: 2
  - id: time_step
    type: float
    doc: "Length of the time step in femtoseconds"
    default: 1.0
    inputBinding:
      position: 3
  - id: save_interval
    type: float
    doc: "Time between trajectory saves in picoseconds"
    default: 0.1
    inputBinding:
      position: 4
  - id: ensemble
    type: int
    doc: "Simulation control mode. Non-periodic systems: 1 constant energy, 2 constant temperature. Periodic systems: 1 NVE, 2 NVT, 3 NPH, 4 NPT"
    default: 1
    inputBinding:
      position: 5
  - id: temperature
    type:
      - 'null'
      - float
    doc: "Temperature in K (needed for ensemble 2 or 4)"
    inputBinding:
      position: 6
  - id: pressure
    type:
      - 'null'
      - float
    doc: "Pressure in atm (needed for ensemble 3 or 4)"
    inputBinding:
      position: 7
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
  - id: restart_file
    type: File
    doc: "Restart file with the final coordinates and velocities"
    outputBinding:
      glob: $(inputs.cartesian_coordinate_file.nameroot).dyn
  - id: trajectory
    type: File
    doc: "Trajectory archive"
    outputBinding:
      glob: $(inputs.cartesian_coordinate_file.nameroot).arc
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.cartesian_coordinate_file.basename, "entry": inputs.cartesian_coordinate_file, "writable": true}];
        if (inputs.key_file) { l.push({"entryname": inputs.cartesian_coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_dynamic.out
