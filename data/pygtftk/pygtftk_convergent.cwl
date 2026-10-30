cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gtftk
  - convergent
label: pygtftk_convergent
doc: "Find transcripts with convergent tts. These transcripts will be defined here as those whose tts region (defined by -u/-d) overlaps with the tts of another gene in reverse/antisens orientation. The output is a GTF with an additional key ('convergent') whose value is set to '.' if the gene has no convergent transcript in its tts region. If the gene has an antisens transcript in its tts region the 'convergent' key is set to the identifier of the transcript whose tts is the closest relative to the considered tts. The tts to tts distance is also provided as an additional key (dist_to_convergent).\n\nTool homepage: http://github.com/dputhier/pygtftk"
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
    doc: "Tabulated two-columns file. Chromosomes as column 1 and sizes as column 2"
    inputBinding:
      position: 101
      prefix: --chrom-info
  - id: upstream
    type: ['null', int]
    doc: "Extends the tts in 5' by a given value (int). Defines the region around the tts."
    inputBinding:
      position: 101
      prefix: --upstream
  - id: downstream
    type: ['null', int]
    doc: "Extends the region in 3' by a given value (int). Defines the region around the tts."
    inputBinding:
      position: 101
      prefix: --downstream
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
