cwlVersion: v1.2
class: CommandLineTool
baseCommand: TdrMappingScripts.pl
label: tdrmapper_TdrMappingScripts.pl
doc: "Map tRNA sequences to a reference tRNA database.\n\nTool homepage: https://github.com/sararselitsky/tDRmapper"
inputs:
  - id: reference_trna
    type: File
    doc: Reference tRNA FASTA file
    inputBinding:
      position: 1
  - id: sample_fa
    type: File
    doc: Trimmed small RNA-seq FASTQ file (Phred 33); working files are written beside it
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: mapped
    type:
      - 'null'
      - File
    doc: All mapped reads
    outputBinding:
      glob: '*.hq_cs.mapped'
  - id: tdr_tables
    type: File[]
    doc: Coverage, species and top 50 tables
    outputBinding:
      glob: ['*.hq_cs.mapped.*.txt']
  - id: tdr_plots
    type: File[]
    doc: Top 50 coverage plots (PDF)
    outputBinding:
      glob: '*.pdf'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sample_fa)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tdrmapper:1.1--pl526_3
stdout: tdrmapper_TdrMappingScripts.pl.out
