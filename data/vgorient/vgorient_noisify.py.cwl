cwlVersion: v1.2
class: CommandLineTool
baseCommand: noisify.py
label: vgorient_noisify.py
doc: "Processes fasta files to optionally reverse and randomly rotate sequences.\n\nTool homepage: https://github.com/whelixw/vgOrient"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA files (*.fasta) to process; they are staged into one directory that the tool reads.
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output folder.
    default: transformed
    inputBinding:
      position: 2
      prefix: --output_prefix
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: Flag to reverse complement sequences with 50% chance.
    inputBinding:
      position: 2
      prefix: --reverse
  - id: num_replicates
    type:
      - 'null'
      - int
    doc: Number of replicates to generate.
    inputBinding:
      position: 2
      prefix: --num_replicates
  - id: mute
    type:
      - 'null'
      - boolean
    doc: Mute stdout for transformations details.
    inputBinding:
      position: 2
      prefix: --mute
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: replicate_dirs
    type:
      type: array
      items: Directory
    doc: One output folder per replicate, holding the transformed FASTA files and the transformation log.
    outputBinding:
      glob: "${ return 'fasta_dir/' + (inputs.output_prefix ? inputs.output_prefix : 'transformed') + '_*'; }"
arguments:
  - position: 1
    valueFrom: fasta_dir
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: 'fasta_dir', listing: inputs.fasta_files})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vgorient:0.1.1--pyhdfd78af_0
stdout: vgorient_noisify.py.out
