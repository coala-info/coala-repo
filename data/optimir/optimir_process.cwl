cwlVersion: v1.2
class: CommandLineTool
baseCommand: optimir_process
label: optimir_process
doc: "Processes sequencing data to identify and analyze microRNAs.\n\nTool homepage:
  https://github.com/FlorianThibord/OptimiR"
inputs:
  - id: adaptor_3_prime
    type:
      - 'null'
      - string
    doc: "Define the 3' adaptor sequence (default is NEB & ILLUMINA: AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
      -a TGGAATTCTCGGGTGCCAAGG -> hack: use -a to add adapter sequences)"
    inputBinding:
      position: 101
      prefix: --adapt3
  - id: adaptor_5_prime
    type:
      - 'null'
      - string
    doc: Define the 5' adaptor sequence
    inputBinding:
      position: 101
      prefix: --adapt5
  - id: annotation_files
    type:
      - 'null'
      - string
    doc: "Control which annotation file is produced by adding corresponding letter
      : 'h' for expressed_hairpins, 'p' for polymiRs_table, 'i' for consistency_table,
      'c' for remaining_ambiguous, 's' for isomiRs_dist. Ex: '-- annot hpics' [default]
      will produce all of them"
    inputBinding:
      position: 101
      prefix: --annot
  - id: base_quality_threshold
    type:
      - 'null'
      - int
    doc: Define the Base Quality threshold defined with option -q in cutadapt
    inputBinding:
      position: 101
      prefix: --bqThresh
  - id: bowtie2_build_path
    type:
      - 'null'
      - string
    doc: Provide path to the bowtie2 index builder binary
    inputBinding:
      position: 101
      prefix: --bowtie2_build
  - id: bowtie2_path
    type:
      - 'null'
      - string
    doc: Provide path to the bowtie2 binary
    inputBinding:
      position: 101
      prefix: --bowtie2
  - id: cutadapt_path
    type:
      - 'null'
      - string
    doc: Provide path to the cutadapt binary
    inputBinding:
      position: 101
      prefix: --cutadapt
  - id: fastq_file
    type: File
    doc: 'Full path of the sample fastq file (accepted formats and extensions: fastq,
      fq and fq.gz)'
    inputBinding:
      position: 101
      prefix: --fq
  - id: generate_gff3_output
    type:
      - 'null'
      - boolean
    doc: 'Add this option to generate results in mirGFF3 format [default : disabled]'
    inputBinding:
      position: 101
      prefix: --gff_out
  - id: generate_vcf_output
    type:
      - 'null'
      - boolean
    doc: 'Add this option to generate results in VCF format [default : disabled]'
    inputBinding:
      position: 101
      prefix: --vcf_out
  - id: inconsistent_threshold
    type:
      - 'null'
      - float
    doc: Choose the rate threshold for inconsistent reads mapped to a polymiR 
      above which the alignment is flagged as highly suspicious
    inputBinding:
      position: 101
      prefix: --consistentRate
  - id: mature_miRNAs_fasta
    type:
      - 'null'
      - File
    doc: Path to the reference library containing mature miRNAs sequences
    inputBinding:
      position: 101
      prefix: --maturesFasta
  - id: max_read_length
    type:
      - 'null'
      - int
    doc: Define the maximum read length defined with option -M in cutadapt
    inputBinding:
      position: 101
      prefix: --readMax
  - id: miRNA_coordinates_gff3
    type:
      - 'null'
      - File
    doc: Path to the reference library containing miRNAs and pri-miRNAs 
      coordinates
    inputBinding:
      position: 101
      prefix: --gff3
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Define the minimum read length defined with option -m in cutadapt
    inputBinding:
      position: 101
      prefix: --readMin
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Full path of the directory where output files are generated
    inputBinding:
      position: 101
      prefix: --dirOutput
  - id: pri_miRNAs_fasta
    type:
      - 'null'
      - File
    doc: Path to the reference library containing pri-miRNAs sequences
    inputBinding:
      position: 101
      prefix: --hairpinsFasta
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: 'Add this option to remove OptimiR progression on screen [default: disabled]'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: remove_temporary_files
    type:
      - 'null'
      - boolean
    doc: Add this option to remove temporary files (trimmed fastq, collapsed 
      fastq, mapped reads, annotated bams)
    inputBinding:
      position: 101
      prefix: --rmTempFiles
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Provide path to the samtools binary
    inputBinding:
      position: 101
      prefix: --samtools
  - id: score_threshold
    type:
      - 'null'
      - int
    doc: Choose the threshold for alignment score above which alignments are 
      discarded
    inputBinding:
      position: 101
      prefix: --scoreThresh
  - id: seed_length
    type:
      - 'null'
      - int
    doc: Choose the alignment seed length used in option '-L' by Bowtie2
    inputBinding:
      position: 101
      prefix: --seedLen
  - id: trim_again
    type:
      - 'null'
      - boolean
    doc: 'Add this option to trim files that have been trimmed in a previous application.
      By default, when temporary files are kept, trimmed files are reused. If you
      wish to change a paramater used in the trimming step of the workflow, this parameter
      is a must [default: disabled]'
    inputBinding:
      position: 101
      prefix: --trimAgain
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: Full path of the vcf file with genotypes
    inputBinding:
      position: 101
      prefix: --vcf
  - id: weight_5_prime
    type:
      - 'null'
      - float
    doc: Choose the weight applied on events detected on the 5' end of aligned 
      reads
    inputBinding:
      position: 101
      prefix: --w5
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
stdout: optimir_process.out
