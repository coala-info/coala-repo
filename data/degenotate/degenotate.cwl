cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - degenotate.py
label: degenotate
doc: "degenotate: Annotation of codon degeneracy for coding sequences\n\nTool homepage: https://github.com/harvardinformatics/degenotate"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: "A gff or gtf file that contains the coordinates of transcripts in the provided genome file (-g). Only one of -a/-g OR -s is REQUIRED."
    inputBinding:
      position: 101
      prefix: -a
  - id: genome_file
    type:
      - 'null'
      - File
    doc: "A FASTA file containing a genome. -a must also be specified. Only one of -a/-g OR -s is REQUIRED."
    inputBinding:
      position: 101
      prefix: -g
  - id: in_seq
    type:
      - 'null'
      - File
    doc: "A single file containing multiple in-frame coding sequences on which to calculate degeneracy. Only one of -a/-g OR -s is REQUIRED."
    inputBinding:
      position: 101
      prefix: -s
  - id: in_seq_dir
    type:
      - 'null'
      - Directory
    doc: "A directory containing individual, in-frame coding sequence files on which to calculate degeneracy."
    inputBinding:
      position: 101
      prefix: -s
  - id: vcf_file
    type:
      - 'null'
      - File
    doc: "Optional VCF file with in and outgroups to output polymorphic and fixed differences for MK tests. The VCF should contain SNPs only (no indels or structural variants)."
    secondaryFiles:
      - .tbi
    inputBinding:
      position: 101
      prefix: -v
  - id: vcf_outgroups
    type:
      - 'null'
      - string
    doc: "A comma separated list of sample IDs in the VCF file that make up the outgroup (e.g. 'sample1,sample2')."
    inputBinding:
      position: 101
      prefix: -u
  - id: vcf_outgroups_file
    type:
      - 'null'
      - File
    doc: "A file with one outgroup sample ID per line."
    inputBinding:
      position: 101
      prefix: -u
  - id: vcf_exclude
    type:
      - 'null'
      - string
    doc: "A comma separated list of sample IDs in the VCF file to exclude (e.g. 'sample1,sample2')."
    inputBinding:
      position: 101
      prefix: -e
  - id: vcf_exclude_file
    type:
      - 'null'
      - File
    doc: "A file with one sample ID to exclude per line."
    inputBinding:
      position: 101
      prefix: -e
  - id: out_dest
    type: string
    doc: "Desired output directory. This will be created for you if it doesn't exist."
    inputBinding:
      position: 101
      prefix: -o
  - id: sfs
    type:
      - 'null'
      - boolean
    doc: "Set this to output raw allele frequencies in the mk table)"
    inputBinding:
      position: 101
      prefix: -sfs
  - id: seq_delim
    type:
      - 'null'
      - string
    doc: "degenotate assumes the chromosome IDs in the GFF file exactly match the sequence headers in the FASTA file. If this is not the case, use this to specify a character at which the FASTA headers will be trimmed."
    inputBinding:
      position: 101
      prefix: -d
  - id: write_cds
    type:
      - 'null'
      - string
    doc: "Extract CDS sequences from the genome, write them to this file and exit. Equivalent to '-x 0234' except this stops the program before calculating degeneracy."
    inputBinding:
      position: 101
      prefix: -c
  - id: write_cds_aa
    type:
      - 'null'
      - string
    doc: "The same as -c, but writes translated amino acid sequences instead."
    inputBinding:
      position: 101
      prefix: -ca
  - id: write_longest
    type:
      - 'null'
      - string
    doc: "Extract CDS sequences from the longest transcript for each gene, write them to this file and exit."
    inputBinding:
      position: 101
      prefix: -l
  - id: write_longest_aa
    type:
      - 'null'
      - string
    doc: "The same as -l, but writes translated amino acid sequences instead."
    inputBinding:
      position: 101
      prefix: -la
  - id: extract_seq
    type:
      - 'null'
      - string
    doc: "Extract sites of a certain degeneracy. For instance, to extract 4-fold degenerate sites enter '4'. To extract 2- and 4-fold degenerate sites enter '24' and so on."
    inputBinding:
      position: 101
      prefix: -x
  - id: min_length
    type:
      - 'null'
      - int
    doc: "The minimum length of a transcript for it to be counted. Default (and global min): 3"
    inputBinding:
      position: 101
      prefix: -m
  - id: maf_cutoff
    type:
      - 'null'
      - float
    doc: "The minor allele frequency cutoff for MK tests. Sites where alternate alleles in the ingroup are below this frequency will be excluded. Default: 1 / 2N, where N is the number of ingroup samples"
    inputBinding:
      position: 101
      prefix: -maf
  - id: imp_cutoff
    type:
      - 'null'
      - float
    doc: "The minor allele frequency cutoff that distinguishes low and high allele frequencies for imputed MK test. Only used if provided VCF is polarized. Default: 0.15"
    inputBinding:
      position: 101
      prefix: -imp
  - id: no_fixed_in
    type:
      - 'null'
      - boolean
    doc: "Set this if you wish to exclude sites from the MK test in which all ingroup samples share the same alternate allele (only the reference differs)."
    inputBinding:
      position: 101
      prefix: --no-fixed-in
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: "Set this to overwrite existing files."
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: appendlog
    type:
      - 'null'
      - boolean
    doc: "Set this to keep the old log file even if --overwrite is specified. New log information will instead be appended to the previous log file."
    inputBinding:
      position: 101
      prefix: --appendlog
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Set this flag to prevent degenotate from reporting detailed information about each step."
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory (degeneracy-all-sites.bed, transcript counts, MK table, log)
    outputBinding:
      glob: $(inputs.out_dest)
  - id: extracted_sequences
    type: File[]
    doc: Sequence files written with -c, -ca, -l, -la or -x
    outputBinding:
      glob: |-
        ${
          var g = [];
          [inputs.write_cds, inputs.write_cds_aa, inputs.write_longest, inputs.write_longest_aa].forEach(function(f) { if (f) { g.push(f); } });
          return g;
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/degenotate:1.3--pyhdfd78af_0
