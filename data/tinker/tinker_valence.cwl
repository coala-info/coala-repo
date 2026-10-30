cwlVersion: v1.2
class: CommandLineTool
baseCommand: valence
label: tinker_valence
doc: "Tinker valence parameter utility: sets initial valence force field parameters from quantum mechanical data, compares quantum and force field frequencies, or fits force or structure parameters to quantum results read from a Gaussian output file.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: run_mode
    type: int
    doc: "Function: 1 initial valence parameters, 2 compare QM and MM frequencies, 3 force fit, 4 structure fit"
    inputBinding:
      position: 1
  - id: gaussian_log
    type: File
    doc: "Gaussian output file (.log) with the optimized structure, frequencies and Hessian"
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: gradient_criterion
    type:
      - 'null'
      - float
    doc: "RMS gradient termination criterion for the parameter fit (modes 3 and 4)"
    inputBinding:
      position: 4
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
  - id: parameter_files
    type: File[]
    doc: "Key or parameter files written by the program"
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
        l.push({"entryname": inputs.gaussian_log.basename, "entry": inputs.gaussian_log});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_valence.out
