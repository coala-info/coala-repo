cwlVersion: v1.2
class: CommandLineTool
baseCommand: squigulator
label: squigulator
doc: "Simulate nanopore sequencing signals.\n\nTool homepage: https://github.com/hasindu2008/squigulator"
inputs:
  - id: ref_fa
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: amp_noise
    type:
      - 'null'
      - float
    doc: amplitude domain noise factor
    default: 1.0
    inputBinding:
      position: 102
      prefix: --amp-noise
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size (max number of reads created at once)
    default: 1000
    inputBinding:
      position: 102
      prefix: -K
  - id: bps
    type:
      - 'null'
      - int
    doc: translocation speed in bases per second (incompatible with 
      --dwell-mean)
    default: 444
    inputBinding:
      position: 102
      prefix: --bps
  - id: cdna
    type:
      - 'null'
      - boolean
    doc: generate cDNA reads (only for dna profiles & the reference must a 
      transcriptome)
    inputBinding:
      position: 102
      prefix: --cdna
  - id: digitisation
    type:
      - 'null'
      - float
    doc: ADC digitisation
    default: 2048.0
    inputBinding:
      position: 102
      prefix: --digitisation
  - id: dwell_mean
    type:
      - 'null'
      - float
    doc: mean of number of signal samples per base
    default: 9.0
    inputBinding:
      position: 102
      prefix: --dwell-mean
  - id: dwell_std
    type:
      - 'null'
      - float
    doc: standard deviation of number of signal samples per base
    default: 4.0
    inputBinding:
      position: 102
      prefix: --dwell-std
  - id: fasta_output
    type:
      - 'null'
      - File
    doc: FASTA file to write simulated reads with no errors
    inputBinding:
      position: 102
      prefix: -q
  - id: fold_coverage
    type:
      - 'null'
      - int
    doc: fold coverage to simulate (incompatible with -n)
    inputBinding:
      position: 102
      prefix: -f
  - id: full_contigs
    type:
      - 'null'
      - boolean
    doc: generate signals for complete contigs/sequences in the input 
      (incompatible with -n, -r & -n)
    inputBinding:
      position: 102
      prefix: --full-contigs
  - id: ideal
    type:
      - 'null'
      - boolean
    doc: generate ideal signals with no noise
    inputBinding:
      position: 102
      prefix: --ideal
  - id: ideal_amp
    type:
      - 'null'
      - boolean
    doc: generate signals with no amplitiude domain noise
    inputBinding:
      position: 102
      prefix: --ideal-amp
  - id: ideal_time
    type:
      - 'null'
      - boolean
    doc: generate signals with no time domain noise
    inputBinding:
      position: 102
      prefix: --ideal-time
  - id: kmer_model
    type:
      - 'null'
      - File
    doc: custom nucleotide k-mer model file (format similar to f5c models)
    inputBinding:
      position: 102
      prefix: --kmer-model
  - id: mean_read_length
    type:
      - 'null'
      - int
    doc: mean read length (estimate only, unused for direct RNA)
    default: 10000
    inputBinding:
      position: 102
      prefix: -r
  - id: median_before_mean
    type:
      - 'null'
      - float
    doc: Median before mean
    default: 214.3
    inputBinding:
      position: 102
      prefix: --median-before-mean
  - id: median_before_std
    type:
      - 'null'
      - float
    doc: Median before standard deviation
    default: 18.0
    inputBinding:
      position: 102
      prefix: --median-before-std
  - id: meth_freq
    type:
      - 'null'
      - File
    doc: simulate CpG methylation using frequency tsv file [chr, 0-based pos, 
      freq] (for DNA)
    inputBinding:
      position: 102
      prefix: --meth-freq
  - id: meth_model
    type:
      - 'null'
      - File
    doc: custom methylation k-mer model file (format similar to f5c models)
    inputBinding:
      position: 102
      prefix: --meth-model
  - id: num_reads
    type:
      - 'null'
      - int
    doc: number of reads to simulate
    default: 4000
    inputBinding:
      position: 102
      prefix: -n
  - id: offset_mean
    type:
      - 'null'
      - float
    doc: ADC offset mean
    default: -237.4
    inputBinding:
      position: 102
      prefix: --offset-mean
  - id: offset_std
    type:
      - 'null'
      - float
    doc: ADC offset standard deviation
    default: 14.2
    inputBinding:
      position: 102
      prefix: --offset-std
  - id: ont_friendly
    type:
      - 'null'
      - string
    doc: generate fake uuid for readids and add a dummy end_reason
    default: no
    inputBinding:
      position: 102
      prefix: --ont-friendly
  - id: paf_output
    type:
      - 'null'
      - File
    doc: PAF file to write the alignment of simulated reads
    inputBinding:
      position: 102
      prefix: -c
  - id: paf_ref
    type:
      - 'null'
      - boolean
    doc: in paf output, use the reference as the target instead of read (needs 
      -c)
    inputBinding:
      position: 102
      prefix: --paf-ref
  - id: parameter_profile
    type:
      - 'null'
      - string
    doc: parameter profile (always applied before other options)
    default: dna-r9-prom
    inputBinding:
      position: 102
      prefix: -x
  - id: prefix
    type:
      - 'null'
      - string
    doc: generate prefixes such as adaptor (and polya for RNA)
    default: no
    inputBinding:
      position: 102
      prefix: --prefix
  - id: range
    type:
      - 'null'
      - float
    doc: ADC range
    default: 748.6
    inputBinding:
      position: 102
      prefix: --range
  - id: sam_output
    type:
      - 'null'
      - File
    doc: SAM file to write the alignment of simulated reads
    inputBinding:
      position: 102
      prefix: -a
  - id: sample_rate
    type:
      - 'null'
      - float
    doc: ADC sampling rate
    default: 4000.0
    inputBinding:
      position: 102
      prefix: --sample-rate
  - id: seed
    type:
      - 'null'
      - int
    doc: seed or random generators (if 0, will be autogenerated)
    default: 0
    inputBinding:
      position: 102
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 8
    inputBinding:
      position: 102
      prefix: -t
  - id: trans_count
    type:
      - 'null'
      - File
    doc: simulate relative abundance using tsv file [transcript name, count]  
      (for direct-rna & cDNA)
    inputBinding:
      position: 102
      prefix: --trans-count
  - id: trans_trunc
    type:
      - 'null'
      - string
    doc: simulate transcript truncation (only for direct-rna)
    default: no
    inputBinding:
      position: 102
      prefix: --trans-trunc
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 4
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: out_signal_blow5
    type: File
    doc: Output SLOW5/BLOW5 file
    outputBinding:
      glob: '*.out'
  - id: output_file
    type:
      - 'null'
      - File
    doc: SLOW5/BLOW5 file to write
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squigulator:0.4.0--h5ca1c30_2
