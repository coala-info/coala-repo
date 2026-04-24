cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhpl8r
  - pipe
label: microhapulator_mhpl8r pipe
doc: "Perform a complete end-to-end microhap analysis pipeline\n\nTool homepage: https://github.com/bioforensics/MicroHapulator/"
inputs:
  - id: markerrefr
    type: File
    doc: path to a FASTA file containing marker reference sequences
    inputBinding:
      position: 1
  - id: markerdefn
    type: File
    doc: path to a TSV file containing marker definitions
    inputBinding:
      position: 2
  - id: seqpath
    type: Directory
    doc: path to a directory containing FASTQ files
    inputBinding:
      position: 3
  - id: samples
    type:
      type: array
      items: string
    doc: list of sample names or path to .txt file containing sample names
    inputBinding:
      position: 4
  - id: ambiguous_thresh
    type:
      - 'null'
      - float
    doc: filter out reads with more than AT percent of ambiguous characters 
      ('N'); AT=0.2 by default
    inputBinding:
      position: 105
      prefix: --ambiguous-thresh
  - id: config
    type:
      - 'null'
      - File
    doc: "CSV file specifying marker-specific thresholds to override global thresholds;
      three required columns: 'Marker' for the marker name; 'Static' and 'Dynamic'
      for marker-specific thresholds"
    inputBinding:
      position: 105
      prefix: --config
  - id: copy_input
    type:
      - 'null'
      - boolean
    doc: copy input files to working directory; by default, input files are 
      symlinked
    inputBinding:
      position: 105
      prefix: --copy-input
  - id: discard_alert
    type:
      - 'null'
      - float
    doc: issue an alert in the final report for each marker whose read discard 
      rate (proportion of reads that could not be typed) exceeds DA; by default 
      DA=0.25
    inputBinding:
      position: 105
      prefix: --discard-alert
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: do not execute the workflow, but display what would have been done
    inputBinding:
      position: 105
      prefix: --dryrun
  - id: dynamic
    type:
      - 'null'
      - float
    doc: global percentage of total read count threshold; e.g. use 
      --dynamic=0.02 to apply a 2% analytical threshold; DT=0.02 by default
    inputBinding:
      position: 105
      prefix: --dynamic
  - id: gap_alert
    type:
      - 'null'
      - float
    doc: issue an alert in the final report for each marker whose gap rate 
      (proportion of reads containing one or more gap alleles) exceeds DA; by 
      default DA=0.05
    inputBinding:
      position: 105
      prefix: --gap-alert
  - id: hspace
    type:
      - 'null'
      - float
    doc: horizontal spacing between samples in the read distribution length 
      ridge plots; negative value for this parameter enables overlapping plots; 
      HS=-0.7 by default
    inputBinding:
      position: 105
      prefix: --hspace
  - id: length_thresh
    type:
      - 'null'
      - int
    doc: filter out reads that are less than LT bp long; LT=50 by default
    inputBinding:
      position: 105
      prefix: --length-thresh
  - id: single
    type:
      - 'null'
      - boolean
    doc: accept single-end reads only; by default, only paired-end reads are 
      accepted
    inputBinding:
      position: 105
      prefix: --single
  - id: static
    type:
      - 'null'
      - int
    doc: global fixed read count threshold; ST=5 by default
    inputBinding:
      position: 105
      prefix: --static
  - id: threads
    type:
      - 'null'
      - int
    doc: process each batch using T threads; by default, one thread per 
      available core is used
    inputBinding:
      position: 105
      prefix: --threads
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: pipeline working directory; default is current directory
    inputBinding:
      position: 105
      prefix: --workdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0
stdout: microhapulator_mhpl8r pipe.out
