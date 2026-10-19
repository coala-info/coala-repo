cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribo
  - seed
label: riboseed_ribo_seed
doc: "Given a cluster file of rDNA regions from riboSelect and either paired-end or single-end reads, assemble the mapped reads into pseudocontig 'seeds', and use those with the reads to run de fere novo and de novo assembly with SPAdes.\n\nTool homepage: https://github.com/nickp60/riboSeed"
inputs:
  - id: clustered_loci_txt
    type: File
    doc: "output from riboSelect"
    inputBinding:
      position: 1
  - id: reference_genbank
    type: File
    doc: "genbank reference, used to estimate insert sizes, and compare with QUAST"
    inputBinding:
      position: 101
      prefix: '--reference_genbank'
  - id: fastq1
    type:
      - 'null'
      - File
    doc: "forward fastq reads, can be compressed"
    inputBinding:
      position: 101
      prefix: '--fastq1'
  - id: fastq2
    type:
      - 'null'
      - File
    doc: "reverse fastq reads, can be compressed"
    inputBinding:
      position: 101
      prefix: '--fastq2'
  - id: fastq_s1
    type:
      - 'null'
      - File
    doc: "single fastq reads"
    inputBinding:
      position: 101
      prefix: '--fastqS1'
  - id: flanking_length
    type:
      - 'null'
      - int
    doc: "length of flanking regions, in bp; default: 1000"
    inputBinding:
      position: 101
      prefix: '--flanking_length'
  - id: just_seed
    type:
      - 'null'
      - boolean
    doc: "Don't do an assembly, just generate the long read 'seeds'; default: False"
    inputBinding:
      position: 101
      prefix: '--just_seed'
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: "prefix for results files; default: riboSeed"
    inputBinding:
      position: 101
      prefix: '--experiment_name'
  - id: mapper
    type:
      - 'null'
      - string
    doc: "available mappers: smalt and bwa; default: bwa"
    inputBinding:
      position: 101
      prefix: '--mapper'
  - id: kmers
    type:
      - 'null'
      - string
    doc: "kmers used for final assembly, separated by commas such as 21,33,55,77,99,127 . Can be set to auto, where SPAdes chooses."
    inputBinding:
      position: 101
      prefix: '--kmers'
  - id: pre_kmers
    type:
      - 'null'
      - string
    doc: "kmers used during seeding assemblies, separated by commas; default: 21,33,55,77,99"
    inputBinding:
      position: 101
      prefix: '--pre_kmers'
  - id: force_kmers
    type:
      - 'null'
      - boolean
    doc: "skip checking to see if kmer choice is appropriate to read length"
    inputBinding:
      position: 101
      prefix: '--force_kmers'
  - id: score_min
    type:
      - 'null'
      - int
    doc: "If using smalt, this sets the '-m' param; if using BWA, reads mapping with ASscore lower than this will be rejected"
    inputBinding:
      position: 101
      prefix: '--score_min'
  - id: min_assembly_len
    type:
      - 'null'
      - int
    doc: "if initial SPAdes assembly largest contig is not at least as long as --min_assembly_len, reject; default: 6000"
    inputBinding:
      position: 101
      prefix: '--min_assembly_len'
  - id: include_shorts
    type:
      - 'null'
      - boolean
    doc: "if assembled contig is smaller than --min_assembly_len, contig will still be included in assembly"
    inputBinding:
      position: 101
      prefix: '--include_shorts'
  - id: damn_the_torpedos
    type:
      - 'null'
      - boolean
    doc: "Ignore certain errors, full speed ahead!"
    inputBinding:
      position: 101
      prefix: '--damn_the_torpedos'
  - id: subtract
    type:
      - 'null'
      - boolean
    doc: "reads already used in previous round of subassembly will not be included in subsequent rounds"
    inputBinding:
      position: 101
      prefix: '--subtract'
  - id: linear
    type:
      - 'null'
      - boolean
    doc: "if genome is known to not be circular and a region of interest extends past chromosome end, this extends the sequence past chromosome origin"
    inputBinding:
      position: 101
      prefix: '--linear'
  - id: min_flank_depth
    type:
      - 'null'
      - int
    doc: "a subassembly will not be performed if this minimum depth is not achieved on both the 3' and 5' end of the pseudocontig. default: 0"
    inputBinding:
      position: 101
      prefix: '--min_flank_depth'
  - id: subassembler
    type:
      - 'null'
      - string
    doc: "assembler to use for subassembly scheme (spades or skesa)"
    inputBinding:
      position: 101
      prefix: '--subassembler'
  - id: ref_as_contig
    type:
      - 'null'
      - string
    doc: "ignore, infer, trusted or untrusted: how the reference is used in subassembly; default: infer"
    inputBinding:
      position: 101
      prefix: '--ref_as_contig'
  - id: additional_libs
    type:
      - 'null'
      - string
    doc: "include this string (usually additional library, but could be other SPAdes args) in final assembly"
    inputBinding:
      position: 101
      prefix: '--additional_libs'
  - id: clean_temps
    type:
      - 'null'
      - boolean
    doc: "mapping files will be removed once they are no longer needed during the mapping iterations to save space"
    inputBinding:
      position: 101
      prefix: '--clean_temps'
  - id: enable_spades_error_corection
    type:
      - 'null'
      - boolean
    doc: "Re-enable SPAdes read error correction (skipped by default)"
    inputBinding:
      position: 101
      prefix: '--enable-spades-error-corection'
  - id: skip_control
    type:
      - 'null'
      - boolean
    doc: "no de novo assembly will be done"
    inputBinding:
      position: 101
      prefix: '--skip_control'
  - id: iterations
    type:
      - 'null'
      - int
    doc: "if iterations>1, multiple seedings will occur after subassembly of seed regions; default: 3"
    inputBinding:
      position: 101
      prefix: '--iterations'
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Logger writes debug to file in output dir; this sets verbosity level sent to stderr. 1 = debug(), 2 = info(), 3 = warning(), 4 = error() and 5 = critical(); default: 2"
    inputBinding:
      position: 101
      prefix: '--verbosity'
  - id: target_len
    type:
      - 'null'
      - string
    doc: "if set, iterations will continue until contigs reach this length, or max iterations have been completed"
    inputBinding:
      position: 101
      prefix: '--target_len'
  - id: serialize
    type:
      - 'null'
      - boolean
    doc: "runs seeding and assembly without multiprocessing"
    inputBinding:
      position: 101
      prefix: '--serialize'
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: "generate a mpileup-based consensus instead of doing a proper spades subassembly"
    inputBinding:
      position: 101
      prefix: '--consensus'
  - id: smalt_scoring
    type:
      - 'null'
      - string
    doc: "if mapping with SMALT, submit custom smalt scoring via smalt -S scorespec option"
    inputBinding:
      position: 101
      prefix: '--smalt_scoring'
  - id: mapper_args
    type:
      - 'null'
      - string
    doc: "submit custom parameters to the mapper (bwa only); default: -L 0,0 -U 0 -a"
    inputBinding:
      position: 101
      prefix: '--mapper_args'
  - id: spades_exe
    type:
      - 'null'
      - string
    doc: "Path to SPAdes executable; default: spades.py"
    inputBinding:
      position: 101
      prefix: '--spades_exe'
  - id: samtools_exe
    type:
      - 'null'
      - string
    doc: "Path to samtools executable; default: samtools"
    inputBinding:
      position: 101
      prefix: '--samtools_exe'
  - id: skesa_exe
    type:
      - 'null'
      - string
    doc: "Path to skesa executable; default: skesa"
    inputBinding:
      position: 101
      prefix: '--skesa_exe'
  - id: smalt_exe
    type:
      - 'null'
      - string
    doc: "Path to smalt executable; default: smalt"
    inputBinding:
      position: 101
      prefix: '--smalt_exe'
  - id: bwa_exe
    type:
      - 'null'
      - string
    doc: "Path to BWA executable; default: bwa"
    inputBinding:
      position: 101
      prefix: '--bwa_exe'
  - id: quast_exe
    type:
      - 'null'
      - string
    doc: "Path to quast executable; default: quast"
    inputBinding:
      position: 101
      prefix: '--quast_exe'
  - id: bcftools_exe
    type:
      - 'null'
      - string
    doc: "Path to bcftools executable; default: bcftools"
    inputBinding:
      position: 101
      prefix: '--bcftools_exe'
  - id: cores
    type:
      - 'null'
      - int
    doc: "cores to be used; default: None"
    inputBinding:
      position: 101
      prefix: '--cores'
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads per processor (1, 2 or 4); default: 1"
    inputBinding:
      position: 101
      prefix: '--threads'
  - id: memory
    type:
      - 'null'
      - int
    doc: "system memory available; default: 8"
    inputBinding:
      position: 101
      prefix: '--memory'
  - id: output
    type: string
    doc: "output directory"
    inputBinding:
      position: 102
      prefix: '--output'
outputs:
  - id: output_dir
    type: Directory
    doc: "Output directory"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/riboseed:0.4.90--py_0
stdout: riboseed_ribo_seed.out
