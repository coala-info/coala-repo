cwlVersion: v1.2
class: CommandLineTool
baseCommand: kestrel
label: kestrel
doc: "Kestrel is a variant caller for DNA sequencing data.\n\nTool homepage: https://github.com/paudano/kestrel"
inputs:
  - id: seq_file
    type:
      type: array
      items: File
    doc: Input sequence file.
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: Set the exponential decay alpha, which controls how quickly the 
      recovery threshold declines to its minimum value (see --decaymin) in an 
      active region search. Alpha is defined as the rate of decay for every k 
      bases. At k bases from the left anchor, the threshold will have declined 
      to alpha * range. At every k bases, the threshold will continue to decline
      at this rate.
    default: 0.8
    inputBinding:
      position: 102
      prefix: --alpha
  - id: ambiregions
    type:
      - 'null'
      - boolean
    doc: Allow active regions to cover ambiguous bases, such as N.
    default: true
    inputBinding:
      position: 102
      prefix: --ambiregions
  - id: ambivar
    type:
      - 'null'
      - boolean
    doc: Allow variants over ambiguous bases, such as N.
    default: true
    inputBinding:
      position: 102
      prefix: --ambivar
  - id: anchorboth
    type:
      - 'null'
      - boolean
    doc: Both ends of an active region (region with variants) must be bordered 
      by unaltered k-mers or variants will not be called in it. This option may 
      miss variants near the ends of a reference sequence, but it forces 
      stronger evidence for the variants that are called.
    default: true
    inputBinding:
      position: 102
      prefix: --anchorboth
  - id: autoflank
    type:
      - 'null'
      - boolean
    doc: When extracting intervals from reference sequences, some bases are 
      extracted on both sides of the interval whenever possible. This gives 
      Kestrel more bases for active region detection, but it does not otherwise 
      affect variant calls. This option tells Kestrel to pick the flank by 
      multiplying 3.50 with the k-mer size.
    default: true
    inputBinding:
      position: 102
      prefix: --autoflank
  - id: byreference
    type:
      - 'null'
      - boolean
    doc: If variant call regions were defined, variant call locations are still 
      relative to the reference sequence and not the region.
    default: true
    inputBinding:
      position: 102
      prefix: --byreference
  - id: byregion
    type:
      - 'null'
      - boolean
    doc: If variant call regions were defined, variant call locations are 
      relative to the region and not the reference sequence.
    inputBinding:
      position: 102
      prefix: --byregion
  - id: charset
    type:
      - 'null'
      - string
    doc: Character set encoding of input files. This option specifies the 
      character set of all files following it. The default, "UTF-8", properly 
      handles ASCII files, which is a safe assumption for most files. Latin-1 
      files with values greater than 127 will not be properly parsed.
    default: UTF-8
    inputBinding:
      position: 102
      prefix: --charset
  - id: countrev
    type:
      - 'null'
      - boolean
    doc: Count reverse complement k-mers in region statistics. This should be 
      set for most sequencing protocols.
    default: true
    inputBinding:
      position: 102
      prefix: --countrev
  - id: decaymin
    type:
      - 'null'
      - float
    doc: Set the minimum value (asymptotic lower bound) of the exponential decay
      function used in active region detection as a proportion of the anchor 
      k-mer count. If this value is 0.0, k-mer count recovery threshold may 
      decline to 1. If this value is 1.0, the decay function is not used and the
      detector falls back to finding a k-mer with a count within the difference 
      threshold of the anchor k-mer count.
    default: 0.55
    inputBinding:
      position: 102
      prefix: --decaymin
  - id: diffq
    type:
      - 'null'
      - float
    doc: If set to a value greater than 0.0, then the k-mer count difference 
      between two k-mers that triggers a correction attempt is found 
      dynamically. The difference in k-mer counts between each pair of 
      neighboring k-mers over an uncorrected reference region is found, and this
      quantile of is computed over those differences. For example, a value of 
      0.85 means that at most 15% (100% - 85%) of the k-mer count differences 
      will be high enough. If this computed value is less than the minimum k-mer
      count difference (--mindiff), then that minimum is the difference 
      threshold. This value may not be 1.0 or greater, and it may not be 
      negative. If 0.0, the minimum count difference is always the minimum 
      threshold (--mindiff).
    default: 0.9
    inputBinding:
      position: 102
      prefix: --diffq
  - id: filespersample
    type:
      - 'null'
      - int
    doc: Set the number of input files per sample. For example, reading 
      paired-end FASTQ files (2 files per sample) can be simplified by setting 
      this value to 2. Alternatively, samples can be separated by multiple -s 
      (--sample) arguments. The default value, 0, will not automatically group 
      input files. If -s (--sample) is read on the command-line, this value is 
      set back to 0. Any sequence files found on the command-line before this 
      option are assigned to a group.
    default: 0
    inputBinding:
      position: 102
      prefix: --filespersample
  - id: flank
    type:
      - 'null'
      - int
    doc: When extracting intervals from reference sequences, this many bases are
      extracted on both sides of the interval whenever possible. This gives 
      Kestrel more bases for active region detection, but it does not otherwise 
      affect variant calls. Set to 0 to disable flanks. If this option is not 
      set, Kestrel will determine the appropriate length of flank by multiplying
      3.50 with the k-mer size.
    default: k * 3.50
    inputBinding:
      position: 102
      prefix: --flank
  - id: free
    type:
      - 'null'
      - boolean
    doc: Free resources between processing samples. This may reduce the memory 
      footprint of Kestrel, but it may force expensive resources to be recreated
      and impact performance.
    inputBinding:
      position: 102
      prefix: --free
  - id: hapfmt
    type:
      - 'null'
      - string
    doc: Set haplotype output format. Ignored if a haplotype output file is not 
      set.
    default: sam
    inputBinding:
      position: 102
      prefix: --hapfmt
  - id: input_format
    type:
      - 'null'
      - string
    doc: Set the input sequence format type. This option determines how the 
      format files are read. This option may be set multiple times when reading 
      files with different formats. See "count -hreader" for a full list of 
      readers.
    default: auto
    inputBinding:
      position: 102
      prefix: --format
  - id: interval_file
    type:
      - 'null'
      - File
    doc: Reads a file of intervals defining the regions over the reference 
      sequences where variants should be detected. If no intervals are 
      specified, variants are detected over the full length of each reference 
      sequence. The file type is determined by the file name, such as 
      "intervals.bed". BED files are supported by Kestrel, and others may be 
      added.
    inputBinding:
      position: 102
      prefix: --interval
  - id: ksize
    type:
      - 'null'
      - int
    doc: Size of k-mers sequence data is translated to during analysis. If 
      unsure, use the default value. If the sequencing error rate is very high, 
      or if the reference is very short, a small (e.g. a single short gene), 
      then a smaller k-mer size, such as 21, may be useful if the defalt value 
      does not produce meaningful results.
    default: 31
    inputBinding:
      position: 102
      prefix: --ksize
  - id: lib_file
    type:
      - 'null'
      - File
    doc: Load a library file. Kestrel can accept external components, and they 
      must be packaged on a JAR file.
    inputBinding:
      position: 102
      prefix: --lib
  - id: lib_url
    type:
      - 'null'
      - string
    doc: Load a library by its URL. Kestrel can accept external components, and 
      they must be packaged on a JAR file. This option can access JAR files on 
      the local system or stored anywhere the program can access and that can be
      represented as a URL.
    inputBinding:
      position: 102
      prefix: --liburl
  - id: logfile
    type:
      - 'null'
      - File
    doc: Set log file name.
    default: <STDERR>
    inputBinding:
      position: 102
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set the log level. Valid levels are ALL, TRACE, DEBUG, INFO, WARN, 
      ERROR, and OFF.
    default: WARN
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: logstderr
    type:
      - 'null'
      - boolean
    doc: Write log messages to standard error instead of a file. Unless 
      redirected, this output is written to the the screen.
    inputBinding:
      position: 102
      prefix: --logstderr
  - id: logstdout
    type:
      - 'null'
      - boolean
    doc: Write log messages to standard output instead of a file. Unless 
      redirected, this output is written to the the screen.
    inputBinding:
      position: 102
      prefix: --logstdout
  - id: maxalignstates
    type:
      - 'null'
      - int
    doc: Set the maximum number of alignment states. When haplotype assembly 
      branches into more than one possible sequence, the state of one is saved 
      while another is built. When the maximum number of saved states reaches 
      this value, the least likely one is discarded.
    default: 10
    inputBinding:
      position: 102
      prefix: --maxalignstates
  - id: maxhapstates
    type:
      - 'null'
      - int
    doc: Set the maximum number of haplotypes for an active region. Alignments 
      can generate more than one haplotype, and with noisy sequence data or 
      paralogues, many haplotypes may be found. This options limits the amount 
      of memory that can be consumed in these cases.
    default: 15
    inputBinding:
      position: 102
      prefix: --maxhapstates
  - id: maxrepeat
    type:
      - 'null'
      - int
    doc: Cycles in the k-mer graph produce unreliable local assemblies. The 
      default value for this option (0) will terminate any local assembly that 
      contains the same k-mer more than once. For most applications, 0 is the 
      recommended value. To attempt assemblies in reptitive regions, this value 
      can be increased, but the results may be variant calls on haplotypes that 
      do not exist in the sequence data.
    default: 0
    inputBinding:
      position: 102
      prefix: --maxrepeat
  - id: memcount
    type:
      - 'null'
      - boolean
    doc: K-mer counts from each sample will be stored in memory. This option 
      assumes that samples are relatively small or the machine has enough memory
      to handle the counts. Note that the JVM might need to be run with 
      additional memory (-Xmx option) to support this option.
    inputBinding:
      position: 102
      prefix: --memcount
  - id: mincount
    type:
      - 'null'
      - int
    doc: Set the minimum k-mer count for processing samples. K-mers with a count
      less than this value will be discarded. Sequence read errors produce many 
      erroneous k-mers, and this slows the process of variant calling 
      significantly.
    default: 5
    inputBinding:
      position: 102
      prefix: --mincount
  - id: mindiff
    type:
      - 'null'
      - int
    doc: Set the minimum k-mer count difference for identifying active regions. 
      When the count between neighboring k-mer counts is this or greater, 
      Kestrel will treat it as a region where a variant may occur.
    default: 5
    inputBinding:
      position: 102
      prefix: --mindiff
  - id: minmask
    type:
      - 'null'
      - int
    doc: Size of k-mer minimizers or 0 to disable processing by minimizers. The 
      minimizer of a k-mer is determined by taking all sub-k-mers of a given 
      size (set by this option) from a k-mer and its reverse complement and 
      choosing the lesser of the sub-k-mers. Sub-k-mers are XORed with this mask
      while comparing them, but the minimizer is not XORed (it is still a 
      sub-k-mer of the original k-mer). This option can be used to break up 
      large minimizer groups due to low-complexity k-mers when minimizers are 
      used.
    default: 0
    inputBinding:
      position: 102
      prefix: --minmask
  - id: minsize
    type:
      - 'null'
      - int
    doc: Minimizers group k-mers in the indexed k-mer count (IKC) file generated
      by Kestrel when reading sequences, and this parameter controls the size of
      the minimizer.
    default: 15
    inputBinding:
      position: 102
      prefix: --minsize
  - id: noambigregions
    type:
      - 'null'
      - boolean
    doc: An active region may not span any base that is not A, C, G, T, or U.
    inputBinding:
      position: 102
      prefix: --noambigregions
  - id: noambivar
    type:
      - 'null'
      - boolean
    doc: A variant may not span any base that is not A, C, G, T, or U.
    inputBinding:
      position: 102
      prefix: --noambivar
  - id: noanchorboth
    type:
      - 'null'
      - boolean
    doc: An active region (region with variants) must be bordered on at least 
      one side by an unaltered k-mers, but it may extend to the end of the 
      sequence. This will allow Kestrel to find variants less than a k-mer from 
      the ends, but the evidence supporting these variants is weaker.
    inputBinding:
      position: 102
      prefix: --noanchorboth
  - id: nocountrev
    type:
      - 'null'
      - boolean
    doc: Do not include the reverse complement of k-mers in read depth 
      estimates. If all sequence reads are in the same orientation as the 
      reference, then this option should be used.
    inputBinding:
      position: 102
      prefix: --nocountrev
  - id: nofree
    type:
      - 'null'
      - boolean
    doc: Retain resources between samples. This may use more memory, but it will
      avoid re-creating expensive resources between samples.
    default: true
    inputBinding:
      position: 102
      prefix: --nofree
  - id: nomemcount
    type:
      - 'null'
      - boolean
    doc: K-mer counts for each sample are offloaded to an indexed k-mer count 
      file. This option reduces the memory demand of Kestrel.
    default: true
    inputBinding:
      position: 102
      prefix: --nomemcount
  - id: norevregion
    type:
      - 'null'
      - boolean
    doc: When set, regions variants are called on are always in the same 
      orientation as the reference sequence. The stranded-ness of defined 
      intervals is ignored.
    inputBinding:
      position: 102
      prefix: --norevregion
  - id: normikc
    type:
      - 'null'
      - boolean
    doc: Do not remove the indexed k-mer count (IKC) file for each sample.
    inputBinding:
      position: 102
      prefix: --normikc
  - id: normrefdesc
    type:
      - 'null'
      - boolean
    doc: Use the full sequence name as it appears in the reference sequence 
      file. FASTA files often include a description after the sequence name, and
      with this option, it becomes part of the full sequence name. If using an 
      interval file, the full sequence name and description must match the 
      sequence file.
    inputBinding:
      position: 102
      prefix: --normrefdesc
  - id: noseqfilter
    type:
      - 'null'
      - boolean
    doc: Turn off sequence filtering for all files following this option. If 
      --seqfilter or --quality was specified, this option disables sequence 
      filtering. These options together make it possible to specify filtering 
      for some files and disable filtering for others.
    default: true
    inputBinding:
      position: 102
      prefix: --noseqfilter
  - id: out_format
    type:
      - 'null'
      - string
    doc: Set output format.
    default: vcf
    inputBinding:
      position: 102
      prefix: --outfmt
  - id: peakscan
    type:
      - 'null'
      - int
    doc: Reference regions with sequence homology in other regions of the genome
      may contain k-mers with artificially high frequencies from adding counts 
      for k-mers that appear in both regions. This causes a peak in the k-mer 
      frequencies over the reference, and it can trigger an erroneous 
      active-region scan for variants. When encountering a difference, Kestrel 
      will scan forward this number of k-mers looking for a peak in the k-mer 
      frequencies. If the frequencies drop back down to the original range, the 
      active-region scan is not performed. This keeps Kestrel from erroneously 
      searching large regions of the reference. Setting this value to 0 disables
      peak detection.
    default: 7
    inputBinding:
      position: 102
      prefix: --peakscan
  - id: ref_sequence
    type:
      - 'null'
      - File
    doc: Add reference sequences variants will be called against. This can be 
      any file that Kestrel can read. The format and character-set options apply
      to reference sequences, but not filters.
    inputBinding:
      position: 102
      prefix: --ref
  - id: revregion
    type:
      - 'null'
      - boolean
    doc: When set, reverse complement reference regions that occur on the 
      negative strand. Only itervals defined with on the negative strand are 
      altered.
    inputBinding:
      position: 102
      prefix: --revregion
  - id: rmikc
    type:
      - 'null'
      - boolean
    doc: Remove the indexed k-mer count (IKC) for each sample after kestrel 
      runs.
    default: true
    inputBinding:
      position: 102
      prefix: --rmikc
  - id: rmrefdesc
    type:
      - 'null'
      - boolean
    doc: When set, remove the description from reference sequence names. The 
      descirption is everything that occurs after the first whitespace 
      character. FASTA files often have a sequence name and a long description 
      separated by whitespace. This option ensures that the sequence name 
      matches in the FASTA and an interval file, if used.
    default: true
    inputBinding:
      position: 102
      prefix: --rmrefdesc
  - id: sample_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Set the name of the sample that the next sample files are assigned to. 
      If the argument (SAMPLE_NAME) is given, the name of the sample is set to 
      this name. If the argument is not given, then the sample name is assigned 
      from the name of the first file after this option. Any files on the 
      command-line appearing before this option are assigned to a sample and 
      will not be part of this sample. If --filespersample was used on the 
      command-line before this option, it is reset and files are no longer 
      automatically grouped.
    inputBinding:
      position: 102
      prefix: --sample
  - id: scanlimitfactor
    type:
      - 'null'
      - float
    doc: Set a limit on how long an active region may be. This is computed by 
      multiplying the k-mer size by this factor and adding the maximum length of
      a gap. The computed limit will be adjusted so that active regions are at 
      least large enough to capture a SNP in cases where the maximum gap length 
      is 0. Setting this to a low value or "min" will set the limit so that it 
      is just large enough to catch SNPs and deletions, but it will miss large 
      deletions if another variant is within the k-mer size window. Setting this
      to a high value or "max" lifts the restrictions on active region lengths, 
      and this may cause the program to take an excessive amount of time and 
      memory trying to solve arbitrarily long active regions.
    default: 7.0
    inputBinding:
      position: 102
      prefix: --scanlimitfactor
  - id: seq_filter
    type:
      - 'null'
      - string
    doc: This option is an alias for "seqfilter"
    inputBinding:
      position: 102
      prefix: --quality
  - id: seqfilter
    type:
      - 'null'
      - string
    doc: Filter sequences as they are read and before k-mers are extracted from 
      them. Some sequence readers can filter or alter reads at runtime. The most
      common filter is a quality filter where low-quality bases are removed. The
      filter specification is a filter name followed by a colon (:) and 
      arguments to the filter. If a filter name is not specified, then the 
      "sanger" quality filter is assumed. For example, "sanger:10" and "10" will
      filter k-mers with any base quality score less than 10. The sequence 
      filter specification is set for all files appearing on the command-line 
      after this option. To turn off filtering once it has been set, files 
      following --noseqfilter will have no filter specification.
    inputBinding:
      position: 102
      prefix: --seqfilter
  - id: stdout
    type:
      - 'null'
      - boolean
    doc: Write output to standard output instead of a file. Unless redirected, 
      this output is written to the the screen.
    default: true
    inputBinding:
      position: 102
      prefix: --stdout
  - id: temploc
    type:
      - 'null'
      - Directory
    doc: The location where segments are offloaded. This argument must be a 
      directory or the location for a new directory. Parent directories will be 
      created as needed.
    default: Output location
    inputBinding:
      position: 102
      prefix: --temploc
  - id: varfilter
    type:
      - 'null'
      - string
    doc: Add a variant filter specification. The argument should be the name of 
      the filter, a colon, and the filter arguments. The correct filter is 
      loaded by name and the filter arguments are passed to it.
    inputBinding:
      position: 102
      prefix: --varfilter
  - id: weight_vec
    type:
      - 'null'
      - string
    doc: Set the alignment weights as a comma-separated list of values. The 
      order of weights is match, mismatch, gap-open, gap-extend, and initial 
      score. If values are blank or the list has fewer than 5 elements, the 
      missing values are assigned their default weight. Each value is a 
      floating-point number, and it may be represented in exponential form (e.g.
      1.0e2) or as an integer in hexadecimal or octal format. Optionally, the 
      list may be surrounded by parenthesis or braces (angle, square, or curly).
    default: (10.0, -10.0, -40.0, -4.0, 0.0)
    inputBinding:
      position: 102
      prefix: --weight
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Set output file name.
    outputBinding:
      glob: $(inputs.out_file)
  - id: hapout_file
    type:
      - 'null'
      - File
    doc: Set haplotype output file name.
    outputBinding:
      glob: $(inputs.hapout_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kestrel:1.0.3--hdfd78af_0
