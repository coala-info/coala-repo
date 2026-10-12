cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_prokka
label: panaroo_run_prokka
doc: "Re-run gene finding and annotation (Prokka) on genome fasta files so that they can be used as Panaroo input.

Tool homepage: https://gtonkinhill.github.io/panaroo"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.out_dir, "listing": []})'
        writable: true
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: "Input fasta files."
    inputBinding:
      prefix: --input
  - id: out_dir
    type: string
    doc: "Location of an output directory."
    inputBinding:
      prefix: --out_dir
  - id: force
    type:
      - 'null'
      - boolean
    doc: "Overwrite old commands."
    inputBinding:
      prefix: --force
  - id: add_prokka_cmds
    type:
      - 'null'
      - string
    doc: "Additional commands to supply to Prokka (these are not checked)."
    inputBinding:
      prefix: --add_prokka_cmds
  - id: num_training
    type:
      - 'null'
      - int
    doc: "Number of genomes to use in training prodigal (default 10)."
    inputBinding:
      prefix: --num_training
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default 1)."
    inputBinding:
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print additional output."
    inputBinding:
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: "Output directory with the Prokka annotation of each genome."
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panaroo:1.6.0--pyhdfd78af_0
stdout: panaroo_run_prokka.out
