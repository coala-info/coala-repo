cwlVersion: v1.2
class: CommandLineTool
baseCommand: anneal
label: tinker_anneal
doc: "Tinker molecular dynamics simulated annealing: runs an optional equilibration phase and then a cooling protocol (linear, sigmoidal or exponential) between a hot and a cold temperature; writes a restart file (.dyn) and a trajectory archive (.arc).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: hot_temperature
    type: float
    doc: "Initial (hot) temperature in K"
    default: 1000.0
    inputBinding:
      position: 2
  - id: cold_temperature
    type: float
    doc: "Final (cold) temperature in K"
    default: 0.0
    inputBinding:
      position: 3
  - id: equilibration_steps
    type: int
    doc: "Number of equilibration steps at the initial temperature"
    default: 0
    inputBinding:
      position: 4
  - id: cooling_steps
    type: int
    doc: "Number of steps of the cooling protocol"
    default: 2000
    inputBinding:
      position: 5
  - id: cooling_type
    type: string
    doc: "Cooling protocol: L linear, S sigmoidal or E exponential"
    default: "L"
    inputBinding:
      position: 6
  - id: time_step
    type: float
    doc: "Length of the time step in femtoseconds"
    default: 1.0
    inputBinding:
      position: 7
  - id: save_interval
    type: float
    doc: "Time between trajectory saves in picoseconds"
    default: 0.1
    inputBinding:
      position: 8
  - id: mass_factor
    type: float
    doc: "Increase the atomic weights by a factor of 10^x (x = 0 keeps the masses)"
    default: 0.0
    inputBinding:
      position: 9
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
  - id: restart_file
    type: File
    doc: "Restart file with the final coordinates and velocities"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).dyn
  - id: trajectory
    type: File
    doc: "Trajectory archive"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).arc
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_anneal.out
