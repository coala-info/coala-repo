cwlVersion: v1.2
class: CommandLineTool
baseCommand: gda
label: tinker_gda
doc: "Tinker Gaussian density annealing (GDA) global optimization: smooths the potential energy surface with Gaussian density functions, anneals from low to high inverse temperature (beta) and finishes with a minimization; one structure per trial is written to numbered files (<name>.001, ...).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: initial_gaussian_width
    type: float
    doc: "Initial mean squared Gaussian width"
    default: 200.0
  - id: number_of_trials
    type: int
    doc: "Number of annealing trials"
    default: 1
  - id: randomize
    type: boolean
    doc: "Start from randomized coordinates (asked only for a single trial)"
    default: false
  - id: beta_start
    type: float
    doc: "Initial value of the inverse temperature beta"
    default: 0.01
  - id: beta_stop
    type: float
    doc: "Final value of the inverse temperature beta"
    default: 10000000000.0
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
  - id: trial_structures
    type: File[]
    doc: "Coordinates of each trial (<name>.001, <name>.002, ...)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).[0-9][0-9][0-9]
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
        l.push({"entryname": "tinker_stdin.txt", "entry": [String(inputs.initial_gaussian_width), String(inputs.number_of_trials)].concat(inputs.number_of_trials == 1 ? [inputs.randomize ? "Y" : "N"] : [], [inputs.beta_start + " " + inputs.beta_stop]).join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_gda.out
