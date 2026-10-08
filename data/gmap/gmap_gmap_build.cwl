cwlVersion: v1.2
class: CommandLineTool
baseCommand: gmap_build
label: gmap_gmap_build
doc: "Builds a gmap database for a genome to be used by GMAP or GSNAP\n\nTool homepage: http://research-pub.gene.com/gmap/"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Genome FASTA files (not needed when only adding a transcriptome to an existing genome database)
    inputBinding:
      position: 110
  - id: genomedir
    type: string
    default: gmapdb
    doc: "Destination directory for installation (defaults to gmapdb directory specified at configure time)"
    inputBinding:
      position: 101
      prefix: --genomedir
  - id: genomedb
    type: string
    doc: "Genome name (required)"
    inputBinding:
      position: 101
      prefix: --genomedb
  - id: names
    type:
      - 'null'
      - File
    doc: "Substitute names for contigs, provided in a file. The file can have two formats: 1.  A file with one column per line, with each line corresponding to a FASTA file, in the order given to gmap_build.  The chromosome name for each FASTA file will be replaced with the desired chromosome name in the file. Every chromosome in the FASTA must have a corresponding line in the file.  This is useful if you want to rename chromosomes with a systematic numbering pattern. 2.  A file with two columns per line, separated by white space.  In each line, the original FASTA chromosome name should be in column 1 and the desired chromosome name will be in column 2. The meaning of file format 2 depends on whether --limit-to-names is specified.  If so, the genome build will be limited to those chromosomes in this file.  Otherwise, all chromosomes in the FASTA file will be included, but only those chromosomes in this file will be re-named, which provides an easy way to change just a few chromosome names. This file can be combined with the --sort=names option, in which the order of chromosomes is that given in the file.  In this case, every chromosome must be listed in the file, and for chromosome names that should not be changed, column 2 can be blank (or the same as column 1).  The option of a blank column 2 is allowed only when specifying --sort=names, because otherwise, the program cannot distinguish between a 1-column and 2-column names file."
    inputBinding:
      position: 101
      prefix: --names
  - id: limit_to_names
    type:
      - 'null'
      - boolean
    doc: "Determines whether to limit the genome build to the lines listed in the --names file.  You can limit a genome build to certain chromosomes with this option, plus a --names file that either renames chromosomes, or lists the same names in both columns for the desired chromosomes."
    inputBinding:
      position: 101
      prefix: --limit-to-names
  - id: kmer
    type:
      - 'null'
      - int
    doc: "k-mer value for genomic index (allowed: 15 or less, default is 15)"
    inputBinding:
      position: 101
      prefix: --kmer
  - id: q
    type:
      - 'null'
      - int
    doc: "sampling interval for genomoe (allowed: 1-3, default 3)"
    inputBinding:
      position: 101
      prefix: -q
  - id: sort
    type:
      - 'null'
      - string
    doc: "Sort chromosomes using given method: none - use chromosomes as found in FASTA file(s) (default) alpha - sort chromosomes alphabetically (chr10 before chr 1) numeric-alpha - chr1, chr1U, chr2, chrM, chrU, chrX, chrY chrom - chr1, chr2, chrM, chrX, chrY, chr1U, chrU names - sort chromosomes based on file provided to --names flag"
    inputBinding:
      position: 101
      prefix: --sort
  - id: gunzip
    type:
      - 'null'
      - boolean
    doc: "Files are gzipped, so need to gunzip each file first"
    inputBinding:
      position: 101
      prefix: --gunzip
  - id: fasta_pipe
    type:
      - 'null'
      - string
    doc: "Interpret argument as a command, instead of a list of FASTA files"
    inputBinding:
      position: 101
      prefix: --fasta-pipe
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Files are in FASTQ format"
    inputBinding:
      position: 101
      prefix: --fastq
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: "Reverse complement all contigs"
    inputBinding:
      position: 101
      prefix: --revcomp
  - id: w
    type:
      - 'null'
      - int
    doc: "Wait (sleep) this many seconds after each step (default 2)"
    inputBinding:
      position: 101
      prefix: -w
  - id: circular
    type:
      - 'null'
      - string
    doc: "Circular chromosomes (either a list of chromosomes separated by a comma, or a filename containing circular chromosomes, one per line).  If you use the --names feature, then you should use the substitute name of the chromosome, not the original name, for this option.  (NOTE: This behavior is different from previous versions, and starts with version 2020-10-20.)"
    inputBinding:
      position: 101
      prefix: --circular
  - id: altscaffold
    type:
      - 'null'
      - File
    doc: "File with alt scaffold info, listing alternate scaffolds, one per line, tab-delimited, with the following fields: (1) alt_scaf_acc, (2) parent_name, (3) orientation, (4) alt_scaf_start, (5) alt_scaf_stop, (6) parent_start, (7) parent_end."
    inputBinding:
      position: 101
      prefix: --altscaffold
  - id: nmessages
    type:
      - 'null'
      - int
    doc: "Maximum number of messages (warnings, contig reports) to report (default 50)"
    inputBinding:
      position: 101
      prefix: --nmessages
  - id: sarray
    type:
      - 'null'
      - int
    doc: "Whether to build suffix array: 0=no (default), 1=yes"
    inputBinding:
      position: 101
      prefix: --sarray
  - id: mdflag
    type:
      - 'null'
      - File
    doc: "Use MD file from NCBI for mapping contigs to chromosomal coordinates"
    inputBinding:
      position: 101
      prefix: --mdflag
  - id: transcriptomedir
    type:
      - 'null'
      - string
    doc: "Destination directory for installation (defaults to gmapdb directory specified at configure time)"
    inputBinding:
      position: 101
      prefix: --transcriptomedir
  - id: transcriptomedb
    type:
      - 'null'
      - string
    doc: "Transcriptome name, plus one of these four flags:"
    inputBinding:
      position: 101
      prefix: --transcriptomedb
  - id: gtf
    type:
      - 'null'
      - File
    doc: "GTF file containing transcripts"
    inputBinding:
      position: 101
      prefix: --gtf
  - id: gff3
    type:
      - 'null'
      - File
    doc: "GFF3 file containing transcripts"
    inputBinding:
      position: 101
      prefix: --gff3
  - id: genes
    type:
      - 'null'
      - File
    doc: "Genes file containing transcripts"
    inputBinding:
      position: 101
      prefix: --genes
  - id: transcripts
    type:
      - 'null'
      - File
    doc: "FASTA file containing transcripts"
    inputBinding:
      position: 101
      prefix: --transcripts
  - id: nthreads
    type:
      - 'null'
      - int
    doc: "Number of threads for GMAP alignment of transcripts to genome (default 8).  Applies if --transcripts option is given"
    inputBinding:
      position: 101
      prefix: --nthreads
outputs:
  - id: genome_dir
    type: Directory
    doc: Destination directory with the genome database
    outputBinding:
      glob: $(inputs.genomedir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gmap:2025.07.31--pl5321hb1d24b7_1
