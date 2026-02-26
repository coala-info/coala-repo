cwlVersion: v1.2
class: CommandLineTool
baseCommand: map_single_fragments.py
label: rilseq_map_single_fragments.py
doc: "Map fastq files to the genome using bwa.\n\nTool homepage: http://github.com/asafpr/RILseq"
inputs:
  - id: genome_fasta
    type: File
    doc: Name of genome fasta file. The file must be indexed usingbwa index 
      command prior to this run.
    inputBinding:
      position: 1
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: Allowed mismatches for BWA mapping.
    default: 2
    inputBinding:
      position: 102
      prefix: --allowed_mismatches
  - id: bwa_exec
    type:
      - 'null'
      - string
    doc: bwa command
    default: bwa
    inputBinding:
      position: 102
      prefix: --bwa_exec
  - id: create_wig
    type:
      - 'null'
      - boolean
    doc: Create a coverage wiggle file.
    default: false
    inputBinding:
      position: 102
      prefix: --create_wig
  - id: dirout
    type:
      - 'null'
      - Directory
    doc: Output directory, default is this directory.
    default: .
    inputBinding:
      position: 102
      prefix: --dirout
  - id: fastq_1
    type:
      - 'null'
      - type: array
        items: File
    doc: A list of the first read of the sequencing.
    default: None
    inputBinding:
      position: 102
      prefix: --fastq_1
  - id: fastq_2
    type:
      - 'null'
      - type: array
        items: File
    doc: A list of the second read of the sequencing. The order of these files 
      should be as same as -1. Optional.
    default: None
    inputBinding:
      position: 102
      prefix: --fastq_2
  - id: feature
    type:
      - 'null'
      - string
    doc: Name of features to count on the GTF file (column 2).
    default: exon
    inputBinding:
      position: 102
      prefix: --feature
  - id: genes_gff
    type:
      - 'null'
      - File
    doc: Name of gff file to count the reads per gene. If not given or not 
      readable, skip this stage.
    default: None
    inputBinding:
      position: 102
      prefix: --genes_gff
  - id: identifier
    type:
      - 'null'
      - string
    doc: Name of identifier to print (in column 8 of the GTF file).
    default: gene_id
    inputBinding:
      position: 102
      prefix: --identifier
  - id: outhead
    type:
      - 'null'
      - string
    doc: Output file names of counts table (suffixed _counts.txt) and wiggle 
      file (suffixed _coverage.wig)
    default: bwa_mapped_single_reads
    inputBinding:
      position: 102
      prefix: --outhead
  - id: overlap
    type:
      - 'null'
      - int
    doc: Minimal required overlap between the fragment and the feature.
    default: 5
    inputBinding:
      position: 102
      prefix: --overlap
  - id: params_aln
    type:
      - 'null'
      - string
    doc: Additional parameters for aln function of bwa.
    default: -t 8 -R 200
    inputBinding:
      position: 102
      prefix: --params_aln
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Treat the reads as reverse complement only when counting number of 
      reads per gene and generating wig file. The resulting BAM files will be 
      the original ones. Use this when treating libraries built using Livny's 
      protocol.
    default: false
    inputBinding:
      position: 102
      prefix: --reverse_complement
  - id: sampe_params
    type:
      - 'null'
      - string
    doc: Additional parameters for sampe function of bwa.
    default: -a 1500 -P
    inputBinding:
      position: 102
      prefix: --sampe_params
  - id: samse_params
    type:
      - 'null'
      - string
    doc: Additional parameters for samse function of bwa.
    default: ''
    inputBinding:
      position: 102
      prefix: --samse_params
  - id: samtools_cmd
    type:
      - 'null'
      - string
    doc: Samtools executable.
    default: samtools
    inputBinding:
      position: 102
      prefix: --samtools_cmd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq_map_single_fragments.py.out
