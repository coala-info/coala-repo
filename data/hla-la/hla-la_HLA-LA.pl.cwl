cwlVersion: v1.2
class: CommandLineTool
baseCommand: HLA-LA.pl
label: hla-la_HLA-LA.pl
doc: "HLA*LA: HLA typing from a BAM/CRAM of short or long reads using a population
  reference graph.\n\nOutput for sample with ID $sampleID will go to a correspondingly
  named sub-directory of the working directory.\n\nTool homepage:
  https://github.com/DiltheyLab/HLA-LA"
inputs:
  - id: bam
    type: File
    doc: Indexed BAM or CRAM file with the reads
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
    inputBinding:
      position: 101
      prefix: --BAM
  - id: graph
    type: string
    doc: Name of the graph in the graphs directory (for example
      PRG_MHC_GRCh38_withIMGT)
    inputBinding:
      position: 101
      prefix: --graph
  - id: custom_graph_dir
    type:
      - 'null'
      - Directory
    doc: Directory with a custom graph (instead of the graphs directory of the
      installation)
    inputBinding:
      position: 101
      prefix: --customGraphDir
  - id: sample_id
    type: string
    doc: sample ID
    inputBinding:
      position: 101
      prefix: --sampleID
  - id: working_dir
    type: string
    doc: Working directory; the output goes into the sub-directory named by sample_id
    inputBinding:
      position: 101
      prefix: --workingDir
  - id: qsub
    type:
      - 'null'
      - string
    doc: qsub command for cluster submission
    inputBinding:
      position: 101
      prefix: --qsub
  - id: samtools_bin
    type:
      - 'null'
      - string
    doc: Path to samtools
    inputBinding:
      position: 101
      prefix: --samtools_bin
  - id: bwa_bin
    type:
      - 'null'
      - string
    doc: Path to bwa
    inputBinding:
      position: 101
      prefix: --bwa_bin
  - id: java_bin
    type:
      - 'null'
      - string
    doc: Path to java
    inputBinding:
      position: 101
      prefix: --java_bin
  - id: picard_sam2fastq_bin
    type:
      - 'null'
      - string
    doc: Path to the Picard SamToFastq jar
    inputBinding:
      position: 101
      prefix: --picard_sam2fastq_bin
  - id: max_threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads
    inputBinding:
      position: 101
      prefix: --maxThreads
  - id: more_references_dir
    type:
      - 'null'
      - Directory
    doc: Directory with additional reference sequences
    inputBinding:
      position: 101
      prefix: --moreReferencesDir
  - id: extract_exon_kmer_counts
    type:
      - 'null'
      - string
    doc: Extract exon k-mer counts
    inputBinding:
      position: 101
      prefix: --extractExonkMerCounts
  - id: long_reads
    type:
      - 'null'
      - string
    doc: Type of long reads (ont2d for Oxford Nanopore, pacbio for PacBio)
    inputBinding:
      position: 101
      prefix: --longReads
  - id: prepare_graph
    type:
      - 'null'
      - string
    doc: Prepare the graph (index it) before the first use
    inputBinding:
      position: 101
      prefix: --prepareGraph
  - id: samtools_t
    type:
      - 'null'
      - File
    doc: Reference genome FASTA for CRAM input (passed to samtools as -T)
    inputBinding:
      position: 101
      prefix: --samtools_T
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory of the sample (working_dir/sample_id)
    outputBinding:
      glob: $(inputs.working_dir)/$(inputs.sample_id)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hla-la:1.0.4--h077b44d_1
stdout: hla-la_HLA-LA.pl.out
