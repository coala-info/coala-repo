cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pepsirf
  - demux
label: pepsirf_demux
doc: "Peptide-based Serological Immune Response Framework demultiplexing module. This
  module takes parameters and outputs counts for each reference sequence (i.e. probe/peptide)
  for each sample.\n\nTool homepage: https://github.com/LadnerLab/PepSIRF"
inputs:
  - id: concatemer
    type:
      - 'null'
      - string
    doc: Concatenated adapter/primer sequences (optional).
    inputBinding:
      position: 101
      prefix: --concatemer
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Include this to output sample-level fastq files.
    inputBinding:
      position: 101
      prefix: --fastq_output
  - id: fif
    type:
      - 'null'
      - File
    doc: Flexible index file provided as an alternative to --index1 and 
      --index2.
    inputBinding:
      position: 101
      prefix: --fif
  - id: include_toggle
    type:
      - 'null'
      - int
    doc: The position toggling for the indexes (1 for true, 0 for false).
    inputBinding:
      position: 101
      prefix: --include_toggle
  - id: index
    type:
      - 'null'
      - File
    doc: Fasta-formatted file containing forward and (potentially) reverse index
      sequences.
    inputBinding:
      position: 101
      prefix: --index
  - id: index1
    type:
      - 'null'
      - string
    doc: Positional information for index1 (start, length, mismatches). E.g., 
      '12,12,1'.
    inputBinding:
      position: 101
      prefix: --index1
  - id: index2
    type:
      - 'null'
      - string
    doc: Positional information for index2 (start, length, mismatches).
    inputBinding:
      position: 101
      prefix: --index2
  - id: input_r1
    type: File
    doc: Fastq-formatted file containing reads with DNA tags. Can be 
      uncompressed or gzipped if Zlib support is enabled.
    inputBinding:
      position: 101
      prefix: --input_r1
  - id: input_r2
    type:
      - 'null'
      - File
    doc: Optional index-only fastq file. If not supplied, only 'index1' will be 
      used to identify samples.
    inputBinding:
      position: 101
      prefix: --input_r2
  - id: library
    type:
      - 'null'
      - File
    doc: Fasta-formatted file containing reference DNA tags. If not included, 
      reference-independent demultiplexing is performed.
    inputBinding:
      position: 101
      prefix: --library
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for analyses.
    inputBinding:
      position: 101
      prefix: --num_threads
  - id: phred_base
    type:
      - 'null'
      - int
    doc: Phred base to use when parsing fastq quality scores (33 or 64).
    inputBinding:
      position: 101
      prefix: --phred_base
  - id: phred_min_score
    type:
      - 'null'
      - int
    doc: The minimum average phred-scaled quality score for the DNA tag portion 
      of a read.
    inputBinding:
      position: 101
      prefix: --phred_min_score
  - id: read_per_loop
    type:
      - 'null'
      - int
    doc: The number of fastq records read at a time.
    inputBinding:
      position: 101
      prefix: --read_per_loop
  - id: samplelist
    type:
      - 'null'
      - File
    doc: A tab-delimited list of samples with a header row and one sample per 
      line.
    inputBinding:
      position: 101
      prefix: --samplelist
  - id: seq
    type:
      - 'null'
      - string
    doc: Positional information for the DNA tags (start, length, mismatches).
    inputBinding:
      position: 101
      prefix: --seq
  - id: sindex
    type:
      - 'null'
      - string
    doc: Header for the index 1 and additional optional index column names in 
      the samplelist.
    inputBinding:
      position: 101
      prefix: --sindex
  - id: sname
    type:
      - 'null'
      - string
    doc: Header for the sample name column in the samplelist.
    inputBinding:
      position: 101
      prefix: --sname
  - id: translate_aggregates
    type:
      - 'null'
      - boolean
    doc: Include this flag to use translation-based aggregation.
    inputBinding:
      position: 101
      prefix: --translate_aggregates
  - id: aa_counts_path
    type:
      - 'null'
      - string
    doc: Name for an output file that will contain aggregated aa-level counts. 
      This is relevant when peptides from a designed library have multiple 
      different nt-level encodings. If this option is included without the 
      '--translate_aggregates' flag, names of sequences in the file supplied by 
      the "--library flag" MUST be of the form ID-NUM, where ID can contain any 
      characters except '-', and NUM represents the id of this encoding. ID and 
      NUM MUST be separated by a single dash '-' character. For example, suppose
      we have TG1_1-1 and TG1_1-2 in our library, which says that we generated 
      two encodings for the TG1_1 peptide. The "--aa_counts" file will have a 
      single TG1_1 entry, with per sample counts that are the sum of the counts 
      from TG1_1-1 and TG1_1-2.
    inputBinding:
      position: 102
      prefix: --aa_counts
  - id: diagnostic_info_path
    type:
      - 'null'
      - string
    doc: 'Include this flag with an output file name to collect diagnostic information
      on read pair matches in map. The file will be formatted with tab delimited lines
      "samplename  # index pair matches  # matches to any variable region".'
    inputBinding:
      position: 103
      prefix: --diagnostic_info
  - id: logfile_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --logfile
  - id: output_path
    type:
      - 'null'
      - string
    doc: Name for the output counts file. This output file will be tab-delimited
      and will contain a header row. The first column will contain probe/peptide
      names. Each subsequent column will contain probe/peptide counts for a 
      sample, with one column per sample.
    inputBinding:
      position: 105
      prefix: --output
  - id: replicate_info_path
    type:
      - 'null'
      - string
    doc: 'Include this flag with an output file name to provide a more thorough summary
      of replicates in the sample list in an output file. The information will be
      tab-delimited with two headers: "Sample Name" and "Number of Replicates".'
    inputBinding:
      position: 106
      prefix: --replicate_info
  - id: trunc_info_output_path
    type:
      - 'null'
      - string
    doc: Name of directory to output truncated sequence information. This will 
      include outputs for unqiue sequences, non-unqiue sequences, and the new 
      fasta-formatted file.
    inputBinding:
      position: 107
      prefix: --trunc_info_output
  - id: unmapped_reads_output_path
    type:
      - 'null'
      - string
    doc: Include this flag with a .fastq output file name to create a single 
      output fastq file containing all of the reads that have not been mapped to
      a sample/peptide (i.e., all of those thatwould not be included in any of 
      the files created by the -q option).
    inputBinding:
      position: 108
      prefix: --unmapped_reads_output
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Name for the output counts file (tab-delimited).
    outputBinding:
      glob: $(inputs.output_path)
  - id: aa_counts
    type:
      - 'null'
      - File
    doc: Name for an output file that will contain aggregated aa-level counts.
    outputBinding:
      glob: $(inputs.aa_counts_path)
  - id: diagnostic_info
    type:
      - 'null'
      - File
    doc: Include this flag with an output file name to collect diagnostic 
      information on read pair matches.
    outputBinding:
      glob: $(inputs.diagnostic_info_path)
  - id: logfile
    type:
      - 'null'
      - File
    doc: Designated file to which the module's processes are logged.
    outputBinding:
      glob: $(inputs.logfile_path)
  - id: replicate_info
    type:
      - 'null'
      - File
    doc: Include this flag with an output file name to provide a summary of 
      replicates.
    outputBinding:
      glob: $(inputs.replicate_info_path)
  - id: unmapped_reads_output
    type:
      - 'null'
      - File
    doc: Include this flag with a .fastq output file name to create a file 
      containing unmapped reads.
    outputBinding:
      glob: $(inputs.unmapped_reads_output_path)
  - id: trunc_info_output
    type:
      - 'null'
      - Directory
    doc: Name of directory to output truncated sequence information.
    outputBinding:
      glob: $(inputs.trunc_info_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pepsirf:1.7.1--h077b44d_0
