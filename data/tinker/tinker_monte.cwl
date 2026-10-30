cwlVersion: v1.2
class: CommandLineTool
baseCommand: monte
label: tinker_monte
doc: "Tinker Monte Carlo minimization (basin hopping) of a structure with Cartesian or torsional random moves; accepted minima are written to a trajectory archive (.arc).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: steps
    type: int
    doc: "Maximum number of Monte Carlo steps"
    default: 1000
    inputBinding:
      position: 2
  - id: efficiency
    type: float
    doc: "Search efficiency termination criterion"
    default: 0.01
    inputBinding:
      position: 3
  - id: move_type
    type: string
    doc: "Type of random moves: C Cartesian or T torsional"
    default: "C"
    inputBinding:
      position: 4
  - id: max_step
    type: float
    doc: "Maximum step: Angstroms for Cartesian moves, degrees for torsional moves"
    default: 3.0
    inputBinding:
      position: 5
  - id: rms_gradient
    type: float
    doc: "RMS gradient criterion for the local minimizations"
    default: 0.01
    inputBinding:
      position: 6
  - id: temperature
    type: float
    doc: "Temperature in K used in the Metropolis test"
    default: 500.0
    inputBinding:
      position: 7
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
  - id: trajectory
    type: File
    doc: "Archive of the accepted minima"
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
stdout: tinker_monte.out
