cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrsfast
label: mrsfast
doc: "mrsFAST is a cache oblivious read mapping tool. mrsFAST capable of mapping single
  and paired end reads to the reference genome. Bisulfite treated sequences are not
  supported in this version.\n\nTool homepage: https://github.com/sfu-compbio/mrsfast"
inputs:
  - id: index_file
    type:
      - 'null'
      - File
    doc: Reference genome file for indexing
    inputBinding:
      position: 1
  - id: search_index
    type:
      - 'null'
      - File
    doc: Index file for searching
    inputBinding:
      position: 2
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: Region(s) to extract
    inputBinding:
      position: 3
  - id: seq_file
    type:
      - 'null'
      - File
    doc: Input sequence file
    inputBinding:
      position: 4
  - id: best
    type:
      - 'null'
      - boolean
    doc: Find the best mapping location of given reads.
    inputBinding:
      position: 105
      prefix: --best
  - id: crop
    type:
      - 'null'
      - int
    doc: Trim the reads to n base pairs from beginning of the read.
    inputBinding:
      position: 105
      prefix: --crop
  - id: disable_nohits
    type:
      - 'null'
      - boolean
    doc: Do not output unmapped reads.
    inputBinding:
      position: 105
      prefix: --disable-nohits
  - id: disable_sam_header
    type:
      - 'null'
      - boolean
    doc: Do not generate SAM header.
    inputBinding:
      position: 105
      prefix: --disable-sam-header
  - id: discordant_vh
    type:
      - 'null'
      - boolean
    doc: Map the reads in discordant fashion that can be processed by Variation 
      Hunter / Common Law. Output will be generate in DIVET format.
    inputBinding:
      position: 105
      prefix: --discordant-vh
  - id: error_threshold
    type:
      - 'null'
      - int
    doc: Allow up to error-threshold mismatches in the mappings.
    inputBinding:
      position: 105
      prefix: -e
  - id: max_discordant_cutoff
    type:
      - 'null'
      - int
    doc: Allow m discordant mappings per read. Should be only used with 
      --discordant-vh option.
    inputBinding:
      position: 105
      prefix: --max-discordant-cutoff
  - id: max_discordant_length
    type:
      - 'null'
      - int
    doc: Use max-discordant-length for maximum length of concordant mapping. 
      Paired-end option only.
    inputBinding:
      position: 105
      prefix: --max
  - id: max_mappings_cutoff
    type:
      - 'null'
      - int
    doc: Output the mapping for the read sequences that have less than cut-off 
      number of mappings. Cannot be used with --best or --discordant-vh options.
    inputBinding:
      position: 105
      prefix: -n
  - id: memory
    type:
      - 'null'
      - int
    doc: Use maximum m GB of memory
    default: 4
    inputBinding:
      position: 105
      prefix: --mem
  - id: min_discordant_length
    type:
      - 'null'
      - int
    doc: Use min-discordant-length for minimum length of concordant mapping. 
      Paired-end option only.
    inputBinding:
      position: 105
      prefix: --min
  - id: outcomp
    type:
      - 'null'
      - boolean
    doc: Compress the output file by gzip.
    inputBinding:
      position: 105
      prefix: --outcomp
  - id: pe
    type:
      - 'null'
      - boolean
    doc: Map the reads in Paired-End mode. min and max of template length will 
      be calculated if not provided by corresponding options.
    inputBinding:
      position: 105
      prefix: --pe
  - id: seq
    type:
      - 'null'
      - File
    doc: Set the input sequence to file. In paired-end mode, file should be used
      if the read sequences are interleaved.
    inputBinding:
      position: 105
      prefix: --seq
  - id: seq1
    type:
      - 'null'
      - File
    doc: Set the input sequence (left mate) to file. Paired-end option only.
    inputBinding:
      position: 105
      prefix: --seq1
  - id: seq2
    type:
      - 'null'
      - File
    doc: Set the input sequence (right mate) to file. Paired-end option only.
    inputBinding:
      position: 105
      prefix: --seq2
  - id: seqcomp
    type:
      - 'null'
      - boolean
    doc: Input file is compressed through gzip.
    inputBinding:
      position: 105
      prefix: --seqcomp
  - id: snp_file
    type:
      - 'null'
      - File
    doc: Map the reads in SNP aware mode. In this mode mrsFAST-Ultra tolerates 
      the mismatches in known SNP locations reported by the provided SNP 
      database. The SNP index snp-file should be created from the dbSNP (.vcf) 
      file using the snp_indexer binary.
    inputBinding:
      position: 105
      prefix: --snp
  - id: snp_qual_threshold
    type:
      - 'null'
      - int
    doc: In SNP-aware mode, a mismatch at a reported SNP location will be 
      ignored only if the corresponding read location has a quality higher than 
      or equal to the quality-threshold. quality-threshold is a Phred-Value base
      33. The default is 53 (base call error 0.01).
    inputBinding:
      position: 105
      prefix: --snp-qual
  - id: tail_crop
    type:
      - 'null'
      - int
    doc: Trim the reads to n base pairs from end of the read.
    inputBinding:
      position: 105
      prefix: --tail-crop
  - id: threads
    type:
      - 'null'
      - int
    doc: Use t number of cores for mapping the sequences. Use 0 to use all the 
      available cores in the system.
    default: 1
    inputBinding:
      position: 105
      prefix: --threads
  - id: unmapped_reads_file
    type:
      - 'null'
      - File
    doc: Output unmapped reads in file. This file will be generated in all 
      mapping mode.
    default: output.nohit
    inputBinding:
      position: 105
      prefix: -u
  - id: window_size
    type:
      - 'null'
      - int
    doc: Index the reference genome with sliding a window of size window_size
    default: 12
    inputBinding:
      position: 105
      prefix: --ws
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output the mapping record into file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrsfast:3.4.2--h7132678_2
