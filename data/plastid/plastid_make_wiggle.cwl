cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - make_wiggle
label: plastid_make_wiggle
doc: 'Convert read alignments or count files to wiggle or bedGraph files, applying a read mapping rule.


  Tool homepage: https://github.com/joshuagryphon/plastid'
inputs:
  - id: output_prefix
    type: string
    doc: Base name for output files
    inputBinding:
      position: 101
      prefix: --out
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Size of nucleotides to fetch at once for export. Large values are faster but require more memory (Default: 100000)'
    inputBinding:
      position: 101
      prefix: --window_size
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress all warning messages. Cannot use with '-v'.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase verbosity. With ''-v'', show every warning. With ''-vv'', turn warnings into exceptions. Cannot use with ''-q''. (Default: show each type of warning once)'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: count_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more count or alignment file(s) from a single sample or set of samples to be pooled.
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 101
      prefix: --count_files
  - id: countfile_format
    type:
      - 'null'
      - string
    doc: 'Format of file containing alignments or counts (Default: BAM)'
    inputBinding:
      position: 101
      prefix: --countfile_format
  - id: normalize
    type:
      - 'null'
      - boolean
    doc: 'Whether counts should be normalized to counts per million (usually not. default: False)'
    inputBinding:
      position: 101
      prefix: --normalize
  - id: sum
    type:
      - 'null'
      - float
    doc: 'Sum used in normalization of counts and RPKM/RPNT calculations (Default: total mapped reads/counts in dataset)'
    inputBinding:
      position: 101
      prefix: --sum
  - id: min_length
    type:
      - 'null'
      - int
    doc: 'Minimum read length required to be included (BAM & bowtie files only. Default: 25)'
    inputBinding:
      position: 101
      prefix: --min_length
  - id: max_length
    type:
      - 'null'
      - int
    doc: 'Maximum read length permitted to be included (BAM & bowtie files only. Default: 100)'
    inputBinding:
      position: 101
      prefix: --max_length
  - id: maxmem
    type:
      - 'null'
      - int
    doc: 'Maximum desired memory footprint in MB to devote to BigBed/BigWig files. May be exceeded by large queries. (Default: 0, No maximum)'
    inputBinding:
      position: 101
      prefix: --maxmem
  - id: big_genome
    type:
      - 'null'
      - boolean
    doc: Use slower but memory-efficient implementation for big genomes or for memory-limited computers. For wiggle & bowtie files only.
    inputBinding:
      position: 101
      prefix: --big_genome
  - id: fiveprime_variable
    type:
      - 'null'
      - boolean
    doc: Map read alignment to a variable offset from 5' position of read, with offset determined by read length. Requires `--offset` below
    inputBinding:
      position: 101
      prefix: --fiveprime_variable
  - id: fiveprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 5' position.
    inputBinding:
      position: 101
      prefix: --fiveprime
  - id: threeprime
    type:
      - 'null'
      - boolean
    doc: Map read alignment to 3' position
    inputBinding:
      position: 101
      prefix: --threeprime
  - id: center
    type:
      - 'null'
      - boolean
    doc: Subtract N positions from each end of read, and add 1/(length-N), to each remaining position, where N is specified by `--nibble`
    inputBinding:
      position: 101
      prefix: --center
  - id: offset
    type:
      - 'null'
      - int
      - File
    doc: 'For `--fiveprime` or `--threeprime`, provide an integer representing the offset into the read, starting from either the 5'' or 3'' end, at which data should be plotted. For `--fiveprime_variable`, provide the filename of a two-column tab-delimited text file, in which first column represents read length or the special keyword `''default''`, and the second column represents the offset from the five prime end of that read length at which the read should be mapped. (Default: 0)'
    inputBinding:
      position: 101
      prefix: --offset
  - id: nibble
    type:
      - 'null'
      - int
    doc: 'For use with `--center` only. nt to remove from each end of read before mapping (Default: 0)'
    inputBinding:
      position: 101
      prefix: --nibble
  - id: color
    type:
      - 'null'
      - string
    doc: An RGB hex string (`'#NNNNNN'`, `N` in `[0-9,A-F]`) specifying the track color.
    inputBinding:
      position: 101
      prefix: --color
  - id: track_name
    type:
      - 'null'
      - string
    doc: Name to give browser track
    inputBinding:
      position: 101
      prefix: --track_name
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Format of output file (Default: bedgraph)'
    inputBinding:
      position: 101
      prefix: --output_format
outputs:
  - id: outputs
    type:
      type: array
      items: File
    doc: Wiggle or bedGraph files written with the given output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plastid:0.6.1--py38h7d1810a_2
