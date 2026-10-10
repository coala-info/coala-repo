cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - extract_kmers
label: metafx_extract_kmers
doc: "count k-mers presence in samples' reads files (to speed up multiple calculations)\n\nTool homepage: https://github.com/ctlab/metafx"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reads)
inputs:
  - id: k
    type: int
    doc: "k-mer size (in nucleotides, maximum value is 31)"
    inputBinding:
      position: 101
      prefix: --k
  - id: reads
    type: File[]
    doc: "list of reads files from single environment. FASTQ, FASTA, gzip- or bzip2-compressed. The files are staged together in the working directory (mates of a pair must sit in one folder to be detected)."
    inputBinding:
      position: 101
      prefix: --reads
      valueFrom: |-
        ${ return self.map(function(f){ return f.basename; }); }
  - id: bad_frequency
    type: ['null', int]
    doc: "maximal frequency for a k-mer to be assumed erroneous"
    inputBinding:
      position: 101
      prefix: --bad-frequency
  - id: threads
    type: ['null', int]
    doc: "number of threads to use"
    inputBinding:
      position: 101
      prefix: --threads
  - id: memory
    type: ['null', string]
    doc: "memory to use (values with suffix: 1500M, 4G, etc.)"
    inputBinding:
      position: 101
      prefix: --memory
  - id: work_dir
    type: string
    doc: "working directory (created by the tool, it must not exist before the run)"
    default: workDir
    inputBinding:
      position: 101
      prefix: --work-dir
outputs:
  - id: results_dir
    type: Directory
    doc: "Working directory with the results"
    outputBinding:
      glob: $(inputs.work_dir)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_extract_kmers.out
