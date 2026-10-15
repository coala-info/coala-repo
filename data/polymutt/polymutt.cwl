cwlVersion: v1.2
class: CommandLineTool
baseCommand: polymutt
label: polymutt
doc: "Polymutt is a tool for genotype likelihood calculation and variant calling.
  It calls variants and de novo mutations in families from GLF files or from a VCF
  file with PL or GL fields. The index file (-g) and the pedigree files name other
  files: give the GLF files in glf_files so that they are staged in the working directory.\n\nTool
  homepage: https://genome.sph.umich.edu/wiki/Polymutt"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.glf_files) { l = l.concat(inputs.glf_files); }
        return l;
      }
inputs:
  - id: glf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: GLF files named in the GLF index file (staged in the working directory)
  - id: pedfile
    type:
      - 'null'
      - File
    doc: 'Pedigree file (merlin format) describing the sample relationships'
    inputBinding:
      position: 101
      prefix: -p
  - id: datfile
    type:
      - 'null'
      - File
    doc: 'Data file; its GLF_Index column is the sixth column of the pedigree file'
    inputBinding:
      position: 101
      prefix: -d
  - id: glf_index_file
    type:
      - 'null'
      - File
    doc: 'GLF index file: maps the indices in the pedigree file to GLF file names'
    inputBinding:
      position: 101
      prefix: -g
  - id: posterior_cutoff
    type:
      - 'null'
      - float
    doc: 'Minimum cutoff of posterior probability to output a variant (default 0.5)'
    inputBinding:
      position: 101
      prefix: -c
  - id: in_vcf
    type:
      - 'null'
      - File
    doc: 'Alternative input VCF file with PL or GL fields (used instead of -g)'
    inputBinding:
      position: 101
      prefix: --in_vcf
  - id: mixed_vcf_records
    type:
      - 'null'
      - boolean
    doc: 'Handle input VCF files that mix records with different FORMAT fields'
    inputBinding:
      position: 101
      prefix: --mixed_vcf_records
  - id: theta
    type:
      - 'null'
      - float
    doc: 'Scaled mutation rate per site for single nucleotide variants (default 0.001)'
    inputBinding:
      position: 101
      prefix: --theta
  - id: indel_theta
    type:
      - 'null'
      - float
    doc: 'Scaled mutation rate per site for indels (default 0.0001)'
    inputBinding:
      position: 101
      prefix: --indel_theta
  - id: poly_tstv
    type:
      - 'null'
      - float
    doc: 'Prior of ts/tv ratio (default 2.0)'
    inputBinding:
      position: 101
      prefix: --poly_tstv
  - id: chrX
    type:
      - 'null'
      - string
    doc: 'Label of chromosome X (default X)'
    inputBinding:
      position: 101
      prefix: --chrX
  - id: chrY
    type:
      - 'null'
      - string
    doc: 'Label of chromosome Y (default Y)'
    inputBinding:
      position: 101
      prefix: --chrY
  - id: MT
    type:
      - 'null'
      - string
    doc: 'Label of the mitochondrial chromosome (default MT)'
    inputBinding:
      position: 101
      prefix: --MT
  - id: denovo
    type:
      - 'null'
      - boolean
    doc: 'Turn on de novo mutation detection (GLF input only)'
    inputBinding:
      position: 101
      prefix: --denovo
  - id: rate_denovo
    type:
      - 'null'
      - float
    doc: 'Mutation rate per haplotype per generation (default 1.5e-08)'
    inputBinding:
      position: 101
      prefix: --rate_denovo
  - id: tstv_denovo
    type:
      - 'null'
      - float
    doc: 'Prior ts/tv ratio of de novo mutations (default 2.0)'
    inputBinding:
      position: 101
      prefix: --tstv_denovo
  - id: minLLR_denovo
    type:
      - 'null'
      - float
    doc: 'Minimum log10 likelihood ratio of allowing versus disallowing de novo mutations to output'
    inputBinding:
      position: 101
      prefix: --minLLR_denovo
  - id: prec
    type:
      - 'null'
      - float
    doc: 'Optimization precision (default 1.0e-04)'
    inputBinding:
      position: 101
      prefix: --prec
  - id: nthreads
    type:
      - 'null'
      - int
    doc: 'Number of threads (default 1)'
    inputBinding:
      position: 101
      prefix: --nthreads
  - id: minMapQuality
    type:
      - 'null'
      - int
    doc: 'Filter: minimum mapping quality'
    inputBinding:
      position: 101
      prefix: --minMapQuality
  - id: minDepth
    type:
      - 'null'
      - int
    doc: 'Filter: minimum total depth'
    inputBinding:
      position: 101
      prefix: --minDepth
  - id: maxDepth
    type:
      - 'null'
      - int
    doc: 'Filter: maximum total depth'
    inputBinding:
      position: 101
      prefix: --maxDepth
  - id: minPercSampleWithData
    type:
      - 'null'
      - float
    doc: 'Filter: minimum percentage of samples with data (default 0.00)'
    inputBinding:
      position: 101
      prefix: --minPercSampleWithData
  - id: pos
    type:
      - 'null'
      - File
    doc: 'File with two columns (chr pos): output genotypes of all individuals at these sites, even if monomorphic'
    inputBinding:
      position: 101
      prefix: --pos
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: 'Output all sites with at least one read coverage'
    inputBinding:
      position: 101
      prefix: --all_sites
  - id: gl_off
    type:
      - 'null'
      - boolean
    doc: 'Do not output genotype likelihood values for each individual'
    inputBinding:
      position: 101
      prefix: --gl_off
  - id: quick_call
    type:
      - 'null'
      - boolean
    doc: 'Call variants assuming all individuals are unrelated first, then run the family-aware calling at variant sites'
    inputBinding:
      position: 101
      prefix: --quick_call
  - id: ext
    type:
      - 'null'
      - boolean
    doc: 'Extended output'
    inputBinding:
      position: 101
      prefix: --ext
  - id: out_vcf
    type:
      - 'null'
      - string
    doc: 'Output VCF file name'
    inputBinding:
      position: 102
      prefix: --out_vcf
outputs:
  - id: stdout
    type: stdout
    doc: Variant calling statistics
  - id: output_vcf
    type:
      - 'null'
      - File
    doc: Output VCF file
    outputBinding:
      glob: $(inputs.out_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polymutt:0.18--0
stdout: polymutt.out
