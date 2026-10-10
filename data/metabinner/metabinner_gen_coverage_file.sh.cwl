cwlVersion: v1.2
class: CommandLineTool
baseCommand: gen_coverage_file.sh
label: metabinner_gen_coverage_file.sh
doc: "Align reads to the assembly (bwa) and generate the coverage profile tables for MetaBinner.\n\nTool homepage: https://github.com/ziyewang/MetaBinner"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.reads)
inputs:
  - id: assembly
    type: File
    doc: "Metagenomic assembly file"
    inputBinding:
      position: 1
      prefix: -a
  - id: out_dir
    type: string
    doc: "Output directory (to save the coverage files)"
    inputBinding:
      position: 2
      prefix: -o
  - id: bam_dir
    type: 
      - 'null'
      - string
    doc: "Directory for the bam files"
    inputBinding:
      position: 3
      prefix: -b
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Number of threads (default=1)"
    inputBinding:
      position: 4
      prefix: -t
  - id: memory
    type: 
      - 'null'
      - int
    doc: "Amount of RAM available (default=4)"
    inputBinding:
      position: 5
      prefix: -m
  - id: min_length
    type: 
      - 'null'
      - int
    doc: "Minimum contig length to bin (default=1000bp)"
    inputBinding:
      position: 6
      prefix: -l
  - id: single_end
    type: 
      - 'null'
      - boolean
    doc: "Non-paired reads mode (provide *.fastq files)"
    inputBinding:
      position: 7
      prefix: --single-end
  - id: interleaved
    type: 
      - 'null'
      - boolean
    doc: "The input read files contain interleaved paired-end reads"
    inputBinding:
      position: 8
      prefix: --interleaved
  - id: forward_suffix
    type: 
      - 'null'
      - string
    doc: "Forward read suffix for paired reads (default=_1.fastq)"
    inputBinding:
      position: 9
      prefix: -f
  - id: reverse_suffix
    type: 
      - 'null'
      - string
    doc: "Reverse read suffix for paired reads (default=_2.fastq)"
    inputBinding:
      position: 10
      prefix: -r
  - id: reads
    type:
      type: array
      items: File
    doc: "Read files: readsA_1.fastq readsA_2.fastq ... (all replicate files, not a joined file; file names must end in the forward/reverse suffix); staged together in the working directory so each forward file finds its reverse file"
    inputBinding:
      position: 20
      valueFrom: $(self.map(function (f) { return f.basename; }))
outputs:
  - id: output
    type: Directory
    doc: "Output directory with coverage_profile.tsv, coverage_profile_f1k.tsv and work_files"
    outputBinding:
      glob: $(inputs.out_dir)
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
stdout: gen_coverage_file.out
stderr: gen_coverage_file.log
