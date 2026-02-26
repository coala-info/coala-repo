cwlVersion: v1.2
class: CommandLineTool
baseCommand: jpredapi
label: jpredapi_submit
doc: "jpredapi command-line interface\nThe JPred API allows users to submit jobs from
  the command-line.\n\nTool homepage: https://github.com/MoseleyBioinformaticsLab/jpredapi"
inputs:
  - id: attempts
    type:
      - 'null'
      - int
    doc: Maximum number of attempts to check job status
    default: 10
    inputBinding:
      position: 101
      prefix: --attempts
  - id: email
    type:
      - 'null'
      - string
    doc: E-mail address where job report will be sent (optional for all but 
      batch submissions).
    inputBinding:
      position: 101
      prefix: --email
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract results tar.gz archive.
    inputBinding:
      position: 101
      prefix: --extract
  - id: file
    type:
      - 'null'
      - File
    doc: Filename of a file with the job input (sequence(s)).
    inputBinding:
      position: 101
      prefix: --file
  - id: format
    type: string
    doc: 'Submission format, possible values: raw, fasta, msf, blc.'
    inputBinding:
      position: 101
      prefix: --format
  - id: jobid
    type:
      - 'null'
      - string
    doc: Job id.
    inputBinding:
      position: 101
      prefix: --jobid
  - id: jpred4
    type:
      - 'null'
      - string
    doc: Address of Jpred4 server
    default: http://www.compbio.dundee.ac.uk/jpred4
    inputBinding:
      position: 101
      prefix: --jpred4
  - id: mode
    type: string
    doc: 'Submission mode, possible values: single, batch, msa.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: name
    type:
      - 'null'
      - string
    doc: Job name.
    inputBinding:
      position: 101
      prefix: --name
  - id: rest
    type:
      - 'null'
      - string
    doc: REST address of server
    default: http://www.compbio.dundee.ac.uk/jpred4/cgi-bin/rest
    inputBinding:
      position: 101
      prefix: --rest
  - id: results
    type:
      - 'null'
      - Directory
    doc: Path to directory where to save archive with results.
    inputBinding:
      position: 101
      prefix: --results
  - id: seq
    type:
      - 'null'
      - string
    doc: Instead of passing input file, for single-sequence submission.
    inputBinding:
      position: 101
      prefix: --seq
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print messages.
    inputBinding:
      position: 101
      prefix: --silent
  - id: skip_pdb
    type:
      - 'null'
      - boolean
    doc: PDB check.
    inputBinding:
      position: 101
      prefix: --skipPDB
  - id: wait
    type:
      - 'null'
      - int
    doc: Wait interval before retrying to check job status in seconds
    default: 60
    inputBinding:
      position: 101
      prefix: --wait
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jpredapi:1.5.6--py_0
stdout: jpredapi_submit.out
