cwlVersion: v1.2
class: CommandLineTool
baseCommand: FEELnc_codpot.pl
label: feelnc_FEELnc_codpot.pl
doc: "FEELnc_codpot.pl is a tool for predicting lncRNA transcripts.\n\nTool homepage:
  https://github.com/tderrien/FEELnc"
inputs:
  - id: biotype
    type:
      - 'null'
      - string
    doc: 'Only consider transcripts having this(these) biotype(s) from the reference
      annotation (e.g : -b transcript_biotype=protein_coding,pseudogene)'
    inputBinding:
      position: 101
      prefix: -b
  - id: genome_fa
    type:
      - 'null'
      - File
    doc: Genome file or directory with chr files (mandatory if input is .GTF)
    inputBinding:
      position: 101
      prefix: --genome
  - id: keeptmp
    type:
      - 'null'
      - int
    doc: To keep the temporary files in a 'tmp' directory the outdir, by default
      don't keep it (0 value). Any other value than 0 will keep the temporary 
      files
    inputBinding:
      position: 101
      prefix: --keeptmp
  - id: kmer
    type:
      - 'null'
      - string
    doc: Kmer size list with size separate by ',' as string
    inputBinding:
      position: 101
      prefix: -k
  - id: known_lnc_gtf
    type:
      - 'null'
      - File
    doc: Specify a known set of lncRNA for training .GTF or .FASTA
    inputBinding:
      position: 101
      prefix: --lncRNAfile
  - id: known_mrna_gtf
    type: File
    doc: Specify the annotation .GTF or .FASTA file (file of protein coding 
      transcripts .GTF or .FASTA file)
    inputBinding:
      position: 101
      prefix: --mRNAfile
  - id: learnorftype
    type:
      - 'null'
      - int
    doc: "Integer [0,1,2,3,4] to specify the type of longest ORF calculate for learning
      data set. If the CDS is annotated in the .GTF, then the CDS is considered as
      the longest ORF, whatever the --orftype value. '0': ORF with start and stop
      codon; '1': same as '0' and ORF with only a start codon, take the longest; '2':
      same as '1' but with a stop codon; '3': same as '0' and ORF with a start or
      a stop, take the longest (see '1' and '2'); '4': same as '3' but if no ORF is
      found, take the input sequence as ORF."
    inputBinding:
      position: 101
      prefix: --learnorftype
  - id: mode
    type:
      - 'null'
      - string
    doc: "The mode of the lncRNA sequences simulation if no lncRNA sequences have
      been provided. The mode can be: 'shuffle' : make a permutation of mRNA sequences
      while preserving the 7mer count. Can be done on either FASTA and GTF input file;
      'intergenic': extract intergenic sequences. Can be done *only* on GTF input
      file."
    inputBinding:
      position: 101
      prefix: -m
  - id: ntree
    type:
      - 'null'
      - int
    doc: Number of trees used in random forest
    inputBinding:
      position: 101
      prefix: --ntree
  - id: numtx
    type:
      - 'null'
      - string
    doc: Number of mRNA and lncRNA transcripts required for the training. mRNAs 
      and lncRNAs numbers need to be separate by a ',', i.e. 1500,1000 for 1500 
      mRNAs and 1000 lncRNAs. For all the annotation, let it blank
    inputBinding:
      position: 101
      prefix: -n
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: outname
    type:
      - 'null'
      - string
    doc: Output filename
    inputBinding:
      position: 101
      prefix: -o
  - id: percentage
    type:
      - 'null'
      - float
    doc: Percentage of the training file use for the training of the kmer model.
      What remains will be used to train the random forest
    inputBinding:
      position: 101
      prefix: --percentage
  - id: rfcut
    type:
      - 'null'
      - float
    doc: Random forest voting cutoff
    inputBinding:
      position: 101
      prefix: -r
  - id: seed
    type:
      - 'null'
      - int
    doc: Use to fixe the seed value for the extraction of intergenic DNA region 
      to get lncRNA like sequences and for the random forest
    inputBinding:
      position: 101
      prefix: --seed
  - id: sizeinter
    type:
      - 'null'
      - float
    doc: Ratio between mRNA sequence lengths and non coding intergenic region 
      sequence lengths as, by default, ncInter = mRNA * 0.75
    inputBinding:
      position: 101
      prefix: -s
  - id: spethres
    type:
      - 'null'
      - string
    doc: Two specificity threshold based on the 10-fold cross-validation, first 
      one for mRNA and the second for lncRNA, need to be in ]0,1[ on separated 
      by a ','
    inputBinding:
      position: 101
  - id: testorftype
    type:
      - 'null'
      - int
    doc: Integer [0,1,2,3,4] to specify the type of longest ORF calculate for 
      test data set. See --learnortype description for more informations.
    inputBinding:
      position: 101
      prefix: --testorftype
  - id: transcripts_gtf
    type: File
    doc: Specify the .GTF or .FASTA file (such as a cufflinks transcripts/merged
      .GTF or .FASTA file)
    inputBinding:
      position: 101
      prefix: --infile
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Integer [0,1,2]: which level of information that need to be print. Note
      that that printing is made on STDERR'
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_codpot.pl.out
