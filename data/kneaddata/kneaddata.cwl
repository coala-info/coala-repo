cwlVersion: v1.2
class: CommandLineTool
baseCommand: kneaddata
label: kneaddata
doc: "KneadData\n\nTool homepage: https://huttenhower.sph.harvard.edu/kneaddata"
inputs:
  - id: bmtagger_path
    type:
      - 'null'
      - File
    doc: path to BMTagger
    default: $PATH
    inputBinding:
      position: 101
      prefix: --bmtagger
  - id: bowtie2_options
    type:
      - 'null'
      - string
    doc: options for bowtie2
    default: --very-sensitive-local
    inputBinding:
      position: 101
      prefix: --bowtie2-options
  - id: bowtie2_path
    type:
      - 'null'
      - File
    doc: path to bowtie2
    default: $PATH
    inputBinding:
      position: 101
      prefix: --bowtie2
  - id: bypass_trf
    type:
      - 'null'
      - boolean
    doc: option to bypass the removal of tandem repeats
    inputBinding:
      position: 101
      prefix: --bypass-trf
  - id: bypass_trim
    type:
      - 'null'
      - boolean
    doc: bypass the trim step
    inputBinding:
      position: 101
      prefix: --bypass-trim
  - id: cat_final_output
    type:
      - 'null'
      - boolean
    doc: concatenate all final output files
    default: final output is not concatenated
    inputBinding:
      position: 101
      prefix: --cat-final-output
  - id: decontaminate_pairs
    type:
      - 'null'
      - string
    doc: options for filtering of paired end reads (strict='remove both R1+R2 if
      either align', lenient='remove only if both R1+R2 align', unpaired='ignore
      pairing and remove as single end')
    default: strict
    inputBinding:
      position: 101
      prefix: --decontaminate-pairs
  - id: delta
    type:
      - 'null'
      - int
    doc: indel penalty
    default: 7
    inputBinding:
      position: 101
      prefix: --delta
  - id: fastqc_path
    type:
      - 'null'
      - File
    doc: path to fastqc
    default: $PATH
    inputBinding:
      position: 101
      prefix: --fastqc
  - id: input1
    type:
      - 'null'
      - File
    doc: Pair 1 input FASTQ file
    inputBinding:
      position: 101
      prefix: --input1
  - id: input2
    type:
      - 'null'
      - File
    doc: Pair 2 input FASTQ file
    inputBinding:
      position: 101
      prefix: --input2
  - id: log
    type:
      - 'null'
      - File
    doc: log file
    default: $OUTPUT_DIR/$SAMPLE_kneaddata.log
    inputBinding:
      position: 101
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of log messages
    default: DEBUG
    inputBinding:
      position: 101
      prefix: --log-level
  - id: match
    type:
      - 'null'
      - int
    doc: matching weight
    default: 2
    inputBinding:
      position: 101
      prefix: --match
  - id: max_memory
    type:
      - 'null'
      - string
    doc: max amount of memory
    default: 500m
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: maxperiod
    type:
      - 'null'
      - int
    doc: maximum period size to report
    default: 500
    inputBinding:
      position: 101
      prefix: --maxperiod
  - id: minscore
    type:
      - 'null'
      - int
    doc: minimum alignment score to report
    default: 50
    inputBinding:
      position: 101
      prefix: --minscore
  - id: mismatch
    type:
      - 'null'
      - int
    doc: mismatching penalty
    default: 7
    inputBinding:
      position: 101
      prefix: --mismatch
  - id: output_dir
    type: Directory
    doc: directory to write output files
    inputBinding:
      position: 101
      prefix: --output
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix for all output files
    default: $SAMPLE_kneaddata
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: pi
    type:
      - 'null'
      - int
    doc: indel probability
    default: 10
    inputBinding:
      position: 101
      prefix: --pi
  - id: pm
    type:
      - 'null'
      - int
    doc: match probability
    default: 80
    inputBinding:
      position: 101
      prefix: --pm
  - id: processes
    type:
      - 'null'
      - int
    doc: number of processes
    default: 1
    inputBinding:
      position: 101
      prefix: --processes
  - id: quality_scores
    type:
      - 'null'
      - string
    doc: quality scores
    default: phred33
    inputBinding:
      position: 101
      prefix: --quality-scores
  - id: reference_db
    type:
      - 'null'
      - type: array
        items: string
    doc: location of reference database (additional arguments add databases)
    inputBinding:
      position: 101
      prefix: --reference-db
  - id: remove_intermediate_output
    type:
      - 'null'
      - boolean
    doc: remove intermediate output files
    default: intermediate output files are stored
    inputBinding:
      position: 101
      prefix: --remove-intermediate-output
  - id: reorder
    type:
      - 'null'
      - boolean
    doc: order the sequences in the same order as the input
    default: Sequences are not ordered
    inputBinding:
      position: 101
      prefix: --reorder
  - id: run_bmtagger
    type:
      - 'null'
      - boolean
    doc: run BMTagger instead of Bowtie2 to identify contaminant reads
    inputBinding:
      position: 101
      prefix: --run-bmtagger
  - id: run_fastqc_end
    type:
      - 'null'
      - boolean
    doc: run fastqc at the end of the workflow
    inputBinding:
      position: 101
      prefix: --run-fastqc-end
  - id: run_fastqc_start
    type:
      - 'null'
      - boolean
    doc: run fastqc at the beginning of the workflow
    inputBinding:
      position: 101
      prefix: --run-fastqc-start
  - id: run_trf
    type:
      - 'null'
      - boolean
    doc: legacy option to run the removal of tandem repeats (now run by default)
    inputBinding:
      position: 101
      prefix: --run-trf
  - id: run_trim_repetitive
    type:
      - 'null'
      - boolean
    doc: Trim fastqc generated overrepresented sequences
    inputBinding:
      position: 101
      prefix: --run-trim-repetitive
  - id: scratch_dir
    type:
      - 'null'
      - Directory
    doc: directory to write temp files
    inputBinding:
      position: 101
      prefix: --scratch
  - id: sequencer_source
    type:
      - 'null'
      - string
    doc: options for sequencer-source
    default: NexteraPE
    inputBinding:
      position: 101
      prefix: --sequencer-source
  - id: serial
    type:
      - 'null'
      - boolean
    doc: filter the input in serial for multiple databases so a subset of reads 
      are processed in each database search (the default when running with a 
      single process)
    inputBinding:
      position: 101
      prefix: --serial
  - id: store_temp_output
    type:
      - 'null'
      - boolean
    doc: store temp output files
    default: temp output files are removed
    inputBinding:
      position: 101
      prefix: --store-temp-output
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: trf_path
    type:
      - 'null'
      - File
    doc: path to TRF
    default: $PATH
    inputBinding:
      position: 101
      prefix: --trf
  - id: trimmomatic_options
    type:
      - 'null'
      - string
    doc: options for trimmomatic
    default: MINLEN:60 ILLUMINACLIP:/-SE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50
    inputBinding:
      position: 101
      prefix: --trimmomatic-options
  - id: trimmomatic_path
    type:
      - 'null'
      - File
    doc: path to trimmomatic
    default: $PATH
    inputBinding:
      position: 101
      prefix: --trimmomatic
  - id: unpaired
    type:
      - 'null'
      - File
    doc: unparied input FASTQ file
    inputBinding:
      position: 101
      prefix: --unpaired
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: additional output is printed
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kneaddata:0.12.4--pyhdfd78af_0
stdout: kneaddata.out
