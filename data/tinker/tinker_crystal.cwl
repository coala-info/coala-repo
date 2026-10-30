cwlVersion: v1.2
class: CommandLineTool
baseCommand: crystal
label: tinker_crystal
doc: "Tinker crystal structure utility: converts between fractional and Cartesian coordinates, moves stray molecules into the unit cell, builds a unit cell from an asymmetric unit and a space group, or builds a block of unit cells; the result is written to a new coordinate file.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: mode
    type: int
    doc: "Utility mode: 1 convert fractional to Cartesian coordinates, 2 convert Cartesian to fractional coordinates (<name>.frac), 3 move stray molecules into the unit cell, 4 make a unit cell from an asymmetric unit (space group from the key file), 5 make a big block from a single unit cell"
    default: 3
    inputBinding:
      position: 2
  - id: merge_fragments
    type:
      - 'null'
      - string
    doc: "Mode 4: merge fragments to form full molecules (Y or N)"
    inputBinding:
      position: 3
  - id: move_into_cell
    type:
      - 'null'
      - string
    doc: "Mode 4: move any stray molecules into the unit cell (Y or N)"
    inputBinding:
      position: 4
  - id: center_cell
    type:
      - 'null'
      - string
    doc: "Mode 4: locate the center of the unit cell at the coordinate origin (Y or N)"
    inputBinding:
      position: 5
  - id: replicates
    type:
      - 'null'
      - int[]
    doc: "Mode 5: numbers of replicates along the a-, b- and c-axes"
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
  - id: xyz_file
    type: File[]
    doc: "Cartesian coordinates (new version of the .xyz file)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).xyz_*
  - id: frac_file
    type: File?
    doc: "Fractional coordinates (mode 2)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).frac
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
        l.push({"entryname": "tinker_stdin.txt", "entry": (inputs.replicates ? [inputs.replicates.join(" ")] : []).join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_crystal.out
