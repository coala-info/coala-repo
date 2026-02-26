cwlVersion: v1.2
class: CommandLineTool
baseCommand: itsx.py
label: frogs_itsx.py
doc: "Uses ITSx to detect/extracts ITS1 or ITS2 regions from ITS sequences.\n\nTool
  homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: check_its_only
    type:
      - 'null'
      - boolean
    doc: Check only if sequences seem to be an ITS (mutually exclusive with 
      --region)
    inputBinding:
      position: 101
      prefix: --check-its-only
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep temporary files to debug program.
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: input_biom
    type:
      - 'null'
      - File
    doc: 'The abundance file for clusters by sample (format: BIOM).'
    inputBinding:
      position: 101
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: 'The cluster sequences (format: FASTA).'
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: nb_cpus
    type:
      - 'null'
      - int
    doc: The maximum number of CPUs used.
    default: 1
    inputBinding:
      position: 101
      prefix: --nb-cpus
  - id: organism_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Reduce ITSx scan to specified organim groups.
    default:
      - F
    inputBinding:
      position: 101
      prefix: --organism-groups
  - id: region
    type:
      - 'null'
      - string
    doc: 'Which fungal ITS region is targeted and trimmed: either ITS1 or ITS2. (mutually
      exclusive with --check-its-only)'
    inputBinding:
      position: 101
      prefix: --region
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: 'sequences file out from ITSx (format: FASTA).'
    outputBinding:
      glob: $(inputs.output_fasta)
  - id: output_biom
    type:
      - 'null'
      - File
    doc: 'Abundance file without chimera (format: BIOM ).'
    outputBinding:
      glob: $(inputs.output_biom)
  - id: output_removed_sequences
    type:
      - 'null'
      - File
    doc: 'sequences file removed (format: FASTA).'
    outputBinding:
      glob: $(inputs.output_removed_sequences)
  - id: html
    type:
      - 'null'
      - File
    doc: The HTML file containing the graphs.
    outputBinding:
      glob: $(inputs.html)
  - id: log_file
    type:
      - 'null'
      - File
    doc: This output file will contain several informations on executed 
      commands.
    outputBinding:
      glob: $(inputs.log_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
