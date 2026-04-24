cwlVersion: v1.2
class: CommandLineTool
baseCommand: wakhan
label: wakhan_cna
doc: "Wakhan plots coverage and copy number profiles from a bam and phased VCF files\n\
  \nTool homepage: https://github.com/KolmogorovLab/Wakhan"
inputs:
  - id: mode
    type: string
    doc: Run full pipeline, cna or hapcorrect modes
    inputBinding:
      position: 1
  - id: bin_size
    type:
      - 'null'
      - int
    doc: bin size for coverage calculation
    inputBinding:
      position: 102
      prefix: --bin-size
  - id: bin_size_snps
    type:
      - 'null'
      - int
    doc: bin size for LOH detection
    inputBinding:
      position: 102
      prefix: --bin-size-snps
  - id: breakpoints
    type:
      - 'null'
      - File
    doc: Path to breakpoints/SVs VCF file
    inputBinding:
      position: 102
      prefix: --breakpoints
  - id: breakpoints_min_length
    type:
      - 'null'
      - int
    doc: SV minimum length to include
    inputBinding:
      position: 102
      prefix: --breakpoints-min-length
  - id: cancer_genes
    type:
      - 'null'
      - File
    doc: Path to custom Genes TSV file (e.g. COSMIC)
    inputBinding:
      position: 102
      prefix: --cancer-genes
  - id: centromere_bed
    type:
      - 'null'
      - File
    doc: Path to custom centromere annotations BED file
    inputBinding:
      position: 102
      prefix: --centromere-bed
  - id: change_point_detection_for_cna
    type:
      - 'null'
      - boolean
    doc: use change point detection algo for more cna segmentation instead of 
      breakpoints
    inputBinding:
      position: 102
      prefix: --change-point-detection-for-cna
  - id: confidence_subclonal_score
    type:
      - 'null'
      - float
    doc: user input p-value to detect if a segment is subclonal/off to integer 
      copynumber
    inputBinding:
      position: 102
      prefix: --confidence-subclonal-score
  - id: contigs
    type:
      - 'null'
      - string
    doc: List of contigs to be included in the plots, default chr1-22,chrX 
      [e.g., chr1-22,X,Y], Must be consistent with chr/nochr notation in input 
      files
    inputBinding:
      position: 102
      prefix: --contigs
  - id: cpd_internal_segments
    type:
      - 'null'
      - boolean
    doc: change point detection algo for more precise segments after 
      breakpoint/cpd segments
    inputBinding:
      position: 102
      prefix: --cpd-internal-segments
  - id: cut_threshold
    type:
      - 'null'
      - int
    doc: Plotting threshold for coverage
    inputBinding:
      position: 102
      prefix: --cut-threshold
  - id: genome_name
    type:
      - 'null'
      - string
    doc: Genome sample/cell line name to be displayed on plots
    inputBinding:
      position: 102
      prefix: --genome-name
  - id: hets_ratio
    type:
      - 'null'
      - float
    doc: Hetrozygous SNPs ratio threshold for LOH detection
    inputBinding:
      position: 102
      prefix: --hets-ratio
  - id: min_phaseblock
    type:
      - 'null'
      - int
    doc: minimum phaseblock length for CNA estimation
    inputBinding:
      position: 102
      prefix: --min-phaseblock
  - id: normal_phased_vcf
    type:
      - 'null'
      - File
    doc: Path to normal phased vcf (tumor-normal mode)
    inputBinding:
      position: 102
      prefix: --normal-phased-vcf
  - id: out_dir_plots
    type: Directory
    doc: Output directory
    inputBinding:
      position: 102
      prefix: --out-dir-plots
  - id: pdf_enable
    type:
      - 'null'
      - boolean
    doc: Enabling PDF output coverage plots
    inputBinding:
      position: 102
      prefix: --pdf-enable
  - id: ploidy_range
    type:
      - 'null'
      - string
    doc: Target tumor ploidy range
    inputBinding:
      position: 102
      prefix: --ploidy-range
  - id: purity_range
    type:
      - 'null'
      - string
    doc: Target tumor purity range
    inputBinding:
      position: 102
      prefix: --purity-range
  - id: reference
    type: File
    doc: path to reference
    inputBinding:
      position: 102
      prefix: --reference
  - id: reference_name
    type:
      - 'null'
      - string
    doc: Reference name
    inputBinding:
      position: 102
      prefix: --reference-name
  - id: target_bam
    type:
      type: array
      items: File
    doc: path to tumor bam file (must be indexed)
    inputBinding:
      position: 102
      prefix: --target-bam
  - id: threads
    type:
      - 'null'
      - int
    doc: number of parallel threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: tumor_phased_vcf
    type:
      - 'null'
      - File
    doc: Path to tumor phased VCF (tumor-only mode)
    inputBinding:
      position: 102
      prefix: --tumor-phased-vcf
  - id: use_sv_haplotypes
    type:
      - 'null'
      - boolean
    doc: Enable using phased SVs/breakpoints
    inputBinding:
      position: 102
      prefix: --use-sv-haplotypes
  - id: without_phasing
    type:
      - 'null'
      - boolean
    doc: Enabling coverage and copynumbers without phasing in plots
    inputBinding:
      position: 102
      prefix: --without-phasing
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wakhan:0.4.2--pyhdfd78af_0
stdout: wakhan_cna.out
