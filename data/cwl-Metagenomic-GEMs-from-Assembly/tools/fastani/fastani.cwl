#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: CommandLineTool

label: FastANI

doc: FastANI is developed for fast alignment-free computation of whole-genome Average Nucleotide Identity. 

requirements:
    InlineJavascriptRequirement: {}
    InitialWorkDirRequirement:
        listing:
          - $(inputs.query_type.querylist)
          - $(inputs.reference_type.reflist)
          - entryname: 'query_list.txt'
            entry: |
              ${
                  if (inputs.query_type.querylist && inputs.query_type.querylist.length > 0) {
                  return inputs.query_type.querylist.map(f => f.basename).join('\n');
                  } else {
                  return "";
                  }
              }
          - entryname: 'ref_list.txt'
            entry: |
              ${
                  if (inputs.reference_type.reflist && inputs.reference_type.reflist.length > 0) {
                  return inputs.reference_type.reflist.map(f => f.basename).join('\n');
                  } else {
                  return "";
                  }
              }

hints:
    SoftwareRequirement:
        packages:
            fastani:
                version: ["1.34"]
                specs: ["https://anaconda.org/bioconda/fastani", "doi.org/10.1038/s41467-018-07641-9"]
    DockerRequirement:
        dockerPull: quay.io/biocontainers/fastani:1.34--h4dfc31f_1

baseCommand: [ "fastANI" ]

inputs:
    query_type:
        type:
            - type: record
              name: query_type
              fields:
                - name: query
                  type: File?
                  doc: "query genome (fasta/fastq)[.gz]"
                  label: Query genome
                  inputBinding:
                    prefix: "--query"
                - name: querylist
                  type: File[]?
                  doc: "a file containing list of query genome files, one genome per line"
                  label: Query genome list
    reference_type:
        type:
            - type: record
              name: reference_type
              fields:
                - name: ref
                  type: File?
                  doc: "reference genome (fasta/fastq)[.gz]"
                  label: Reference genome
                  inputBinding:
                      prefix: "--ref"
                - name: reflist
                  type: File[]?
                  doc: "a file containing list of reference genome files, one genome per line"
                  label: Reference genome list
    # query:
    #     type: File?
    #     doc: "query genome (fasta/fastq)[.gz]"
    #     label: Query genome
    #     inputBinding:
    #         prefix: "--query"
    # querylist:
    #     type: File[]?
    #     doc: "a file containing list of query genome files, one genome per line"
    #     label: Query genome list
    # ref:
    #     type: File?
    #     doc: "reference genome (fasta/fastq)[.gz]"
    #     label: Reference genome
    #     inputBinding:
    #         prefix: "--ref"
    # reflist:
    #     type: File[]?
    #     doc: "a file containing list of reference genome files, one genome per line"
    #     label: Reference genome list

    threads:
        type: int?
        doc: "thread count for parallel execution"
        label: Threads
        inputBinding:
            prefix: "--threads"
        default: 4 # lets use more than 1 thread by default
    visualize:
        type: boolean?
        doc: "output mappings for visualization, can be enabled for single genome to single genome comparison only [disabled by default]"
        label: Visualize ANI matrix
        inputBinding:
            prefix: "--visualize"
        default: false
    fragLen:
        type: int?
        doc: "fragment length for ANI calculation [default: 3000]"
        label: Fragment length
        inputBinding:
            prefix: "--fragLen"
    minFraction:
        type: float?
        doc: "minimum fraction of genome that must be shared for trusting ANI. If reference and query genome size differ, smaller one among the two is considered.[default: 0.2]"
        label: Minimum fraction
        inputBinding:
            prefix: "--minFraction"
    maxRatioDiff:
        type: float?
        doc: "maximum difference between (Total Ref. Length/Total Occ. Hashes) and (Total Ref. Length/Total No. Hashes).[default: 0.25]"
        label: Maximum ratio difference
        inputBinding:
            prefix: "--maxRatioDiff"
    matrix:
        type: boolean?
        doc: "also output ANI values as lower triangular matrix (format inspired from phylip). If enabled, you should expect an output file with .matrix extension [disabled by default]"
        label: ANI matrix file name
        inputBinding:
            prefix: "--matrix"
        default: false
    outfile:
        type: string
        doc: "output file name"
        label: Output file name
        inputBinding:
            prefix: "--output"
        default: "fastani.out"

arguments:
  - valueFrom: >
      ${
        if (inputs.query_type.querylist && inputs.query_type.querylist.length > 0) {
          return runtime.outdir + '/query_list.txt';
        } else {
          return null;
        }
      }
    prefix: --ql
    shellQuote: false
  - valueFrom: >
      ${
        if (inputs.reference_type.reflist && inputs.reference_type.reflist.length > 0) {
          return runtime.outdir + '/ref_list.txt';
        } else {
          return null; // or handle it 
        }
      }
    prefix: --rl
    shellQuote: false

outputs:
    fastani_output:
        type: File # but will get blank output when <80 AAI
        outputBinding:
            glob: $(inputs.outfile)
    visualization:
        type: File?
        outputBinding:
            glob: $(inputs.outfile).visual
    matrix:
        type: File?
        outputBinding:
            glob: $(inputs.outfile).matrix



s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2024-02-27"
s:dateModified: "2024-02-27"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
    s: https://schema.org/