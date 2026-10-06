cwlVersion: v1.2
class: CommandLineTool
baseCommand: berokka
label: berokka
doc: "Trim and clean prokaryotic gene overlaps\n\nTool homepage: https://github.com/tseemann/berokka"
inputs:
  - id: input_contigs
    type: File
    doc: Input long read assembly contigs in FASTA format (e.g. canu.contigs.fasta)
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output directory
    inputBinding:
      position: 102
      prefix: --force
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug info.
    inputBinding:
      position: 102
      prefix: --debug
  - id: readlen
    type:
      - 'null'
      - int
    doc: Approximate max read length [60000].
    inputBinding:
      position: 102
      prefix: --readlen
  - id: fuzz
    type:
      - 'null'
      - int
    doc: Accept local alignment within --fuzz bp of global [5].
    inputBinding:
      position: 102
      prefix: --fuzz
  - id: keepfiles
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files.
    inputBinding:
      position: 102
      prefix: --keepfiles
  - id: noanno
    type:
      - 'null'
      - boolean
    doc: Don't annotate FASTA with circular=true.
    inputBinding:
      position: 102
      prefix: --noanno
  - id: filter
    type:
      - 'null'
      - File
    doc: Contaminants to remove [/usr/local/db/controls.fna].
    inputBinding:
      position: 102
      prefix: --filter
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 103
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: trimmed_fasta
    type: File
    doc: Filtered, trimmed and circularised contigs
    outputBinding:
      glob: $(inputs.outdir_path)/02.trimmed.fa
  - id: results_table
    type: File
    doc: Table of the result for each contig
    outputBinding:
      glob: $(inputs.outdir_path)/03.results.tab
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/berokka:0.2.3--0
