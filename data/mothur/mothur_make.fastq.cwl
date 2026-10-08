cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_make.fastq
doc: "Reads a fasta and quality file and creates a fastq file.\n\nThe make.fastq command reads a fasta and quality file and creates a fastq file.\nThe make.fastq command parameters are fasta, qfile and format.  fasta and qfile are required.\nThe format parameter is used to indicate whether your sequences are sanger, solexa, illumina1.8+ or illumina, default=illumina1.8+.\nThe make.fastq command should be in the following format: make.fastq(qfile=yourQualityFile, fasta=yourFasta).\nExample make.fastq(fasta=amazon.fasta, qfile=amazon.qual).\n\nThe valid parameters are: fasta, qfile, format, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.qfile ? inputs.qfile : [])"
inputs:
  - id: fasta
    type: File
    doc: "Fasta file (mothur parameter fasta=)"
  - id: qfile
    type: File
    doc: "Quality file (mothur parameter qfile=)"
  - id: format
    type:
      - 'null'
      - string
    doc: "Quality encoding: sanger, solexa, illumina1.8+ or illumina (default illumina1.8+) (mothur parameter format=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["fasta", "fasta"], ["qfile", "qfile"], ["format", "format"], ["seed", "seed"]];
        var opts = [];
        params.forEach(function (p) {
          var v = inputs[p[0]];
          if (v === null || v === undefined) { return; }
          if (Array.isArray(v)) { v = v.map(function (f) { return f.basename; }).join('-'); }
          else if (typeof v === 'object') { v = v.basename; }
          else if (typeof v === 'boolean') { v = v ? 'T' : 'F'; }
          opts.push(p[1] + '=' + v);
        });
        opts.push('outputdir=' + runtime.outdir + '/');
        return '#make.fastq(' + opts.join(', ') + ')';
      }
outputs:
  - id: fastq
    type: File
    doc: "FASTQ file"
    outputBinding:
      glob: "*.fastq"
  - id: logfile
    type:
      - 'null'
      - File
    doc: mothur log file
    outputBinding:
      glob: mothur.*.logfile
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_make.fastq.out
