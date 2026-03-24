{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "compress a file multithreaded with pigz",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/pigz:2.8",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.8"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/pigz"
                            ],
                            "package": "pigz"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "pigz",
                "-c"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.inputfile)"
                }
            ],
            "stdout": "$(inputs.inputfile.basename).gz",
            "inputs": [
                {
                    "type": "File",
                    "id": "#pigz.cwl/inputfile"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "-p"
                    },
                    "id": "#pigz.cwl/threads"
                }
            ],
            "id": "#pigz.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.inputfile.basename).gz"
                    },
                    "id": "#pigz.cwl/outfile"
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "Bracken",
            "doc": "Bayesian Reestimation of Abundance with KrakEN.\nBracken is a highly accurate statistical method that computes the abundance of species in DNA sequences from a metagenomics sample.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "InitialWorkDirRequirement",
                    "listing": [
                        {
                            "entry": "$(inputs.kraken_report)",
                            "writable": true
                        }
                    ]
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/bracken:2.9--py39h1f90b4d_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.9"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/bracken",
                                "file:///home/bart/git/cwl/tools/bracken/doi.org/10.7717/peerj-cs.104"
                            ],
                            "package": "bracken"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "bracken"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.identifier+\"_\"+inputs.database.path.split( '/' ).pop()+\"_bracken_\"+inputs.level+\".txt\")",
                    "prefix": "-o"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "label": "Database",
                    "doc": "Database location of kraken2",
                    "inputBinding": {
                        "prefix": "-d"
                    },
                    "id": "#bracken.cwl/database"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset",
                    "label": "identifier used",
                    "id": "#bracken.cwl/identifier"
                },
                {
                    "type": "File",
                    "label": "Kraken report",
                    "doc": "Kraken REPORT file to use for abundance estimation",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#bracken.cwl/kraken_report"
                },
                {
                    "type": "string",
                    "label": "Level",
                    "doc": "Level to estimate abundance at. option [D,P,C,O,F,G,S,S1]. Default Species; 'S'",
                    "inputBinding": {
                        "prefix": "-l"
                    },
                    "default": "S",
                    "id": "#bracken.cwl/level"
                },
                {
                    "type": "int",
                    "label": "Read length",
                    "doc": "Read length to get all classification. Default 100",
                    "inputBinding": {
                        "prefix": "-r"
                    },
                    "default": 100,
                    "id": "#bracken.cwl/read_length"
                },
                {
                    "type": "int",
                    "label": "threshold",
                    "doc": "Number of reads required PRIOR to abundance estimation to perform reestimation. Default 0",
                    "inputBinding": {
                        "prefix": "-t"
                    },
                    "default": 0,
                    "id": "#bracken.cwl/threshold"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier+\"_\"+inputs.database.path.split( '/' ).pop()+\"_bracken_\"+inputs.level+\".txt\")"
                    },
                    "id": "#bracken.cwl/output_report"
                }
            ],
            "id": "#bracken.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2024-04-15",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "ExpressionTool",
            "doc": "Transforms the input files to a mentioned directory\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "id": "#files_to_folder.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "id": "#files_to_folder.cwl/files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "id": "#files_to_folder.cwl/folders"
                }
            ],
            "expression": "${\n  var array = []\n  if (inputs.files != null) {\n    array = array.concat(inputs.files)\n  }\n  if (inputs.folders != null) {\n    array = array.concat(inputs.folders)\n  }\n  var r = {\n     'results':\n       { \"class\": \"Directory\",\n         \"basename\": inputs.destination,\n         \"listing\": array\n       } \n     };\n   return r; \n }\n",
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#files_to_folder.cwl/results"
                }
            ],
            "id": "#files_to_folder.cwl",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateModified": "2024-10-07",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Kraken2",
            "doc": "Kraken2 metagenomics taxomic read classification.\n\nUpdated databases available at: https://benlangmead.github.io/aws-indexes/k2 (e.g. PlusPF-8)\nOriginal db: https://ccb.jhu.edu/software/kraken2/index.shtml?t=downloads\n\nNOTE: This needs the docker container to function properly.\n",
            "hints": [
                {
                    "packages": [
                        {
                            "version": [
                                "2.1.5"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/kraken2",
                                "file:///home/bart/git/cwl/tools/kraken2/doi.org/10.1186/s13059-019-1891-0",
                                "file:///home/bart/git/cwl/tools/kraken2/identifiers.org/RRID:SCR_026838"
                            ],
                            "package": "kraken2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/kraken2:2.1.5",
                    "class": "DockerRequirement"
                },
                {
                    "listing": [
                        {
                            "entry": "$({class: 'Directory', listing: []})",
                            "entryname": "kraken2_output",
                            "writable": true
                        },
                        {
                            "entryname": "kraken2.sh",
                            "entry": "#!/bin/bash\nkraken2 $@\nthreads=$2\n\nshopt -s nullglob\nfor file in *.f*q; do\n  if [ -e \"$file\" ]; then\n    echo \"Compressing: $file\"\n    pigz -p $threads \"$file\"\n  fi\ndone"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "bash",
                "kraken2.sh"
            ],
            "arguments": [
                {
                    "valueFrom": "${\n  if (!inputs.no_standard_report) { \n    return inputs.identifier + '_' + inputs.database.path.split( '/' ).pop() + '_kraken2.tsv';\n  }\n  else { \n    return '/dev/null'; \n    }\n}\n",
                    "prefix": "--output",
                    "position": 2
                },
                {
                    "valueFrom": "$(inputs.identifier)_$(inputs.database.path.split( '/' ).pop())_kraken2_report.txt",
                    "prefix": "--report",
                    "position": 3
                },
                {
                    "valueFrom": "${\n  if (inputs.keep_classified_reads) {\n    return '--classified-out';\n  } else if (inputs.keep_unclassified_reads) {\n    return '--unclassified-out';\n  } else {\n      return null;\n  }\n}\n",
                    "position": 20
                },
                {
                    "valueFrom": "${\n  if (inputs.keep_classified_reads){\n    if (inputs.paired_end) {\n      return inputs.identifier + \"_classified#.fq\";\n    } else {\n      return inputs.identifier + \"_classified.fastq\";\n    }\n  } else if (inputs.keep_unclassified_reads) {\n      if (inputs.paired_end) {\n        return inputs.identifier + \"_unclassified#.fq\";\n      } else {\n        return inputs.identifier + \"_unclassified.fastq\";\n      }\n  } else {\n    return null;\n  }\n}\n",
                    "position": 21
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Bzip2 input",
                    "doc": "input data is gzip compressed",
                    "inputBinding": {
                        "position": 7,
                        "prefix": "--bzip2-compressed"
                    },
                    "default": false,
                    "id": "#kraken2.cwl/bzip2"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "Confidence",
                    "doc": "Confidence score threshold (default 0.0) must be in [0, 1]",
                    "inputBinding": {
                        "position": 6,
                        "prefix": "--confidence"
                    },
                    "id": "#kraken2.cwl/confidence"
                },
                {
                    "type": "Directory",
                    "label": "Database",
                    "doc": "Database location of kraken2",
                    "inputBinding": {
                        "prefix": "--db",
                        "position": 4
                    },
                    "id": "#kraken2.cwl/database"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Forward reads",
                    "doc": "Illumina forward read file",
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#kraken2.cwl/forward_reads"
                },
                {
                    "type": "boolean",
                    "label": "Gzip input",
                    "doc": "input data is gzip compressed",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--gzip-compressed"
                    },
                    "default": false,
                    "id": "#kraken2.cwl/gzip"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#kraken2.cwl/identifier"
                },
                {
                    "type": "boolean",
                    "label": "Keep classified reads",
                    "doc": "Output classified reads. Default false",
                    "default": false,
                    "id": "#kraken2.cwl/keep_classified_reads"
                },
                {
                    "type": "boolean",
                    "label": "Keep unclassified reads",
                    "doc": "Output unclassified reads. Default false",
                    "default": false,
                    "id": "#kraken2.cwl/keep_unclassified_reads"
                },
                {
                    "type": "boolean",
                    "label": "Memory mapping",
                    "doc": "Avoids loading database into RAM. default false",
                    "inputBinding": {
                        "position": 9,
                        "prefix": "--memory-mapping"
                    },
                    "default": false,
                    "id": "#kraken2.cwl/memory_mapping"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Nanopore reads",
                    "doc": "Oxford Nanopore Technologies reads in FASTQ",
                    "inputBinding": {
                        "position": 102
                    },
                    "id": "#kraken2.cwl/nanopore_reads"
                },
                {
                    "type": "boolean",
                    "label": "No kraken standard output",
                    "doc": "Do not output kraken's read classification output. Default false",
                    "default": false,
                    "id": "#kraken2.cwl/no_standard_report"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Paired end",
                    "doc": "Data is paired end (separate files). Default false",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--paired"
                    },
                    "default": false,
                    "id": "#kraken2.cwl/paired_end"
                },
                {
                    "type": "boolean",
                    "label": "Report zero counts",
                    "doc": "With --report, report counts for ALL taxa, even if count is zero. default true",
                    "inputBinding": {
                        "position": 8,
                        "prefix": "--report-zero-counts"
                    },
                    "default": true,
                    "id": "#kraken2.cwl/report_zero_counts"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Reverse reads",
                    "doc": "Illumina reverse read file",
                    "inputBinding": {
                        "position": 101
                    },
                    "id": "#kraken2.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#kraken2.cwl/threads"
                },
                {
                    "type": "boolean",
                    "label": "Use names",
                    "doc": "Print scientific names instead of just taxids. default true",
                    "inputBinding": {
                        "position": 10,
                        "prefix": "--use-names"
                    },
                    "default": true,
                    "id": "#kraken2.cwl/use_names"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_1.fq.gz"
                    },
                    "id": "#kraken2.cwl/out_forward_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*_2.fq.gz"
                    },
                    "id": "#kraken2.cwl/out_reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.fastq.gz"
                    },
                    "id": "#kraken2.cwl/out_single_end_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_$(inputs.database.path.split( '/' ).pop())_kraken2_report.txt"
                    },
                    "id": "#kraken2.cwl/sample_report"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_$(inputs.database.path.split( '/' ).pop())_kraken2.tsv"
                    },
                    "id": "#kraken2.cwl/standard_report"
                }
            ],
            "id": "#kraken2.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-5516-8391",
                    "https://schema.org/email": "mailto:german.royvalgarcia@wur.nl",
                    "https://schema.org/name": "Germ\u00e1n Royval"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-11-25",
            "https://schema.org/dateModified": "2025-05-09",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "kreport2krona.py",
            "doc": "This program takes a Kraken report file and prints out a krona-compatible TEXT file\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/krakentools:1.2--pyh5e36f6f_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/krakentools"
                            ],
                            "package": "kronatools"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "kreport2krona.py"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.report.nameroot)_krona.txt",
                    "prefix": "--output"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Intermediate Ranks",
                    "doc": "Include non-standard levels. Default false",
                    "inputBinding": {
                        "prefix": "--intermediate-ranks"
                    },
                    "default": false,
                    "id": "#kreport2krona.cwl/intermediate-ranks"
                },
                {
                    "type": "boolean",
                    "label": "No Intermediate Ranks",
                    "doc": "only output standard levels [D,P,C,O,F,G,S]. Default true",
                    "inputBinding": {
                        "prefix": "--no-intermediate-ranks"
                    },
                    "default": true,
                    "id": "#kreport2krona.cwl/no-intermediate-ranks"
                },
                {
                    "type": "File",
                    "label": "Report",
                    "doc": "Kraken report file",
                    "inputBinding": {
                        "prefix": "--report"
                    },
                    "id": "#kreport2krona.cwl/report"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.report.nameroot)_krona.txt"
                    },
                    "id": "#kreport2krona.cwl/krona_txt"
                }
            ],
            "id": "#kreport2krona.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/krona:2.8.1--pl5321hdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.8.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/krona",
                                "file:///home/bart/git/cwl/tools/krona/doi.org/10.1186/1471-2105-12-385"
                            ],
                            "package": "krona"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "ktImportText"
            ],
            "label": "Krona ktImportText",
            "doc": "Creates a Krona chart from text files listing quantities and lineages.\ntext  Tab-delimited text file. Each line should be a number followed by a list of wedges to contribute to (starting from the highest level). \nIf no wedges are listed (and just a quantity is given), it will contribute to the top level. \nIf the same lineage is listed more than once, the values will be added. Quantities can be omitted if -q is specified.\nLines beginning with \"#\" will be ignored. By default, separate datasets will be created for each input.\n",
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input.nameroot).html"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Highest level",
                    "doc": "Name of the highest level. Default 'all'",
                    "inputBinding": {
                        "position": 1,
                        "prefix": "-n"
                    },
                    "id": "#krona_ktImportText.cwl/highest_level"
                },
                {
                    "type": "File",
                    "label": "Tab-delimited text file",
                    "inputBinding": {
                        "position": 10
                    },
                    "id": "#krona_ktImportText.cwl/input"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "No quantity",
                    "doc": "Fields do not have a field for quantity. Default false",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "-q"
                    },
                    "default": false,
                    "id": "#krona_ktImportText.cwl/no_quantity"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input.nameroot).html"
                    },
                    "id": "#krona_ktImportText.cwl/krona_html"
                }
            ],
            "id": "#krona_ktImportText.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2024-04-10",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                }
            ],
            "label": "Kracken2 + Bracken",
            "doc": "Run Kraken2 Analysis + Krona visualization followed by Bracken. Currently only on illumina reads.\n",
            "outputs": [
                {
                    "type": "Directory",
                    "label": "Bracken folder",
                    "doc": "Folder with Bracken output files",
                    "outputSource": "#main/files_to_folder_bracken/results",
                    "id": "#main/bracken_folder"
                },
                {
                    "type": "Directory",
                    "label": "Kraken2 folder",
                    "doc": "Folder with Kraken2 output files",
                    "outputSource": "#main/files_to_folder_kraken/results",
                    "id": "#main/kraken2_folder"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "label": "Bracken levels",
                    "doc": "Taxonomy levels in bracken estimate abundances on. Default runs through; [P,C,O,F,G,S]",
                    "default": [
                        "P",
                        "C",
                        "O",
                        "F",
                        "G",
                        "S"
                    ],
                    "id": "#main/bracken_levels"
                },
                {
                    "type": "int",
                    "label": "Bracken reads threshold",
                    "doc": "Number of reads required PRIOR to abundance estimation to perform reestimation in bracken. Default 0",
                    "default": 0,
                    "id": "#main/bracken_reads_threshold"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional output destination only used for cwl-prov reporting.",
                    "id": "#main/destination"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#main/identifier"
                },
                {
                    "type": "File",
                    "doc": "Forward sequence fastq file(s) locally",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#main/illumina_forward_reads"
                },
                {
                    "type": "File",
                    "doc": "Reverse sequence fastq file(s) locally",
                    "label": "Reverse reads",
                    "loadListing": "no_listing",
                    "id": "#main/illumina_reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "Kraken2 confidence threshold",
                    "doc": "Confidence score threshold (default 0.0) must be between [0, 1]",
                    "id": "#main/kraken2_confidence"
                },
                {
                    "type": "Directory",
                    "label": "Kraken2 database",
                    "doc": "Kraken2 database location",
                    "loadListing": "no_listing",
                    "id": "#main/kraken2_database"
                },
                {
                    "type": "boolean",
                    "label": "Kraken2 standard report",
                    "doc": "Also output Kraken2 standard report with per read classification. These can be large. (default true)",
                    "default": true,
                    "id": "#main/output_standard_report"
                },
                {
                    "type": "int",
                    "label": "Read length",
                    "doc": "Read length to use in bracken",
                    "id": "#main/read_length"
                },
                {
                    "type": "boolean",
                    "label": "Run Bracken",
                    "doc": "Skip Bracken analysis. Default false.",
                    "default": false,
                    "id": "#main/skip_bracken"
                },
                {
                    "label": "Input URLs used for this run",
                    "doc": "A provenance element to capture the original source of the input data",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "string"
                        }
                    ],
                    "id": "#main/source"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Number of threads to use for computational processes",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "label": "Bracken folder",
                    "doc": "Bracken files to single folder",
                    "in": [
                        {
                            "default": "Bracken_Illumina",
                            "id": "#main/files_to_folder_bracken/destination"
                        },
                        {
                            "source": [
                                "#main/illumina_bracken/output_report"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/files_to_folder_bracken/files"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#main/files_to_folder_bracken/results"
                    ],
                    "id": "#main/files_to_folder_bracken"
                },
                {
                    "label": "Kraken2 folder",
                    "doc": "Kraken2 files to single folder",
                    "in": [
                        {
                            "default": "Kraken2_Illumina",
                            "id": "#main/files_to_folder_kraken/destination"
                        },
                        {
                            "source": [
                                "#main/illumina_kraken2/sample_report",
                                "#main/illumina_kraken2/sample_report",
                                "#main/kraken2krona_txt/krona_txt",
                                "#main/krona/krona_html",
                                "#main/kraken2_compress/outfile"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/files_to_folder_kraken/files"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#main/files_to_folder_kraken/results"
                    ],
                    "id": "#main/files_to_folder_kraken"
                },
                {
                    "label": "Illumina bracken",
                    "doc": "Bracken runs on Illumina reads",
                    "run": "#bracken.cwl",
                    "when": "$(!inputs.skip_bracken)",
                    "scatter": "#main/illumina_bracken/level",
                    "in": [
                        {
                            "source": "#main/kraken2_database",
                            "id": "#main/illumina_bracken/database"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/illumina_bracken/identifier"
                        },
                        {
                            "source": "#main/illumina_kraken2/sample_report",
                            "id": "#main/illumina_bracken/kraken_report"
                        },
                        {
                            "source": "#main/bracken_levels",
                            "id": "#main/illumina_bracken/level"
                        },
                        {
                            "source": "#main/read_length",
                            "id": "#main/illumina_bracken/read_length"
                        },
                        {
                            "source": "#main/skip_bracken",
                            "id": "#main/illumina_bracken/skip_bracken"
                        },
                        {
                            "source": "#main/bracken_reads_threshold",
                            "id": "#main/illumina_bracken/threshold"
                        }
                    ],
                    "out": [
                        "#main/illumina_bracken/output_report"
                    ],
                    "id": "#main/illumina_bracken"
                },
                {
                    "label": "Kraken2",
                    "doc": "bla",
                    "run": "#kraken2.cwl",
                    "in": [
                        {
                            "source": "#main/kraken2_confidence",
                            "id": "#main/illumina_kraken2/confidence"
                        },
                        {
                            "source": "#main/kraken2_database",
                            "id": "#main/illumina_kraken2/database"
                        },
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/illumina_kraken2/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/illumina_kraken2/identifier"
                        },
                        {
                            "default": true,
                            "id": "#main/illumina_kraken2/paired_end"
                        },
                        {
                            "source": "#main/illumina_reverse_reads",
                            "id": "#main/illumina_kraken2/reverse_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/illumina_kraken2/threads"
                        }
                    ],
                    "out": [
                        "#main/illumina_kraken2/sample_report",
                        "#main/illumina_kraken2/standard_report"
                    ],
                    "id": "#main/illumina_kraken2"
                },
                {
                    "label": "Compress kraken2",
                    "doc": "Compress large kraken2 report file",
                    "when": "$(inputs.kraken2_standard_report)",
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#main/illumina_kraken2/standard_report",
                            "id": "#main/kraken2_compress/inputfile"
                        },
                        {
                            "source": "#main/output_standard_report",
                            "id": "#main/kraken2_compress/kraken2_standard_report"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/kraken2_compress/threads"
                        }
                    ],
                    "out": [
                        "#main/kraken2_compress/outfile"
                    ],
                    "id": "#main/kraken2_compress"
                },
                {
                    "label": "kraken2krona",
                    "doc": "Convert kraken2 report to krona format",
                    "run": "#kreport2krona.cwl",
                    "in": [
                        {
                            "source": "#main/illumina_kraken2/sample_report",
                            "id": "#main/kraken2krona_txt/report"
                        }
                    ],
                    "out": [
                        "#main/kraken2krona_txt/krona_txt"
                    ],
                    "id": "#main/kraken2krona_txt"
                },
                {
                    "label": "Krona",
                    "doc": "Krona visualization of Kraken2",
                    "run": "#krona_ktImportText.cwl",
                    "in": [
                        {
                            "source": "#main/kraken2krona_txt/krona_txt",
                            "id": "#main/krona/input"
                        }
                    ],
                    "out": [
                        "#main/krona/krona_html"
                    ],
                    "id": "#main/krona"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
