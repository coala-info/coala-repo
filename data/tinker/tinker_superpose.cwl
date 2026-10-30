cwlVersion: v1.2
class: CommandLineTool
baseCommand: superpose
label: tinker_superpose
doc: "Tinker structure superposition: fits the atoms of one structure onto those of a second structure and reports the root mean square deviation.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "First structure (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: coordinate_file2
    type: File
    doc: "Second structure (.xyz); it is fitted onto the first"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: fit_option
    type: int
    doc: "Fit option: 1 fit atoms start through stop of structure 1 onto the corresponding atoms of structure 2"
    default: 1
    inputBinding:
      position: 3
  - id: first_atom
    type: int
    doc: "First atom of the fit range (0 uses all atoms)"
    default: 0
    inputBinding:
      position: 4
  - id: last_atom
    type: int
    doc: "Last atom of the fit range (0 uses all atoms)"
    default: 0
    inputBinding:
      position: 5
  - id: include_hydrogens
    type: string
    doc: "Include the hydrogen atoms in the fit (Y or N)"
    default: "Y"
    inputBinding:
      position: 6
  - id: periodic_boundaries
    type:
      - 'null'
      - string
    doc: "Apply periodic boundary conditions (Y or N); asked only for periodic systems"
    inputBinding:
      position: 7
  - id: weighting
    type: string
    doc: "Mass- or unit-weighted coordinates (M or U)"
    default: "U"
    inputBinding:
      position: 8
  - id: write_fitted
    type: string
    doc: "Write the best-fit coordinates of the second structure (Y or N)"
    default: "N"
    inputBinding:
      position: 9
  - id: rms_cutoff
    type: float
    doc: "Cutoff value for listing individual RMS deviations"
    default: 0.0
    inputBinding:
      position: 10
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
  - id: fitted_structures
    type: File[]
    doc: "Best-fit coordinates of the second structure (name.xyz_2), written when write_fitted is Y"
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
stdout: tinker_superpose.out
