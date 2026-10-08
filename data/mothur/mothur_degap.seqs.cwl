cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_degap.seqs
doc: "Reads a fasta file and removes all gap characters.\n\nThe degap.seqs command reads a fastafile and removes all gap characters.\nThe degap.seqs command parameter are fasta and processors.\nThe fasta parameter allows you to enter the fasta file containing your sequences, and is required unless you have a valid current fasta file. \nThe processors parameter allows you to enter the number of processors you would like to use. \nThe degap.seqs command should be in the following format: \ndegap.seqs(fasta=yourFastaFile) \nExample: degap.seqs(fasta=abrecovery.align) \n\nThe valid parameters are: fasta, seed, processors, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.fasta ? inputs.fasta : [])"
inputs:
  - id: fasta
    type: File
    doc: "Fasta file of (aligned) sequences (mothur parameter fasta=)"
  - id: processors
    type:
      - 'null'
      - int
    doc: "Number of processors to use (mothur default: all available) (mothur parameter processors=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["fasta", "fasta"], ["processors", "processors"], ["seed", "seed"]];
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
        return '#degap.seqs(' + opts.join(', ') + ')';
      }
outputs:
  - id: fasta_out
    type: File
    doc: "Degapped fasta file"
    outputBinding:
      glob: "*.ng.fasta"
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
stdout: mothur_degap.seqs.out
