cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sga
  - kmer-count
label: sga_kmer-count
doc: "Generate a table of the k-mers in src.{bwt,fa,fq}, and optionally count the
  number of time they appears in testX.bwt.\nOutput on stdout the canonical kmers
  and their counts on forward and reverse strand if input is .bwt\nIf src is a sequence
  file output forward and reverse counts for each kmer in the file\n\nTool homepage:
  https://github.com/jts/sga"
inputs:
  - id: src_file
    type: File
    doc: Source file (bwt, fa, or fq)
    inputBinding:
      position: 1
  - id: test_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional test files (bwt) to count k-mer occurrences
    inputBinding:
      position: 2
  - id: cache_length
    type:
      - 'null'
      - int
    doc: Cache Length for bwt lookups
    inputBinding:
      position: 103
      prefix: --cache-length
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: The length of the kmer to use.
    inputBinding:
      position: 103
      prefix: --kmer-size
  - id: sample_rate
    type:
      - 'null'
      - int
    doc: "use occurrence array sample rate of N in the FM-index. Higher values use
      significantly\nless memory at the cost of higher runtime. This value must be
      a power of 2"
    inputBinding:
      position: 103
      prefix: --sample-rate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sga:v0.10.15-4-deb_cv1
stdout: sga_kmer-count.out
