cwlVersion: v1.2
class: CommandLineTool
baseCommand: correlate
label: tinker_correlate
doc: "Tinker correlation function utility: computes the velocity autocorrelation function or the superposition (RMS deviation) correlation function from a series of numbered coordinate cycle files.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: mode
    type: int
    doc: "Correlation function: 1 velocity autocorrelation (needs <name>.NNNv velocity files), 2 superposition correlation of coordinate files"
    default: 2
    inputBinding:
      position: 1
  - id: base_name
    type: string
    doc: "Base name of the numbered coordinate cycle files (<name>.001, <name>.002, ...)"
    inputBinding:
      position: 2
  - id: cycle_files
    type: File[]
    doc: "Numbered coordinate (or velocity) cycle files, for example made by arcedit"
  - id: first_file
    type: int
    doc: "Number of the first cycle file"
    default: 1
    inputBinding:
      position: 3
  - id: last_file
    type: int
    doc: "Number of the last cycle file"
    default: 1
    inputBinding:
      position: 4
  - id: file_step
    type: int
    doc: "Step increment between files"
    default: 1
    inputBinding:
      position: 5
  - id: max_separation
    type: int
    doc: "Maximum separation of frames used in the correlation (0 for all)"
    default: 0
    inputBinding:
      position: 6
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        (inputs.cycle_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f, "writable": false}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_correlate.out
