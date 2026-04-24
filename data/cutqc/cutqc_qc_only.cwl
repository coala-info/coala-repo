cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqc
label: cutqc_qc_only
doc: "FastQC reads a set of sequence files and produces from each one a quality control
  report consisting of a number of different modules, each one of which will help
  to identify a different potential type of problem in your data.\n\nTool homepage:
  https://github.com/obenno/cutqc"
inputs:
  - id: seqfile1
    type:
      type: array
      items: File
    doc: Sequence file(s) to process
    inputBinding:
      position: 1
  - id: adapters
    type:
      - 'null'
      - File
    doc: Specifies a non-default file which contains the list of adapter 
      sequences which will be explicity searched against the library. The file 
      must contain sets of named adapters in the form name[tab]sequence. Lines 
      prefixed with a hash will be ignored.
    inputBinding:
      position: 102
      prefix: --adapters
  - id: casava
    type:
      - 'null'
      - boolean
    doc: Files come from raw casava output. Files in the same sample group 
      (differing only by the group number) will be analysed as a set rather than
      individually. Sequences with the filter flag set in the header will be 
      excluded from the analysis. Files must have the same names given to them 
      by casava (including being gzipped and ending with .gz) otherwise they 
      won't be grouped together correctly.
    inputBinding:
      position: 102
      prefix: --casava
  - id: contaminant_file
    type:
      - 'null'
      - File
    doc: Specifies a non-default file which contains the list of contaminants to
      screen overrepresented sequences against. The file must contain sets of 
      named contaminants in the form name[tab]sequence. Lines prefixed with a 
      hash will be ignored.
    inputBinding:
      position: 102
      prefix: --contaminants
  - id: dir
    type:
      - 'null'
      - Directory
    doc: Selects a directory to be used for temporary files written when 
      generating report images. Defaults to system temp directory if not 
      specified.
    inputBinding:
      position: 102
      prefix: --dir
  - id: extract
    type:
      - 'null'
      - boolean
    doc: If set then the zipped output file will be uncompressed in the same 
      directory after it has been created. By default this option will be set if
      fastqc is run in non-interactive mode.
    inputBinding:
      position: 102
      prefix: --extract
  - id: format
    type:
      - 'null'
      - string
    doc: Bypasses the normal sequence file format detection and forces the 
      program to use the specified format. Valid formats are 
      bam,sam,bam_mapped,sam_mapped and fastq
    inputBinding:
      position: 102
      prefix: --format
  - id: java
    type:
      - 'null'
      - string
    doc: Provides the full path to the java binary you want to use to launch 
      fastqc. If not supplied then java is assumed to be in your path.
    inputBinding:
      position: 102
      prefix: --java
  - id: kmers
    type:
      - 'null'
      - int
    doc: Specifies the length of Kmer to look for in the Kmer content module. 
      Specified Kmer length must be between 2 and 10. Default length is 7 if not
      specified.
    inputBinding:
      position: 102
      prefix: --kmers
  - id: limits
    type:
      - 'null'
      - File
    doc: Specifies a non-default file which contains a set of criteria which 
      will be used to determine the warn/error limits for the various modules. 
      This file can also be used to selectively remove some modules from the 
      output all together. The format needs to mirror the default limits.txt 
      file found in the Configuration folder.
    inputBinding:
      position: 102
      prefix: --limits
  - id: min_length
    type:
      - 'null'
      - int
    doc: Sets an artificial lower limit on the length of the sequence to be 
      shown in the report. As long as you set this to a value greater or equal 
      to your longest read length then this will be the sequence length used to 
      create your read groups. This can be useful for making directly 
      comaparable statistics from datasets with somewhat variable read lengths.
    inputBinding:
      position: 102
      prefix: --min_length
  - id: nano
    type:
      - 'null'
      - boolean
    doc: Files come from nanopore sequences and are in fast5 format. In this 
      mode you can pass in directories to process and the program will take in 
      all fast5 files within those directories and produce a single output file 
      from the sequences found in all files.
    inputBinding:
      position: 102
      prefix: --nano
  - id: noextract
    type:
      - 'null'
      - boolean
    doc: Do not uncompress the output file after creating it. You should set 
      this option if you do not wish to uncompress the output when running in 
      non-interactive mode.
    inputBinding:
      position: 102
      prefix: --noextract
  - id: nofilter
    type:
      - 'null'
      - boolean
    doc: If running with --casava then don't remove read flagged by casava as 
      poor quality when performing the QC analysis.
    inputBinding:
      position: 102
      prefix: --nofilter
  - id: nogroup
    type:
      - 'null'
      - boolean
    doc: 'Disable grouping of bases for reads >50bp. All reports will show data for
      every base in the read. WARNING: Using this option will cause fastqc to crash
      and burn if you use it on really long reads, and your plots may end up a ridiculous
      size. You have been warned!'
    inputBinding:
      position: 102
      prefix: --nogroup
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Supress all progress messages on stdout and only report errors.
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Specifies the number of files which can be processed simultaneously. 
      Each thread will be allocated 250MB of memory so you shouldn't run more 
      threads than your available memory will cope with, and not more than 6 
      threads on a 32 bit machine
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Create all output files in the specified output directory. Please note 
      that this directory must exist as the program will not create it. If this 
      option is not set then the output file for each sequence file is created 
      in the same directory as the sequence file which was processed.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cutqc:0.07--hdfd78af_0
