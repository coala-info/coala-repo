cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phava
  - ratio
label: phava_ratio
doc: "Map reads and compute ratio of forward vs reverse orientation invertons\n\nTool homepage: https://github.com/patrickwest/PhaVa"
inputs:
  - id: dir_name
    type: string
    doc: "Name of the work directory where data and output are stored (use the same one for all PhaVa operations); created when it does not exist yet"
    inputBinding:
      position: 1
      prefix: --dir
  - id: prior_dir
    type:
      - 'null'
      - Directory
    doc: "Work directory written by an earlier PhaVa step (staged writable under the name given in dir_name)"
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of threads to use"
    inputBinding:
      position: 2
      prefix: --cpus
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Should the logging info be output to stdout? Otherwise it is written to PhaVa.log"
    inputBinding:
      position: 3
      prefix: --log
  - id: fastq
    type:
      - 'null'
      - File
    doc: "Name of the reads file to be used for mapping"
    inputBinding:
      position: 10
      prefix: --fastq
  - id: min_rc
    type:
      - 'null'
      - int
    doc: "The minimum count of mapped reads to an inverted inverton for it to be reported in the output"
    inputBinding:
      position: 11
      prefix: --minRC
  - id: max_mismatch
    type:
      - 'null'
      - float
    doc: "Maximum proportion of inverton sequence that can be mismatch before a read is removed"
    inputBinding:
      position: 12
      prefix: --maxMismatch
  - id: keep_sam
    type:
      - 'null'
      - boolean
    doc: "Keep the sam file from the mapping"
    inputBinding:
      position: 13
      prefix: --keepSam
  - id: report_all
    type:
      - 'null'
      - boolean
    doc: "Report mapping results for all putative invertons, regardless of outcome"
    inputBinding:
      position: 14
      prefix: --reportAll
  - id: short_reads
    type:
      - 'null'
      - boolean
    doc: "Run the pipeline with short reads instead of long reads"
    inputBinding:
      position: 15
      prefix: --short-reads
  - id: fastq2
    type:
      - 'null'
      - File
    doc: "Name of the file with reverse reads to be used for mapping (only for paired short reads)"
    inputBinding:
      position: 16
      prefix: -r2
  - id: inv
    type:
      - 'null'
      - File
    doc: "Fasta file of forward and inverted repeats (ie. generated from create command)"
    inputBinding:
      position: 20
      prefix: --inv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: work_dir
    type: Directory
    doc: Work directory with the PhaVa data, intermediate files and results
    outputBinding:
      glob: $(inputs.dir_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.dir_name)
        entry: '${ return inputs.prior_dir ? inputs.prior_dir : {"class": "Directory", "basename": inputs.dir_name, "listing": []}; }'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phava:0.2.3--pyhdfd78af_0
stdout: phava_ratio.out
