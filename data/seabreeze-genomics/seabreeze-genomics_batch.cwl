cwlVersion: v1.2
class: CommandLineTool
baseCommand: [seabreeze, batch]
label: seabreeze-genomics_batch
doc: "Execute given workflow for batch processing\n\nTool homepage: https://github.com/barricklab/seabreeze"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genomes)
        entryname: 02_genomes
        writable: true
      - entry: $(inputs.data)
        writable: true
      - entry: $(inputs.oridif)
        writable: true
inputs:
  - id: genomes
    type: Directory
    doc: Folder with the genome FASTA files named in data.csv; staged as 02_genomes in the working directory
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
    doc: Working directory where output will be created. Default is the current working directory
    inputBinding:
      position: 1
      prefix: --dir
  - id: data
    type: File
    doc: data.csv file (columns assembly, ancestor); staged writable, the tool requires this
    inputBinding:
      position: 1
      prefix: --data
      valueFrom: $(self.basename)
  - id: oridif
    type: File
    doc: Csv file with sequences for the origin and terminus (staged writable, the tool requires this). Required for predict_replichore_balance or run_all
    inputBinding:
      position: 1
      prefix: --oridif
      valueFrom: $(self.basename)
  - id: threads
    type: ['null', int]
    doc: Resources to be used (default 4)
    inputBinding:
      position: 1
      prefix: --threads
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
stdout: seabreeze-genomics_batch.out
