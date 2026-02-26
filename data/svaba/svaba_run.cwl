cwlVersion: v1.2
class: CommandLineTool
baseCommand: svaba run
label: svaba_run
doc: "SV and indel detection using rolling SGA assembly and BWA-MEM realignment\n\n\
  Tool homepage: https://github.com/walaj/svaba"
inputs:
  - id: all_contigs
    type:
      - 'null'
      - boolean
    doc: Output all contigs that were assembled, regardless of mapping or 
      length.
    default: off
    inputBinding:
      position: 101
      prefix: --all-contigs
  - id: bandwidth
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM SW alignment bandwidth for contig to genome alignments.
      BWA-MEM -w
    default: 1000
    inputBinding:
      position: 101
      prefix: --bandwidth
  - id: blacklist
    type:
      - 'null'
      - File
    doc: BED-file with blacklisted regions to not extract any reads from.
    inputBinding:
      position: 101
      prefix: --blacklist
  - id: bwa_match_score
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM match score. BWA-MEM -A
    default: 2
    inputBinding:
      position: 101
      prefix: --bwa-match-score
  - id: case_bam
    type:
      type: array
      items: File
    doc: Case BAM/CRAM/SAM file (eg tumor). Can input multiple.
    inputBinding:
      position: 101
      prefix: --case-bam
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: Size of a local assembly window (in bp). Set 0 for whole-BAM in one 
      assembly.
    default: 25000
    inputBinding:
      position: 101
      prefix: --chunk-size
  - id: control_bam
    type:
      - 'null'
      - type: array
        items: File
    doc: (optional) Control BAM/CRAM/SAM file (eg normal). Can input multiple.
    inputBinding:
      position: 101
      prefix: --control-bam
  - id: dbsnp_vcf
    type:
      - 'null'
      - File
    doc: DBsnp database (VCF) to compare indels against
    inputBinding:
      position: 101
      prefix: --dbsnp-vcf
  - id: disc_sd_cutoff
    type:
      - 'null'
      - float
    doc: Number of standard deviations of calculated insert-size distribution to
      consider discordant.
    default: 3.92
    inputBinding:
      position: 101
      prefix: --disc-sd-cutoff
  - id: discordant_only
    type:
      - 'null'
      - boolean
    doc: Only run the discordant read clustering module, skip assembly.
    inputBinding:
      position: 101
      prefix: --discordant-only
  - id: ec_correct_type
    type:
      - 'null'
      - string
    doc: (f) Fermi-kit BFC correction, (s) Kmer-correction from SGA, (0) no 
      correction (then suggest non-zero -e)
    default: f
    inputBinding:
      position: 101
      prefix: --ec-correct-type
  - id: ec_subsample
    type:
      - 'null'
      - float
    doc: Learn from fraction of non-weird reads during error-correction. Lower 
      number = faster compute
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ec-subsample
  - id: error_rate
    type:
      - 'null'
      - float
    doc: Fractional difference two reads can have to overlap. See SGA. 0 is 
      fast, but requires error correcting.
    default: 0
    inputBinding:
      position: 101
      prefix: --error-rate
  - id: g_zip
    type:
      - 'null'
      - boolean
    doc: Gzip and tabix the output VCF files.
    default: off
    inputBinding:
      position: 101
      prefix: --g-zip
  - id: gap_extension_penalty
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM gap extension penalty for contig to genome alignments. 
      BWA-MEM -E
    default: 1
    inputBinding:
      position: 101
      prefix: --gap-extension-penalty
  - id: gap_open_penalty
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM gap open penalty for contig to genome alignments. 
      BWA-MEM -O
    default: 32
    inputBinding:
      position: 101
      prefix: --gap-open-penalty
  - id: germline
    type:
      - 'null'
      - boolean
    doc: Sets recommended settings for case-only analysis (eg germline). (-I, 
      -L5, assembles NM >= 3 reads)
    inputBinding:
      position: 101
      prefix: --germline
  - id: germline_sv_database
    type:
      - 'null'
      - File
    doc: BED file containing sites of known germline SVs. Used as additional 
      filter for somatic SV detection
    inputBinding:
      position: 101
      prefix: --germline-sv-database
  - id: hp
    type:
      - 'null'
      - boolean
    doc: Highly parallel. Don't write output until completely done. More memory,
      but avoids all thread-locks.
    inputBinding:
      position: 101
      prefix: --hp
  - id: id_string
    type: string
    doc: String specifying the analysis ID to be used as part of ID common.
    inputBinding:
      position: 101
      prefix: --id-string
  - id: lod
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as non-REF (tests AF=0 vs 
      AF=MaxLikelihood(AF))
    default: 8
    inputBinding:
      position: 101
      prefix: --lod
  - id: lod_dbsnp
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as non-REF (tests AF=0 vs 
      AF=MaxLikelihood(AF)) at DBSnp indel site
    default: 5
    inputBinding:
      position: 101
      prefix: --lod-dbsnp
  - id: lod_somatic
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as somatic (tests AF=0 in normal vs 
      AF=ML(0.5))
    default: 2.5
    inputBinding:
      position: 101
      prefix: --lod-somatic
  - id: lod_somatic_dbsnp
    type:
      - 'null'
      - float
    doc: LOD cutoff to classify indel as somatic (tests AF=0 in normal vs 
      AF=ML(0.5)) at DBSnp indel site
    default: 4
    inputBinding:
      position: 101
      prefix: --lod-somatic-dbsnp
  - id: mate_lookup_min
    type:
      - 'null'
      - int
    doc: Minimum number of somatic reads required to attempt mate-region lookup
    default: 3
    inputBinding:
      position: 101
      prefix: --mate-lookup-min
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: Max read coverage to send to assembler (per BAM). Subsample reads if 
      exceeded.
    default: 500
    inputBinding:
      position: 101
      prefix: --max-coverage
  - id: max_reads
    type:
      - 'null'
      - int
    doc: Max total read count to read in from assembly region. Set 0 to turn 
      off.
    default: 50000
    inputBinding:
      position: 101
      prefix: --max-reads
  - id: max_reads_mate_region
    type:
      - 'null'
      - int
    doc: Max weird reads to include from a mate lookup region.
    default: 400
    inputBinding:
      position: 101
      prefix: --max-reads-mate-region
  - id: microbial_genome
    type:
      - 'null'
      - File
    doc: Path to indexed reference genome of microbial sequences to be used by 
      BWA-MEM to filter reads.
    inputBinding:
      position: 101
      prefix: --microbial-genome
  - id: min_overlap
    type:
      - 'null'
      - string
    doc: 'Minimum read overlap, an SGA parameter. Default: 0.4* readlength'
    inputBinding:
      position: 101
      prefix: --min-overlap
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM mismatch penalty for contig to genome alignments. 
      BWA-MEM -b
    default: 18
    inputBinding:
      position: 101
      prefix: --mismatch-penalty
  - id: no_interchrom_lookup
    type:
      - 'null'
      - boolean
    doc: Skip mate lookup for inter-chr candidate events. Reduces power for 
      translocations but less I/O.
    inputBinding:
      position: 101
      prefix: --no-interchrom-lookup
  - id: num_assembly_rounds
    type:
      - 'null'
      - int
    doc: Run assembler multiple times. > 1 will bootstrap the assembly.
    default: 2
    inputBinding:
      position: 101
      prefix: --num-assembly-rounds
  - id: num_to_sample
    type:
      - 'null'
      - int
    doc: When learning about inputs, number of reads to sample.
    default: 2,000,000
    inputBinding:
      position: 101
      prefix: --num-to-sample
  - id: override_reference_check
    type:
      - 'null'
      - boolean
    doc: With much caution, allows user to run svaba with different reference 
      genomes for BAMs and -G
    inputBinding:
      position: 101
      prefix: --override-reference-check
  - id: penalty_clip_3
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM penalty for 3' clipping.
    default: 5
    inputBinding:
      position: 101
      prefix: --penalty-clip-3
  - id: penalty_clip_5
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM penalty for 5' clipping.
    default: 5
    inputBinding:
      position: 101
      prefix: --penalty-clip-5
  - id: read_tracking
    type:
      - 'null'
      - boolean
    doc: Track supporting reads by qname. Increases file sizes.
    default: off
    inputBinding:
      position: 101
      prefix: --read-tracking
  - id: reference_genome
    type: File
    doc: Path to indexed reference genome to be used by BWA-MEM.
    inputBinding:
      position: 101
      prefix: --reference-genome
  - id: region
    type:
      - 'null'
      - string
    doc: Run on targeted intervals. Accepts BED file or Samtools-style string
    inputBinding:
      position: 101
      prefix: --region
  - id: reseed_trigger
    type:
      - 'null'
      - float
    doc: Set the BWA-MEM reseed trigger for reseeding mems for contig to genome 
      alignments. BWA-MEM -r
    default: 1.5
    inputBinding:
      position: 101
      prefix: --reseed-trigger
  - id: scale_errors
    type:
      - 'null'
      - int
    doc: Scale the priors that a site is artifact at given repeat count. 0 means
      assume low (const) error rate
    default: 1
    inputBinding:
      position: 101
      prefix: --scale-errors
  - id: simple_seq_database
    type:
      - 'null'
      - File
    doc: BED file containing sites of simple DNA that can confuse the contig 
      re-alignment.
    inputBinding:
      position: 101
      prefix: --simple-seq-database
  - id: threads
    type:
      - 'null'
      - int
    doc: Use NUM threads to run svaba.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - int
    doc: Select verbosity level (0-4).
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
  - id: write_asqg
    type:
      - 'null'
      - boolean
    doc: Output an ASQG graph file for each assembly window.
    inputBinding:
      position: 101
      prefix: --write-asqg
  - id: write_extracted_reads
    type:
      - 'null'
      - boolean
    doc: For the case BAM, write reads sent to assembly to a BAM file.
    default: off
    inputBinding:
      position: 101
      prefix: --write-extracted-reads
  - id: z_dropoff
    type:
      - 'null'
      - int
    doc: Set the BWA-MEM SW alignment Z-dropoff for contig to genome alignments.
      BWA-MEM -d
    default: 100
    inputBinding:
      position: 101
      prefix: --z-dropoff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svaba:1.2.0--h69ac913_1
stdout: svaba_run.out
