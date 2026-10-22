cwlVersion: v1.2
class: CommandLineTool
baseCommand: xyzpdb
label: tinker_xyzpdb
doc: "Tinker conversion of a Cartesian coordinate file to a Protein Data Bank (or CIF) file.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: file_format
    type: string
    doc: "Output format, PDB or CIF"
    default: "PDB"
    inputBinding:
      position: 2
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: "Sequence (.seq) file; it is staged as <coordinate base name>.seq so that residues are written as ATOM records instead of HETATM records"
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
  - id: pdb_file
    type: File
    doc: "Protein Data Bank file"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).pdb
  - id: cif_file
    type: File?
    doc: "mmCIF file (when the CIF format is chosen)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).cif
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true}];
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        if (inputs.sequence_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".seq", "entry": inputs.sequence_file}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_xyzpdb.out
