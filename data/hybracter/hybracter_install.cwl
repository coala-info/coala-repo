cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybracter
  - install
label: hybracter_install
doc: "Downloads and installs the plassembler database\n\nTool homepage: https://github.com/gbouras13/hybracter"
inputs:
  - id: snake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Additional arguments for Snakemake
    inputBinding:
      position: 1
  - id: use_conda
    type:
      - 'null'
      - boolean
    doc: Use conda for Snakemake rules (default).
    inputBinding:
      position: 102
      prefix: --use-conda
  - id: no_use_conda
    type:
      - 'null'
      - boolean
    doc: Do not use conda for Snakemake rules.
    inputBinding:
      position: 102
      prefix: --no-use-conda
  - id: snake_default
    type:
      - 'null'
      - string
    doc: Customise Snakemake runtime args
    inputBinding:
      position: 102
      prefix: --snake-default
  - id: databases
    type:
      - 'null'
      - string
    doc: Directory where the Plassembler Database will be installed to.
    inputBinding:
      position: 102
      prefix: --databases
  - id: medaka
    type:
      - 'null'
      - boolean
    doc: Download medaka models.
    inputBinding:
      position: 102
      prefix: --medaka
  - id: mac
    type:
      - 'null'
      - boolean
    doc: If you are running Hybracter on Mac, installs v1.8.0 of Medaka, as higher
      versions break.
    inputBinding:
      position: 102
      prefix: --mac
  - id: output
    type:
      - 'null'
      - string
    doc: Temporary directory where intermediate files will be stored for hybracter
      install. This will be deleted.
    inputBinding:
      position: 102
      prefix: --output
  - id: configfile
    type:
      - 'null'
      - string
    doc: Custom config file
    inputBinding:
      position: 102
      prefix: --configfile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: databases_dir
    type:
      - 'null'
      - Directory
    doc: The plassembler database directory.
    outputBinding:
      glob: $(inputs.databases)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybracter:0.12.0--pyhdfd78af_0
stdout: hybracter_install.out
