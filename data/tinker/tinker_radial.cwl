cwlVersion: v1.2
class: CommandLineTool
baseCommand: radial
label: tinker_radial
doc: "Tinker radial distribution function: computes the pairwise g(r) between two atom names or atom types from a coordinate archive.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: archive_file
    type: File
    doc: "Coordinate archive file (.arc) with the frames to analyze"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: first_frame
    type: int
    doc: "Number of the first frame to use"
    default: 1
    inputBinding:
      position: 2
  - id: last_frame
    type: int
    doc: "Number of the last frame to use"
    default: 100000
    inputBinding:
      position: 3
  - id: frame_step
    type: int
    doc: "Step increment between frames"
    default: 1
    inputBinding:
      position: 4
  - id: first_atom
    type: string
    doc: "First atom name or atom type number"
    inputBinding:
      position: 5
  - id: second_atom
    type: string
    doc: "Second atom name or atom type number"
    inputBinding:
      position: 6
  - id: maximum_distance
    type: float
    doc: "Maximum distance to accumulate in Angstroms (used when there is no periodic box)"
    default: 10.0
    inputBinding:
      position: 7
  - id: bin_width
    type: float
    doc: "Width of the distance bins in Angstroms"
    default: 0.01
    inputBinding:
      position: 8
  - id: include_intramolecular
    type: string
    doc: "Include intramolecular pairs in the distribution (Y or N)"
    default: "N"
    inputBinding:
      position: 9
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
        var l = [{"entryname": inputs.archive_file.basename, "entry": inputs.archive_file}];
        if (inputs.key_file) { l.push({"entryname": inputs.archive_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_radial.out
