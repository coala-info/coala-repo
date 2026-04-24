cwlVersion: v1.2
class: CommandLineTool
baseCommand: HG-CoLoR
label: hg-color_HG-CoLoR
doc: "Corrects, trims, and splits long reads using short reads.\n\nTool homepage:
  https://github.com/pierre-morisse/HG-CoLoR"
inputs:
  - id: bestn
    type:
      - 'null'
      - int
    doc: Top alignments to be reported by BLASR. This parameter should be raised
      accordingly to the short reads coverage. Its default value is adapted for 
      a 50x coverage of short reads. It should be decreased with higher 
      coverage, and increased with lower coverage.
    inputBinding:
      position: 101
      prefix: --bestn
  - id: branches
    type:
      - 'null'
      - int
    doc: Maximum number of branches exploration. Raising this parameter will 
      result in less split corrected long reads. However, it will also increase 
      the runtime, and may create chimeric linkings between the seeds.
    inputBinding:
      position: 101
      prefix: --branches
  - id: kmcmem
    type:
      - 'null'
      - int
    doc: Maximum amount of RAM for KMC, in GB
    inputBinding:
      position: 101
      prefix: --kmcmem
  - id: longreads
    type: File
    doc: fasta file of long reads, one sequence per line.
    inputBinding:
      position: 101
      prefix: --longreads
  - id: max_k
    type: int
    doc: Maximum K-mer size of the variable-order de Bruijn graph.
    inputBinding:
      position: 101
      prefix: -K
  - id: min_order
    type:
      - 'null'
      - int
    doc: Minimum k-mer size of the variable-order de Bruijn graph
    inputBinding:
      position: 101
      prefix: --minorder
  - id: mismatches
    type:
      - 'null'
      - int
    doc: Allowed mismatches when attempting to link two seeds together
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: nproc
    type:
      - 'null'
      - int
    doc: Number of processes to run in parallel
    inputBinding:
      position: 101
      prefix: --nproc
  - id: seedsdistance
    type:
      - 'null'
      - int
    doc: Maximum distance to consider two consecutive seeds for merging
    inputBinding:
      position: 101
      prefix: --seedsdistance
  - id: seedskips
    type:
      - 'null'
      - int
    doc: Maximum number of seed skips
    inputBinding:
      position: 101
      prefix: --seedskips
  - id: seedsoverlap
    type:
      - 'null'
      - int
    doc: Minimum overlap length to allow the merging of two overlapping seeds
    inputBinding:
      position: 101
      prefix: --seedsoverlap
  - id: shortreads
    type: File
    doc: 'fastq file of short reads. Warning: only one file must be provided. If using
      paired reads, please concatenate them into one single file.'
    inputBinding:
      position: 101
      prefix: --shortreads
  - id: solid
    type:
      - 'null'
      - int
    doc: Minimum number of occurrences to consider a short read k-mer as solid, 
      after correction. This parameter should be carefully raised accordingly to
      the short reads coverage and accuracy, and to the chosen maximum order of 
      the graph. It should only be increased when using high coverage of short 
      reads, or a small maximum order.
    inputBinding:
      position: 101
      prefix: --solid
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Path where to store the directory containing temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: out
    type: File
    doc: Prefix of the fasta files where to output the corrected, trim and split
      long reads.
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hg-color:1.1.1--he1b5a44_0
