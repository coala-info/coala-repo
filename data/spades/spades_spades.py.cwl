cwlVersion: v1.2
class: CommandLineTool
baseCommand: spades.py
label: spades_spades.py
doc: "SPAdes genome assembler v4.2.0\n\nTool homepage: https://github.com/ablab/spades"
inputs:
  - id: bio
    type:
      - 'null'
      - boolean
    doc: this flag is required for biosyntheticSPAdes mode
    inputBinding:
      position: 101
      prefix: --bio
  - id: careful
    type:
      - 'null'
      - boolean
    doc: tries to reduce number of mismatches and short indels
    inputBinding:
      position: 101
      prefix: --careful
  - id: checkpoints
    type:
      - 'null'
      - string
    doc: save intermediate check-points ('last', 'all')
    inputBinding:
      position: 101
      prefix: --checkpoints
  - id: continue_run
    type:
      - 'null'
      - boolean
    doc: continue run from the last available check-point (only -o should be 
      specified)
    inputBinding:
      position: 101
      prefix: --continue
  - id: corona
    type:
      - 'null'
      - boolean
    doc: this flag is required for coronaSPAdes mode
    inputBinding:
      position: 101
      prefix: --corona
  - id: cov_cutoff
    type:
      - 'null'
      - float
    doc: coverage cutoff value (a positive float number, or 'auto', or 'off')
    default: "'off'"
    inputBinding:
      position: 101
      prefix: --cov-cutoff
  - id: custom_hmms
    type:
      - 'null'
      - Directory
    doc: directory with custom hmms that replace default ones,
    default: None
    inputBinding:
      position: 101
      prefix: --custom-hmms
  - id: dataset
    type:
      - 'null'
      - File
    doc: file with dataset description in YAML format
    inputBinding:
      position: 101
      prefix: --dataset
  - id: disable_gzip_output
    type:
      - 'null'
      - boolean
    doc: forces error correction not to compress the corrected reads
    inputBinding:
      position: 101
      prefix: --disable-gzip-output
  - id: disable_rr
    type:
      - 'null'
      - boolean
    doc: disables repeat resolution stage of assembling
    inputBinding:
      position: 101
      prefix: --disable-rr
  - id: forward_reads_1
    type:
      - 'null'
      - File
    doc: file with forward paired-end reads
    inputBinding:
      position: 101
      prefix: '-1'
  - id: gfa11
    type:
      - 'null'
      - boolean
    doc: use GFA v1.1 format for assembly graph
    inputBinding:
      position: 101
      prefix: --gfa11
  - id: grid_engine
    type:
      - 'null'
      - string
    doc: run under grid control ('slurm', 'local', 'mpi', save_yaml')
    default: "'local'"
    inputBinding:
      position: 101
      prefix: --grid-engine
  - id: grid_extra
    type:
      - 'null'
      - string
    doc: any extra commands
    inputBinding:
      position: 101
      prefix: --grid-extra
  - id: grid_nnodes
    type:
      - 'null'
      - int
    doc: specifies the number of processors
    inputBinding:
      position: 101
      prefix: --grid-nnodes
  - id: grid_queue
    type:
      - 'null'
      - string
    doc: submits the jobs to one of the specified queues
    inputBinding:
      position: 101
      prefix: --grid-queue
  - id: grid_time
    type:
      - 'null'
      - string
    doc: time limit
    inputBinding:
      position: 101
      prefix: --grid-time
  - id: grid_wait
    type:
      - 'null'
      - boolean
    doc: wait for job finish
    inputBinding:
      position: 101
      prefix: --grid-wait
  - id: hqmp_forward_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with forward reads for high-quality mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --hqmp-1
  - id: hqmp_interlaced_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with interlaced reads for high-quality mate-pair library number 
      <#>
    inputBinding:
      position: 101
      prefix: --hqmp-12
  - id: hqmp_orientation
    type:
      - 'null'
      - type: array
        items: string
    doc: orientation of reads for high-quality mate-pair library number <#> 
      (<or> = fr, rf, ff)
    inputBinding:
      position: 101
      prefix: --hqmp-or
  - id: hqmp_reverse_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with reverse reads for high-quality mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --hqmp-2
  - id: hqmp_unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with unpaired reads for high-quality mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --hqmp-s
  - id: interlaced_reads_12
    type:
      - 'null'
      - File
    doc: file with interlaced forward and reverse paired-end reads
    inputBinding:
      position: 101
      prefix: --12
  - id: iontorrent
    type:
      - 'null'
      - boolean
    doc: this flag is required for IonTorrent data
    inputBinding:
      position: 101
      prefix: --iontorrent
  - id: isolate
    type:
      - 'null'
      - boolean
    doc: this flag is highly recommended for high-coverage isolate and 
      multi-cell data
    inputBinding:
      position: 101
      prefix: --isolate
  - id: kmer_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: list of k-mer sizes (must be odd and less than 128)
    default: "'auto'"
    inputBinding:
      position: 101
      prefix: -k
  - id: memory
    type:
      - 'null'
      - int
    doc: RAM limit for SPAdes in Gb (terminates if exceeded).
    default: 250
    inputBinding:
      position: 101
      prefix: --memory
  - id: merged_reads
    type:
      - 'null'
      - File
    doc: file with merged forward and reverse paired-end reads
    inputBinding:
      position: 101
      prefix: --merged
  - id: meta
    type:
      - 'null'
      - boolean
    doc: this flag is required for metagenomic data
    inputBinding:
      position: 101
      prefix: --meta
  - id: metaplasmid
    type:
      - 'null'
      - boolean
    doc: runs metaplasmidSPAdes pipeline for plasmid detection in metagenomic 
      datasets (equivalent for --meta --plasmid)
    inputBinding:
      position: 101
      prefix: --metaplasmid
  - id: metaviral
    type:
      - 'null'
      - boolean
    doc: runs metaviralSPAdes pipeline for virus detection
    inputBinding:
      position: 101
      prefix: --metaviral
  - id: mp_forward_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with forward reads for mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --mp-1
  - id: mp_interlaced_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with interlaced reads for mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --mp-12
  - id: mp_orientation
    type:
      - 'null'
      - type: array
        items: string
    doc: orientation of reads for mate-pair library number <#> (<or> = fr, rf, 
      ff)
    inputBinding:
      position: 101
      prefix: --mp-or
  - id: mp_reverse_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with reverse reads for mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --mp-2
  - id: mp_unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with unpaired reads for mate-pair library number <#>
    inputBinding:
      position: 101
      prefix: --mp-s
  - id: nanopore_reads
    type:
      - 'null'
      - File
    doc: file with Nanopore reads
    inputBinding:
      position: 101
      prefix: --nanopore
  - id: only_assembler
    type:
      - 'null'
      - boolean
    doc: runs only assembling (without read error correction)
    inputBinding:
      position: 101
      prefix: --only-assembler
  - id: only_error_correction
    type:
      - 'null'
      - boolean
    doc: runs only read error correction (without assembling)
    inputBinding:
      position: 101
      prefix: --only-error-correction
  - id: output_dir
    type: Directory
    doc: directory to store all the resulting files (required)
    inputBinding:
      position: 101
      prefix: -o
  - id: pacbio_reads
    type:
      - 'null'
      - File
    doc: file with PacBio reads
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: pe_forward_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with forward reads for paired-end library number <#>
    inputBinding:
      position: 101
      prefix: --pe-1
  - id: pe_interlaced_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with interlaced reads for paired-end library number <#>
    inputBinding:
      position: 101
      prefix: --pe-12
  - id: pe_merged_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with merged reads for paired-end library number <#>
    inputBinding:
      position: 101
      prefix: --pe-m
  - id: pe_orientation
    type:
      - 'null'
      - type: array
        items: string
    doc: orientation of reads for paired-end library number <#> (<or> = fr, rf, 
      ff)
    inputBinding:
      position: 101
      prefix: --pe-or
  - id: pe_reverse_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with reverse reads for paired-end library number <#>
    inputBinding:
      position: 101
      prefix: --pe-2
  - id: pe_unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with unpaired reads for paired-end library number <#>
    inputBinding:
      position: 101
      prefix: --pe-s
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: PHRED quality offset in the input reads (33 or 64),
    default: auto-detect
    inputBinding:
      position: 101
      prefix: --phred-offset
  - id: plasmid
    type:
      - 'null'
      - boolean
    doc: runs plasmidSPAdes pipeline for plasmid detection
    inputBinding:
      position: 101
      prefix: --plasmid
  - id: restart_from
    type:
      - 'null'
      - string
    doc: restart run with updated options and from the specified check-point 
      ('ec', 'as', 'k<int>', 'mc', 'last')
    inputBinding:
      position: 101
      prefix: --restart-from
  - id: reverse_reads_2
    type:
      - 'null'
      - File
    doc: file with reverse paired-end reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: rna
    type:
      - 'null'
      - boolean
    doc: this flag is required for RNA-Seq data
    inputBinding:
      position: 101
      prefix: --rna
  - id: rnaviral
    type:
      - 'null'
      - boolean
    doc: this flag enables virus assembly module from RNA-Seq data
    inputBinding:
      position: 101
      prefix: --rnaviral
  - id: sanger_reads
    type:
      - 'null'
      - File
    doc: file with Sanger reads
    inputBinding:
      position: 101
      prefix: --sanger
  - id: sc
    type:
      - 'null'
      - boolean
    doc: this flag is required for MDA (single-cell) data
    inputBinding:
      position: 101
      prefix: --sc
  - id: sewage
    type:
      - 'null'
      - boolean
    doc: this flag is required for sewage mode
    inputBinding:
      position: 101
      prefix: --sewage
  - id: single_unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: file with unpaired reads for single reads library number <#>
    inputBinding:
      position: 101
      prefix: --s
  - id: test
    type:
      - 'null'
      - boolean
    doc: runs SPAdes on toy dataset
    inputBinding:
      position: 101
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads.
    default: 16
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files.
    default: <output_dir>/tmp
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: trusted_contigs
    type:
      - 'null'
      - File
    doc: file with trusted contigs
    inputBinding:
      position: 101
      prefix: --trusted-contigs
  - id: unpaired_reads_s
    type:
      - 'null'
      - File
    doc: file with unpaired reads
    inputBinding:
      position: 101
      prefix: -s
  - id: untrusted_contigs
    type:
      - 'null'
      - File
    doc: file with untrusted contigs
    inputBinding:
      position: 101
      prefix: --untrusted-contigs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spades:4.2.0--h8d6e82b_2
stdout: spades_spades.py.out
