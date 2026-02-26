cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - f5c
  - call-methylation
label: f5c_call-methylation
doc: "Call methylation from nanopore reads using f5c\n\nTool homepage: https://github.com/hasindu2008/f5c"
inputs:
  - id: alignments_bam
    type: File
    doc: sorted bam file
    inputBinding:
      position: 101
      prefix: -b
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size (max number of reads loaded at once)
    default: 512
    inputBinding:
      position: 101
      prefix: -K
  - id: debug_break
    type:
      - 'null'
      - int
    doc: break after processing the specified no. of batches
    inputBinding:
      position: 101
      prefix: --debug-break
  - id: genome
    type: File
    doc: reference genome
    inputBinding:
      position: 101
      prefix: -g
  - id: io_processes
    type:
      - 'null'
      - int
    doc: number of I/O processes to read fast5 files
    default: 1
    inputBinding:
      position: 101
      prefix: --iop
  - id: kmer_model
    type:
      - 'null'
      - File
    doc: custom nucleotide k-mer model file
    inputBinding:
      position: 101
      prefix: --kmer-model
  - id: max_bases
    type:
      - 'null'
      - string
    doc: max number of bases loaded at once
    default: 5.0M
    inputBinding:
      position: 101
      prefix: -B
  - id: meth_model
    type:
      - 'null'
      - File
    doc: custom methylation k-mer model file
    inputBinding:
      position: 101
      prefix: --meth-model
  - id: meth_out_version
    type:
      - 'null'
      - int
    doc: methylation tsv output version (set 2 to print the strand column)
    default: 2
    inputBinding:
      position: 101
      prefix: --meth-out-version
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 20
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_recalib_events
    type:
      - 'null'
      - int
    doc: minimum number of events to recalbrate
    default: 200
    inputBinding:
      position: 101
      prefix: --min-recalib-events
  - id: pore
    type:
      - 'null'
      - string
    doc: set the pore chemistry (r9, r10 or rna004)
    default: r9
    inputBinding:
      position: 101
      prefix: --pore
  - id: print_banded_aln
    type:
      - 'null'
      - string
    doc: prints the event alignment
    inputBinding:
      position: 101
      prefix: --print-banded-aln
  - id: print_events
    type:
      - 'null'
      - string
    doc: prints the event table
    inputBinding:
      position: 101
      prefix: --print-events
  - id: print_raw
    type:
      - 'null'
      - string
    doc: prints the raw signal
    inputBinding:
      position: 101
      prefix: --print-raw
  - id: print_scaling
    type:
      - 'null'
      - string
    doc: prints the estimated scalings
    inputBinding:
      position: 101
      prefix: --print-scaling
  - id: profile
    type:
      - 'null'
      - string
    doc: parameter profile to be used for better performance (e.g., laptop, 
      desktop, hpc)
    inputBinding:
      position: 101
      prefix: -x
  - id: profile_cpu
    type:
      - 'null'
      - string
    doc: process section by section (used for profiling on CPU)
    inputBinding:
      position: 101
      prefix: --profile-cpu
  - id: read_dump
    type:
      - 'null'
      - string
    doc: read from a fast5 dump file or not
    inputBinding:
      position: 101
      prefix: --read-dump
  - id: read_file
    type: File
    doc: fastq/fasta read file
    inputBinding:
      position: 101
      prefix: -r
  - id: region
    type:
      - 'null'
      - string
    doc: limit processing to a genomic region specified as chr:start-end or a 
      list of regions in a .bed file
    inputBinding:
      position: 101
      prefix: -w
  - id: secondary
    type:
      - 'null'
      - string
    doc: consider secondary mappings or not
    default: no
    inputBinding:
      position: 101
      prefix: --secondary
  - id: skip_unreadable
    type:
      - 'null'
      - string
    doc: skip any unreadable fast5 or terminate program
    default: yes
    inputBinding:
      position: 101
      prefix: --skip-unreadable
  - id: slow5
    type:
      - 'null'
      - File
    doc: read from a slow5 file
    inputBinding:
      position: 101
      prefix: --slow5
  - id: threads
    type:
      - 'null'
      - int
    doc: number of processing threads
    default: 8
    inputBinding:
      position: 101
      prefix: -t
  - id: ultra_thresh
    type:
      - 'null'
      - int
    doc: threshold to skip ultra long reads
    default: 100000
    inputBinding:
      position: 101
      prefix: --ultra-thresh
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_dump
    type:
      - 'null'
      - string
    doc: write the fast5 dump to a file or not
    inputBinding:
      position: 101
      prefix: --write-dump
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to file
    outputBinding:
      glob: $(inputs.output_file)
  - id: skip_ultra
    type:
      - 'null'
      - File
    doc: skip ultra long reads and write those entries to the bam file provided 
      as the argument
    outputBinding:
      glob: $(inputs.skip_ultra)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/f5c:1.6--hee927d3_0
