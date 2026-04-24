cwlVersion: v1.2
class: CommandLineTool
baseCommand: PhyloAln
label: phyloaln_PhyloAln
doc: "A program to directly generate multiple sequence alignments from FASTA/FASTQ
  files based on reference alignments for phylogenetic analyses.\n\nTool homepage:
  https://github.com/huangyh45/PhyloAln"
inputs:
  - id: alignment_suffix
    type:
      - 'null'
      - string
    doc: the suffix of the reference FASTA alignment files when using 
      "-d"(default:.fa)
    inputBinding:
      position: 101
      prefix: --aln_suffix
  - id: config
    type:
      - 'null'
      - File
    doc: the TSV file with the format of 'species sequence_file(s)(absolute 
      path, files separated by commas)' per line for multiple species
    inputBinding:
      position: 101
      prefix: --config
  - id: cross_overlap_length
    type:
      - 'null'
      - int
    doc: minimum overlap length when cross contamination detection(default:30)
    inputBinding:
      position: 101
      prefix: --cross_overlap_len
  - id: cross_overlap_percent_identity
    type:
      - 'null'
      - float
    doc: minimum overlap percent identity when cross contamination 
      detection(default:98.00)
    inputBinding:
      position: 101
      prefix: --cross_overlap_pident
  - id: fasta_file
    type:
      type: array
      items: File
    doc: the input FASTA/FASTQ file(s) of the single species(-s), compressed 
      files ending with ".gz" are allowed
    inputBinding:
      position: 101
      prefix: --input
  - id: file_format
    type:
      - 'null'
      - string
    doc: the file format of the provided FASTA/FASTQ files, 'large_fasta' is 
      recommended for speeding up reading the FASTA files with long 
      sequences(e.g. genome sequences) and cannot be guessed(default:guess)
    inputBinding:
      position: 101
      prefix: --file_format
  - id: final_sequence_mode
    type:
      - 'null'
      - string
    doc: the mode to output the sequences(default:consensus, 'consensus' means 
      selecting most common bases from all sequences, 'consensus_strict' means 
      only selecting the common bases and remaining the different bases unknow, 
      'all' means remaining all sequences, 'expression' means the sequence with 
      highest read counts after assembly, 'length' means sequence with longest 
      length
    inputBinding:
      position: 101
      prefix: --final_seq
  - id: gencode
    type:
      - 'null'
      - int
    doc: the genetic code used in translation(default:1 = the standard code, see
      https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi)
    inputBinding:
      position: 101
      prefix: --gencode
  - id: hmmbuild_parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: the parameters when using HMMER hmmbuild for reference preparation, 
      with the format of ' --xxx' of each parameter, in which space is 
      required(default:[])
    inputBinding:
      position: 101
      prefix: --hmmbuild_parameters
  - id: hmmsearch_parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: the parameters when using HMMER hmmsearch for mapping the sequences, 
      with the format of ' --xxx' of each parameter, in which space is 
      required((default:[])
    inputBinding:
      position: 101
      prefix: --hmmsearch_parameters
  - id: ingroup
    type:
      - 'null'
      - type: array
        items: string
    doc: the ingroup species for score calculation in foreign or no-signal 
      sequences detection(default:all the sequences when all sequences are set 
      as outgroups; all other sequences except the outgroups)
    inputBinding:
      position: 101
      prefix: --ingroup
  - id: keep_sequence_id
    type:
      - 'null'
      - boolean
    doc: keep original sequence IDs in the output alignments instead of renaming
      them based on the species ID, not recommended when the output mode is 
      'consensus'/'consensus_strict' or the assembly step is on
    inputBinding:
      position: 101
      prefix: --keep_seqid
  - id: low_memory
    type:
      - 'null'
      - boolean
    doc: use a low-memory but slower mode to prepare the reads, 'large_fasta' 
      format is not supported and gz compressed files may still spend some 
      memory
    inputBinding:
      position: 101
      prefix: --low_mem
  - id: min_expression
    type:
      - 'null'
      - float
    doc: minimum expression value when cross contamination 
      detection(default:0.20)
    inputBinding:
      position: 101
      prefix: --min_exp
  - id: min_expression_fold
    type:
      - 'null'
      - float
    doc: minimum expression fold when cross contamination 
      detection(default:5.00)
    inputBinding:
      position: 101
      prefix: --min_exp_fold
  - id: mode
    type:
      - 'null'
      - string
    doc: 'the common mode to automatically set the parameters for easy use(**NOTICE:
      if you manually set those parameters, the parameters you set will be ignored
      and covered! See https://github.com/huangyh45/PhyloAln/blob/main/README.md#example-commands-for-different-data-and-common-mode-for-easy-use
      for detailed parameters)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: molecular_type
    type:
      - 'null'
      - string
    doc: the molecular type of the reference alignments(default:dna, 'dna' 
      suitable for nucleotide-to-nucleotide or protein-to-protein alignment, 
      'prot' suitable for protein-to-nucleotide alignment, 'codon' and 
      'dna_codon' suitable for codon-to-nucleotide alignment based on protein 
      and nucleotide alignments respectively)
    inputBinding:
      position: 101
      prefix: --mol_type
  - id: no_assemble
    type:
      - 'null'
      - boolean
    doc: not to assemble the raw sequences based on overlap regions
    inputBinding:
      position: 101
      prefix: --no_assemble
  - id: no_cross_species
    type:
      - 'null'
      - boolean
    doc: not to remove the cross contamination for multiple species
    inputBinding:
      position: 101
      prefix: --no_cross_species
  - id: no_out_filter
    type:
      - 'null'
      - boolean
    doc: not to filter the foreign or no-signal sequences based on conservative 
      score
    inputBinding:
      position: 101
      prefix: --no_out_filter
  - id: no_reference
    type:
      - 'null'
      - boolean
    doc: not to output the reference sequences
    inputBinding:
      position: 101
      prefix: --no_ref
  - id: no_reverse
    type:
      - 'null'
      - boolean
    doc: not to prepare and search the reverse strand of the sequences, 
      recommended for searching protein or CDS sequences
    inputBinding:
      position: 101
      prefix: --no_reverse
  - id: outgroup
    type:
      - 'null'
      - type: array
        items: string
    doc: the outgroup species for foreign or no-signal sequences 
      detection(default:all the sequences in the alignments with all sequences 
      as ingroups)
    inputBinding:
      position: 101
      prefix: --outgroup
  - id: outgroup_weight
    type:
      - 'null'
      - float
    doc: the weight coefficient to adjust strictness of the foreign or no-signal
      sequence filter, small number or decimal means ralaxed criterion 
      (default:0.90, 1 = not adjust)
    inputBinding:
      position: 101
      prefix: --outgroup_weight
  - id: output_directory
    type: Directory
    doc: the output directory containing the results(default:PhyloAln_out)
    inputBinding:
      position: 101
      prefix: --output
  - id: overlap_length
    type:
      - 'null'
      - int
    doc: minimum overlap length when assembling the raw sequences(default:30)
    inputBinding:
      position: 101
      prefix: --overlap_len
  - id: overlap_percent_identity
    type:
      - 'null'
      - float
    doc: minimum overlap percent identity when assembling the raw 
      sequences(default:98.00)
    inputBinding:
      position: 101
      prefix: --overlap_pident
  - id: parallel_tasks
    type:
      - 'null'
      - int
    doc: number of parallel tasks for each alignments, number of CPUs used for 
      single alignment will be automatically calculated by '--cpu / 
      --parallel'(default:the smaller value between number of alignments and the
      maximum threads to be used)
    inputBinding:
      position: 101
      prefix: --parallel
  - id: reference_alignment_file
    type: File
    doc: the single reference FASTA alignment file
    inputBinding:
      position: 101
      prefix: --aln
  - id: reference_alignments_directory
    type:
      - 'null'
      - Directory
    doc: the directory containing all the reference FASTA alignment files
    inputBinding:
      position: 101
      prefix: --aln_dir
  - id: reference_split_length
    type:
      - 'null'
      - int
    doc: If provided, split the reference alignments longer than this length 
      into short alignments with this length, ~1000 may be recommended for 
      concatenated alignments, and codon alignments should be devided by 3
    inputBinding:
      position: 101
      prefix: --ref_split_len
  - id: separator
    type:
      - 'null'
      - string
    doc: the separate symbol between species name and gene identifier in the 
      sequence headers of the alignments(default:.)
    inputBinding:
      position: 101
      prefix: --sep
  - id: sequence_split_length
    type:
      - 'null'
      - int
    doc: If provided, split the sequences longer than this length into short 
      sequences with this length, 200 may be recommended for long genomic reads 
      or sequences
    inputBinding:
      position: 101
      prefix: --split_len
  - id: sequence_split_slide
    type:
      - 'null'
      - int
    doc: the slide to split the sequences using sliding window 
      method(default:half of '--split_len')
    inputBinding:
      position: 101
      prefix: --split_slide
  - id: species
    type: string
    doc: the studied species ID for the provided FASTA/FASTQ files(-i)
    inputBinding:
      position: 101
      prefix: --species
  - id: threads
    type:
      - 'null'
      - int
    doc: maximum threads to be totally used in parallel tasks(default:8)
    inputBinding:
      position: 101
      prefix: --cpu
  - id: unknown_symbol
    type:
      - 'null'
      - string
    doc: the symbol representing unknown bases for missing 
      regions(default:unknow = 'N' in nucleotide alignments and 'X' in protein 
      alignments)
    inputBinding:
      position: 101
      prefix: --unknow_symbol
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloaln:1.1.0--hdfd78af_0
stdout: phyloaln_PhyloAln.out
