cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmox
label: dmox
doc: "Demultiplex reads based on their sequenced index barcodes for haplotagging.\n\
  Supposed to match the `demultiplex` step of Harpy's pipeline:\n    https://pdimens.github.io/harpy/workflows/demultiplex/\n\
  \nTool homepage: https://gitlab.mbb.cnrs.fr/ibonnici/dmox"
inputs:
  - id: barcodes_table
    type: File
    doc: Where to write the file summarizing assigned / unassigned barcodes
    inputBinding:
      position: 101
      prefix: --barcodes-table
  - id: bx
    type:
      - 'null'
      - boolean
    doc: Raise to output BX codes as part of demultiplexed fastq identifiers
    inputBinding:
      position: 101
      prefix: --bx
  - id: distance
    type:
      - 'null'
      - string
    doc: Distance metric to use when matching modules against references
    inputBinding:
      position: 101
      prefix: --distance
  - id: i1
    type: File
    doc: Forward indexes .fastq.gz file
    inputBinding:
      position: 101
      prefix: --i1
  - id: i2
    type: File
    doc: Reverse indexes .fastq.gz file
    inputBinding:
      position: 101
      prefix: --i2
  - id: id_tail
    type:
      - 'null'
      - boolean
    doc: Raise to output the last part of original fastq identifiers
    inputBinding:
      position: 101
      prefix: --id-tail
  - id: max_distance
    type:
      - 'null'
      - int
    doc: If set, reject modules matching references with a distance higher than 
      this threshold
    inputBinding:
      position: 101
      prefix: --max-distance
  - id: max_queued_blocks
    type:
      - 'null'
      - int
    doc: Stop reading input files if this number of fastq blocks are queued in 
      memory, still waiting for a writer to pick them up. Increase to improve 
      performance *provided you have enough RAM*
    inputBinding:
      position: 101
      prefix: --max-queued-blocks
  - id: module_size
    type:
      - 'null'
      - int
    doc: Size of one barcode module
    inputBinding:
      position: 101
      prefix: --module-size
  - id: multiple_samples_per_barcode
    type:
      - 'null'
      - boolean
    doc: Raise to allow that a sample be fed from several different barcodes. 
      (So it appears several times in the schema file.)
    inputBinding:
      position: 101
      prefix: --multiple-samples-per-barcode
  - id: n_modules
    type:
      - 'null'
      - int
    doc: Total number of reference barcode modules for each letter
    inputBinding:
      position: 101
      prefix: --n-modules
  - id: n_writers
    type:
      - 'null'
      - int
    doc: Number of threads to spawn for zipping + writing output sample files. 
      Defaults to the number of available cores on the machine
    inputBinding:
      position: 101
      prefix: --n-writers
  - id: qx
    type:
      - 'null'
      - boolean
    doc: Raise to output QX codes as part of demultiplexed fastq identifiers
    inputBinding:
      position: 101
      prefix: --qx
  - id: r1
    type: File
    doc: Forward reads .fastq.gz file
    inputBinding:
      position: 101
      prefix: --r1
  - id: r2
    type: File
    doc: Reverse reads .fastq.gz file
    inputBinding:
      position: 101
      prefix: --r2
  - id: readers_channel_capacity
    type:
      - 'null'
      - int
    doc: Number of fastq blocks to read before blocking when the above limit is 
      hit. Don't tweak without profiling performances
    inputBinding:
      position: 101
      prefix: --readers-channel-capacity
  - id: ref_a
    type: File
    doc: Reference 'A' barcode modules
    inputBinding:
      position: 101
      prefix: --ref-a
  - id: ref_b
    type: File
    doc: Reference 'B' barcode modules
    inputBinding:
      position: 101
      prefix: --ref-b
  - id: ref_c
    type: File
    doc: Reference 'C' barcode modules
    inputBinding:
      position: 101
      prefix: --ref-c
  - id: ref_d
    type: File
    doc: Reference 'D' barcode modules
    inputBinding:
      position: 101
      prefix: --ref-d
  - id: rx
    type:
      - 'null'
      - boolean
    doc: Raise to output RX codes as part of demultiplexed fastq identifiers
    inputBinding:
      position: 101
      prefix: --rx
  - id: samples
    type: Directory
    doc: Desired output folder for the resulting sample files. Created if 
      missing
    inputBinding:
      position: 101
      prefix: --samples
  - id: schema
    type: File
    doc: Schema file mapping sample ids to barcode sample modules with the same 
      letter
    inputBinding:
      position: 101
      prefix: --schema
  - id: undetermined_barcodes
    type:
      - 'null'
      - string
    doc: Optional output filename stub to collect reads with undetermined 
      barcode. For example `--undetermined-barcode nomatch` will produce 
      `./nomatch.R1.fq.gz` and `./nomatch.R2.fq.gz`
    inputBinding:
      position: 101
      prefix: --undetermined-barcodes
  - id: undetermined_samples
    type:
      - 'null'
      - string
    doc: Optional output filename stub to collect reads with determined barcodes
      but undetermined samples, because the barcodes where missing from the 
      schema
    inputBinding:
      position: 101
      prefix: --undetermined-samples
  - id: writers_capacity
    type:
      - 'null'
      - int
    doc: Size of memory buffers for accumulation before writing to disk
    inputBinding:
      position: 101
      prefix: --writers-capacity
  - id: zlevel
    type:
      - 'null'
      - int
    doc: Desired output compression level (defaults to gzip's default)
    inputBinding:
      position: 101
      prefix: --zlevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmox:0.2.1--h3ab6199_0
stdout: dmox.out
