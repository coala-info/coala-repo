cwlVersion: v1.2
class: CommandLineTool
baseCommand: nucleic
label: tinker_nucleic
doc: "Tinker nucleic acid builder: builds the Cartesian and internal coordinates of a DNA or RNA strand or double helix (A-, B- or Z-form) from a nucleotide sequence; writes sequence (.seq), internal coordinate (.int) and Cartesian coordinate (.xyz) files.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: output_name
    type: string
    doc: "Base name used for the output files (.seq, .int and .xyz)"
    inputBinding:
      position: 1
  - id: title
    type: string
    doc: "Title of the structure"
    default: "nucleic acid"
  - id: helix_form
    type: string
    doc: "Helix form: A, B or Z"
    default: "B"
  - id: residues
    type: string[]
    doc: "Nucleotides from 5' to 3', one PDB residue code per entry (for example DA, DC, DG, DT, A, C, G, U); an entry MOL starts a new strand"
  - id: double_helix
    type: boolean
    doc: "Build a double helix using complementary bases"
    default: false
  - id: key_file
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file with the parameters line (for example: parameters amoebabio09); staged as <output_name>.key"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: sequence_file
    type: File
    doc: "Sequence file"
    outputBinding:
      glob: $(inputs.output_name).seq
  - id: internal_coordinates
    type: File
    doc: "Internal coordinate (Z-matrix) file"
    outputBinding:
      glob: $(inputs.output_name).int
  - id: xyz_file
    type: File
    doc: "Cartesian coordinates"
    outputBinding:
      glob: $(inputs.output_name).xyz
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
        if (inputs.key_file) { l.push({"entryname": inputs.output_name + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        l.push({"entryname": "tinker_stdin.txt", "entry": [inputs.title, inputs.helix_form].concat(inputs.residues, [""], [inputs.double_helix ? "Y" : "N"]).join("\n") + "\n" + "\n\n\n\n\n\n\n\n\n\n"});
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_nucleic.out
