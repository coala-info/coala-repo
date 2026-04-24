cwlVersion: v1.2
class: CommandLineTool
baseCommand: mykrobe predict
label: mykrobe_predict
doc: "Predicts antimicrobial resistance from sequencing data.\n\nTool homepage: https://github.com/iqbal-lab/Mykrobe-predictor"
inputs:
  - id: conf_percent_cutoff
    type:
      - 'null'
      - float
    doc: Number between 0 and 100. Determines --min_variant_conf, by simulating 
      variants and choosing the cutoff that would keep x% of the variants
    inputBinding:
      position: 101
      prefix: --conf_percent_cutoff
  - id: ctx
    type:
      - 'null'
      - File
    doc: Cortex graph binary
    inputBinding:
      position: 101
      prefix: --ctx
  - id: custom_lineage_json
    type:
      - 'null'
      - File
    doc: For use with `--panel custom`. Ignored otherwise. File path to JSON 
      made by --lineage option of make-probes
    inputBinding:
      position: 101
      prefix: --custom_lineage_json
  - id: custom_probe_set_path
    type:
      - 'null'
      - File
    doc: Required if species is 'custom'. Ignored otherwise. File path to fasta 
      file from `mykrobe make-probes`.
    inputBinding:
      position: 101
      prefix: --custom_probe_set_path
  - id: custom_variant_to_resistance_json
    type:
      - 'null'
      - File
    doc: For use with `--panel custom`. Ignored otherwise. File path to JSON 
      with key,value pairs of variant names and induced drug resistance.
    inputBinding:
      position: 101
      prefix: --custom_variant_to_resistance_json
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Output debugging information to stderr
    inputBinding:
      position: 101
      prefix: --debug
  - id: expected_depth
    type:
      - 'null'
      - float
    doc: Expected depth
    inputBinding:
      position: 101
      prefix: --expected_depth
  - id: expected_error_rate
    type:
      - 'null'
      - float
    doc: Expected sequencing error rate
    inputBinding:
      position: 101
      prefix: --expected_error_rate
  - id: filters
    type:
      - 'null'
      - type: array
        items: string
    doc: Don't include specific filtered genotypes
      - MISSING_WT
      - LOW_PERCENT_COVERAGE
      - LOW_GT_CONF
      - LOW_TOTAL_DEPTH
    inputBinding:
      position: 101
      prefix: --filters
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force override any skeleton files
    inputBinding:
      position: 101
      prefix: --force
  - id: format
    type:
      - 'null'
      - string
    doc: Choose output format
    inputBinding:
      position: 101
      prefix: --format
  - id: guess_sequence_method
    type:
      - 'null'
      - boolean
    doc: Guess if ONT or Illumia based on error rate. If error rate is > 10%, 
      ploidy is set to haploid and a confidence threshold is used
    inputBinding:
      position: 101
      prefix: --guess_sequence_method
  - id: ignore_filtered
    type:
      - 'null'
      - string
    doc: Don't include filtered genotypes
    inputBinding:
      position: 101
      prefix: --ignore_filtered
  - id: ignore_minor_calls
    type:
      - 'null'
      - boolean
    doc: Ignore minor calls when running resistance prediction
    inputBinding:
      position: 101
      prefix: --ignore_minor_calls
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Don't remove temporary files
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer length
    inputBinding:
      position: 101
      prefix: --kmer
  - id: memory
    type:
      - 'null'
      - string
    doc: Memory to allocate for graph constuction
    inputBinding:
      position: 101
      prefix: --memory
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_gene_conf
    type:
      - 'null'
      - int
    doc: Minimum genotype confidence for gene genotyping
    inputBinding:
      position: 101
      prefix: --min_gene_conf
  - id: min_gene_percent_covg_threshold
    type:
      - 'null'
      - int
    doc: All genes alleles found above this percent coverage will be reported
    inputBinding:
      position: 101
      prefix: --min_gene_percent_covg_threshold
  - id: min_proportion_expected_depth
    type:
      - 'null'
      - float
    doc: Minimum depth required on the sum of both alleles
    inputBinding:
      position: 101
      prefix: --min_proportion_expected_depth
  - id: min_variant_conf
    type:
      - 'null'
      - int
    doc: Minimum genotype confidence for variant genotyping
    inputBinding:
      position: 101
      prefix: --min_variant_conf
  - id: model
    type:
      - 'null'
      - string
    doc: Genotype model used. Options kmer_count, median_depth
    inputBinding:
      position: 101
      prefix: --model
  - id: ncbi_names
    type:
      - 'null'
      - boolean
    doc: Report NCBI species names in addiition to the usual species names in 
      the JSON output. Only applies when the species is tb
    inputBinding:
      position: 101
      prefix: --ncbi_names
  - id: ont
    type:
      - 'null'
      - boolean
    doc: Set defaults for ONT data. Sets `-e 0.08 --ploidy haploid`
    inputBinding:
      position: 101
      prefix: --ont
  - id: panel
    type:
      - 'null'
      - string
    doc: Name of panel to use. Ignored if species is 'custom'. Run `mykrobe 
      panels describe` to see list of options
    inputBinding:
      position: 101
      prefix: --panel
  - id: panels_dir
    type:
      - 'null'
      - Directory
    doc: Name of directory that contains panel data
    inputBinding:
      position: 101
      prefix: --panels_dir
  - id: ploidy
    type:
      - 'null'
      - string
    doc: Use a diploid (includes 0/1 calls) or haploid genotyping model
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only output warnings/errors to stderr
    inputBinding:
      position: 101
      prefix: --quiet
  - id: report_all_calls
    type:
      - 'null'
      - boolean
    doc: Report all calls
    inputBinding:
      position: 101
      prefix: --report_all_calls
  - id: sample
    type: string
    doc: Sample identifier
    inputBinding:
      position: 101
      prefix: --sample
  - id: seq
    type:
      - 'null'
      - type: array
        items: File
    doc: Sequence files (fasta,fastq,bam)
    inputBinding:
      position: 101
      prefix: --seq
  - id: skeleton_dir
    type:
      - 'null'
      - Directory
    doc: Directory for skeleton binaries
    inputBinding:
      position: 101
      prefix: --skeleton_dir
  - id: species
    type: string
    doc: Species name, or 'custom' to use custom data, in which case 
      --custom_probe_set_path is required. Run `mykrobe panels describe` to see 
      list of options
    inputBinding:
      position: 101
      prefix: --species
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp
    type:
      - 'null'
      - Directory
    doc: Directory to write temporary files to
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: dump_species_covgs
    type:
      - 'null'
      - File
    doc: Dump species probes coverage information to a JSON file
    outputBinding:
      glob: $(inputs.dump_species_covgs)
  - id: output
    type:
      - 'null'
      - File
    doc: File path to save output file as. Default is to stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mykrobe:0.13.0--py38h59a8061_3
