cwlVersion: v1.2
class: CommandLineTool
baseCommand: spades.py
label: cloudspades_spades.py
doc: "SPAdes genome assembler v3.16.0-dev\n\nTool homepage: https://github.com/ablab/spades"
inputs:
  - id: aux_reads
    type:
      - 'null'
      - File
    doc: file with auxiliary reads (e.g. TELL-Seq library barcodes)
    inputBinding:
      position: 101
      prefix: --aux
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
  - id: continue
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
      - string
    doc: coverage cutoff value (a positive float number, or 'auto', or 'off')
    inputBinding:
      position: 101
      prefix: --cov-cutoff
  - id: custom_hmms
    type:
      - 'null'
      - Directory
    doc: directory with custom hmms that replace default ones
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
  - id: gfa11
    type:
      - 'null'
      - boolean
    doc: use GFA v1.1 format for assembly graph
    inputBinding:
      position: 101
      prefix: --gfa11
  - id: interlaced_reads
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
  - id: k_mer_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: list of k-mer sizes (must be odd and less than 128)
    inputBinding:
      position: 101
      prefix: -k
  - id: memory
    type:
      - 'null'
      - int
    doc: RAM limit for SPAdes in Gb (terminates if exceeded)
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
  - id: nanopore
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
  - id: pacbio
    type:
      - 'null'
      - File
    doc: file with PacBio reads
    inputBinding:
      position: 101
      prefix: --pacbio
  - id: pe1
    type:
      - 'null'
      - File
    doc: file with forward paired-end reads
    inputBinding:
      position: 101
      prefix: '-1'
  - id: pe2
    type:
      - 'null'
      - File
    doc: file with reverse paired-end reads
    inputBinding:
      position: 101
      prefix: '-2'
  - id: phred_offset
    type:
      - 'null'
      - int
    doc: PHRED quality offset in the input reads (33 or 64)
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
  - id: sanger
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
    doc: number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
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
  - id: unpaired_reads
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
  - id: output_dir
    type: Directory
    doc: directory to store all the resulting files (required)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cloudspades:3.16.0--haf24da9_3
