cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- sourmash
- sig
- ingest
label: sourmash_sig_ingest
doc: 'Import a mash or other signature.


  Tool homepage: https://github.com/sourmash-bio/sourmash'
inputs:
- id: filenames
  type: File[]
  doc: Input files in Mash CSV or JSON format.
  inputBinding:
    position: 100
- id: csv
  type:
  - 'null'
  - boolean
  doc: import in Mash CSV format
  inputBinding:
    position: 1
    prefix: --csv
- id: quiet
  type:
  - 'null'
  - boolean
  doc: suppress non-error output
  inputBinding:
    position: 1
    prefix: --quiet
- id: output
  type: string
  doc: output signature to this file (default stdout)
  inputBinding:
    position: 1
    prefix: --output
  default: ingested.sig
outputs:
- id: output_result
  type: File
  doc: output signature to this file (default stdout)
  outputBinding:
    glob: $(inputs.output)
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
