cwlVersion: v1.2
class: CommandLineTool
baseCommand: emirge_amplicon.py
label: emirge_emirge_amplicon.py
doc: "EMIRGE amplicon reconstructs full-length rRNA SSU genes from Illumina 16S amplicon
  data.\n\nTool homepage: https://github.com/csmiller/EMIRGE"
inputs:
  - id: working_dir
    type: string
    doc: DIR, the working directory to process data in (created by the tool)
    inputBinding:
      position: 1
  - id: reads_1
    type: File
    doc: path to fastq file with 1 (forward) reads from a paired-end run, or all
      reads from a single-end run (may be gzipped)
    inputBinding:
      position: 102
      prefix: '-1'
  - id: reads_2
    type:
      - 'null'
      - File
    doc: path to fastq file with 2 (reverse) reads from a paired-end run (must 
      be unzipped for the mapper)
    inputBinding:
      position: 102
      prefix: '-2'
  - id: fasta_db
    type: File
    doc: path to fasta file of candidate SSU sequences
    inputBinding:
      position: 102
      prefix: --fasta_db
  - id: bowtie_db
    type: string
    doc: precomputed bowtie index of candidate SSU sequences (prefix of the 
      index files, see bowtie_index_files)
    inputBinding:
      position: 102
      prefix: --bowtie_db
  - id: bowtie_index_files
    type:
      type: array
      items: File
    doc: the bowtie index files (.ebwt) that belong to bowtie_db, staged next to
      the working directory
  - id: max_read_length
    type: int
    doc: length of longest read in input data
    inputBinding:
      position: 102
      prefix: --max_read_length
  - id: insert_mean
    type:
      - 'null'
      - float
    doc: insert size distribution mean (paired-end reads)
    inputBinding:
      position: 102
      prefix: --insert_mean
  - id: insert_stddev
    type:
      - 'null'
      - float
    doc: insert size distribution standard deviation (paired-end reads)
    inputBinding:
      position: 102
      prefix: --insert_stddev
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations to perform (default=40)
    inputBinding:
      position: 102
      prefix: --iterations
  - id: processors
    type:
      - 'null'
      - int
    doc: 'Number of processors to use in the mapping steps (default: 1)'
    inputBinding:
      position: 102
      prefix: --processors
  - id: mapping
    type:
      - 'null'
      - File
    doc: path to precomputed initial mapping (bam file)
    inputBinding:
      position: 102
      prefix: --mapping
  - id: snp_fraction_thresh
    type:
      - 'null'
      - float
    doc: 'If fraction of variants in a candidate sequence exceeds this threshold,
      split the candidate into two sequences for the next iteration (default: 0.04)'
    inputBinding:
      position: 102
      prefix: --snp_fraction_thresh
  - id: variant_fraction_thresh
    type:
      - 'null'
      - float
    doc: 'minimum probability of second most probable base at a site required in order
      to call the site a variant (default: 0.1)'
    inputBinding:
      position: 102
      prefix: --variant_fraction_thresh
  - id: join_threshold
    type:
      - 'null'
      - float
    doc: 'If two candidate sequences share >= this fractional identity over their
      bases with mapped reads, merge them (default: 0.97; valid range: [0.95, 1.0])'
    inputBinding:
      position: 102
      prefix: --join_threshold
  - id: min_length_coverage
    type:
      - 'null'
      - float
    doc: 'minimum fraction of the length of a candidate reference sequence that must
      be covered by mapped reads; otherwise the candidate is discarded (default: 0.3;
      valid range: (0.0, 1.0])'
    inputBinding:
      position: 102
      prefix: --min_length_coverage
  - id: nice_mapping
    type:
      - 'null'
      - int
    doc: If set, during the mapping phase the mapper is niced by the Linux 
      kernel with this value
    inputBinding:
      position: 102
      prefix: --nice_mapping
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: Illumina quality values in fastq files are Phred+33 (default is to 
      assume Phred+64)
    inputBinding:
      position: 102
      prefix: --phred33
outputs:
  - id: working_dir_out
    type: Directory
    doc: working directory with the iteration folders (iter.N)
    outputBinding:
      glob: $(inputs.working_dir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.bowtie_index_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/emirge:0.61.1--py27_1
stdout: emirge_emirge_amplicon.py.out
