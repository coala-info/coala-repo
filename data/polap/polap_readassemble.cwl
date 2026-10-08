cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - readassemble
label: polap_readassemble
doc: "Annotate long reads with organelle genes and assemble the plastid or mitochondrial genome\
  \ from the selected reads.\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: long_reads
    type: File
    doc: Long-read data file in FASTQ format; results <name>.pt.fa/.pt.gfa or <name>.mt.gfa
      are written beside it.
    inputBinding:
      position: 101
      prefix: -l
      valueFrom: $(self.basename)
  - id: outdir
    type: string
    doc: Output folder name.
    default: o
    inputBinding:
      position: 101
      prefix: -o
  - id: plastid
    type:
      - 'null'
      - boolean
    doc: Assemble the plastid genome instead of the mitochondrial genome.
    inputBinding:
      position: 101
      prefix: --plastid
  - id: animal
    type:
      - 'null'
      - boolean
    doc: Assemble animal mtDNA.
    inputBinding:
      position: 101
      prefix: --animal
  - id: nano_raw
    type:
      - 'null'
      - boolean
    doc: Long reads are raw ONT reads (default).
    inputBinding:
      position: 101
      prefix: --nano-raw
  - id: pacbio_hifi
    type:
      - 'null'
      - boolean
    doc: Long reads are PacBio HiFi reads.
    inputBinding:
      position: 101
      prefix: --pacbio-hifi
  - id: use_oatk
    type:
      - 'null'
      - boolean
    doc: Use Oatk for the assembly.
    inputBinding:
      position: 101
      prefix: --use-oatk
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir)
  - id: assemblies
    type: File[]
    doc: Assembly sequences, graphs and figures (<name>.pt.* or <name>.mt.*).
    outputBinding:
      glob:
        - $(inputs.long_reads.nameroot).pt.*
        - $(inputs.long_reads.nameroot).mt.*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.long_reads)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_readassemble.out
