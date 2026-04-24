cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - f5c
  - eventalign
label: f5c_eventalign
doc: "Align nanopore events to a reference genome\n\nTool homepage: https://github.com/hasindu2008/f5c"
inputs:
  - id: bam
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
    inputBinding:
      position: 101
      prefix: -K
  - id: collapse_events
    type:
      - 'null'
      - boolean
    doc: collapse events that stays on the same reference k-mer
    inputBinding:
      position: 101
      prefix: --collapse-events
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
  - id: iop
    type:
      - 'null'
      - int
    doc: number of I/O processes to read fast5 files
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
  - id: m6anet
    type:
      - 'null'
      - boolean
    doc: write output in m6anet format
    inputBinding:
      position: 101
      prefix: --m6anet
  - id: max_bases
    type:
      - 'null'
      - string
    doc: max number of bases loaded at once
    inputBinding:
      position: 101
      prefix: -B
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 101
      prefix: --min-mapq
  - id: min_recalib_events
    type:
      - 'null'
      - int
    doc: minimum number of events to recalbrate
    inputBinding:
      position: 101
      prefix: --min-recalib-events
  - id: paf
    type:
      - 'null'
      - boolean
    doc: write output in PAF format
    inputBinding:
      position: 101
      prefix: --paf
  - id: pore
    type:
      - 'null'
      - string
    doc: set the pore chemistry (r9, r10 or rna004)
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
  - id: print_read_names
    type:
      - 'null'
      - boolean
    doc: print read names instead of indexes
    inputBinding:
      position: 101
      prefix: --print-read-names
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
      prefix: --read_dump
  - id: reads
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
  - id: rna
    type:
      - 'null'
      - boolean
    doc: the dataset is direct RNA
    inputBinding:
      position: 101
      prefix: --rna
  - id: sam
    type:
      - 'null'
      - boolean
    doc: write output in SAM format
    inputBinding:
      position: 101
      prefix: --sam
  - id: sam_out_version
    type:
      - 'null'
      - int
    doc: sam output version (set 1 to revert to old nanopolish style format)
    inputBinding:
      position: 101
      prefix: --sam-out-version
  - id: samples
    type:
      - 'null'
      - boolean
    doc: write the raw samples for the event to the tsv output
    inputBinding:
      position: 101
      prefix: --samples
  - id: scale_events
    type:
      - 'null'
      - boolean
    doc: scale events to the model, rather than vice-versa
    inputBinding:
      position: 101
      prefix: --scale-events
  - id: secondary
    type:
      - 'null'
      - string
    doc: consider secondary mappings or not
    inputBinding:
      position: 101
      prefix: --secondary
  - id: signal_index
    type:
      - 'null'
      - boolean
    doc: write the raw signal start and end index values for the event to the 
      tsv output
    inputBinding:
      position: 101
      prefix: --signal-index
  - id: skip_ultra
    type:
      - 'null'
      - File
    doc: skip ultra long reads and write those entries to the bam file provided 
      as the argument
    inputBinding:
      position: 101
      prefix: --skip-ultra
  - id: skip_unreadable
    type:
      - 'null'
      - string
    doc: skip any unreadable fast5 or terminate program
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
    inputBinding:
      position: 101
      prefix: -t
  - id: ultra_thresh
    type:
      - 'null'
      - int
    doc: threshold to skip ultra long reads
    inputBinding:
      position: 101
      prefix: --ultra-thresh
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
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
  - id: output
    type:
      - 'null'
      - File
    doc: output to file
    outputBinding:
      glob: $(inputs.output)
  - id: summary
    type:
      - 'null'
      - File
    doc: summarise the alignment of each read/strand in FILE
    outputBinding:
      glob: $(inputs.summary)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/f5c:1.6--hee927d3_0
