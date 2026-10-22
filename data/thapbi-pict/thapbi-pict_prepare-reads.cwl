cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - thapbi_pict
  - prepare-reads
label: thapbi-pict_prepare-reads
doc: "Trim and merge paired FASTQ files of marker amplicons.\n\nTool homepage: https://github.com/peterjc/thapbi-pict"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "One or more paired FASTQ filenames named XXX_1.fastq[.gz] and XXX_2.fastq[.gz], or XXX_R1/XXX_R2, or XXX_R1_001/XXX_R2_001."
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
  - id: output
    type: string
    doc: "Output directory. Required."
    inputBinding:
      position: 101
      prefix: -o
  - id: abundance
    type:
      - 'null'
      - int
    doc: "Minimum abundance applied to unique marker sequences in each sample (i.e. each FASTQ pair). Default 2 meaning only exclude singletons."
    inputBinding:
      position: 101
      prefix: -a
  - id: abundance_fraction
    type:
      - 'null'
      - float
    doc: "Minimum abundance fraction, low frequency noise threshold applied to unique marker sequences in each sample. Default zero, meaning not used."
    inputBinding:
      position: 101
      prefix: -f
  - id: database
    type:
      - 'null'
      - File
    doc: "Marker database to use, default '-' for bundled DB."
    inputBinding:
      position: 101
      prefix: -d
  - id: markers
    type:
      - 'null'
      - string
    doc: "If the DB defines multiple amplicon markers, but you only wish to use a subset, list them as a comma-separated string"
    inputBinding:
      position: 101
      prefix: -k
  - id: flip
    type:
      - 'null'
      - boolean
    doc: "Also check reverse complement strand for primers."
    inputBinding:
      position: 101
      prefix: --flip
  - id: merged_cache
    type:
      - 'null'
      - string
    doc: "Advanced option. Cache directory for temporary per-sample FASTA file after overlap merging."
    inputBinding:
      position: 101
      prefix: --merged-cache
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
    doc: "Folder with one sub-folder per marker holding the per-sample FASTA files"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.input)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/thapbi-pict:1.0.21--pyhdfd78af_0
