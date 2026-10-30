cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - divergent
label: pygtftk_divergent
doc: "Find transcripts with divergent promoters. These transcripts will be defined here as those whose promoter region (defined by -u/-d) overlaps with the tss of another gene in reverse/antisens orientation. This may be useful to select coding genes in head-to-head orientation or LUAT as described in \"Divergent transcription is associated with promoters of transcriptional regulators\" (Lepoivre C, BMC Genomics, 2013). The output is a GTF with an additional key ('divergent') whose value is set to '.' if the gene has no antisens transcript in its promoter region. If the gene has an antisens transcript in its promoter region the 'divergent' key is set to the identifier of the transcript whose tss is the closest relative to the considered promoter. The tss to tss distance is also provided as an additional key (dist_to_divergent).\n\nTool homepage: http://github.com/dputhier/pygtftk"
inputs:
  - id: inputfile
    type: File
    doc: "Path to the GTF file. Default to STDIN"
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: outputfile_path
    type: string
    doc: "Output file."
    inputBinding:
      position: 102
      prefix: --outputfile
  - id: chrom_info
    type:
      - File
      - string
    doc: "Tabulated two-columns file. Chromosomes as column 1 and their sizes as column 2"
    inputBinding:
      position: 101
      prefix: --chrom-info
  - id: upstream
    type: ['null', int]
    doc: "Extend the promoter in 5' by a given value (int). Defines the region around the tss."
    inputBinding:
      position: 101
      prefix: --upstream
  - id: downstream
    type: ['null', int]
    doc: "Extend the region in 3' by a given value (int). Defines the region around the tss."
    inputBinding:
      position: 101
      prefix: --downstream
  - id: no_annotation
    type: ['null', boolean]
    doc: "Do not annotate the GTF. Just select the divergent transcripts."
    inputBinding:
      position: 101
      prefix: --no-annotation
  - id: no_strandness
    type: ['null', boolean]
    doc: "Do not consider strandness (only look whether the promoter from a transcript overlaps with the promoter from another gene)."
    inputBinding:
      position: 101
      prefix: --no-strandness
  - id: key_name
    type: ['null', string]
    doc: "The name of the key."
    inputBinding:
      position: 101
      prefix: --key-name
  - id: verbosity
    type: ['null', int]
    doc: "Set output verbosity ([0-3])."
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: no_date
    type: ['null', boolean]
    doc: "Do not add date to output file names."
    inputBinding:
      position: 101
      prefix: --no-date
  - id: add_chr
    type: ['null', boolean]
    doc: "Add 'chr' to chromosome names before printing output."
    inputBinding:
      position: 101
      prefix: --add-chr
  - id: tmp_dir
    type: ['null', string]
    doc: "Keep all temporary files into this folder."
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: keep_all
    type: ['null', boolean]
    doc: "Try to keep all temporary files even if process does not terminate normally."
    inputBinding:
      position: 101
      prefix: --keep-all
  - id: logger_file
    type: ['null', string]
    doc: "Stores the arguments passed to the command into a file."
    inputBinding:
      position: 101
      prefix: --logger-file
  - id: write_message_to_file
    type: ['null', string]
    doc: "Store all message into a file."
    inputBinding:
      position: 101
      prefix: --write-message-to-file
outputs:
  - id: outputfile
    type: File
    doc: "Output file."
    outputBinding:
      glob: $(inputs.outputfile_path)
  - id: logger_file_out
    type: ['null', File]
    doc: "Stores the arguments passed to the command into a file."
    outputBinding:
      glob: $(inputs.logger_file)
  - id: write_message_to_file_out
    type: ['null', File]
    doc: "Store all message into a file."
    outputBinding:
      glob: $(inputs.write_message_to_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pygtftk:1.6.2--py39heed1e64_5
