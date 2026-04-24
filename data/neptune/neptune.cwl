cwlVersion: v1.2
class: CommandLineTool
baseCommand: neptune
label: neptune
doc: "Neptune identifies signatures using an exact k-mer matching strategy. Neptune
  locates sequence that is sufficiently present in many inclusion targets and sufficiently
  absent from exclusion targets.\n\nTool homepage: https://github.com/iqiyi/Neptune"
inputs:
  - id: aggregate_specification
    type:
      - 'null'
      - string
    doc: The DRMAA specific parameters specific to k-mer aggregation.
    inputBinding:
      position: 101
      prefix: --aggregate-specification
  - id: confidence
    type:
      - 'null'
      - float
    doc: The statistical confidence level in decision making involving 
      probabilities when producing candidate signatures.
    inputBinding:
      position: 101
      prefix: --confidence
  - id: consolidate_specification
    type:
      - 'null'
      - string
    doc: The DRMAA parameters specific to filtered signature consolidation.
    inputBinding:
      position: 101
      prefix: --consolidate-specification
  - id: count_specification
    type:
      - 'null'
      - string
    doc: The DRMAA parameters specific to k-mer counting.
    inputBinding:
      position: 101
      prefix: --count-specification
  - id: database_specification
    type:
      - 'null'
      - string
    doc: The DRMAA parameters specific to database construction and querying.
    inputBinding:
      position: 101
      prefix: --database-specification
  - id: default_specification
    type:
      - 'null'
      - string
    doc: The default DRMAA parameters.
    inputBinding:
      position: 101
      prefix: --default-specification
  - id: drmaa
    type:
      - 'null'
      - boolean
    doc: Whether or not to run Neptune in DRMAA-mode and attempt to schedule 
      jobs through DRMAA. This will require setting up DRMAA in advance.
    inputBinding:
      position: 101
      prefix: --drmaa
  - id: exclusion
    type:
      type: array
      items: File
    doc: The exclusion targets in FASTA format.
    inputBinding:
      position: 101
      prefix: --exclusion
  - id: exhits
    type:
      - 'null'
      - int
    doc: The maximum allowable number of exclusion targets that may contain a 
      k-mer observed in the reference before terminating the construction of a 
      candidate signature. This will be calculated if not specified.
    inputBinding:
      position: 101
      prefix: --exhits
  - id: extract_specification
    type:
      - 'null'
      - string
    doc: The DRMAA parameters specific to candidate signature extraction.
    inputBinding:
      position: 101
      prefix: --extract-specification
  - id: filter_length
    type:
      - 'null'
      - float
    doc: The maximum shared fractional length of an exclusion target alignment 
      with a candidate signature before discarding the signature. When both the 
      filtered percent and filtered length limits are exceed, the signature is 
      discarded.
    inputBinding:
      position: 101
      prefix: --filter-length
  - id: filter_percent
    type:
      - 'null'
      - float
    doc: The maximum percent identity of a candidate signature with an exclusion
      hit before discarding the signature. When both the filtered percent and 
      filtered length limits are exceed, the signature is discarded.
    inputBinding:
      position: 101
      prefix: --filter-percent
  - id: filter_specification
    type:
      - 'null'
      - string
    doc: The DRMAA parameters specific to candidate signature filtering.
    inputBinding:
      position: 101
      prefix: --filter-specification
  - id: gap
    type:
      - 'null'
      - int
    doc: The maximum number of consecutive k-mers observed in the reference 
      during signature candidate construction that fail to have enough inclusion
      hits before terminating the construction of a candidate signature. This 
      will be calculated if not specified and is determined from the size of k 
      and the rate.
    inputBinding:
      position: 101
      prefix: --gap
  - id: gc_content
    type:
      - 'null'
      - float
    doc: The average GC-content of all inclusion and exclusion targets. This 
      will be calculated from inclusion and exclusion targets if not specified.
    inputBinding:
      position: 101
      prefix: --gc-content
  - id: inclusion
    type:
      type: array
      items: File
    doc: The inclusion targets in FASTA format.
    inputBinding:
      position: 101
      prefix: --inclusion
  - id: inhits
    type:
      - 'null'
      - int
    doc: The minimum number of inclusion targets that must contain a k-mer 
      observed in the reference to begin or continue building candidate 
      signatures. This will be calculated if not specified.
    inputBinding:
      position: 101
      prefix: --inhits
  - id: kmer
    type:
      - 'null'
      - int
    doc: The size of the k-mers.
    inputBinding:
      position: 101
      prefix: --kmer
  - id: organization
    type:
      - 'null'
      - string
    doc: The degree of k-mer organization in the output files. This exploits the
      four-character alphabet of nucleotides to produce several k-mer output 
      files, with all k-mers in a file beginning with the same short sequence of
      nucleotides. This parameter determines the number of nucleotides to use 
      and will produce 4^X output files, where X is the number of nucleotides 
      specified by this parameter. The number of output files directly 
      corresponds to the amount of parallelization in the k-mer aggregation 
      process.
    inputBinding:
      position: 101
      prefix: --organization
  - id: parallelization
    type:
      - 'null'
      - int
    doc: The number of processes to run simultaneously. Note that this is only 
      applicable when running Neptune in non-DRMAA mode (default).
    inputBinding:
      position: 101
      prefix: --parallelization
  - id: rate
    type:
      - 'null'
      - float
    doc: The probability of a mutation or error at an arbitrary position. The 
      default value is 0.01.
    inputBinding:
      position: 101
      prefix: --rate
  - id: reference
    type:
      - 'null'
      - type: array
        items: File
    doc: The FASTA reference from which to extract signatures.
    inputBinding:
      position: 101
      prefix: --reference
  - id: reference_size
    type:
      - 'null'
      - int
    doc: The estimated total size in nucleotides of the reference. This will be 
      calculated if not specified.
    inputBinding:
      position: 101
      prefix: --reference-size
  - id: seed_size
    type:
      - 'null'
      - int
    doc: The seed size used during alignment.
    inputBinding:
      position: 101
      prefix: --seed-size
  - id: size
    type:
      - 'null'
      - int
    doc: The minimum size of all reported candidate signatures. Identified 
      candidate signatures shorter than this value will be discard.
    inputBinding:
      position: 101
      prefix: --size
outputs:
  - id: output
    type: Directory
    doc: The directory to place all output.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neptune:1.2.5--py27_0
