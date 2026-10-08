cwlVersion: v1.2
class: CommandLineTool
baseCommand: itsx.py
label: frogs_itsx.py
doc: "Uses ITSx to detect/extracts ITS1 or ITS2 regions from ITS sequences.\n\nTool\
  \ homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: check_its_only
    type:
      - 'null'
      - boolean
    doc: Check only if sequences seem to be an ITS (mutually exclusive with --region)
    inputBinding:
      position: 101
      prefix: --check-its-only
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Keep temporary files to debug program.
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
    inputBinding:
      position: 101
      prefix: --nb-cpus
  - id: organism_groups
    type:
      - 'null'
      - type: array
        items: string
    doc: Reduce ITSx scan to specified organim groups. - F
    inputBinding:
      position: 101
      prefix: --organism-groups
  - id: region
    type:
      - 'null'
      - string
    doc: 'Which fungal ITS region is targeted and trimmed: either ITS1 or ITS2 (mutually
      exclusive with --check-its-only; one of the two is required)'
    inputBinding:
      position: 101
      prefix: --region
  - id: html_path
    type:
      - 'null'
      - string
    doc: 'The HTML file containing the graphs. [Default:'
    inputBinding:
      position: 102
      prefix: --html
  - id: log_file_path
    type:
      - 'null'
      - string
    doc: This output file will contain several informations on
    inputBinding:
      position: 103
      prefix: --log-file
  - id: output_biom_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --output-biom
  - id: output_fasta_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 105
      prefix: --output-fasta
  - id: output_removed_sequences_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 106
      prefix: --output-removed-sequences
outputs:
  - id: output_fasta
    type:
      - 'null'
      - File
    doc: 'sequences file out from ITSx (format: FASTA). [Default: itsx.fasta]'
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''itsx.fasta'';
        }'
  - id: output_biom
    type:
      - 'null'
      - File
    doc: 'Abundance file without chimera (format: BIOM). Written when input_biom is
      given. [Default: itsx_abundance.biom]'
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''itsx_abundance.biom'';
        }'
  - id: output_removed_sequences
    type:
      - 'null'
      - File
    doc: 'sequences file removed (format: FASTA). [Default: itsx_removed.fasta]'
    outputBinding:
      glob: '${ return inputs.output_removed_sequences_path ? inputs.output_removed_sequences_path
        : ''itsx_removed.fasta''; }'
  - id: html
    type:
      - 'null'
      - File
    doc: 'The HTML file containing the graphs. [Default: itsx.html]'
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''itsx.html''; }'
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file with several informations on executed commands (--log-file)
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''itsx_stdout.txt'';
        }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: itsx_stdout.txt
