cwlVersion: v1.2
class: CommandLineTool
baseCommand: panfeed
label: panfeed
doc: "Get gene cluster specific k-mers from a set of bacterial genomes\n\nTool homepage:
  https://github.com/microbial-pangenomes-lab/panfeed"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: 'Compress output files with gzip (default: plain text)'
    inputBinding:
      position: 101
      prefix: --compress
  - id: consider_missing
    type:
      - 'null'
      - boolean
    doc: 'Output NaN for strains that do not encode for a k-mer if the gene is missing
      (default: value is set to 0, as for the gene. WARNING: slows down execution)'
    inputBinding:
      position: 101
      prefix: --consider-missing
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Threads (default: 1, at least 3 are needed for parallelization)'
    inputBinding:
      position: 101
      prefix: --cores
  - id: downstream
    type:
      - 'null'
      - int
    doc: "How many bases to include downstream of the actual gene sequences (e.g.
      to include the 3' region, default: 0)"
    inputBinding:
      position: 101
      prefix: --downstream
  - id: downstream_start_codon
    type:
      - 'null'
      - boolean
    doc: Center the --downstream argument at the start codon (default is stop codon)
    inputBinding:
      position: 101
      prefix: --downstream-start-codon
  - id: fasta
    type:
      - 'null'
      - Directory
    doc: Directory containing all samples' nucleotide fasta files, or a file listing
      the relative path to each fasta file, one per line (extension either .fasta
      or .fna, samples should be named in the same way as in the panaroo header)
    inputBinding:
      position: 101
      prefix: --fasta
  - id: genes
    type:
      - 'null'
      - File
    doc: 'File indicating for which gene clusters k-mer positions and patterns should
      be logged (one gene cluster ID per line, default: all gene clusters)'
    inputBinding:
      position: 101
      prefix: --genes
  - id: gff
    type: Directory
    doc: Directory containing all samples' GFF files, or a file listing the relative
      path to each GFF file, one per line (must contain nucleotide sequence as well
      unless -f is used, and samples should be named in the same way as in the panaroo
      header)
    inputBinding:
      position: 101
      prefix: --gff
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: K-mer length
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: maf
    type:
      - 'null'
      - float
    doc: 'Minor allele frequency threshold; patterns whose frequency is below this
      value or above 1-MAF are excluded (default: 0.01, does not apply to the kmers.tsv
      file)'
    inputBinding:
      position: 101
      prefix: --maf
  - id: multiple_files
    type:
      - 'null'
      - boolean
    doc: 'Generate one set of outputs for each gene cluster (default: one set of outputs)'
    inputBinding:
      position: 101
      prefix: --multiple-files
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Do not filter out k-mers with the same presence absence pattern as the gene
      cluster itself
    inputBinding:
      position: 101
      prefix: --no-filter
  - id: non_canonical
    type:
      - 'null'
      - boolean
    doc: Compute non-canonical k-mers (default is canonical)
    inputBinding:
      position: 101
      prefix: --non-canonical
  - id: presence_absence
    type: File
    doc: Gene clusters presence absence table as output by panaroo
    inputBinding:
      position: 101
      prefix: --presence-absence
  - id: queue_limit
    type:
      - 'null'
      - int
    doc: 'limit on items that may be put into the readingand writing queues. (default:
      3)this option is only relevant for cores > 1reading queue limit = ql * coreswriting
      queue limit = ql'
    inputBinding:
      position: 101
      prefix: --queue-limit
  - id: stop_on_missing
    type:
      - 'null'
      - boolean
    doc: 'Crash if samples/chromosomes/genes are not found (default: throw warnings)'
    inputBinding:
      position: 101
      prefix: --stop-on-missing
  - id: targets
    type:
      - 'null'
      - File
    doc: 'File indicating for which samples k-mer positions should be logged (one
      sample name per line, default: no samples)'
    inputBinding:
      position: 101
      prefix: --targets
  - id: upstream
    type:
      - 'null'
      - int
    doc: "How many bases to include upstream of the actual gene sequences (e.g. to
      include the 5' region, default: 0)"
    inputBinding:
      position: 101
      prefix: --upstream
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase verbosity level
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory to store outputs (will cause an error if already present)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panfeed:1.7.2--pyhdfd78af_0
