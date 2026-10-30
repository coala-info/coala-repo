cwlVersion: v1.2
class: CommandLineTool
baseCommand: protein
label: tinker_protein
doc: "Tinker protein builder: builds internal and Cartesian coordinates of a polypeptide from the amino acid sequence and optional backbone and side chain torsion angles.\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: output_name
    type: string
    doc: "Base name for the output files (name.seq, name.int, name.xyz)"
    inputBinding:
      position: 1
  - id: key_file
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file; it is staged as <output name>.key"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
  - id: stdin_answers
    type: File
    doc: "Text file sent to standard input: first the title line, then one residue per line (three-letter code, optionally followed by phi psi omega, up to four chi angles, disulfide partner and D/L chirality; MOL starts a new chain), then an empty line, then Y or N to cyclize the chain. The key file must name the force field parameter file."
outputs:
  - id: sequence_file
    type: File
    doc: "Amino acid sequence file"
    outputBinding:
      glob: $(inputs.output_name).seq
  - id: internal_file
    type: File
    doc: "Internal coordinate file"
    outputBinding:
      glob: $(inputs.output_name).int
  - id: xyz_file
    type: File
    doc: "Cartesian coordinate file"
    outputBinding:
      glob: $(inputs.output_name).xyz
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.key_file) { l.push({"entryname": inputs.output_name + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdin: $(inputs.stdin_answers.path)
stdout: tinker_protein.out
