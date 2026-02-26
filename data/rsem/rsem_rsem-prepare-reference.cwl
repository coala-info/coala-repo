cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-prepare-reference
label: rsem_rsem-prepare-reference
doc: "Prepare transcript references for RSEM and optionally build BOWTIE/BOWTIE2/STAR/HISAT2(transcriptome)
  indices.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: reference_fasta_files
    type:
      type: array
      items: File
    doc: Either a comma-separated list of Multi-FASTA formatted files OR a 
      directory name. If a directory name is specified, RSEM will read all files
      with suffix ".fa" or ".fasta" in this directory. The files should contain 
      either the sequences of transcripts or an entire genome, depending on 
      whether the '--gtf' option is used.
    inputBinding:
      position: 1
  - id: reference_name
    type: string
    doc: The name of the reference used. RSEM will generate several 
      reference-related files that are prefixed by this name. This name can 
      contain path information (e.g. '/ref/mm9').
    inputBinding:
      position: 2
  - id: allele_to_gene_map
    type:
      - 'null'
      - File
    doc: "Use information from <file> to provide gene_id and transcript_id information
      for each allele-specific transcript. Each line of <file> should be of the form:\n\
      \ngene_id transcript_id allele_id\n\nwith the fields separated by a tab character.\n\
      \nThis option is designed for quantifying allele-specific expression. It is
      only valid if '--gtf' option is not specified. allele_id should be the sequence
      names presented in the Multi-FASTA-formatted files.\n\n(Default: off)"
    inputBinding:
      position: 103
      prefix: --allele-to-gene-map
  - id: bowtie
    type:
      - 'null'
      - boolean
    doc: 'Build Bowtie indices. (Default: off)'
    inputBinding:
      position: 103
      prefix: --bowtie
  - id: bowtie2
    type:
      - 'null'
      - boolean
    doc: 'Build Bowtie 2 indices. (Default: off)'
    inputBinding:
      position: 103
      prefix: --bowtie2
  - id: bowtie2_path
    type:
      - 'null'
      - Directory
    doc: "The path to the Bowtie 2 executables. (Default: the path to Bowtie 2 executables
      is assumed to be in the user's PATH environment variable)"
    inputBinding:
      position: 103
      prefix: --bowtie2-path
  - id: bowtie_path
    type:
      - 'null'
      - Directory
    doc: "The path to the Bowtie executables. (Default: the path to Bowtie executables
      is assumed to be in the user's PATH environment variable)"
    inputBinding:
      position: 103
      prefix: --bowtie-path
  - id: gff3_file
    type:
      - 'null'
      - File
    doc: "The annotation file is in GFF3 format instead of GTF format. RSEM will first
      convert it to GTF format with the file name 'reference_name.gtf'. Please make
      sure that 'reference_name.gtf' does not exist. (Default: off)"
    inputBinding:
      position: 103
      prefix: --gff3
  - id: gff3_genes_as_transcripts
    type:
      - 'null'
      - boolean
    doc: This option is designed for untypical organisms, such as viruses, whose
      GFF3 files only contain genes. RSEM will assume each gene as a unique 
      transcript when it converts the GFF3 file into GTF format.
    inputBinding:
      position: 103
      prefix: --gff3-genes-as-transcripts
  - id: gff3_rna_patterns
    type:
      - 'null'
      - string
    doc: '<pattern> is a comma-separated list of transcript categories, e.g. "mRNA,rRNA".
      Only transcripts that match the <pattern> will be extracted. (Default: "mRNA")'
    default: mRNA
    inputBinding:
      position: 103
      prefix: --gff3-RNA-patterns
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: "If this option is on, RSEM assumes that 'reference_fasta_file(s)' contains
      the sequence of a genome, and will extract transcript reference sequences using
      the gene annotations specified in <file>, which should be in GTF format.\n\n\
      If this and '--gff3' options are off, RSEM will assume 'reference_fasta_file(s)'
      contains the reference transcripts. In this case, RSEM assumes that name of
      each sequence in the Multi-FASTA files is its transcript_id.\n\n(Default: off)"
    inputBinding:
      position: 103
      prefix: --gtf
  - id: hisat2_hca
    type:
      - 'null'
      - boolean
    doc: 'Build HISAT2 indices on the transcriptome according to Human Cell Atlas
      (HCA) SMART-Seq2 pipeline. (Default: off)'
    inputBinding:
      position: 103
      prefix: --hisat2-hca
  - id: hisat2_path
    type:
      - 'null'
      - Directory
    doc: "The path to the HISAT2 executables. (Default: the path to HISAT2 executables
      is assumed to be in the user's PATH environment variable)"
    inputBinding:
      position: 103
      prefix: --hisat2-path
  - id: mappability_bigwig_file
    type:
      - 'null'
      - File
    doc: 'Full path to a whole-genome mappability file in bigWig format. This file
      is required for running prior-enhanced RSEM. It is used for selecting a training
      set of isoforms for prior-learning. This file can be either downloaded from
      UCSC Genome Browser or generated by GEM (Derrien et al., 2012, PLoS One). (Default:
      "")'
    default: ''
    inputBinding:
      position: 103
      prefix: --mappability-bigwig-file
  - id: no_polyA_subset
    type:
      - 'null'
      - File
    doc: "Only meaningful if '--polyA' is specified. Do not add poly(A) tails to those
      transcripts listed in <file>. <file> is a file containing a list of transcript_ids.
      (Default: off)"
    inputBinding:
      position: 103
      prefix: --no-polyA-subset
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for building STAR's genome indices. (Default: 1)"
    default: 1
    inputBinding:
      position: 103
      prefix: --num-threads
  - id: polyA
    type:
      - 'null'
      - boolean
    doc: "Add poly(A) tails to the end of all reference isoforms. The length of poly(A)
      tail added is specified by '--polyA-length' option. STAR aligner users may not
      want to use this option. (Default: do not add poly(A) tail to any of the isoforms)"
    inputBinding:
      position: 103
      prefix: --polyA
  - id: polyA_length
    type:
      - 'null'
      - int
    doc: 'The length of the poly(A) tails to be added. (Default: 125)'
    default: 125
    inputBinding:
      position: 103
      prefix: --polyA-length
  - id: prep_prsem
    type:
      - 'null'
      - boolean
    doc: 'A Boolean indicating whether to prepare reference files for pRSEM, including
      building Bowtie indices for a genome and selecting training set isoforms. The
      index files will be used for aligning ChIP-seq reads in prior-enhanced RSEM
      and the training set isoforms will be used for learning prior. A path to Bowtie
      executables and a mappability file in bigWig format are required when this option
      is on. Currently, Bowtie2 is not supported for prior-enhanced RSEM. (Default:
      off)'
    inputBinding:
      position: 103
      prefix: --prep-pRSEM
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Suppress the output of logging information. (Default: off)'
    inputBinding:
      position: 103
      prefix: --quiet
  - id: star
    type:
      - 'null'
      - boolean
    doc: 'Build STAR indices. (Default: off)'
    inputBinding:
      position: 103
      prefix: --star
  - id: star_path
    type:
      - 'null'
      - Directory
    doc: "The path to STAR's executable. (Default: the path to STAR executable is
      assumed to be in user's PATH environment variable)"
    inputBinding:
      position: 103
      prefix: --star-path
  - id: star_sjdboverhang
    type:
      - 'null'
      - int
    doc: "Length of the genomic sequence around annotated junction. It is only used
      for STAR to build splice junctions database and not needed for Bowtie or Bowtie2.
      It will be passed as the --sjdbOverhang option to STAR. According to STAR's
      manual, its ideal value is max(ReadLength)-1, e.g. for 2x101 paired-end reads,
      the ideal value is 101-1=100. In most cases, the default value of 100 will work
      as well as the ideal value. (Default: 100)"
    default: 100
    inputBinding:
      position: 103
      prefix: --star-sjdboverhang
  - id: transcript_to_gene_map
    type:
      - 'null'
      - File
    doc: "Use information from <file> to map from transcript (isoform) ids to gene
      ids. Each line of <file> should be of the form:\n\ngene_id transcript_id\n\n\
      with the two fields separated by a tab character.\n\nIf you are using a GTF
      file for the \"UCSC Genes\" gene set from the UCSC Genome Browser, then the
      \"knownIsoforms.txt\" file (obtained from the \"Downloads\" section of the UCSC
      Genome Browser site) is of this format.\n\nIf this option is off, then the mapping
      of isoforms to genes depends on whether the '--gtf' option is specified. If
      '--gtf' is specified, then RSEM uses the \"gene_id\" and \"transcript_id\" attributes
      in the GTF file. Otherwise, RSEM assumes that each sequence in the reference
      sequence files is a separate gene.\n\n(Default: off)"
    inputBinding:
      position: 103
      prefix: --transcript-to-gene-map
  - id: trusted_sources
    type:
      - 'null'
      - string
    doc: '<sources> is a comma-separated list of trusted sources, e.g. "ENSEMBL,HAVANA".
      Only transcripts coming from these sources will be extracted. If this option
      is off, all sources are accepted. (Default: off)'
    inputBinding:
      position: 103
      prefix: --trusted-sources
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem_rsem-prepare-reference.out
