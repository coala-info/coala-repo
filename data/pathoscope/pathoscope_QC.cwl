cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pathoscope
  - QC
label: pathoscope_QC
doc: "PathoScope QC (PathoQC): quality control and filtering of sequencing reads\n\nTool
  homepage: https://github.com/PathoScope/PathoScope"
inputs:
  - id: read1
    type: File
    doc: 1st pair of read in PER or SER
    inputBinding:
      position: 101
      prefix: '-1'
  - id: read2
    type:
      - 'null'
      - File
    doc: 2nd pair of read in PER
    inputBinding:
      position: 101
      prefix: '-2'
  - id: read_length
    type:
      - 'null'
      - string
    doc: 'let us know a mean read length (0:ignore. [1]:I want to know the range of
      read length after trimming, i:user_specified_mean_read_length)'
    inputBinding:
      position: 101
      prefix: -r
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: 'specify a phred offset used in encoding base quality(0:not sure?, [33]:phred+33,
      64:phred+64)'
    inputBinding:
      position: 101
      prefix: -t
  - id: sequencer
    type:
      - 'null'
      - string
    doc: tell us which sequencer generates the reads ([Illumina], PacBio, Roche454,
      IonTorrent)
    inputBinding:
      position: 101
      prefix: -s
  - id: min_length
    type:
      - 'null'
      - int
    doc: specify the min read length cutoff[35]
    inputBinding:
      position: 101
      prefix: -m
  - id: adaptor
    type:
      - 'null'
      - string
    doc: 'specify an adaptor (Y:have pathoQC detect it, [N]:ignore, ACGT:adaptor)'
    inputBinding:
      position: 101
      prefix: -a
  - id: adaptor2
    type:
      - 'null'
      - string
    doc: 'specify a second adaptor if it is different from the first one (Y:have pathoQC
      detect it, [N]:ignore, ACGT:adaptor)'
    inputBinding:
      position: 101
      prefix: -a2
  - id: quality_cutoff
    type:
      - 'null'
      - string
    doc: 'specify a cutoff of base quality value to trim at the end of reads([0]:ignore,
      1:let pathoQC take care of it, i:user_specified_cutoff_value)'
    inputBinding:
      position: 101
      prefix: -q
  - id: lower454
    type:
      - 'null'
      - int
    doc: set to 1 if you want to mask all lower case bases that may correspond to
      sequence tag or adaptor in Roche454 or IonTorrent
    inputBinding:
      position: 101
      prefix: -R
  - id: entropy_cutoff
    type:
      - 'null'
      - int
    doc: 'specify a cutoff of entropy of low sequence complexity to filter out[0..100],default:30,
      set 0 to disable'
    inputBinding:
      position: 101
      prefix: -e
  - id: derep
    type:
      - 'null'
      - string
    doc: "filtering duplicates: [1] (exact duplicate), 2 (5' duplicate), 3 (3' duplicate),
      4 (reverse complement exact duplicate), 5 (reverse complement 5'/3' duplicate)"
    inputBinding:
      position: 101
      prefix: -d
  - id: add_valid_single
    type:
      - 'null'
      - int
    doc: Set to 1 if you want to add a valid single read into a reduced valid PER
      set. Note that this option works only with PER
    inputBinding:
      position: 101
      prefix: -g
  - id: no_prinseq
    type:
      - 'null'
      - boolean
    doc: to force to skip prinseq module
    inputBinding:
      position: 101
      prefix: --no_prinseq
  - id: num_threads
    type:
      - 'null'
      - int
    doc: specify a total number of cpus to use[1]
    inputBinding:
      position: 101
      prefix: -p
  - id: debug
    type:
      - 'null'
      - boolean
    doc: working on debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: out_dir_path
    type: string
    doc: specify output directory in full path
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: out_dir
    type: Directory
    doc: Output directory with the filtered reads and the quality report
    outputBinding:
      glob: $(inputs.out_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.out_dir_path)
        writable: true
        entry: "$({\"class\": \"Directory\", \"basename\": inputs.out_dir_path, \"listing\": []})"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathoscope:2.0.7--pyhdfd78af_2
