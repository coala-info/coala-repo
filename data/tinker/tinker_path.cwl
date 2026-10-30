cwlVersion: v1.2
class: CommandLineTool
baseCommand: path
label: tinker_path
doc: "Tinker reaction path: finds a minimum energy path between a reactant and a product structure by a sequence of constrained optimizations of intermediate points; the path points are written to numbered files named after the product (<name>.001, ...).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: reactant_file
    type: File
    doc: "Cartesian coordinate file (.xyz) of the reactant"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: product_file
    type: File
    doc: "Cartesian coordinate file (.xyz) of the product"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: number_of_points
    type: int
    doc: "Number of path points to generate"
    default: 9
    inputBinding:
      position: 3
  - id: rms_gradient
    type: float
    doc: "RMS gradient per atom termination criterion"
    default: 0.1
    inputBinding:
      position: 4
  - id: key_file
    type:
      - 'null'
      - File
    loadContents: true
    doc: "Keyword (.key) file; it is staged as <reactant and product base names>.key beside the main input file"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: path_points
    type: File[]
    doc: "Coordinates of the path points (<product name>.001, <product name>.002, ...)"
    outputBinding:
      glob: $(inputs.product_file.nameroot).[0-9][0-9][0-9]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.reactant_file.basename, "entry": inputs.reactant_file, "writable": true});
        l.push({"entryname": inputs.product_file.basename, "entry": inputs.product_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.reactant_file.nameroot + ".key", "entry": inputs.key_file.contents}); l.push({"entryname": inputs.product_file.nameroot + ".key", "entry": inputs.key_file.contents}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_path.out
