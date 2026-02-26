cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - filterBAM
label: sga_filterBAM
doc: "Discard mate-pair alignments from a BAM file that are potentially erroneous\n\
  \nTool homepage: https://github.com/jts/sga"
inputs:
  - id: asqg_file
    type: File
    doc: ASQGFILE
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: BAMFILE
    inputBinding:
      position: 2
  - id: asqg
    type:
      - 'null'
      - File
    doc: load an asqg file and filter pairs that are shorter than --max-distance
    inputBinding:
      position: 103
      prefix: --asqg
  - id: error_rate
    type:
      - 'null'
      - float
    doc: 'filter out pairs where one read has an error rate higher than F (default:
      no filter)'
    inputBinding:
      position: 103
      prefix: --error-rate
  - id: mate_contamination
    type:
      - 'null'
      - boolean
    doc: filter out pairs aligning with FR orientation, which may be 
      contiminates in a mate pair library
    inputBinding:
      position: 103
      prefix: --mate-contamination
  - id: max_distance
    type:
      - 'null'
      - int
    doc: search the graph for a path completing the mate-pair fragment. If the 
      path is less than LEN then the pair will be discarded.
    inputBinding:
      position: 103
      prefix: --max-distance
  - id: max_kmer_depth
    type:
      - 'null'
      - int
    doc: filter out pairs that contain a kmer that has been seen in the FM-index
      more than N times
    inputBinding:
      position: 103
      prefix: --max-kmer-depth
  - id: min_quality
    type:
      - 'null'
      - float
    doc: 'filter out pairs where one read has mapping quality less than F (default:
      10)'
    default: 10
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
      prefix: --prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: out_bam
    type:
      - 'null'
      - File
    doc: write the filtered reads to FILE
    outputBinding:
      glob: $(inputs.out_bam)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
