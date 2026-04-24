cwlVersion: v1.2
class: CommandLineTool
baseCommand: outrigger psi
label: outrigger_psi
doc: "Calculate PSI scores\n\nTool homepage: https://yeolab.github.io/outrigger"
inputs:
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: Bam files to use to calculate psi on
    inputBinding:
      position: 101
      prefix: --bam
  - id: debug
    type:
      - 'null'
      - boolean
    doc: If given, print debugging logging information to standard out
    inputBinding:
      position: 101
      prefix: --debug
  - id: ignore_multimapping
    type:
      - 'null'
      - boolean
    doc: Applies to STAR SJ.out.tab files only. If this flag is used, then do 
      not include reads that mapped to multiple locations in the genome, not 
      uniquely to a locus, in the read count for a junction. If inputting "bam" 
      files, then this means that reads with a mapping quality (MAPQ) of less 
      than 255 are considered "multimapped." This is the same thing as what the 
      STAR aligner does. By default, this is off, and all reads are used.
    inputBinding:
      position: 101
      prefix: --ignore-multimapping
  - id: index
    type:
      - 'null'
      - Directory
    doc: Name of the folder where you saved the output from "outrigger index" 
      (default is ./outrigger_output/index, which is relative to the directory 
      where you called this program, assuming you have called "outrigger psi" in
      the same folder as you called "outrigger index")
    inputBinding:
      position: 101
      prefix: --index
  - id: junction_id_col
    type:
      - 'null'
      - string
    doc: Name of column in --splice-junction-csv containing the ID of the 
      junction to use. Must match exactly with the junctions in the 
      index.(default='junction_id')
    inputBinding:
      position: 101
      prefix: --junction-id-col
  - id: junction_reads_csv
    type:
      - 'null'
      - File
    doc: Name of the compiled splice junction file to calculate psi scores on. 
      Default is the '--output' folder's junctions/reads.csv file. Not required 
      if you specify SJ.out.tab files with '--sj-out-tab'
    inputBinding:
      position: 101
      prefix: --junction-reads-csv
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: If set, then use a smaller memory footprint. By default, this is off.
    inputBinding:
      position: 101
      prefix: --low-memory
  - id: method
    type:
      - 'null'
      - string
    doc: How to deal with multiple junctions on an event - take the mean 
      (default) or the min? (the other option)
    inputBinding:
      position: 101
      prefix: --method
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum number of reads per junction for calculating Psi (default=10)
    inputBinding:
      position: 101
      prefix: --min-reads
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: Number of threads to use when parallelizing psi calculation and file 
      reading. Default is -1, which means to use as many threads as are 
      available.
    inputBinding:
      position: 101
      prefix: --n-jobs
  - id: reads_col
    type:
      - 'null'
      - string
    doc: Name of column in --splice-junction-csv containing reads to use. 
      (default='reads')
    inputBinding:
      position: 101
      prefix: --reads-col
  - id: sample_id_col
    type:
      - 'null'
      - string
    doc: Name of column in --splice-junction-csv containing sample ids to use. 
      (default='sample_id')
    inputBinding:
      position: 101
      prefix: --sample-id-col
  - id: sj_out_tab
    type:
      - 'null'
      - type: array
        items: File
    doc: SJ.out.tab files from STAR aligner output. Not required if you specify 
      a file with "--compiled-junction-reads"
    inputBinding:
      position: 101
      prefix: --sj-out-tab
  - id: uneven_coverage_multiplier
    type:
      - 'null'
      - float
    doc: If a junction one one side of an exon is bigger than the other side of 
      the exon by this amount, (default is 10, so 10x bigger), then do not use 
      this event
    inputBinding:
      position: 101
      prefix: --uneven-coverage-multiplier
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Name of the folder where you saved the output from "outrigger index" 
      (default is ./outrigger_output, which is relative to the directory where 
      you called the program). Cannot specify both an --index and --output with 
      "psi"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/outrigger:1.1.1--py35_0
