cwlVersion: v1.2
class: CommandLineTool
baseCommand: [seabreeze, run]
label: seabreeze-genomics_run
doc: "Execute given workflow for single sample\n\nTool homepage: https://github.com/barricklab/seabreeze"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.ancestor)
        writable: true
      - entry: $(inputs.assembly)
        writable: true
inputs:
  - id: workflow
    type: string
    doc: "Workflow to run: analyse_genome_sizes, predict_IS_elements, predict_structural_variants, predict_replichore_balance, predict_SV_mechanism, annotate_SV_regions or run_all"
    inputBinding:
      position: 10
  - id: snakemake_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra arguments passed to snakemake
    inputBinding:
      position: 11
  - id: dir
    type: ['null', string]
    doc: Working directory. Default is the current working directory
    inputBinding:
      position: 1
      prefix: --dir
  - id: ancestor
    type: File
    doc: FASTA file of the ancestor or reference sequence (staged writable, the tool requires this)
    inputBinding:
      position: 1
      prefix: --ancestor
      valueFrom: $(self.basename)
  - id: assembly
    type: File
    doc: FASTA file of the assembly or query sequence (staged writable, the tool requires this)
    inputBinding:
      position: 1
      prefix: --assembly
      valueFrom: $(self.basename)
  - id: threads
    type: ['null', int]
    doc: Resources to be used (default 4)
    inputBinding:
      position: 1
      prefix: --threads
  - id: ori
    type: ['null', string]
    doc: Sequence of the origin (IUPAC bases, unique in ancestor and assembly). Required for predict_replichore_balance or run_all
    inputBinding:
      position: 1
      prefix: --ori
  - id: dif
    type: ['null', string]
    doc: Sequence of the terminus (IUPAC bases, unique in ancestor and assembly). Required for predict_replichore_balance or run_all
    inputBinding:
      position: 1
      prefix: --dif
  - id: masked
    type: ['null', boolean]
    doc: Mask insertion sequences
    inputBinding:
      position: 1
      prefix: --masked
outputs:
  - id: csv_files
    type:
      type: array
      items: File
    doc: CSV result tables (genome sizes, IS elements, replichore balance, SV mechanisms)
    outputBinding:
      glob: '*.csv'
  - id: syri_files
    type:
      type: array
      items: File
    doc: SyRI structural variant outputs
    outputBinding:
      glob: '*.syri.out'
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seabreeze-genomics:1.5.0--pyhdfd78af_0
stdout: seabreeze-genomics_run.out
