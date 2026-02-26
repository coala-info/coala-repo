cwlVersion: v1.2
class: CommandLineTool
baseCommand: igdtools
label: igdtools
doc: "Process or create IGD files.\n\nTool homepage: https://aprilweilab.github.io/"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: The input file (.vcf, .vcf.gz, or .igd)
    inputBinding:
      position: 1
  - id: alleles
    type:
      - 'null'
      - boolean
    doc: Emit allele frequencies.
    inputBinding:
      position: 102
      prefix: --alleles
  - id: contig
    type:
      - 'null'
      - string
    doc: Only convert the contig with the given name from the input VCF.
    inputBinding:
      position: 102
      prefix: --contig
  - id: contig_require_one
    type:
      - 'null'
      - boolean
    doc: Require the input VCF to contain a single contig, or fail the 
      conversion.
    inputBinding:
      position: 102
      prefix: --contig-require-one
  - id: contig_use_first
    type:
      - 'null'
      - boolean
    doc: Only convert the first contig encountered in the input VCF.
    inputBinding:
      position: 102
      prefix: --contig-use-first
  - id: description
    type:
      - 'null'
      - string
    doc: The description string to include in the IGD output.
    inputBinding:
      position: 102
      prefix: --description
  - id: drop_multi_sites
    type:
      - 'null'
      - boolean
    doc: Drop multi-allelic sites (more than one alternate allele).
    inputBinding:
      position: 102
      prefix: --drop-multi-sites
  - id: drop_non_snv_sites
    type:
      - 'null'
      - boolean
    doc: Drop sites containing alleles that are not single nucleotides.
    inputBinding:
      position: 102
      prefix: --drop-non-snv-sites
  - id: drop_non_snvs
    type:
      - 'null'
      - boolean
    doc: Drop variants containing alleles that are not single nucleotides.
    inputBinding:
      position: 102
      prefix: --drop-non-snvs
  - id: drop_unphased
    type:
      - 'null'
      - boolean
    doc: Drop sites containing unphased data.
    inputBinding:
      position: 102
      prefix: --drop-unphased
  - id: emit_individuals
    type:
      - 'null'
      - boolean
    doc: Emit the mapping from individual index to ID.
    inputBinding:
      position: 102
      prefix: --individuals
  - id: emit_variants
    type:
      - 'null'
      - boolean
    doc: Emit the mapping from variant index to ID.
    inputBinding:
      position: 102
      prefix: --variants
  - id: export_metadata_file
    type:
      - 'null'
      - File
    doc: 'Export the metadata from the given .vcf[.gz] file to the given filename.
      The output format is a text file in the format that can be loaded via numpy.loadtxt(),
      where the first line is a comment containing information about the metadata.
      This option takes a list of metadata to export, which can be: all, chrom, qual,
      filter, info'
    inputBinding:
      position: 102
      prefix: --export-metadata
  - id: force_ploidy
    type:
      - 'null'
      - string
    doc: IGD files have a single ploidy, but you can use this to force all 
      variants/individuals to have the same ploidy.
    inputBinding:
      position: 102
      prefix: --force-ploidy
  - id: force_unphased
    type:
      - 'null'
      - boolean
    doc: Force output file to be unphased, regardless of input.
    inputBinding:
      position: 102
      prefix: --force-unphased
  - id: frequency_range
    type:
      - 'null'
      - string
    doc: Restrict to variants with frequency in the range (inclusive, 
      exclusive).
    inputBinding:
      position: 102
      prefix: --frange
  - id: info
    type:
      - 'null'
      - boolean
    doc: Display information from the IGD header.
    inputBinding:
      position: 102
      prefix: --info
  - id: jobs
    type:
      - 'null'
      - int
    doc: How many jobs (threads) to use. Only VCF->IGD conversion supports this 
      currently
    inputBinding:
      position: 102
      prefix: --jobs
  - id: keep_samples_file
    type:
      - 'null'
      - File
    doc: Keep samples listed in the given text file.
    inputBinding:
      position: 102
      prefix: --samples
  - id: lists
    type:
      - 'null'
      - boolean
    doc: Emit sample lists.
    inputBinding:
      position: 102
      prefix: --lists
  - id: merge_with
    type:
      - 'null'
      - type: array
        items: File
    doc: Merge the input IGD file with all of these specified IGD files.
    inputBinding:
      position: 102
      prefix: --merge
  - id: no_variant_ids
    type:
      - 'null'
      - boolean
    doc: Do not emit IDs for variants in the resulting IGD file.
    inputBinding:
      position: 102
      prefix: --no-var-ids
  - id: range
    type:
      - 'null'
      - string
    doc: Restrict to the given base-pair range (inclusive).
    inputBinding:
      position: 102
      prefix: --range
  - id: stats
    type:
      - 'null'
      - boolean
    doc: Emit some simple statistics about the distribution of samples, sites, 
      and variants.
    inputBinding:
      position: 102
      prefix: --stats
  - id: trim_samples
    type:
      - 'null'
      - int
    doc: Trim samples to this many individuals.
    inputBinding:
      position: 102
      prefix: --trim
  - id: update_indiv_ids_file
    type:
      - 'null'
      - File
    doc: Given a text file with an individual ID per line, set the IDs in the 
      output IGD file to match them
    inputBinding:
      position: 102
      prefix: --update-indiv-ids
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file to produce.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdtools:2.6--py312h5e9d817_0
