cwlVersion: v1.2
class: CommandLineTool
baseCommand: insilicosv
label: insilicosv
doc: "insilicoSV is a software to design and simulate complex structural variants,
  both novel and known.\n\nTool homepage: https://github.com/PopicLab/insilicoSV"
inputs:
  - id: config
    type: File
    doc: YAML config file
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: random_seed
    type:
      - 'null'
      - int
    doc: if non-zero, random seed for random number generation
    inputBinding:
      position: 102
      prefix: --random_seed
  - id: support_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config (reference FASTA, BED or VCF files), staged beside the config so the relative names resolve
  - id: root_directory
    type:
      - 'null'
      - string
    doc: root directory for all files given
    inputBinding:
      position: 102
      prefix: --root
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: haplotype_fastas
    type: File[]
    doc: Simulated haplotype genomes (sim.hapA.fa, sim.hapB.fa) and inserted sequences (sim.insertions.fa)
    outputBinding:
      glob: sim.*.fa
  - id: sv_bed
    type: File
    doc: Simulated SV calls in BEDPE-like format
    outputBinding:
      glob: sim.bed
  - id: stats
    type: File
    doc: Simulation statistics
    outputBinding:
      glob: sim.stats.txt
  - id: log
    type:
      - 'null'
      - File
    doc: Log file (written when generate_log_file is set in the config)
    outputBinding:
      glob: sim.log
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.config)
        writable: true
      - entry: $(inputs.support_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/insilicosv:0.0.6--pyhdfd78af_0
stdout: insilicosv.out
