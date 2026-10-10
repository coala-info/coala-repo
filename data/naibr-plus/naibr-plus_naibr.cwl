cwlVersion: v1.2
class: CommandLineTool
baseCommand: naibr
label: naibr-plus_naibr
doc: "NAIBR identifies novel adjacencies created by structural variation events such
  as deletions, duplications, inversions, and complex rearrangements using linked-read
  whole-genome sequencing data as produced by 10X Genomics. Please refer to the publication
  for details about the method. NAIBR reads its parameters from a config file with
  \"=\" separated parameters and values; this wrapper writes that file (naibr.config)
  from the inputs and runs `naibr naibr.config`.\n\nTool homepage: https://github.com/pontushojer/NAIBR"
arguments:
  - naibr.config
inputs:
  - id: bam_file
    type: File
    secondaryFiles:
      - .bai
    doc: Path to BAM file with phased linked reads, i.e. has BX and HP tags.
  - id: outdir
    type: string
    default: naibr_out
    doc: Path to output directory (created before the run).
  - id: blacklist
    type:
      - 'null'
      - File
    doc: Path to BED file with regions to ignore
  - id: candidates
    type:
      - 'null'
      - File
    doc: Path to BEDPE with candidiate SVs to evaluate
  - id: d
    type:
      - 'null'
      - int
    doc: Maximum distance between read-pairs in a linked-read. Default 10,000
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality to evaluate reads. Default 40
  - id: k
    type:
      - 'null'
      - int
    doc: Minimum number of barcode overlaps supporting a candidate NA. Default 3
  - id: min_sv
    type:
      - 'null'
      - int
    doc: Minimum size of structural variant. Default 1000
  - id: sd_mult
    type:
      - 'null'
      - int
    doc: Stddev multiplier for max/min insert size (LMAX/LMIN) calculcation. Default
      2
  - id: min_len
    type:
      - 'null'
      - int
    doc: 'Minimum length of linked read fragment. Default: 2*LMAX'
  - id: max_len
    type:
      - 'null'
      - int
    doc: TO_BE_ADDED. Default 200,000
  - id: min_reads
    type:
      - 'null'
      - int
    doc: Minimum reads in linked read fragment. Default 2
  - id: min_discs
    type:
      - 'null'
      - int
    doc: Minimum number of discordant reads. Default 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads to use. Default 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files. Default NAIBR_SVs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run in debug mode. Default False (config key DEBUG)
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the NAIBR result files (<prefix>.bedpe, <prefix>.vcf and log)
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
      - entryname: naibr.config
        entry: |-
          ${
            var lines = ["bam_file=" + inputs.bam_file.path, "outdir=" + inputs.outdir];
            var files = {blacklist: inputs.blacklist, candidates: inputs.candidates};
            for (var key in files) {
              if (files[key] !== null && files[key] !== undefined) {
                lines.push(key + "=" + files[key].path);
              }
            }
            var vals = {d: inputs.d, min_mapq: inputs.min_mapq, k: inputs.k, min_sv: inputs.min_sv,
              sd_mult: inputs.sd_mult, min_len: inputs.min_len, max_len: inputs.max_len,
              min_reads: inputs.min_reads, min_discs: inputs.min_discs, threads: inputs.threads,
              prefix: inputs.prefix};
            for (var name in vals) {
              if (vals[name] !== null && vals[name] !== undefined) {
                lines.push(name + "=" + vals[name]);
              }
            }
            if (inputs.debug) {
              lines.push("DEBUG=True");
            }
            return lines.join("\n") + "\n";
          }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/naibr-plus:0.5.3--pyhdfd78af_0
stdout: naibr-plus_naibr.out
