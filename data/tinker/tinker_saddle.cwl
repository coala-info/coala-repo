cwlVersion: v1.2
class: CommandLineTool
baseCommand: saddle
label: tinker_saddle
doc: "Tinker transition state location: finds a saddle point between two endpoint structures by synchronous transit and quadratic path methods.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "First endpoint structure (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: coordinate_file2
    type: File
    doc: "Second endpoint structure (.xyz); its key file is the one that is read"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: gradient_criterion
    type: float
    doc: "RMS gradient per atom convergence criterion"
    default: 0.1
    inputBinding:
      position: 3
  - id: synchronous_transit_scans
    type: string
    doc: "Perform synchronous transit pathway scans (Y or N)"
    default: "N"
    inputBinding:
      position: 4
  - id: key_file
    type:
      - 'null'
      - File
    loadContents: true
    doc: "Keyword (.key) file; it is staged as <coordinate base name>.key beside the coordinate file"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: transition_state
    type: File[]
    doc: "Transition state estimate and final saddle point (tstate.xyz)"
    outputBinding:
      glob: "tstate.xyz"
  - id: structure_files
    type: File[]
    doc: "Other coordinate files written by the program"
    outputBinding:
      glob: "*.xyz_*"
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
        if (inputs.coordinate_file2) { l.push({"entryname": inputs.coordinate_file2.basename, "entry": inputs.coordinate_file2}); if (inputs.key_file && inputs.coordinate_file2.nameroot != inputs.coordinate_file.nameroot) { l.push({"entryname": inputs.coordinate_file2.nameroot + ".key", "entry": inputs.key_file.contents}); } }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_saddle.out
