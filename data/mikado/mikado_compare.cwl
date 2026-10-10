cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - compare
label: mikado_compare
doc: "Compare a prediction annotation with a reference annotation (class codes, precision and recall).\n\
  \nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: reference
    type: File
    doc: Reference annotation file.
    inputBinding:
      position: 101
      prefix: -r
  - id: prediction
    type:
      - 'null'
      - File
    doc: Prediction annotation file.
    inputBinding:
      position: 101
      prefix: -p
  - id: self
    type:
      - 'null'
      - boolean
    doc: Compare the reference with itself.
    inputBinding:
      position: 101
      prefix: --self
  - id: internal
    type:
      - 'null'
      - boolean
    doc: Compare each isoform of a gene with the others.
    inputBinding:
      position: 101
      prefix: --internal
  - id: index
    type:
      - 'null'
      - boolean
    doc: Stop after generating the GFF index for the reference.
    inputBinding:
      position: 101
      prefix: --index
  - id: no_shm
    type:
      - 'null'
      - boolean
    doc: Switch off /dev/shm usage.
    inputBinding:
      position: 101
      prefix: --no-shm
  - id: shm
    type:
      - 'null'
      - boolean
    doc: Switch on /dev/shm usage.
    inputBinding:
      position: 101
      prefix: --shm
  - id: distance
    type:
      - 'null'
      - int
    doc: 'Maximum distance for a transcript to be considered a polymerase run-on. Default: 2000.'
    inputBinding:
      position: 101
      prefix: --distance
  - id: protein_coding
    type:
      - 'null'
      - boolean
    doc: Only consider transcripts with a CDS (both in reference and prediction).
    inputBinding:
      position: 101
      prefix: -pc
  - id: out
    type:
      - 'null'
      - string
    doc: 'Prefix for the output files. Default: mikado_compare.'
    inputBinding:
      position: 101
      prefix: -o
  - id: fuzzy_intron_match
    type:
      - 'null'
      - int
    doc: Introns count as matched if their splices are within N bases of the annotated ones (default 0).
    inputBinding:
      position: 101
      prefix: -fm
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Calculate exonic statistics leniently in the TMAP.
    inputBinding:
      position: 101
      prefix: --lenient
  - id: do_not_report_fusions
    type:
      - 'null'
      - boolean
    doc: Do not report fusions in the input.
    inputBinding:
      position: 101
      prefix: -nF
  - id: exclude_utr
    type:
      - 'null'
      - boolean
    doc: Strip reference and prediction transcripts of their UTRs.
    inputBinding:
      position: 101
      prefix: -eu
  - id: no_index
    type:
      - 'null'
      - boolean
    doc: Do not save an index of the reference.
    inputBinding:
      position: 101
      prefix: -n
  - id: extended_refmap
    type:
      - 'null'
      - boolean
    doc: Also report recall and precision statistics in the RefMap.
    inputBinding:
      position: 101
      prefix: -erm
  - id: use_prediction_alias
    type:
      - 'null'
      - boolean
    doc: Use the alias rather than the transcript ID in the TMAP and REFMAP files.
    inputBinding:
      position: 101
      prefix: -upa
  - id: log
    type:
      - 'null'
      - string
    doc: Log file.
    inputBinding:
      position: 101
      prefix: -l
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose logging.
    inputBinding:
      position: 101
      prefix: -v
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: GZip the TMAP and REFMAP files.
    inputBinding:
      position: 101
      prefix: -z
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes.
    inputBinding:
      position: 101
      prefix: -x
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named inside the configuration or list file (annotations, genome, scoring file, ...); staged
      in the working directory so the relative names resolve.
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: Comparison tables (.tmap, .refmap, .stats) and the reference index.
    outputBinding:
      glob:
        - '$(inputs.out ? inputs.out : ''mikado_compare'')*'
  - id: log_file
    type:
      - 'null'
      - File
    doc: Log file.
    outputBinding:
      glob: $(inputs.log)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '$(inputs.staged_files ? inputs.staged_files : [])'
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
