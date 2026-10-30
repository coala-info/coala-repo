cwlVersion: v1.2
class: CommandLineTool
baseCommand: diffuse
label: tinker_diffuse
doc: "Tinker self-diffusion constant of a liquid or solution: computes the mean squared displacement of molecular centers from a periodic coordinate archive and the diffusion constant from it.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_archive
    type: File
    doc: "Coordinate archive file (.arc) of a periodic simulation"
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
  - id: time_increment
    type: float
    doc: "Time between archive frames in picoseconds"
    default: 1.0
    inputBinding:
      position: 5
  - id: excluded_atoms
    type: int[]
    doc: "Numbers of atoms (or molecules made of them) to leave out of the calculation; a negative first number starts a range; 0 excludes none"
    default: [0]
    inputBinding:
      position: 6
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
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.coordinate_archive.basename, "entry": inputs.coordinate_archive, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_archive.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_diffuse.out
