cwlVersion: v1.2
class: CommandLineTool
baseCommand: sniffles
label: sniffles
doc: "Sniffles2: A fast structural variant (SV) caller for long-read sequencing data\n\
  \nTool homepage: https://github.com/fritzsedlazeck/Sniffles"
inputs:
  - id: all_contigs
    type:
      - 'null'
      - boolean
    doc: Process all contigs in the input file including small ones.
    inputBinding:
      position: 101
      prefix: --all-contigs
  - id: allow_overwrite
    type:
      - 'null'
      - boolean
    doc: Allow overwriting output files if already existing
    inputBinding:
      position: 101
      prefix: --allow-overwrite
  - id: combine_max_inmemory_results
    type:
      - 'null'
      - int
    doc: Maximum number of .snf input files to keep results in memory for. If 
      the number of input files exceeds this value, --no-sort should be given as
      well to keep the output in a single file. If sorting is requested, the 
      result will be sorted but calls encountered out of order will be written 
      to extra files and NOT be included in the result.
    default: 20
    inputBinding:
      position: 101
      prefix: --combine-max-inmemory-results
  - id: combine_pctseq
    type:
      - 'null'
      - float
    doc: Minimum alignment distance as percent of SV length to be merged. Set to
      0 to disable alignments for merging.
    default: 0.7
    inputBinding:
      position: 101
      prefix: --combine-pctseq
  - id: combine_population
    type:
      - 'null'
      - File
    doc: Name of a population SNF to enable population annotation.
    inputBinding:
      position: 101
      prefix: --combine-population
  - id: contig
    type:
      - 'null'
      - type: array
        items: string
    doc: Only process the specified contigs. May be given more than once.
    inputBinding:
      position: 101
      prefix: --contig
  - id: genotype_vcf
    type:
      - 'null'
      - File
    doc: Input known SVs VCF file for genotyping.
    inputBinding:
      position: 101
      prefix: --genotype-vcf
  - id: input
    type:
      type: array
      items: File
    doc: 'For single-sample calling: A coordinate-sorted and indexed .bam/.cram (BAM/CRAM
      format) file containing aligned reads. - OR - For multi-sample calling: Multiple
      .snf files (generated before by running Sniffles2 for individual samples with
      --snf)'
    inputBinding:
      position: 101
      prefix: --input
  - id: mapq
    type:
      - 'null'
      - int
    doc: Alignments with mapping quality lower than this value will be ignored
    inputBinding:
      position: 101
      prefix: --mapq
  - id: max_del_seq_len
    type:
      - 'null'
      - int
    doc: Maximum deletion sequence length to be output. Deletion SVs longer than
      this value will be written to the output as symbolic SVs.
    default: 50000
    inputBinding:
      position: 101
      prefix: --max-del-seq-len
  - id: minsvlen
    type:
      - 'null'
      - int
    doc: Minimum SV length (in bp)
    default: 50
    inputBinding:
      position: 101
      prefix: --minsvlen
  - id: mosaic
    type:
      - 'null'
      - boolean
    doc: Set Sniffles run mode to detect rare, somatic and mosaic SVs
    inputBinding:
      position: 101
      prefix: --mosaic
  - id: mosaic_af_min
    type:
      - 'null'
      - float
    doc: Minimum allele frequency for mosaic SVs to be output
    default: 0.05
    inputBinding:
      position: 101
      prefix: --mosaic-af-min
  - id: mosaic_include_germline
    type:
      - 'null'
      - boolean
    doc: Report germline SVs as well in mosaic mode
    inputBinding:
      position: 101
      prefix: --mosaic-include-germline
  - id: no_qc
    type:
      - 'null'
      - boolean
    doc: Output all SV candidates, disregarding quality control steps.
    inputBinding:
      position: 101
      prefix: --no-qc
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort output VCF by genomic coordinates (may slightly improve 
      performance)
    inputBinding:
      position: 101
      prefix: --no-sort
  - id: output_rnames
    type:
      - 'null'
      - boolean
    doc: Output names of all supporting reads for each SV in the RNAMEs info 
      field
    inputBinding:
      position: 101
      prefix: --output-rnames
  - id: phase
    type:
      - 'null'
      - boolean
    doc: Determine phase for SV calls (requires the input alignments to be 
      phased)
    inputBinding:
      position: 101
      prefix: --phase
  - id: qc_output_all
    type:
      - 'null'
      - boolean
    doc: Output all SV candidates, disregarding quality control steps.
    inputBinding:
      position: 101
      prefix: --qc-output-all
  - id: reference
    type:
      - 'null'
      - File
    doc: Reference sequence the reads were aligned against. To enable output of 
      deletion SV sequences, this parameter must be set.
    inputBinding:
      position: 101
      prefix: --reference
  - id: regions
    type:
      - 'null'
      - File
    doc: Only process the specified regions.
    inputBinding:
      position: 101
      prefix: --regions
  - id: symbolic
    type:
      - 'null'
      - boolean
    doc: Output all SVs as symbolic, including insertions and deletions, instead
      of reporting nucleotide sequences.
    inputBinding:
      position: 101
      prefix: --symbolic
  - id: tandem_repeats
    type:
      - 'null'
      - File
    doc: Input .bed file containing tandem repeat annotations for the reference 
      genome.
    inputBinding:
      position: 101
      prefix: --tandem-repeats
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads to use (speed-up for multi-core CPUs)
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory where temporary files are written, must exist. If it doesn't,
      default path is used
    inputBinding:
      position: 101
      prefix: --tmp-dir
outputs:
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF output filename to write the called and refined SVs to. If the 
      given filename ends with .gz, the VCF file will be automatically bgzipped 
      and a .tbi index built for it.
    outputBinding:
      glob: $(inputs.vcf)
  - id: snf
    type:
      - 'null'
      - File
    doc: Sniffles2 file (.snf) output filename to store candidates for later 
      multi-sample calling
    outputBinding:
      glob: $(inputs.snf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sniffles:2.7.2--pyhdfd78af_0
