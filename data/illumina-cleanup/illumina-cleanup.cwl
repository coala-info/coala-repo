cwlVersion: v1.2
class: CommandLineTool
baseCommand: illumina-cleanup
label: illumina-cleanup
doc: "v1.0.0\n\nTool homepage: https://github.com/rpetit3/illumina-cleanup"
inputs:
  - id: adapter_k
    type:
      - 'null'
      - int
    doc: "Kmer length used for finding adapters. Adapters\n                      \
      \      shorter than k will not be found."
    inputBinding:
      position: 101
      prefix: --adapter_k
  - id: adapters
    type:
      - 'null'
      - File
    doc: Illumina adapters to remove
    inputBinding:
      position: 101
      prefix: --adapters
  - id: check_fastqs
    type:
      - 'null'
      - boolean
    doc: Verify "--fastqs" produces the expected inputs.
    inputBinding:
      position: 101
      prefix: --check_fastqs
  - id: coverage
    type:
      - 'null'
      - int
    doc: Reduce samples to a given coverage.
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cpus
    type:
      - 'null'
      - int
    doc: "Number of processors made available to a single process.\n             \
      \               If greater than \"--max_cpus\" it will be set equal to\n   \
      \                         \"--max_cpus\""
    inputBinding:
      position: 101
      prefix: --cpus
  - id: example_fastqs
    type:
      - 'null'
      - boolean
    doc: Print an example of expected input for FASTQs file.
    inputBinding:
      position: 101
      prefix: --example_fastqs
  - id: fastqs
    type: string
    doc: "An input file containing the sample name and absolute\n                \
      \            paths to FASTQs to process."
    inputBinding:
      position: 101
      prefix: --fastqs
  - id: ftm
    type:
      - 'null'
      - int
    doc: "If positive, right-trim length to be equal to zero,\n                  \
      \          modulo this number."
    inputBinding:
      position: 101
      prefix: --ftm
  - id: genome_size
    type:
      - 'null'
      - int
    doc: Expected genome size (bp) for all samples.
    inputBinding:
      position: 101
      prefix: --genome_size
  - id: hdist
    type:
      - 'null'
      - int
    doc: "Maximum Hamming distance for ref kmers (subs only).\n                  \
      \          Memory use is proportional to (3*K)^hdist."
    inputBinding:
      position: 101
      prefix: --hdist
  - id: keep_cache
    type:
      - 'null'
      - boolean
    doc: "Keeps 'work' and '.nextflow' logs, default is to\n                     \
      \       delete on successful completion."
    inputBinding:
      position: 101
      prefix: --keep_cache
  - id: ktrim
    type:
      - 'null'
      - string
    doc: "Trim reads to remove bases matching reference kmers.\n                 \
      \           Values:\n                                f (do not trim)\n     \
      \                           r (trim to the right, Default)\n               \
      \                 l (trim to the left)"
    inputBinding:
      position: 101
      prefix: --ktrim
  - id: maq
    type:
      - 'null'
      - int
    doc: "Reads with average quality (after trimming) below\n                    \
      \        this will be discarded."
    inputBinding:
      position: 101
      prefix: --maq
  - id: max_cpus
    type:
      - 'null'
      - int
    doc: "The maximum number of processors this workflow should\n                \
      \             have access to at any given moment."
    inputBinding:
      position: 101
      prefix: --max_cpus
  - id: maxcor
    type:
      - 'null'
      - int
    doc: Max number of corrections within a 20bp window
    inputBinding:
      position: 101
      prefix: --maxcor
  - id: mink
    type:
      - 'null'
      - int
    doc: "Look for shorter kmers at read tips down to this\n                     \
      \       length, when k-trimming or masking. 0 means\n                      \
      \      disabled. Enabling this will disable maskmiddle."
    inputBinding:
      position: 101
      prefix: --mink
  - id: minlength
    type:
      - 'null'
      - int
    doc: "Reads shorter than this after trimming will be\n                       \
      \     discarded. Pairs will be discarded if both are\n                     \
      \       shorter."
    inputBinding:
      position: 101
      prefix: --minlength
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory to write results to.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: phix
    type:
      - 'null'
      - File
    doc: phiX174 reference genome to remove
    inputBinding:
      position: 101
      prefix: --phix
  - id: phix_k
    type:
      - 'null'
      - int
    doc: "Kmer length used for finding phiX174. Contaminants\n                   \
      \         shorter than k will not be found."
    inputBinding:
      position: 101
      prefix: --phix_k
  - id: qout
    type:
      - 'null'
      - string
    doc: "Output quality offset.\n                            Values:\n          \
      \                      33 (PHRED33 offset quality scores, Default)\n       \
      \                         64 (PHRED64 offset quality scores)\n             \
      \                   auto (keeps the current input offset)"
    inputBinding:
      position: 101
      prefix: --qout
  - id: qtrim
    type:
      - 'null'
      - string
    doc: "Trim read ends to remove bases with quality below\n                    \
      \        trimq. Performed AFTER looking for kmers. Values:\n               \
      \                 rl (trim both ends, Default)\n                           \
      \     f (neither end)\n                                r (right end only)\n\
      \                                l (left end only)\n                       \
      \         w (sliding window)"
    inputBinding:
      position: 101
      prefix: --qtrim
  - id: sampleseed
    type:
      - 'null'
      - int
    doc: "Set to a positive number to use that prng seed for\n                   \
      \         sampling"
    inputBinding:
      position: 101
      prefix: --sampleseed
  - id: tbo
    type:
      - 'null'
      - boolean
    doc: "Trim adapters based on where paired reads overlap.\n                   \
      \         Values:\n                                f (do not trim by overlap)\n\
      \                                t (trim by overlap, Default)"
    inputBinding:
      position: 101
      prefix: --tbo
  - id: tossjunk
    type:
      - 'null'
      - boolean
    doc: "Discard reads with invalid characters as bases.\n                      \
      \      Values:\n                                f (keep all reads)\n       \
      \                         t (toss reads with ambiguous bases, Default)"
    inputBinding:
      position: 101
      prefix: --tossjunk
  - id: tpe
    type:
      - 'null'
      - boolean
    doc: "When kmer right-trimming, trim both reads to the\n                     \
      \       minimum length of either.\n                            Values:\n   \
      \                             f (do not equally trim)\n                    \
      \            t (equally trim to the right, Default)"
    inputBinding:
      position: 101
      prefix: --tpe
  - id: trimq
    type:
      - 'null'
      - float
    doc: "Regions with average quality BELOW this will be\n                      \
      \      trimmed if qtrim is set to something other than f."
    inputBinding:
      position: 101
      prefix: --trimq
  - id: xmx
    type:
      - 'null'
      - string
    doc: "This will be passed to Java to set memory usage.\n                     \
      \       Examples:\n                                8g will specify 8 gigs of
      RAM (Default)\n                                20g will specify 20 gigs of RAM\n\
      \                                200m will specify 200 megs of RAM"
    inputBinding:
      position: 101
      prefix: --xmx
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/illumina-cleanup:1.0.0--0
stdout: illumina-cleanup.out
