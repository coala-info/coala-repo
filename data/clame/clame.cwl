cwlVersion: v1.2
class: CommandLineTool
baseCommand: clame
label: clame
doc: "Clasificador Metagenomico\n\nTool homepage: https://github.com/andvides/CLAME"
inputs:
  - id: cut_points
    type:
      - 'null'
      - string
    doc: array of cut points (comma separator) for edges constrains
    inputBinding:
      position: 101
      prefix: -e
  - id: enable_print
    type:
      - 'null'
      - boolean
    doc: enable print output to file
    inputBinding:
      position: 101
      prefix: -print
  - id: fm9_file
    type:
      - 'null'
      - File
    doc: Load fm9 file (FM-index made by an earlier clame run)
    inputBinding:
      position: 101
      prefix: -fm9
  - id: input_fastq
    type:
      - 'null'
      - boolean
    doc: input file is in a fastq format
    inputBinding:
      position: 101
      prefix: -fastq
  - id: min_bases
    type:
      - 'null'
      - int
    doc: minimum number of bases to take an alignment
    inputBinding:
      position: 101
      prefix: -b
  - id: min_reads_per_bin
    type:
      - 'null'
      - int
    doc: minimum number of reads to report a bin
    inputBinding:
      position: 101
      prefix: -sizeBin
  - id: multi_fasta_file
    type: File
    doc: FILE with all the reads
    inputBinding:
      position: 101
      prefix: -multiFasta
  - id: output_file_name
    type:
      - 'null'
      - string
    doc: name for the output-file if print option was selected
    default: output
    inputBinding:
      position: 101
      prefix: -output
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -nt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: binning
    type:
      - 'null'
      - File
    doc: All bins reported (OUTPUT.binning)
    outputBinding:
      glob: $(inputs.output_file_name).binning
  - id: bins
    type:
      type: array
      items: File
    doc: Sequences of each reported bin (OUTPUT_N.fasta or .fastq, with -print)
    outputBinding:
      glob: $(inputs.output_file_name)_*
  - id: fm9_index
    type:
      - 'null'
      - File
    doc: FM-index output (OUTPUT.fm9)
    outputBinding:
      glob: $(inputs.output_file_name).fm9
  - id: read_index
    type:
      - 'null'
      - File
    doc: Original read names and the index used by CLAME (OUTPUT.index)
    outputBinding:
      glob: $(inputs.output_file_name).index
  - id: links
    type:
      - 'null'
      - File
    doc: Histogram of links by number of reads (OUTPUT.links)
    outputBinding:
      glob: $(inputs.output_file_name).links
  - id: result
    type:
      - 'null'
      - File
    doc: Adjacency list of the overlaps detected for each read (OUTPUT.result)
    outputBinding:
      glob: $(inputs.output_file_name).result
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clame:1.0--h503566f_3
stdout: clame.out
successCodes:
  - 0
  - 1
