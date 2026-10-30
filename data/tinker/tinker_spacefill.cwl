cwlVersion: v1.2
class: CommandLineTool
baseCommand: spacefill
label: tinker_spacefill
doc: "Tinker surface area and volume: computes the van der Waals, accessible or contact-reentrant surface area and volume of a structure.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz); the key file and force field parameter files are staged beside it"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: area_type
    type: int
    doc: "Type of area and volume: 1 van der Waals, 2 accessible area and excluded volume, 3 contact-reentrant"
    default: 1
    inputBinding:
      position: 2
  - id: probe_radius
    type:
      - 'null'
      - float
    doc: "Probe radius in Angstroms; give it only when area_type is 2 or 3"
    inputBinding:
      position: 3
  - id: include_hydrogens
    type: string
    doc: "Include the hydrogen atoms in the computation (Y or N)"
    default: "N"
    inputBinding:
      position: 4
  - id: atom_areas
    type:
      - 'null'
      - string
    doc: "Output the surface area of individual atoms (Y or N); asked only for systems of more than 100 atoms"
    inputBinding:
      position: 5
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
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_spacefill.out
