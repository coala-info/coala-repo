cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdbxyz
label: tinker_pdbxyz
doc: "Tinker conversion of a Protein Data Bank file to a Cartesian coordinate file (.xyz) and a sequence file (.seq).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: protein_data_bank_file_name
    type: File
    doc: "Protein Data Bank file (.pdb)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
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
  - id: xyz_file
    type: File
    doc: "Cartesian coordinates"
    outputBinding:
      glob: $(inputs.protein_data_bank_file_name.nameroot).xyz
  - id: seq_file
    type: File?
    doc: "Sequence file"
    outputBinding:
      glob: $(inputs.protein_data_bank_file_name.nameroot).seq
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{"entryname": inputs.protein_data_bank_file_name.basename, "entry": inputs.protein_data_bank_file_name, "writable": true}];
        if (inputs.key_file) { l.push({"entryname": inputs.protein_data_bank_file_name.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_pdbxyz.out
