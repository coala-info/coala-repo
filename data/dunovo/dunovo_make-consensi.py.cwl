cwlVersion: v1.2
class: CommandLineTool
baseCommand: make-consensi.py
label: dunovo_make-consensi.py
doc: "Build consensus sequences from read aligned families. Prints duplex consensus
  sequences in FASTA to stdout. The sequence ids are BARCODE.MATE, e.g. \"CTCAGATAACATACCTTATATGCA.1\"\
  , where \"BARCODE\" is the input barcode, and \"MATE\" is \"1\" or \"2\" as an arbitrary
  designation of the two reads in the pair. The id is followed by the count of the
  number of reads in the two families (one from each strand) that make up the duplex,
  in the format READS1/READS2. If the duplex is actually a single-strand consensus
  because the matching strand is missing, only one number is listed.\nRules for consensus
  building: Single-strand consensus sequences are made by counting how many of each
  base are at a given position. Bases with a PHRED quality score below the --qual
  threshold are not counted. If a majority of the reads (that pass the --qual threshold
  at that position) have one base at that position, then that base is used as the
  consensus base. If no base has a majority, then an N is used.\nDuplex consensus
  sequences are made by aligning pairs of single-strand consensuses, and comparing
  bases at each position. If they agree, that base is used in the consensus. Otherwise,
  the IUPAC ambiguity code for both bases is used (N + anything and gap + non-gap
  result in an N).\n\nTool homepage: https://github.com/galaxyproject/dunovo"
inputs:
  - id: families_msa_tsv
    type: File
    doc: "The output of align_families.py. 6 columns:\n                        1.
      (canonical) barcode\n                        2. order (\"ab\" or \"ba\")\n \
      \                       3. mate (\"1\" or \"2\")\n                        4.
      read name\n                        5. aligned sequence\n                   \
      \     6. aligned quality scores."
    inputBinding:
      position: 1
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Which pairwise alignment library to use. 'swalign' uses a custom Smith-Waterman
      implementation by Nicolaus Lance Hepler and is the old default. 'biopython'
      uses BioPython's PairwiseAligner and a substitution matrix built by the Bioconductor's
      Biostrings package. Default: biopython"
    default: biopython
    inputBinding:
      position: 102
      prefix: --aligner
  - id: cons_thres
    type:
      - 'null'
      - float
    doc: 'The fractional threshold to use when making consensus sequences. The consensus
      base must be present in more than this fraction of the reads, or N will be used
      as the consensus base instead. Default: 0.7'
    default: 0.7
    inputBinding:
      position: 102
      prefix: --cons-thres
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --debug
  - id: fastq_out_phred_score
    type:
      - 'null'
      - int
    doc: Output in FASTQ instead of FASTA. You must specify the quality score to
      give to all bases. There is no meaningful quality score we can 
      automatically give, so you will have to specify an artificial one. A good 
      choice is 40, the maximum score normally output by sequencers.
    inputBinding:
      position: 102
      prefix: --fastq-out
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: Tell the script it's running on Galaxy. Currently this only affects 
      data reported when phoning home.
    inputBinding:
      position: 102
      prefix: --galaxy
  - id: min_cons_reads
    type:
      - 'null'
      - int
    doc: 'The absolute threshold to use when making consensus sequences. The consensus
      base must be present in more than this number of reads, or N will be used as
      the consensus base instead. Default: 0'
    default: 0
    inputBinding:
      position: 102
      prefix: --min-cons-reads
  - id: min_reads
    type:
      - 'null'
      - int
    doc: 'The minimum number of reads (from each strand) required to form a single-strand
      consensus. Strands with fewer reads will be skipped. Default: 3.'
    default: 3
    inputBinding:
      position: 102
      prefix: --min-reads
  - id: phone_home
    type:
      - 'null'
      - boolean
    doc: Report helpful usage data to the developer, to better understand the 
      use cases and performance of the tool. The only data which will be 
      recorded is the name and version of the tool, the size of the input data, 
      the time and memory taken to process it, and the IP address of the machine
      running it. Also, if the script fails, it will report the name of the 
      exception thrown and the line of code it occurred in. No filenames are 
      sent, and the only parameters reported are the number of --processes and 
      the --queue-size. All the reporting and recording code is available at 
      https://github.com/NickSto/ET.
    inputBinding:
      position: 102
      prefix: --phone-home
  - id: processes
    type:
      - 'null'
      - string
    doc: 'Number of worker subprocesses to use. If 0, no subprocesses will be started
      and everything will be done inside one process. Give "auto" to use as many processes
      as there are CPU cores. Default: 0.'
    default: '0'
    inputBinding:
      position: 102
      prefix: --processes
  - id: qual
    type:
      - 'null'
      - int
    doc: 'Base quality threshold. Bases below this quality will not be counted. Default:
      20.'
    default: 20
    inputBinding:
      position: 102
      prefix: --qual
  - id: qual_format
    type:
      - 'null'
      - string
    doc: "FASTQ quality score format. Sanger scores are assumed to begin at 33 ('!').
      Default: sanger."
    default: sanger
    inputBinding:
      position: 102
      prefix: --qual-format
  - id: queue_size
    type:
      - 'null'
      - int
    doc: 'How long to go accumulating responses from worker subprocesses before dealing
      with all of them. Default: 8 * the number of worker --processes.'
    inputBinding:
      position: 102
      prefix: --queue-size
  - id: quiet
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --quiet
  - id: test
    type:
      - 'null'
      - boolean
    doc: If reporting usage data, mark this as a test run.
    inputBinding:
      position: 102
      prefix: --test
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: duplexes_1_fa
    type:
      - 'null'
      - File
    doc: 'The file to output the first mates of the duplex consensus sequences into.
      Warning: This will be overwritten if it exists!'
    outputBinding:
      glob: $(inputs.duplexes_1_fa)
  - id: duplexes_2_fa
    type:
      - 'null'
      - File
    doc: 'Same, but for mate 2. Warning: This will be overwritten if it exists!'
    outputBinding:
      glob: $(inputs.duplexes_2_fa)
  - id: sscs1_fa
    type:
      - 'null'
      - File
    doc: 'Save the single-strand consensus sequences (mate 1) in this file (FASTA
      format). Warning: This will be overwritten if it exists!'
    outputBinding:
      glob: $(inputs.sscs1_fa)
  - id: sscs2_fa
    type:
      - 'null'
      - File
    doc: 'Save the single-strand consensus sequences (mate 2) in this file (FASTA
      format). Warning: This will be overwritten if it exists!'
    outputBinding:
      glob: $(inputs.sscs2_fa)
  - id: log
    type:
      - 'null'
      - File
    doc: 'Print log messages to this file instead of to stderr. Warning: Will overwrite
      the file.'
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
