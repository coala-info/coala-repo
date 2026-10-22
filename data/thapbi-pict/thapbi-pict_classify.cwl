cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - classify
label: thapbi-pict_classify
doc: "Classify FASTA file of marker sequences by species.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "One or more prepared FASTA or sample tally TSV filenames."
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
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum abundance applied to unique marker sequences in each FASTA sample file, default 0 (classify all)."
    inputBinding:
      position: 101
      prefix: -a
  - id: database
    type:
      - 'null'
      - File
    doc: "Marker database to use, default '-' for bundled DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: marker
    type:
      - 'null'
      - string
    doc: "If DB has multiple amplicon markers, which one should be used?"
    inputBinding:
      position: 101
      prefix: -k
  - id: method
    type:
      - 'null'
      - string
    doc: "Classify method to run, default is 'onebp': one of 1s2g,1s3g,1s4g,1s5g,1s6g,1s7g,1s8g,1s9g,blast,identity,onebp,substr."
    inputBinding:
      position: 101
      prefix: -m
  - id: output
    type: string
    doc: "Directory for output reports."
    inputBinding:
      position: 101
      prefix: -o
  - id: biom
    type:
      - 'null'
      - boolean
    doc: "Enable optional BIOM output."
    inputBinding:
      position: 101
      prefix: -b
  - id: temp
    type:
      - 'null'
      - string
    doc: "Debug option. Specify an (ideally empty) directory to use for temporary files, which will not be deleted."
    inputBinding:
      position: 101
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Verbose logging."
    inputBinding:
      position: 101
      prefix: -v
  - id: cpu
    type:
      - 'null'
      - int
    doc: "Number of parallel threads to use in called tools. Use zero for all available. Default 1."
    inputBinding:
      position: 101
      prefix: --cpu
outputs:
  - id: output_dir
    type: Directory
    doc: "Folder with one XXX.method.tsv report per input file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
