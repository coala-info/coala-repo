cwlVersion: v1.2
class: CommandLineTool
baseCommand: ViReMa.py
label: virema_ViReMa.py
doc: "ViReMa Version 0.6 - written by Andrew Routh\n\nTool homepage: https://sourceforge.net/projects/virema/"
inputs:
  - id: virus_index
    type: string
    doc: Virus genome reference index key. e.g. FHV_Genome
    inputBinding:
      position: 1
  - id: input_data
    type: File
    doc: File containing single reads in FASTQ format
    inputBinding:
      position: 2
  - id: output_data
    type: string
    doc: Destination file for results
    inputBinding:
      position: 3
  - id: aligner
    type:
      - 'null'
      - string
    doc: "Enter Alignment Software: 'bwa', 'bowtie'."
    default: bowtie
    inputBinding:
      position: 104
      prefix: --Aligner
  - id: bed_output
    type:
      - 'null'
      - boolean
    doc: Output recombination data into BED files.
    inputBinding:
      position: 104
      prefix: -BED
  - id: chunk
    type:
      - 'null'
      - int
    doc: Enter number of reads to process together.
    inputBinding:
      position: 104
      prefix: --Chunk
  - id: compound_handling
    type:
      - 'null'
      - string
    doc: Select this option for compound recombination event mapping (see manual
      for details). Enter number of nucleotides to map (must be less than Seed, 
      and greater than number of nts in MicroInDel). Default is off.
    inputBinding:
      position: 104
      prefix: --Compound_Handling
  - id: dedup
    type:
      - 'null'
      - boolean
    doc: Remove potential PCR duplicates. Default is 'off'.
    inputBinding:
      position: 104
      prefix: -DeDup
  - id: defuzz
    type:
      - 'null'
      - string
    doc: "Choose how to defuzz data: '5' to report at 5' end of fuzzy region, '3'
      to report at 3' end, or '0' to report in centre of fuzzy region. Default is
      no fuzz handling (similar to choosing Right - see Routh et al)."
    inputBinding:
      position: 104
      prefix: --Defuzz
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: Select '-F' if data is in FASTA format fasta. Default is FASTQ.
    inputBinding:
      position: 104
      prefix: -F
  - id: five_pad
    type:
      - 'null'
      - int
    doc: Number of nucleotides not allowed to have mismatches at 5' end of 
      segment.
    default: 5
    inputBinding:
      position: 104
      prefix: --FivePad
  - id: host_index
    type:
      - 'null'
      - string
    doc: Host genome reference index key, e.g. d_melanogaster_fb5_22
    inputBinding:
      position: 104
      prefix: --Host_Index
  - id: host_seed
    type:
      - 'null'
      - int
    doc: Number of nucleotides in the Seed region when mapping to the Host 
      Genome. Default is same as Seed value.
    inputBinding:
      position: 104
      prefix: --Host_Seed
  - id: max_fuzz
    type:
      - 'null'
      - string
    doc: Select maximum allowed length of fuzzy region. Recombination events 
      with longer fuzzy regions will not be reported. Default is Seed Length.
    inputBinding:
      position: 104
      prefix: --MaxFuzz
  - id: micro_indel_length
    type:
      - 'null'
      - int
    doc: Size of MicroInDels - these are common artifacts of cDNA preparation. 
      See Routh et al JMB 2012. Default size is 0)
    default: 0
    inputBinding:
      position: 104
      prefix: --MicroInDel_Length
  - id: n
    type:
      - 'null'
      - int
    doc: Number of mismatches tolerated in mapped seed and in mapped segments.
    default: 1
    inputBinding:
      position: 104
      prefix: --N
  - id: no_compile
    type:
      - 'null'
      - boolean
    doc: Select this option if you do not wish to compile the results file into.
      Maybe useful when combining results from different datasets.
    inputBinding:
      position: 104
      prefix: -No_Compile
  - id: output_tag
    type:
      - 'null'
      - string
    doc: Enter a tag name that will be appended to end of each output file.
    inputBinding:
      position: 104
      prefix: --Output_Tag
  - id: p
    type:
      - 'null'
      - int
    doc: Enter number of available processors.
    default: 1
    inputBinding:
      position: 104
      prefix: --p
  - id: read_names_entry
    type:
      - 'null'
      - boolean
    doc: Append Read Names contributing to each compiled result. Default is off.
    inputBinding:
      position: 104
      prefix: -ReadNamesEntry
  - id: seed
    type:
      - 'null'
      - int
    doc: Number of nucleotides in the Seed region.
    default: 25
    inputBinding:
      position: 104
      prefix: --Seed
  - id: three_pad
    type:
      - 'null'
      - int
    doc: Number of nucleotides not allowed to have mismatches at 3' end of 
      segment.
    default: 5
    inputBinding:
      position: 104
      prefix: --ThreePad
  - id: windows_cygwin
    type:
      - 'null'
      - boolean
    doc: Select this option if running ViReMa from a Windows/Cygwin shell.
    inputBinding:
      position: 104
      prefix: -Win
  - id: x
    type:
      - 'null'
      - int
    doc: Number of nucleotides not allowed to have mismatches at 3' end and 5' 
      of segment. Overrides seperate ThreePad and FivePad settings.
    default: 5
    inputBinding:
      position: 104
      prefix: --X
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Enter a directory name that all compiled output files will be saved in.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virema:0.6--py27_0
