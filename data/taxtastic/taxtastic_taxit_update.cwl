cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - update
label: taxtastic_taxit_update
doc: "Add or modify files or metadata in a refpkg\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: metadata
    type:
      - 'null'
      - boolean
    doc: "Update metadata instead of files"
    inputBinding:
      position: 1
      prefix: "--metadata"
  - id: stats_type
    type:
      - 'null'
      - string
    doc: "stats file type, one of PhyML, FastTree, RAxML, IQTREE [default: attempt to guess from file contents]"
    inputBinding:
      position: 1
      prefix: "--stats-type"
  - id: frequency_type
    type:
      - 'null'
      - string
    doc: "Residue frequency type from the model, empirical or model. Required for PhyML Amino Acid alignments."
    inputBinding:
      position: 1
      prefix: "--frequency-type"
  - id: refpkg
    type: Directory
    doc: "the reference package to operate on"
    inputBinding:
      position: 101
  - id: key_values
    type:
      - 'null'
      - {type: array, items: string}
    doc: "keys to update, in key=some_file format (or key=value with --metadata); use the base name of each file given in key_files"
    inputBinding:
      position: 102
  - id: key_files
    type:
      - 'null'
      - {type: array, items: File}
    doc: "Files named in key_values; staged in the working directory so that the names resolve"
outputs:
  - id: refpkg_out
    type: Directory
    doc: "The reference package after the update"
    outputBinding:
      glob: "$(inputs.refpkg.basename)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${ var l = [{"entry": inputs.refpkg, "writable": true}];
         (inputs.key_files ? inputs.key_files : []).forEach(function(f){ l.push(f); }); return l; }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_update.out
