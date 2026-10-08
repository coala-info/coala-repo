cwlVersion: v1.2
class: CommandLineTool
baseCommand: goldpolish
label: goldrush_goldpolish
doc: "Polish sequences with long reads (GoldPolish), also usable in targeted mode
  (GoldPolish-Target).\n\nTool homepage: https://github.com/bcgsc/goldrush"
inputs:
  - id: seqs_to_polish
    type: File
    doc: Sequences to polish.
    inputBinding:
      position: 1
      valueFrom: $(runtime.outdir)/$(self.basename)
  - id: polishing_seqs
    type: File
    doc: Sequences to polish with.
    inputBinding:
      position: 2
      valueFrom: $(runtime.outdir)/$(self.basename)
  - id: output_seqs
    type: string
    doc: Filename to write polished sequences to.
    inputBinding:
      position: 3
  - id: k
    type:
      - 'null'
      - type: array
        items: int
        inputBinding:
          prefix: -k
          separate: false
    doc: 'k-mer sizes to use for polishing. Example: -k32 -k28 (Default: 32, 28, 24, 20)'
  - id: bsize
    type:
      - 'null'
      - int
    doc: Batch size. A batch is how many polished sequences are processed per 
      Bloom filter. (Default 1)
    inputBinding:
      position: 101
      prefix: --bsize
  - id: shared_mem
    type:
      - 'null'
      - string
    doc: Shared memory path to do polishing in. (Default /dev/shm)
    inputBinding:
      position: 101
      prefix: --shared-mem
  - id: threads
    type:
      - 'null'
      - int
    doc: How many threads to use. (Default 48)
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: mx_max_reads_per_10kbp
    type:
      - 'null'
      - int
    doc: When subsampling, increase the common minimizer count threshold for 
      ntLink mappings until there's at most this many reads per 10kbp of 
      polished sequence. (Default 150)
    inputBinding:
      position: 101
      prefix: --mx-max-reads-per-10kbp
  - id: subsample_max_reads_per_10kbp
    type:
      - 'null'
      - int
    doc: Random subsampling of mapped reads. For ntLink mappings, this is done 
      after common minimizer subsampling. For minimap2 mappings, only this 
      subsampling is done. By default, 40 if using minimap2 mappings and 100 if
      using ntLink mappings.
    inputBinding:
      position: 101
      prefix: --subsample-max-reads-per-10kbp
  - id: ntlink
    type:
      - 'null'
      - boolean
    doc: Run ntLink to generate read mappings (default).
    inputBinding:
      position: 101
      prefix: --ntlink
  - id: minimap2
    type:
      - 'null'
      - boolean
    doc: Run minimap2 to generate read mappings.
    inputBinding:
      position: 101
      prefix: --minimap2
  - id: mappings
    type:
      - 'null'
      - File
    doc: Use provided pre-generated mappings. Accepted formats are PAF, SAM, and 
      *.verbose_mapping.tsv from ntLink.
    inputBinding:
      position: 101
      prefix: --mappings
  - id: k_ntlink
    type:
      - 'null'
      - int
    doc: k-mer size used for ntLink mappings (if --ntlink specified)
    inputBinding:
      position: 101
      prefix: --k-ntlink
  - id: w_ntlink
    type:
      - 'null'
      - int
    doc: Window size used for ntLink mappings (if --ntlink specified)
    inputBinding:
      position: 101
      prefix: --w-ntlink
  - id: target
    type:
      - 'null'
      - boolean
    doc: Run GoldPolish in targeted mode
    inputBinding:
      position: 101
      prefix: --target
  - id: length
    type:
      - 'null'
      - int
    doc: GoldPolish-Target flank length (if --target specified)
    inputBinding:
      position: 101
      prefix: --length
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file specifying target coordinates (if --target specified)
    inputBinding:
      position: 101
      prefix: --bed
  - id: softmask
    type:
      - 'null'
      - boolean
    doc: Target coordinates determined from softmasked regions in the input 
      assembly (if --target specified)
    inputBinding:
      position: 101
      prefix: --softmask
outputs:
  - id: polished_seqs
    type: File
    doc: Polished sequences
    outputBinding:
      glob: $(inputs.output_seqs)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.seqs_to_polish)
      - $(inputs.polishing_seqs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goldrush:1.2.2--py39h2de1943_0
