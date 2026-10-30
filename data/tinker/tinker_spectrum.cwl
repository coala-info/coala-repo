cwlVersion: v1.2
class: CommandLineTool
baseCommand: spectrum
label: tinker_spectrum
doc: "Tinker power spectrum: computes the infrared-like power spectrum from a velocity autocorrelation file written by correlate.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: velocity_file
    type: File
    doc: "Velocity autocorrelation file (.vel) written by the correlate program"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: time_step
    type: float
    doc: "Time step between the autocorrelation data points in femtoseconds"
    default: 1.0
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
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.velocity_file.basename, "entry": inputs.velocity_file}];
        if (inputs.key_file) { l.push({"entryname": inputs.velocity_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_spectrum.out
