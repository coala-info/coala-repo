cwlVersion: v1.2
class: CommandLineTool
baseCommand: secapr reference_assembly
label: secapr_reference_assembly
doc: "Create new reference library and map raw reads against the library (reference-based
  assembly)\n\nTool homepage: https://github.com/AntonelliLab/seqcap_processor"
inputs:
  - id: a
    type:
      - 'null'
      - float
    doc: Matching score. Acts as a factor enhancing any match (higher value 
      makes it less conservative = allows reads that have fewer matches, since 
      every match is scored higher).
    inputBinding:
      position: 101
      prefix: --a
  - id: b
    type:
      - 'null'
      - float
    doc: 'Mismatch penalty. The accepted mismatch rate per read on length k is approximately:
      {.75 * exp[-log(4) * B/A]}'
    inputBinding:
      position: 101
      prefix: --b
  - id: c
    type:
      - 'null'
      - int
    doc: Discard a match if it has more than INT occurence in the genome
    inputBinding:
      position: 101
      prefix: --c
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of computational cores for parallelization of computation.
    inputBinding:
      position: 101
      prefix: --cores
  - id: d
    type:
      - 'null'
      - int
    doc: Stop extension when the difference between the best and the current 
      extension score is above |i-j|*A+INT, where i and j are the current 
      positions of the query and reference, respectively, and A is the matching 
      score.
    inputBinding:
      position: 101
      prefix: --d
  - id: e
    type:
      - 'null'
      - float
    doc: Gap extension penalty
    inputBinding:
      position: 101
      prefix: --e
  - id: k
    type:
      - 'null'
      - int
    doc: If the part of the read that sufficiently matches the reference is 
      shorter than this threshold, it will be discarded (minSeedLen).
    inputBinding:
      position: 101
      prefix: --k
  - id: keep_duplicates
    type:
      - 'null'
      - boolean
    doc: Use this flag if you do not want to discard all duplicate reads with 
      Picard.
    inputBinding:
      position: 101
      prefix: --keep_duplicates
  - id: l
    type:
      - 'null'
      - float
    doc: Clipping penalty. During extension, the algorithm keeps track of the 
      best score reaching the end of query. If this score is larger than the 
      best extension score minus the clipping penalty, clipping will not be 
      applied.
    inputBinding:
      position: 101
      prefix: --l
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: Set the minimum read coverage. Only positions that are covered by this 
      number of reads will be called in the consensus sequence, otherwise the 
      program will add an ambiguity at this position.
    inputBinding:
      position: 101
      prefix: --min_coverage
  - id: o
    type:
      - 'null'
      - float
    doc: Gap opening penalty
    inputBinding:
      position: 101
      prefix: --o
  - id: r
    type:
      - 'null'
      - float
    doc: Trigger re-seeding for a MEM longer than minSeedLen*FLOAT.
    inputBinding:
      position: 101
      prefix: --r
  - id: reads
    type: Directory
    doc: Call the folder that contains the trimmed reads, organized in a 
      separate subfolder for each sample. The name of the subfolder has to start
      with the sample name, delimited with an underscore [_] (default output of 
      clean_reads function).
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type: File
    doc: When choosing "alignment-consensus" or "sample-specific" as 
      reference_type, this flag calls the folder containing the alignment files 
      for your target loci (fasta-format). In case of "user-ref-lib" as 
      reference_type, this flag calls one single fasta file that contains a 
      user-prepared reference library which will be applied to all samples.
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_type
    type:
      - 'null'
      - string
    doc: Please choose which type of reference you want to map the samples to. 
      "alignment-consensus" will create a consensus sequence for each alignment 
      file which will be used as a reference for all samples. This is 
      recommendable when all samples are rather closely related to each other. 
      "sample-specific" will extract the sample specific sequences from an 
      alignment and use these as a separate reference for each individual 
      sample. "user-ref-lib" enables to input one single fasta file created by 
      the user which will be used as a reference library for all samples.
    inputBinding:
      position: 101
      prefix: --reference_type
  - id: u
    type:
      - 'null'
      - float
    doc: Penalty for an unpaired read pair. The lower the value, the more 
      unpaired reads will be allowed in the mapping.
    inputBinding:
      position: 101
      prefix: --u
  - id: w
    type:
      - 'null'
      - int
    doc: Avoid introducing gaps in reads that are longer than this threshold.
    inputBinding:
      position: 101
      prefix: --w
outputs:
  - id: output
    type: Directory
    doc: The output directory where results will be safed.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/secapr:2.2.8--pyh5e36f6f_0
