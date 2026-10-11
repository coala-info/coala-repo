cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smap
  - haplotype-sites
label: ngs-smap_smap_haplotype-sites
doc: "Create haplotypes using a VCF file containing variant positions and a BED file containing SMAPs.\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: alignments_dir
    type: Directory
    doc: "Path to the directory containing BAM and BAI alignment files. All BAM files should be in the same directory."
    inputBinding:
      position: 1
  - id: bed
    type: File
    doc: "BED file containing sites for which haplotypes will be reconstructed. For GBS experiments, the BED file should be generated using SMAP delineate. For HiPlex data, a BED6 file can be provided."
    inputBinding:
      position: 2
  - id: vcf
    type: File
    doc: "VCF file containing variant positions. It should contain at least the first 9 columns."
    inputBinding:
      position: 3
      valueFrom: $(self.basename)
  - id: out
    type:
      - 'null'
      - string
    doc: "Basename of the output file without extension (default: \"\")."
    inputBinding:
      position: 10
      prefix: --out
  - id: mapping_orientation
    type: string
    doc: "Specify if strandedness of read mapping should be considered for haplotyping. When specifying \"ignore\", reads are collected per locus independent of the strand that the reads are mapped on (i.e. ignoring their mapping orientation). \"stranded\" means that only those reads will be considered that map on the same strand as indicated per locus in the BED file. For more information on which option to choose, please consult the manual. (https://ngs-smap.readthedocs.io/e n/latest/sites/sites_scope_usage.html#commands- options)"
    inputBinding:
      position: 10
      prefix: -r
  - id: read_type
    type:
      - 'null'
      - string
    doc: "Deprecated option: please use --mapping_orientation. \" --read_type merged\" should be replaced by \"-- mapping_orientation ignore\", and \"--read_type separate\" should be replaced by \"--mapping_orientation stranded\"."
    inputBinding:
      position: 10
      prefix: -read_type
  - id: cervus
    type:
      - 'null'
      - boolean
    doc: "Transform discrete calls table to an multi-allelic format that can be used with Cervus. Haplotypes are transformed to letters of the alphabet (a-z)."
    inputBinding:
      position: 10
      prefix: --cervus
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
    doc: "Create a new .bed file defining only the loci that were correctly dosage called (-z) in at least the defined percentage of samples."
    inputBinding:
      position: 10
      prefix: --locus_correctness
  - id: plot
    type:
      - 'null'
      - string
    doc: "Select which plots are to be generated. Choosing \"nothing\" disables plot generation. Passing \"summary\" only generates graphs with information for all samples while \"all\" will also generate per-sample plots [default \"summary\"]."
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
    doc: "Mask haplotype frequency values below MASK_FREQUENCY for individual samples to remove noise from the final output. Haplotype frequency values below MASK_FREQUENCY are set to UNDEFINED_REPRESENTATION (see -u). Haplotypes are not removed based on this value, use --min_haplotype_frequency for this purpose instead."
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
  - id: no_indels
    type:
      - 'null'
      - boolean
    doc: "Use this option if you want to exclude haplotypes that contain an indel at the given SNP positions. These reads are then also ignored to evaluate the minimum read count (default off: haplotypes with indels co- localising at SNP positions are included in output)."
    inputBinding:
      position: 10
      prefix: --no_indels
  - id: partial
    type: string
    doc: "Choose to include or exclude haplotypes that contain partial alignments. For GBS data, choose \"include\", for HiPlex data, choose \"exclude\"."
    inputBinding:
      position: 10
      prefix: -a
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
    doc: "Minimum number of distinct haplotypes per locus across all samples. Loci that do not fit this criterium are removed from the final output [0]."
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
    doc: "Minimum total number of reads per locus per sample, read depth is calculated after filtering out the low frequency haplotypes (-f) [0]."
    inputBinding:
      position: 10
      prefix: --min_read_count
  - id: max_read_count
    type:
      - 'null'
      - int
    doc: "Maximal total number of reads per locus per sample, read depth is calculated after filtering out the low frequency haplotypes (-f) [inf]."
    inputBinding:
      position: 10
      prefix: --max_read_count
  - id: min_haplotype_frequency
    type:
      - 'null'
      - float
    doc: "Minimum haplotype frequency (in %) to retain the haplotype in the genotype table. If in at least one sample the haplotype frequency is above MIN_HAPLOTYPE_FREQUENCY, the haplotype is retained. Haplotypes for which MIN_HAPLOTYPE_FREQUENCY is never reached in any of the samples are removed [0]."
    inputBinding:
      position: 10
      prefix: --min_haplotype_frequency
  - id: processes
    type:
      - 'null'
      - int
    doc: "Number of parallel processes [1]."
    inputBinding:
      position: 10
      prefix: --processes
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Haplotype tables, coordinates and plots written by SMAP haplotype-sites"
    outputBinding:
      glob:
        - "*.tsv"
        - "*.bed"
        - "*.png"
        - "*.pdf"
        - "*.txt"
        - "*.xlsx"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.vcf)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
