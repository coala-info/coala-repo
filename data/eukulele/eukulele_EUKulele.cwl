cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukulele
label: eukulele_EUKulele
doc: "EUKulele is a standalone taxonomic annotation software designed primarily for
  marine microbial eukaryotes.\n\nTool homepage: https://github.com/AlexanderLabWHOI/EUKulele"
inputs:
  - id: subroutine
    type: string
    doc: Choice of subroutine to run.
    inputBinding:
      position: 1
  - id: alignment_choice
    type:
      - 'null'
      - string
    doc: Choice of alignment tool (diamond or blast).
    inputBinding:
      position: 102
      prefix: --alignment_choice
  - id: busco_file
    type:
      - 'null'
      - File
    doc: If specified, the following two arguments ('--organisms' and 
      '--taxonomy_organisms' are overwritten by the two columns of this 
      tab-separated file.
    inputBinding:
      position: 102
      prefix: --busco_file
  - id: busco_threshold
    type:
      - 'null'
      - float
    doc: BUSCO threshold.
    inputBinding:
      position: 102
      prefix: --busco_threshold
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file.
    inputBinding:
      position: 102
      prefix: --config_file
  - id: consensus_cutoff
    type:
      - 'null'
      - float
    doc: Consensus cutoff.
    inputBinding:
      position: 102
      prefix: --consensus_cutoff
  - id: consensus_proportion
    type:
      - 'null'
      - float
    doc: Consensus proportion.
    inputBinding:
      position: 102
      prefix: --consensus_proportion
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use.
    inputBinding:
      position: 102
      prefix: --CPUs
  - id: create_euk_fasta
    type:
      - 'null'
      - boolean
    doc: Whether to create FASTA files containing sequences identified to be 
      eukaryotic.
    inputBinding:
      position: 102
      prefix: --create_euk_fasta
  - id: create_fasta
    type:
      - 'null'
      - boolean
    doc: Whether to create FASTA files containing ID'd transcripts during BUSCO 
      analysis.
    inputBinding:
      position: 102
      prefix: --create_fasta
  - id: cutoff_file
    type:
      - 'null'
      - File
    doc: Cutoff file.
    inputBinding:
      position: 102
      prefix: --cutoff_file
  - id: database
    type:
      - 'null'
      - string
    doc: The name of the database to be used to assess the reads.
    inputBinding:
      position: 102
      prefix: --database
  - id: filter_metric
    type:
      - 'null'
      - string
    doc: Metric to filter by (pid, evalue, bitscore).
    inputBinding:
      position: 102
      prefix: --filter_metric
  - id: force_rerun
    type:
      - 'null'
      - boolean
    doc: Force rerun of the analysis.
    inputBinding:
      position: 102
      prefix: --force_rerun
  - id: individual
    type:
      - 'null'
      - boolean
    doc: Run individual analysis.
    inputBinding:
      position: 102
      prefix: --individual
  - id: individual_or_summary
    type:
      - 'null'
      - string
    doc: Whether to run summary or individual analysis.
    inputBinding:
      position: 102
      prefix: --individual_or_summary
  - id: mets_or_mags
    type: string
    doc: Type of dataset (METs or MAGs).
    inputBinding:
      position: 102
      prefix: --mets_or_mags
  - id: names_to_reads
    type:
      - 'null'
      - File
    doc: A file to be created or used if it exists that relates transcript names
      to salmon counts from the salmon directory.
    inputBinding:
      position: 102
      prefix: --names_to_reads
  - id: no_busco
    type:
      - 'null'
      - boolean
    doc: When true, BUSCO steps are not run.
    inputBinding:
      position: 102
      prefix: --no_busco
  - id: nucleotide_extension
    type:
      - 'null'
      - string
    doc: Nucleotide extension.
    inputBinding:
      position: 102
      prefix: --nucleotide_extension
  - id: organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: List of organisms to check BUSCO completeness on.
    inputBinding:
      position: 102
      prefix: --organisms
  - id: perc_mem
    type:
      - 'null'
      - float
    doc: The percentage of the total available memory which should be targeted 
      for use by processes.
    inputBinding:
      position: 102
      prefix: --perc_mem
  - id: protein_extension
    type:
      - 'null'
      - string
    doc: Protein extension.
    inputBinding:
      position: 102
      prefix: --protein_extension
  - id: protein_map
    type:
      - 'null'
      - File
    doc: Protein map file.
    inputBinding:
      position: 102
      prefix: --protein_map
  - id: proteins_or_nt
    type:
      - 'null'
      - string
    doc: Whether input is proteins or nucleotides.
    inputBinding:
      position: 102
      prefix: --proteins_or_nt
  - id: ref_fasta
    type:
      - 'null'
      - File
    doc: Either a file in the reference directory where the fasta file for the 
      database is located, or a directory containing multiple fasta files that 
      constitute the database.
    inputBinding:
      position: 102
      prefix: --ref_fasta
  - id: reference_dir
    type: Directory
    doc: Folder containing the reference files for the chosen database.
    inputBinding:
      position: 102
      prefix: --reference_dir
  - id: run_transdecoder
    type:
      - 'null'
      - boolean
    doc: Whether TransDecoder should be run on metatranscriptomic samples.
    inputBinding:
      position: 102
      prefix: --run_transdecoder
  - id: salmon_dir
    type:
      - 'null'
      - Directory
    doc: Salmon directory is required if use_salmon_counts is true.
    inputBinding:
      position: 102
      prefix: --salmon_dir
  - id: sample_dir
    type: Directory
    doc: Folder where the input data is located (the protein or peptide files to
      be assessed).
    inputBinding:
      position: 102
      prefix: --sample_dir
  - id: scratch
    type:
      - 'null'
      - Directory
    doc: The scratch location to store intermediate files.
    inputBinding:
      position: 102
      prefix: --scratch
  - id: tax_table
    type:
      - 'null'
      - File
    doc: Taxonomy table file.
    inputBinding:
      position: 102
      prefix: --tax_table
  - id: taxonomy_organisms
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxonomic level of organisms specified in organisms tag.
    inputBinding:
      position: 102
      prefix: --taxonomy_organisms
  - id: test
    type:
      - 'null'
      - boolean
    doc: Whether we're just running a test and should not execute downloads.
    inputBinding:
      position: 102
      prefix: --test
  - id: transdecoder_orfsize
    type:
      - 'null'
      - int
    doc: TransDecoder ORF size.
    inputBinding:
      position: 102
      prefix: --transdecoder_orfsize
  - id: use_salmon_counts
    type:
      - 'null'
      - boolean
    doc: Whether to use salmon counts.
    inputBinding:
      position: 102
      prefix: --use_salmon_counts
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Folder where the output will be written.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukulele:2.1.2--pyhdfd78af_0
