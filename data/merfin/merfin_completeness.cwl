cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - merfin
  - -completeness
label: merfin_completeness
doc: "Compute kmer completeness using expected copy numbers for all kmers.\n\nTool homepage: https://github.com/arangrhie/merfin"
inputs:
  - id: sequence
    type:
      - 'null'
      - File
    doc: "Consensus sequence FASTA (required unless -seqmers is given)"
    inputBinding:
      position: 102
      prefix: -sequence
  - id: readmers
    type: Directory
    doc: "Read k-mer database (meryl database directory built from the reads)"
    inputBinding:
      position: 102
      prefix: -readmers
  - id: peak
    type: float
    doc: "Haploid peak: hard sets copy 1 and infers multiplicity to copy number (recommended)"
    inputBinding:
      position: 102
      prefix: -peak
  - id: seqmers
    type:
      - 'null'
      - Directory
    doc: "Optional input for a pre-built sequence meryl database (by default <seq.fasta>.meryl is generated)"
    inputBinding:
      position: 102
      prefix: -seqmers
  - id: prob
    type:
      - 'null'
      - File
    doc: "Optional input vector of probabilities; adjusts multiplicity to copy number (takes priority over -peak for the multiplicities listed)"
    inputBinding:
      position: 102
      prefix: -prob
  - id: min_kmer_value
    type:
      - 'null'
      - int
    doc: "Ignore kmers with value below m"
    inputBinding:
      position: 102
      prefix: -min
  - id: max_kmer_value
    type:
      - 'null'
      - int
    doc: "Ignore kmers with value above m"
    inputBinding:
      position: 102
      prefix: -max
  - id: threads
    type:
      - 'null'
      - int
    doc: "Multithreading for meryl lookup table construction, dump and hist"
    inputBinding:
      position: 102
      prefix: -threads
  - id: memory
    type:
      - 'null'
      - float
    doc: "Do not use more than m GB memory for loading mers"
    inputBinding:
      position: 102
      prefix: -memory
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: stderr_log
    type: stderr
    doc: Standard error (progress, QV or completeness report)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.sequence)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/merfin:1.0--h9948957_3
stdout: merfin_completeness.out
stderr: merfin_completeness.err
