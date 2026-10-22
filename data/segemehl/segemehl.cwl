cwlVersion: v1.2
class: CommandLineTool
baseCommand: segemehl
label: segemehl
doc: "segemehl is a software to map short sequencer reads to reference genomes. Unlike other methods, segemehl is able to find de novo junctions (splits) in short reads.\n\nTool homepage: http://www.bioinf.uni-leipzig.de/Software/segemehl/"
inputs:
  - id: database
    type:
      type: array
      items: File
    doc: "List of path/filename(s) of fasta database sequence(s)"
    inputBinding:
      position: 1
      prefix: --database
  - id: query
    type: ['null', File]
    doc: "Path/filename of query sequences"
    inputBinding:
      position: 1
      prefix: --query
  - id: mate
    type: ['null', File]
    doc: "Path/filename of mate pair sequences"
    inputBinding:
      position: 1
      prefix: --mate
  - id: index
    type: ['null', File]
    doc: "Path/filename of db index"
    inputBinding:
      position: 1
      prefix: --index
  - id: index2
    type: ['null', File]
    doc: "Path/filename of second db index"
    inputBinding:
      position: 1
      prefix: --index2
  - id: generate
    type: ['null', string]
    doc: "Generate db index and store to disk (output file name)"
    inputBinding:
      position: 1
      prefix: --generate
  - id: generate2
    type: ['null', string]
    doc: "Generate second db index and store to disk (output file name)"
    inputBinding:
      position: 1
      prefix: --generate2
  - id: readgroupfile
    type: ['null', File]
    doc: "Filename to read @RG header"
    inputBinding:
      position: 1
      prefix: --readgroupfile
  - id: readgroupid
    type: ['null', string]
    doc: "Read group id"
    inputBinding:
      position: 1
      prefix: --readgroupid
  - id: threads
    type: ['null', int]
    doc: "Start n threads (default 1)"
    inputBinding:
      position: 1
      prefix: --threads
  - id: outfile
    type: ['null', string]
    doc: "Output file"
    inputBinding:
      position: 1
      prefix: --outfile
  - id: bamabafixoida
    type: ['null', boolean]
    doc: "Generate a bam output (outfile required)"
    inputBinding:
      position: 1
      prefix: --bamabafixoida
  - id: nomatchfilename
    type: ['null', string]
    doc: "Filename for unmatched reads"
    inputBinding:
      position: 1
      prefix: --nomatchfilename
  - id: briefcigar
    type: ['null', boolean]
    doc: "Brief cigar string (M vs X and =)"
    inputBinding:
      position: 1
      prefix: --briefcigar
  - id: progressbar
    type: ['null', boolean]
    doc: "Show a progress bar"
    inputBinding:
      position: 1
      prefix: --progressbar
  - id: filebins
    type: ['null', string]
    doc: "File bins with this basename for easier data handling"
    inputBinding:
      position: 1
      prefix: --filebins
  - id: meop
    type: ['null', boolean]
    doc: "Output MEOP field for easier variance calling in SAM (XE:Z:)"
    inputBinding:
      position: 1
      prefix: --MEOP
  - id: bisulfite
    type: ['null', int]
    doc: "Bisulfite alignment with methylC-seq/Lister et al. (1) or bs-seq/Cokus et al. protocol (2) (default 0)"
    inputBinding:
      position: 1
      prefix: --bisulfite
  - id: splits
    type: ['null', string]
    doc: "Detect split/spliced reads; value is the basename of the split output files"
    inputBinding:
      position: 1
      prefix: --splits
  - id: accuracy
    type: ['null', int]
    doc: "Min percentage of matches per read in semi-global alignment (default 90)"
    inputBinding:
      position: 1
      prefix: --accuracy
  - id: differences
    type: ['null', int]
    doc: "Search seeds initially with n differences (default 1)"
    inputBinding:
      position: 1
      prefix: --differences
  - id: evalue
    type: ['null', float]
    doc: "Max evalue (default 5.0)"
    inputBinding:
      position: 1
      prefix: --evalue
  - id: hitstrategy
    type: ['null', boolean]
    doc: "Report only best scoring hits (1) or all (0)"
    inputBinding:
      position: 1
      prefix: --hitstrategy
  - id: minsize
    type: ['null', int]
    doc: "Minimum length of queries (default 12)"
    inputBinding:
      position: 1
      prefix: --minsize
  - id: minfraglen
    type: ['null', int]
    doc: "Min length of a spliced fragment (default 20)"
    inputBinding:
      position: 1
      prefix: --minfraglen
  - id: minsplicecover
    type: ['null', int]
    doc: "Min coverage for spliced transcripts (default 80)"
    inputBinding:
      position: 1
      prefix: --minsplicecover
  - id: minfragscore
    type: ['null', int]
    doc: "Min score of a spliced fragment (default 18)"
    inputBinding:
      position: 1
      prefix: --minfragscore
  - id: splicescorescale
    type: ['null', float]
    doc: "Report spliced alignment with score s only if f*s is larger than next best spliced alignment (default 0.9)"
    inputBinding:
      position: 1
      prefix: --splicescorescale
  - id: maxsplitevalue
    type: ['null', float]
    doc: "Max evalue for splits (default 50.0)"
    inputBinding:
      position: 1
      prefix: --maxsplitevalue
  - id: dropoff
    type: ['null', int]
    doc: "Dropoff parameter for extension (default 8)"
    inputBinding:
      position: 1
      prefix: --dropoff
  - id: jump
    type: ['null', int]
    doc: "Search seeds with jump size n (0=automatic) (default 0)"
    inputBinding:
      position: 1
      prefix: --jump
  - id: order
    type: ['null', boolean]
    doc: "Sorts the output by chromosome and position (might take a while)"
    inputBinding:
      position: 1
      prefix: --order
  - id: maxpairinsertsize
    type: ['null', int]
    doc: "Maximum size of the inserts (paired end) in case of multiple hits (default 200000)"
    inputBinding:
      position: 1
      prefix: --maxpairinsertsize
  - id: maxinterval
    type: ['null', int]
    doc: "Maximum width of a suffix array interval, a query seed is omitted if it matches more than n times (default 100)"
    inputBinding:
      position: 1
      prefix: --maxinterval
  - id: checkidx
    type: ['null', boolean]
    doc: "Check index"
    inputBinding:
      position: 1
      prefix: --checkidx
  - id: extensionpenalty
    type: ['null', int]
    doc: "Penalty for a mismatch during extension (default 4)"
    inputBinding:
      position: 1
      prefix: --extensionpenalty
  - id: maxout
    type: ['null', int]
    doc: "Maximum number of alignments that will be reported; 0 reports all (default 0)"
    inputBinding:
      position: 1
      prefix: --maxout
  - id: skipidcheck
    type: ['null', boolean]
    doc: "Do not check whether the fastq ids of mates / paired ends match"
    inputBinding:
      position: 1
      prefix: --skipidcheck
  - id: showalign
    type: ['null', boolean]
    doc: "Show alignments"
    inputBinding:
      position: 1
      prefix: --showalign
  - id: nohead
    type: ['null', boolean]
    doc: "Do not output header"
    inputBinding:
      position: 1
      prefix: --nohead
  - id: fullname
    type: ['null', boolean]
    doc: "Write full query name (no truncation at whitespace)"
    inputBinding:
      position: 1
      prefix: --fullname
outputs:
  - id: alignments
    type: ['null', File]
    doc: Alignment output file (SAM, or BAM with bamabafixoida)
    outputBinding:
      glob: $(inputs.outfile)
  - id: generated_index
    type: ['null', File]
    doc: Index written with generate
    outputBinding:
      glob: $(inputs.generate)
  - id: generated_index2
    type: ['null', File]
    doc: Second index written with generate2
    outputBinding:
      glob: $(inputs.generate2)
  - id: unmatched_reads
    type: ['null', File]
    doc: Unmatched reads
    outputBinding:
      glob: $(inputs.nomatchfilename)
  - id: split_files
    type:
      type: array
      items: File
    doc: Split read files written with splits (.bed, .txt)
    outputBinding:
      glob: $(inputs.splits).*
  - id: stdout
    type: stdout
    doc: Standard output (SAM when no output file is given)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/segemehl:v0.3.4-1-deb_cv1
stdout: segemehl.out
