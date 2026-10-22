cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - sample-tally
label: thapbi-pict_sample-tally
doc: "Prepare ASV x sample TSV sequence file using MD5 naming.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: marker
    type:
      - 'null'
      - string
    doc: "Which amplicon marker to process. Required if the DB has more than one defined."
    inputBinding:
      position: 101
      prefix: -k
  - id: input
    type:
      type: array
      items: File
    doc: "One or more per-sample FASTA files."
    inputBinding:
      position: 101
      prefix: -i
  - id: ignore_prefixes
    type:
      - 'null'
      - type: array
        items: string
    doc: "One or more filename prefixes to ignore, default Undetermined_ unknown_"
    inputBinding:
      position: 101
      prefix: --ignore-prefixes
  - id: synctrls
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more synthetic control FASTA filenames (which must also appear in inputs). Can use '-' for none."
    inputBinding:
      position: 101
      prefix: -y
  - id: negctrls
    type:
      - 'null'
      - type: array
        items: File
    doc: "One or more negative control FASTA filenames (which must also appear in the inputs). Can use '-' for none."
    inputBinding:
      position: 101
      prefix: -n
  - id: output
    type:
      - 'null'
      - string
    doc: "Single output filename, '-' for stdout (default). The pipeline will use the .tally.tsv extension."
    inputBinding:
      position: 101
      prefix: -o
  - id: fasta
    type:
      - 'null'
      - string
    doc: "Optional output FASTA filename, '-' for stdout."
    inputBinding:
      position: 101
      prefix: --fasta
  - id: biom
    type:
      - 'null'
      - string
    doc: "Optional BIOM format output."
    inputBinding:
      position: 101
      prefix: -b
  - id: database
    type:
      - 'null'
      - File
    doc: "Marker database to use, default '-' for bundled DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: synthetic
    type:
      - 'null'
      - string
    doc: "Comma separated case insensitive genus list of any spike-in sequences in the database which should be expected in the negative controls. Default 'synthetic', use '' if none."
    inputBinding:
      position: 101
      prefix: --synthetic
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum abundance applied to unique marker sequences in each sample. Default 100."
    inputBinding:
      position: 101
      prefix: -a
  - id: abundance_fraction
    type:
      - 'null'
      - float
    doc: "Minimum abundance fraction, low frequency noise threshold applied to unique marker sequences in each sample. Default 0.001 meaning 0.1%."
    inputBinding:
      position: 101
      prefix: -f
  - id: total
    type:
      - 'null'
      - int
    doc: "Minimum total abundance for sequences. Applied after per-sample thresholds. Default 0 (not used)."
    inputBinding:
      position: 101
      prefix: -t
  - id: minlen
    type:
      - 'null'
      - int
    doc: "Minimum length sequence to accept (default 100)."
    inputBinding:
      position: 101
      prefix: --minlen
  - id: maxlen
    type:
      - 'null'
      - int
    doc: "Maximum length sequence to accept (default 1000)."
    inputBinding:
      position: 101
      prefix: --maxlen
  - id: denoise
    type:
      - 'null'
      - string
    doc: "Optional read-correction algorithm, default '-' for none: unoise-l, usearch or vsearch."
    inputBinding:
      position: 101
      prefix: --denoise
  - id: unoise_alpha
    type:
      - 'null'
      - float
    doc: "UNOISE read-correction alpha parameter. Default 2.0 for UNOISE-L."
    inputBinding:
      position: 101
      prefix: --unoise-alpha
  - id: unoise_gamma
    type:
      - 'null'
      - int
    doc: "UNOISE read-correction gamma parameter. Default 4 for UNOISE-L."
    inputBinding:
      position: 101
      prefix: --unoise-gamma
  - id: temp
    type:
      - 'null'
      - string
    doc: "Debug option. Specify an (ideally empty) directory to use for temporary files, which will not be deleted."
    inputBinding:
      position: 101
      prefix: --temp
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of parallel threads to use in called tools. Use zero for all available. Default 1."
    inputBinding:
      position: 101
      prefix: --cpu
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: "Sample tally table"
    outputBinding:
      glob: $(inputs.output)
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: "Optional FASTA output"
    outputBinding:
      glob: $(inputs.fasta)
  - id: biom_file
    type:
      - 'null'
      - File
    doc: "Optional BIOM output"
    outputBinding:
      glob: $(inputs.biom)
  - id: log
    type: stdout
    doc: "Standard output when no output file is given"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
stdout: thapbi-pict_sample-tally.out
