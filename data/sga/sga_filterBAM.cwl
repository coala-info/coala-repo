cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - filterBAM
label: sga_filterBAM
doc: 'Discard mate-pair alignments from a BAM file that are potentially erroneous


  Tool homepage: https://github.com/jts/sga'
inputs:
  - id: bam_file
    type: File
    doc: BAM file of mate-pair alignments, sorted by read name, containing only paired mapped reads.
    inputBinding:
      position: 200
  - id: asqg
    type:
      - 'null'
      - File
    doc: Load an asqg file and filter pairs that are shorter than --max-distance
    inputBinding:
      position: 103
      prefix: -a
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'filter out pairs where one read has an error rate higher than F (default: no filter)'
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: mate_contamination
    type:
      - 'null'
      - boolean
    doc: filter out pairs aligning with FR orientation, which may be contiminates in a mate pair library
    inputBinding:
      position: 103
      prefix: -c
  - id: max_distance
    type:
      - 'null'
      - int
    doc: search the graph for a path completing the mate-pair fragment. If the path is less than LEN then the pair will be discarded.
    inputBinding:
      position: 103
      prefix: --max-distance
  - id: max_kmer_depth
    type:
      - 'null'
      - int
    doc: filter out pairs that contain a kmer that has been seen in the FM-index more than N times
    inputBinding:
      position: 103
      prefix: -x
  - id: min_quality
    type:
      - 'null'
      - float
    doc: 'filter out pairs where one read has mapping quality less than F (default: 10)'
    inputBinding:
      position: 103
      prefix: --min-quality
  - id: prefix
    type:
      - 'null'
      - string
    doc: load the FM-index with prefix STR
    inputBinding:
      position: 103
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
  - id: out_bam_path
    type: string
    doc: write the filtered reads to FILE
    inputBinding:
      position: 104
      prefix: -o
  - id: index_reads
    type:
      - 'null'
      - File
    doc: Reads file whose FM-index (.bwt, .rbwt, .sai, .rsai) is loaded with --prefix (staged in the working directory; give the file name without extension as prefix).
    secondaryFiles:
      - ^.bwt
      - ^.rbwt
      - ^.sai
      - ^.rsai
outputs:
  - id: out_bam
    type: File
    doc: write the filtered reads to FILE
    outputBinding:
      glob: $(inputs.out_bam_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - '${ return inputs.index_reads ? inputs.index_reads : []; }'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
