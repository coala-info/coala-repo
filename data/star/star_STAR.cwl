cwlVersion: v1.2
class: CommandLineTool
baseCommand: STAR
label: star_STAR
doc: Spliced Transcripts Alignment to a Reference
inputs:
  - id: parameters_files
    type:
      - 'null'
      - File
    doc: name of a user-defined parameters file
    inputBinding:
      position: 101
      prefix: --parametersFiles
  - id: sys_shell
    type:
      - 'null'
      - string
    doc: path to the shell binary, preferably bash
    inputBinding:
      position: 101
      prefix: --sysShell
  - id: run_mode
    type:
      - 'null'
      - string
    doc: 'type of the run: alignReads, genomeGenerate, inputAlignmentsFromBAM, liftOver'
    inputBinding:
      position: 101
      prefix: --runMode
  - id: run_thread_n
    type:
      - 'null'
      - int
    doc: number of threads to run STAR
    inputBinding:
      position: 101
      prefix: --runThreadN
  - id: genome_dir
    type: Directory
    doc: path to the directory where genome files are stored or will be 
      generated
    inputBinding:
      position: 101
      prefix: --genomeDir
  - id: genome_load
    type:
      - 'null'
      - string
    doc: mode of shared memory usage for the genome files
    inputBinding:
      position: 101
      prefix: --genomeLoad
  - id: genome_fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: path(s) to the fasta files with the genome sequences
    inputBinding:
      position: 101
      prefix: --genomeFastaFiles
  - id: sjdb_file_chr_start_end
    type:
      - 'null'
      - type: array
        items: File
    doc: path to the files with genomic coordinates for the splice junction 
      introns
    inputBinding:
      position: 101
      prefix: --sjdbFileChrStartEnd
  - id: sjdb_gtf_file
    type:
      - 'null'
      - File
    doc: path to the GTF file with annotations
    inputBinding:
      position: 101
      prefix: --sjdbGTFfile
  - id: sjdb_overhang
    type:
      - 'null'
      - int
    doc: length of the donor/acceptor sequence on each side of the junctions
    inputBinding:
      position: 101
      prefix: --sjdbOverhang
  - id: input_bam_file
    type:
      - 'null'
      - File
    doc: path to BAM input file
    inputBinding:
      position: 101
      prefix: --inputBAMfile
  - id: read_files_in
    type:
      - 'null'
      - type: array
        items: File
    doc: paths to files that contain input read1 (and, if needed, read2)
    inputBinding:
      position: 101
      prefix: --readFilesIn
  - id: read_files_command
    type:
      - 'null'
      - type: array
        items: string
    doc: command line to execute for each of the input file (e.g. zcat)
    inputBinding:
      position: 101
      prefix: --readFilesCommand
  - id: out_file_name_prefix
    type:
      - 'null'
      - string
    doc: output files name prefix (including full or relative path)
    inputBinding:
      position: 101
      prefix: --outFileNamePrefix
  - id: out_sam_type
    type:
      - 'null'
      - type: array
        items: string
    doc: type of SAM/BAM output (BAM/SAM/None and Unsorted/SortedByCoordinate)
    inputBinding:
      position: 101
      prefix: --outSAMtype
  - id: out_sam_attributes
    type:
      - 'null'
      - string
    doc: a string of desired SAM attributes
    inputBinding:
      position: 101
      prefix: --outSAMattributes
  - id: out_filter_multimap_n_max
    type:
      - 'null'
      - int
    doc: maximum number of loci the read is allowed to map to
    inputBinding:
      position: 101
      prefix: --outFilterMultimapNmax
  - id: out_filter_mismatch_n_max
    type:
      - 'null'
      - int
    doc: alignment will be output only if it has no more mismatches than this 
      value
    inputBinding:
      position: 101
      prefix: --outFilterMismatchNmax
  - id: align_intron_max
    type:
      - 'null'
      - int
    doc: maximum intron size
    inputBinding:
      position: 101
      prefix: --alignIntronMax
  - id: quant_mode
    type:
      - 'null'
      - type: array
        items: string
    doc: types of quantification requested (TranscriptomeSAM, GeneCounts)
    inputBinding:
      position: 101
      prefix: --quantMode
  - id: twopass_mode
    type:
      - 'null'
      - string
    doc: 2-pass mapping mode (None, Basic)
    inputBinding:
      position: 101
      prefix: --twopassMode
  - id: solo_type
    type:
      - 'null'
      - type: array
        items: string
    doc: type of single-cell RNA-seq
    inputBinding:
      position: 101
      prefix: --soloType
  - id: solo_cb_whitelist
    type:
      - 'null'
      - File
    doc: file with whitelist of cell barcodes
    inputBinding:
      position: 101
      prefix: --soloCBwhitelist
outputs:
  - id: output_out_file_name_prefix
    type:
      - 'null'
      - File
    doc: output files name prefix (including full or relative path)
    outputBinding:
      glob: $(inputs.out_file_name_prefix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/star:2.7.0b--0
s:url: https://github.com/alexdobin/STAR
$namespaces:
  s: https://schema.org/
