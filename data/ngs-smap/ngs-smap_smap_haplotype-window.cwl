cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smap
  - haplotype-window
label: ngs-smap_smap_haplotype-window
doc: "\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: genome
    type: File
    doc: "FASTA file with the reference genome sequence."
    inputBinding:
      position: 1
  - id: borders
    type: File
    doc: "GFF file with the coordinates of pairs of Borders that enclose a Window. Must contain NAME=<> in column 9 to denote the Window name."
    inputBinding:
      position: 2
  - id: alignments_dir
    type: Directory
    doc: "Directory containing BAM and BAM index files. All BAM files should be in the same directory (default current directory)"
    inputBinding:
      position: 3
  - id: sample_dir
    type: Directory
    doc: "Directory containing .fastq files that were mapped onto the reference genome to create the .bam files. The .fastq file names must have the same prefix as the .bam files specified in --dir."
    inputBinding:
      position: 4
  - id: guides
    type:
      - 'null'
      - File
    doc: Optional fasta file containing the sequences from gRNAs used in CRISPR genome editing. Useful when primers against the delivery vector are included in the HiPlex amplicon mixture. In multiplex setting, this list of sequences can be used to identify exactly which gRNA(s) were used in the CRISPR-Cas/gRNA delivery vector.
    inputBinding:
      position: 5
  - id: write_sorted_sequences
    type:
      - 'null'
      - boolean
    doc: "Write .fastq files containing the reads for each Window in a separate file per input sample."
    inputBinding:
      position: 10
      prefix: --write_sorted_sequences
  - id: out
    type:
      - 'null'
      - string
    doc: "Basename of the output file without extension (default: \"\")."
    inputBinding:
      position: 10
      prefix: --out
  - id: discrete_calls
    type:
      - 'null'
      - string
    doc: "Set to \"dominant\" to transform haplotype frequency values into presence(1)/absence(0) calls per allele, or \"dosage\" to indicate the allele copy number."
    inputBinding:
      position: 10
      prefix: --discrete_calls
  - id: frequency_interval_bounds
    type:
      - 'null'
      - type: array
        items: string
    doc: "Frequency interval bounds for transforming haplotype frequencies into discrete calls. Custom thresholds can be defined by passing one or more space-separated values (relative frequencies in percentage). For dominant calling, one value should be specified. For dosage calling, an even total number of four or more thresholds should be specified. Default values are invoked by passing either \"diploid\" or \"tetraploid\". The default value for dominant calling (see discrete_calls argument) is 10, both for \"diploid\" and \"tetraploid\". For dosage calling, the default for diploids is \"10, 10, 90, 90\" and for tetraploids \"12.5, 12.5, 37.5, 37.5, 62.5, 62.5, 87.5, 87.5\"."
    inputBinding:
      position: 10
      prefix: --frequency_interval_bounds
  - id: dosage_filter
    type:
      - 'null'
      - int
    doc: "Mask dosage calls in the loci for which the total allele count for a given locus at a given sample differs from the defined value. For example, in diploid organisms the total allele copy number must be 2, and in tetraploids the total allele copy number must be 4. (default no filtering)."
    inputBinding:
      position: 10
      prefix: --dosage_filter
  - id: locus_correctness
    type:
      - 'null'
      - float
    doc: "Create a new .gff file defining only the loci that were correctly dosage called (-z) in at least the defined percentage of samples."
    inputBinding:
      position: 10
      prefix: --locus_correctness
  - id: plot
    type:
      - 'null'
      - string
    doc: "Select which plots are generated. Choosing \"nothing\" disables plot generation. Passing \"summary\" only generates graphs with information for all samples, while \"all\" will also generate per-sample plots [default \"summary\"]."
    inputBinding:
      position: 10
      prefix: --plot
  - id: plot_type
    type:
      - 'null'
      - string
    doc: "Choose the file type for the plots [png]."
    inputBinding:
      position: 10
      prefix: --plot_type
  - id: mask_frequency
    type:
      - 'null'
      - float
    doc: "Mask haplotype frequency values below MASK_FREQUENCY for individual samples to remove noise from the final output. Haplotype frequency values below MASK_FREQUENCY are set to UNDEFINED_REPRESENTATION (see -u). Haplotypes are not removed based on this value, use '--min_haplotype_frequency' for this purpose instead."
    inputBinding:
      position: 10
      prefix: --mask_frequency
  - id: undefined_representation
    type:
      - 'null'
      - string
    doc: "Value to use for non-existing or masked data [NaN]."
    inputBinding:
      position: 10
      prefix: --undefined_representation
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: "Minimum bam mapping quality to retain reads for analysis [30]."
    inputBinding:
      position: 10
      prefix: --min_mapping_quality
  - id: min_distinct_haplotypes
    type:
      - 'null'
      - int
    doc: "Minimal number of distinct haplotypes per locus across all samples. Loci that do not fit this criterium are removed from the final output [0]."
    inputBinding:
      position: 10
      prefix: --min_distinct_haplotypes
  - id: max_distinct_haplotypes
    type:
      - 'null'
      - int
    doc: "Maximal number of distinct haplotypes per locus across all samples. Loci that do not fit this criterium are removed from the final output [inf]."
    inputBinding:
      position: 10
      prefix: --max_distinct_haplotypes
  - id: min_read_count
    type:
      - 'null'
      - int
    doc: "Minimal total number of reads for a locus in each sample [0]."
    inputBinding:
      position: 10
      prefix: --min_read_count
  - id: max_read_count
    type:
      - 'null'
      - int
    doc: "Maximal number of reads per locus per sample, read depth is calculated after filtering out the low frequency haplotypes (-f) [inf]."
    inputBinding:
      position: 10
      prefix: --max_read_count
  - id: min_haplotype_frequency
    type:
      - 'null'
      - float
    doc: "Minimal haplotype frequency (in %) to retain the haplotype in the genotyping table. If in at least one sample the haplotype frequency is above MIN_HAPLOTYPE_FREQUENCY, the haplotype is retained. Haplotypes for which MIN_HAPLOTYPE_FREQUENCY is never reached in any of the samples are removed [0]."
    inputBinding:
      position: 10
      prefix: --min_haplotype_frequency
  - id: max_error
    type:
      - 'null'
      - float
    doc: "The maximum error rate (between 0 and 1; but not exactly 1) for finding the border sequences in the reads."
    inputBinding:
      position: 10
      prefix: --max_error
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of parallel processes [1]."
    inputBinding:
      position: 10
      prefix: --processes
  - id: memory_efficient
    type:
      - 'null'
      - boolean
    doc: "Reduces the memory load significantly, but increases time to calculate results."
    inputBinding:
      position: 10
      prefix: --memory_efficient
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Haplotype tables and plots written by SMAP haplotype-window"
    outputBinding:
      glob:
        - "*.tsv"
        - "*.gff"
        - "*.png"
        - "*.pdf"
        - "*.fastq"
        - "*.fq"
        - "*.txt"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
