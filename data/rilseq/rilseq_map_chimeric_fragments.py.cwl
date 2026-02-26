cwlVersion: v1.2
class: CommandLineTool
baseCommand: map_chimeric_fragments.py
label: rilseq_map_chimeric_fragments.py
doc: "Map unmapped reads as chimeric fragments\n\nTool homepage: http://github.com/asafpr/RILseq"
inputs:
  - id: genome_fasta
    type: File
    doc: Name of genome fasta file. The file must be indexed using bwa index 
      command prior to this run.
    inputBinding:
      position: 1
  - id: bamfiles
    type:
      type: array
      items: File
    doc: One or more bam files.
    inputBinding:
      position: 2
  - id: add_all_reads
    type:
      - 'null'
      - boolean
    doc: By default map all reads in the BAM file, write all the fragments, 
      either chimeric ro single to the output file (stdout). If this option is 
      selected don't wirte the single reads.
    default: true
    inputBinding:
      position: 103
      prefix: --add_all_reads
  - id: all_reads
    type:
      - 'null'
      - File
    doc: Map all reads in the BAM file, write all the fragments that are not 
      chimeric to the file specified here e.g. -a single_fragments_mapping.txt. 
      By default these reads will be written to the standard output.
    default: None
    inputBinding:
      position: 103
      prefix: --all_reads
  - id: allowed_mismatches
    type:
      - 'null'
      - int
    doc: This number of mismatches is allowed between the a match and the 
      genome. If there are mapped reads with less than --max_mismatches 
      mismatches but more than this number the read will be ignored.
    default: 1
    inputBinding:
      position: 103
      prefix: --allowed_mismatches
  - id: bwa_exec
    type:
      - 'null'
      - string
    doc: bwa command
    default: bwa
    inputBinding:
      position: 103
      prefix: --bwa_exec
  - id: dirout
    type:
      - 'null'
      - Directory
    doc: Output directory, default is this directory.
    default: ./remapped-data/
    inputBinding:
      position: 103
      prefix: --dirout
  - id: distance
    type:
      - 'null'
      - int
    doc: Maximal distance between concordant reads. If they are generated from 
      the same strand but larger than this distance they will be considered as 
      chimeric.
    default: 1000
    inputBinding:
      position: 103
      prefix: --distance
  - id: dust_thr
    type:
      - 'null'
      - int
    doc: Threshold for dust filter. If 0 skip.
    default: 10
    inputBinding:
      position: 103
      prefix: --dust_thr
  - id: feature
    type:
      - 'null'
      - string
    doc: Name of features to count on the GTF file (column 2).
    default: exon
    inputBinding:
      position: 103
      prefix: --feature
  - id: identifier
    type:
      - 'null'
      - string
    doc: Name of identifier to print (in column 8 of the GTF file).
    default: gene_id
    inputBinding:
      position: 103
      prefix: --identifier
  - id: keep_circular
    type:
      - 'null'
      - boolean
    doc: Remove reads that are probably a result of circular RNAs by default. If
      the reads are close but in opposite order they will be removed unless this
      argument is set.
    default: false
    inputBinding:
      position: 103
      prefix: --keep_circular
  - id: length
    type:
      - 'null'
      - int
    doc: Length of sequence to map. Take the ends of the fragment and map each 
      to the genome. The length of the region will be this length.
    default: 25
    inputBinding:
      position: 103
      prefix: --length
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Find alignment allowing this number of mismatches. If there are more 
      than one match with this number of mismatches the read will be treated as 
      if it might match all of them and if there is one scenario in which the 
      two ends are concordant it will be removed.
    default: 3
    inputBinding:
      position: 103
      prefix: --max_mismatches
  - id: maxg
    type:
      - 'null'
      - float
    doc: If a read has more than this fraction of Gs remove this read from the 
      screen. This is due to nextseq technology which puts G where there is no 
      signal, the poly G might just be noise. When using other sequencing 
      technologies set to 1.
    default: 0.8
    inputBinding:
      position: 103
      prefix: --maxG
  - id: params_aln
    type:
      - 'null'
      - string
    doc: Additional parameters for aln function of bwa.
    default: -t 8 -N -M 0
    inputBinding:
      position: 103
      prefix: --params_aln
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Treat the reads as reverse complement. This means that the first read 
      is actually the 3' end of the fragment. Use this when using Jonathan 
      Livny's protocol for library construction
    default: false
    inputBinding:
      position: 103
      prefix: --reverse_complement
  - id: samse_params
    type:
      - 'null'
      - string
    doc: Additional parameters for samse function of bwa.
    default: -n 1000
    inputBinding:
      position: 103
      prefix: --samse_params
  - id: samtools_cmd
    type:
      - 'null'
      - string
    doc: Samtools executable.
    default: samtools
    inputBinding:
      position: 103
      prefix: --samtools_cmd
  - id: skip_mapping
    type:
      - 'null'
      - boolean
    doc: Skip the mapping step, use previously mapped files.
    default: false
    inputBinding:
      position: 103
      prefix: --skip_mapping
  - id: transcripts
    type:
      - 'null'
      - File
    doc: A gff file of transcripts. If given, screen reads that might reside 
      from the same transcript. Very useful for screening ribosomal RNAs. 
      Otherwise use only the size limit.
    default: None
    inputBinding:
      position: 103
      prefix: --transcripts
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq_map_chimeric_fragments.py.out
