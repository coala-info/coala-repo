cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igvtools
  - toTDF
label: igvtools_toTDF
doc: "Convert a sorted .wig, .cn, .igv or .gct file (or a .list file) to tiled data format (.tdf).\n\nTool homepage: http://www.broadinstitute.org/igv/"
inputs:
  - id: input_file
    type: File
    doc: "Input file (.wig, .cn, .igv, .gct, mage-tab or .list)"
    inputBinding:
      position: 10
  - id: output_name
    type: string
    doc: "Binary output file name, must end in .tdf"
    inputBinding:
      position: 11
  - id: genome
    type: ['null', File, string]
    doc: "Genome id or path to a chrom.sizes, .genome or genome json file (a FASTA file also works) (default hg18)"
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 12
  - id: max_zoom
    type: ['null', int]
    doc: "Maximum zoom level to precompute (default 7)"
    inputBinding:
      position: 1
      prefix: --maxZoom
  - id: window_functions
    type: ['null', string]
    doc: "Comma delimited window functions: min, max, mean, median, p2, p10, p90, p98"
    inputBinding:
      position: 1
      prefix: --windowFunctions
  - id: probe_file
    type: ['null', File]
    doc: "Bed file (chr start end name) mapping probe identifiers to locations; for gct files"
    inputBinding:
      position: 1
      prefix: --probeFile
  - id: file_type
    type: ['null', string]
    doc: "Explicit file type: mage-tab, .wig, .cn, .igv or .gct (required for mage-tab and .list files)"
    inputBinding:
      position: 1
      prefix: --fileType
  - id: tmp_dir
    type: ['null', string]
    doc: "Temporary working directory for the sort of gct and mage-tab files"
    inputBinding:
      position: 1
      prefix: --tmpDir
  - id: max_records
    type: ['null', int]
    doc: "Maximum number of records kept in memory during the sort (default 500000)"
    inputBinding:
      position: 1
      prefix: --maxRecords
outputs:
  - id: output_file
    type: File
    doc: "Tiled data format output (.tdf)"
    outputBinding:
      glob: $(inputs.output_name)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igvtools:2.17.3--hdfd78af_0
