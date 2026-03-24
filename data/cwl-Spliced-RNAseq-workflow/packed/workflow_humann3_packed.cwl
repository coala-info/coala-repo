{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "Concatenate multiple files",
            "baseCommand": [
                "cat"
            ],
            "stdout": "$(inputs.outname)",
            "hints": [
                {
                    "dockerPull": "debian:buster",
                    "class": "DockerRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#concatenate.cwl/infiles"
                },
                {
                    "type": "string",
                    "id": "#concatenate.cwl/outname"
                }
            ],
            "id": "#concatenate.cwl",
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
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.outname)"
                    },
                    "id": "#concatenate.cwl/output"
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "Filter from reads",
            "doc": "Filter reads using BBmaps bbduk tool (paired-end only)\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/bbmap:39.06",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "39.06"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/bbmap"
                            ],
                            "package": "bbmap"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "bbduk.sh"
            ],
            "inputs": [
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "in=",
                        "separate": false
                    },
                    "id": "#bbduk_filter.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#bbduk_filter.cwl/identifier"
                },
                {
                    "type": "int",
                    "inputBinding": {
                        "prefix": "k=",
                        "separate": false
                    },
                    "default": 31,
                    "id": "#bbduk_filter.cwl/kmersize"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 8000,
                    "id": "#bbduk_filter.cwl/memory"
                },
                {
                    "doc": "Reference contamination fasta file (can be compressed)",
                    "label": "Reference contamination file",
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "ref=",
                        "separate": false
                    },
                    "id": "#bbduk_filter.cwl/reference"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "in2=",
                        "separate": false
                    },
                    "id": "#bbduk_filter.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "threads=",
                        "separate": false
                    },
                    "id": "#bbduk_filter.cwl/threads"
                }
            ],
            "stderr": "$(inputs.identifier)_bbduk-summary.txt",
            "arguments": [
                {
                    "prefix": "-Xmx",
                    "separate": false,
                    "valueFrom": "$(inputs.memory)M"
                },
                {
                    "prefix": "out=",
                    "separate": false,
                    "valueFrom": "$(inputs.identifier)_1.fq.gz"
                },
                {
                    "prefix": "out2=",
                    "separate": false,
                    "valueFrom": "$(inputs.identifier)_2.fq.gz"
                },
                {
                    "prefix": "stats=",
                    "separate": false,
                    "valueFrom": "$(inputs.identifier)_bbduk-stats.txt"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_1.fq.gz"
                    },
                    "id": "#bbduk_filter.cwl/out_forward_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_2.fq.gz"
                    },
                    "id": "#bbduk_filter.cwl/out_reverse_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_bbduk-stats.txt"
                    },
                    "id": "#bbduk_filter.cwl/stats_file"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_bbduk-summary.txt"
                    },
                    "id": "#bbduk_filter.cwl/summary"
                }
            ],
            "id": "#bbduk_filter.cwl",
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
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2023-02-10",
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
            "label": "Convert an array of 1 file to a file object",
            "doc": "Converts the array and returns the first file in the array. \nShould only be used when 1 file is in the array.\n",
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#array_to_file_tool.cwl/files"
                }
            ],
            "baseCommand": [
                "mv"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.files[0].path)",
                    "position": 1
                },
                {
                    "valueFrom": "./",
                    "position": 2
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.files[0].basename)"
                    },
                    "id": "#array_to_file_tool.cwl/file"
                }
            ],
            "id": "#array_to_file_tool.cwl"
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
            "class": "ExpressionTool",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "label": "Merge file arrays",
            "doc": "Merges arrays of files in an array to a array of files\n",
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": "File"
                        }
                    },
                    "id": "#merge_file_arrays.cwl/input"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#merge_file_arrays.cwl/output"
                }
            ],
            "expression": "${\n  var output = [];\n  for (var i = 0; i < inputs.input.length; i++) {\n    var readgroup_array = inputs.input[i];\n    for (var j = 0; j < readgroup_array.length; j++) {\n      var readgroup = readgroup_array[j];\n      output.push(readgroup);\n    }\n  }\n  return {'output': output}\n}",
            "id": "#merge_file_arrays.cwl"
        },
        {
            "class": "CommandLineTool",
            "doc": "Modified from https://github.com/ambarishK/bio-cwl-tools/blob/release/fastp/fastp.cwl\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/fastp:0.24.1--heae3180_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.24.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/fastp",
                                "file:///home/bart/git/cwl/tools/fastp/doi.org/10.1002/imt2.107",
                                "https://identifiers.org/RRID:SCR_016962"
                            ],
                            "package": "fastp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "prefix": "--correction"
                    },
                    "id": "#fastp.cwl/base_correction"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": false,
                    "inputBinding": {
                        "prefix": "--dedup"
                    },
                    "id": "#fastp.cwl/deduplicate"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "prefix": "--disable_trim_poly_g"
                    },
                    "id": "#fastp.cwl/disable_trim_poly_g"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_poly_g"
                    },
                    "id": "#fastp.cwl/force_polyg_tail_trimming"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--in1"
                    },
                    "id": "#fastp.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#fastp.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": false,
                    "inputBinding": {
                        "prefix": "--merge"
                    },
                    "id": "#fastp.cwl/merge_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 50,
                    "inputBinding": {
                        "prefix": "--length_required"
                    },
                    "id": "#fastp.cwl/min_length_required"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 20,
                    "inputBinding": {
                        "prefix": "--qualified_quality_phred"
                    },
                    "id": "#fastp.cwl/qualified_phred_quality"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--in2"
                    },
                    "id": "#fastp.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--thread"
                    },
                    "id": "#fastp.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 20,
                    "inputBinding": {
                        "prefix": "--unqualified_percent_limit"
                    },
                    "id": "#fastp.cwl/unqualified_phred_quality"
                }
            ],
            "arguments": [
                {
                    "prefix": "--out1",
                    "valueFrom": "$(inputs.identifier)_fastp_1.fq.gz"
                },
                "${\n  if (inputs.reverse_reads){\n    return '--out2';\n  } else {\n    return null;\n  }\n}\n",
                "${\n  if (inputs.reverse_reads){\n    return inputs.identifier + \"_fastp_2.fq.gz\";\n  } else {\n    return null;\n  }\n}\n",
                "${\n  if (inputs.reverse_reads_path){\n    return '--out2';\n  } else {\n    return null;\n  }\n}\n",
                "${\n  if (inputs.reverse_reads_path){\n    return inputs.identifier + \"_fastp_2.fq.gz\";\n  } else {\n    return null;\n  }\n}\n",
                "${\n  if (inputs.merge_reads){\n    return '--merged_out';\n  } else {\n    return null;\n  }\n}\n",
                "${\n  if (inputs.merge_reads){\n    return inputs.identifier + \"merged_fastp.fq.gz\";\n  } else {\n    return null;\n  }\n}\n",
                {
                    "prefix": "-h",
                    "valueFrom": "$(inputs.identifier)_fastp-report.html"
                },
                {
                    "prefix": "-j",
                    "valueFrom": "$(inputs.identifier)_fastp-report.json"
                }
            ],
            "baseCommand": [
                "fastp"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_fastp-report.html"
                    },
                    "id": "#fastp.cwl/html_report"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_fastp-report.json"
                    },
                    "id": "#fastp.cwl/json_report"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_merged_fastp.fq.gz"
                    },
                    "id": "#fastp.cwl/merged_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_fastp_1.fq.gz"
                    },
                    "id": "#fastp.cwl/out_forward_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_fastp_2.fq.gz"
                    },
                    "id": "#fastp.cwl/out_reverse_reads"
                }
            ],
            "id": "#fastp.cwl",
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
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2025-08-08",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Interleave fastq file",
            "doc": "Interleave forward and reverse compressed (gzipped) fastq files.\npaste <(zcat fwd_1.fq.gz \\| paste - - - -) <(zcat rev_2.fq.gz \\| paste - - - -) \\| tr '\\t' '\\n' \\| pigz -p 4 -c > identifier.fastq.gz\n",
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
            "requirements": [
                {
                    "listing": [
                        {
                            "entry": "$({class: 'Directory', listing: []})",
                            "entryname": "interleave_fastq",
                            "writable": true
                        },
                        {
                            "entryname": "script.sh",
                            "entry": "#!/bin/bash\npaste <(zcat $1 | paste - - - -) <(zcat $2 | paste - - - -) | tr '\\t' '\\n' | pigz -p $3 -c"
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
                "script.sh"
            ],
            "stdout": "$(inputs.identifier).fastq.gz",
            "inputs": [
                {
                    "type": "File",
                    "doc": "Compressed (gzip) forward sequence fastq file",
                    "label": "Forward reads",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#interleave_fastq.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file",
                    "label": "output file name",
                    "id": "#interleave_fastq.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "Compressed (gzip) reverse sequence fastq file",
                    "label": "Reverse reads",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#interleave_fastq.cwl/reverse_reads"
                },
                {
                    "type": "int",
                    "doc": "Number of compression threads",
                    "label": "Threads",
                    "inputBinding": {
                        "position": 3
                    },
                    "default": 4,
                    "id": "#interleave_fastq.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "id": "#interleave_fastq.cwl/fastq_out",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).fastq.gz"
                    }
                }
            ],
            "id": "#interleave_fastq.cwl",
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
            "https://schema.org/dateCreated": "2024-05-21",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Hostile",
            "doc": "Read contamination filtering for short reads paired end data. \nIt will use bowtie2 as it's aligner. Therefor a bowtie2 database will need to be provided.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/hostile:2.0.1--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.0.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/hostile"
                            ],
                            "package": "hostile"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "hostile",
                "clean"
            ],
            "stdout": "$(inputs.output_filename_prefix)_summary.json",
            "arguments": [
                {
                    "prefix": "--aligner",
                    "valueFrom": "bowtie2"
                },
                {
                    "prefix": "--out",
                    "valueFrom": "hostile_out"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Forward reads",
                    "doc": "Forward read file",
                    "inputBinding": {
                        "prefix": "--fastq1"
                    },
                    "id": "#hostile_clean_shortreads.cwl/forward_reads"
                },
                {
                    "type": "Directory",
                    "loadListing": "deep_listing",
                    "doc": "Folder with bowtie2 index files",
                    "inputBinding": {
                        "prefix": "--index",
                        "valueFrom": "${\n    for (var i = 0; i < self.listing.length; i++) {\n        if (self.listing[i].path.split('.').slice(-3).join('.') == 'rev.1.bt2' ||\n            self.listing[i].path.split('.').slice(-3).join('.') == 'rev.1.bt2l'){\n          return self.listing[i].path.split('.').slice(0,-3).join('.');\n        }\n    }\n    return null;\n}\n"
                    },
                    "id": "#hostile_clean_shortreads.cwl/indexfolder"
                },
                {
                    "type": "boolean",
                    "doc": "Keep only reads aligning to the index (and their mates if applicable) (default false)",
                    "label": "Invert",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--invert"
                    },
                    "id": "#hostile_clean_shortreads.cwl/invert"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Name of the output file. (_1/_2).fq.gz will be appended to the reads. Default \"hostile_clean\"",
                    "label": "Output filename (base)",
                    "default": "hostile_clean",
                    "id": "#hostile_clean_shortreads.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Reverse reads",
                    "doc": "Reverse read file",
                    "inputBinding": {
                        "prefix": "--fastq2"
                    },
                    "id": "#hostile_clean_shortreads.cwl/reverse_reads"
                },
                {
                    "type": "int",
                    "doc": "Number of parallel threads to use. Default 4",
                    "label": "Threads",
                    "default": 4,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#hostile_clean_shortreads.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "hostile_out/*_1.fastq.gz",
                        "outputEval": "${self[0].basename=inputs.output_filename_prefix+\"_1.fq.gz\"; return self;}"
                    },
                    "id": "#hostile_clean_shortreads.cwl/out_forward_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "hostile_out/*_2.fastq.gz",
                        "outputEval": "${self[0].basename=inputs.output_filename_prefix+\"_2.fq.gz\"; return self;}"
                    },
                    "id": "#hostile_clean_shortreads.cwl/out_reverse_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#hostile_clean_shortreads.cwl/summary"
                }
            ],
            "id": "#hostile_clean_shortreads.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-07-25",
            "https://schema.org/dateCreated": "2025-07-25",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "HUMAnN Analysis",
            "doc": "Runs the HUMAnN 3 meta-omics taxonomic and functional profiling tool.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/humann:3.9--py312hdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.8"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/humann",
                                "file:///home/bart/git/cwl/tools/humann/doi.org/10.7554/eLife.65088"
                            ],
                            "package": "humann"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "humann"
            ],
            "stdout": "$(inputs.identifier)_HUMAnN.stdout.log",
            "arguments": [
                {
                    "prefix": "--output",
                    "valueFrom": "$(inputs.identifier)_HUMAnN"
                },
                {
                    "prefix": "--o-log",
                    "valueFrom": "$(inputs.identifier)_HUMAnN.log"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "doc": "Identifier for output files.",
                    "label": "Identifier",
                    "id": "#humann.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "a single file that is one of the following types filtered shotgun sequencing metagenome file (fastq, fastq.gz, fasta, or fasta.gz format) alignment file (sam, bam or blastm8 format) gene table file (tsv or biom format)",
                    "label": "Input",
                    "inputBinding": {
                        "prefix": "--input"
                    },
                    "id": "#humann.cwl/input_file"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "location of a indexed metaphlan database",
                    "label": "metaphlan database",
                    "inputBinding": {
                        "prefix": "--metaphlan-options"
                    },
                    "id": "#humann.cwl/metaphlan-options"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing the nucleotide database",
                    "label": "Nucleotide database",
                    "inputBinding": {
                        "prefix": "--nucleotide-database"
                    },
                    "id": "#humann.cwl/nucleotide_database"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing the protein database",
                    "label": "Protein database",
                    "inputBinding": {
                        "prefix": "--protein-database"
                    },
                    "id": "#humann.cwl/protein_database"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Search for uniref50 or uniref90 gene families. Default, based on translated database selected.",
                    "label": "Search mode",
                    "inputBinding": {
                        "prefix": "--search-mode"
                    },
                    "id": "#humann.cwl/search_mode"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A taxonomic profile (the output file created by metaphlan)",
                    "label": "Taxonomic Profile",
                    "inputBinding": {
                        "prefix": "--taxonomic-profile"
                    },
                    "id": "#humann.cwl/taxonomic_profile"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 2,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#humann.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_HUMAnN/*_genefamilies.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_HUMAnN_genefamilies.tsv\"; return self;}"
                    },
                    "id": "#humann.cwl/genefamilies_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_HUMAnN.log"
                    },
                    "id": "#humann.cwl/log_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_HUMAnN/*_pathabundance.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_HUMAnN_pathabundance.tsv\"; return self;}"
                    },
                    "id": "#humann.cwl/pathabundance_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_HUMAnN/*_pathcoverage.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_HUMAnN_pathcoverage.tsv\"; return self;}"
                    },
                    "id": "#humann.cwl/pathcoverage_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_HUMAnN.stdout.log"
                    },
                    "id": "#humann.cwl/stdout_out"
                }
            ],
            "id": "#humann.cwl",
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
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/dateModified": "2024-05-22",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "HUMAnN3 humann_regroup_table",
            "doc": "Runs the HUMAnN 3 humann_regroup_table function.\nHUMAnN utility for regrouping table features\n=============================================\nGiven a table of feature values and a mapping of groups to component features, produce a \nnew table with group values in place of feature values.\n\nThis tool makes use of the docker image wherein the utility mapping databases are included.\nIt includes a script by which you can create all possible mappings at once or separately.\n\nDocker build:\nhttps://gitlab.com/m-unlock/docker/-/tree/main/tools/humann3?ref_type=heads\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/humann:3.9",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.8"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/humann",
                                "file:///home/bart/git/cwl/tools/humann/doi.org/10.7554/eLife.65088"
                            ],
                            "package": "humann"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "humann_regroup_table.sh"
            ],
            "inputs": [
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_regroup_table.cwl/add_unireftype/Y",
                                "#humann_regroup_table.cwl/add_unireftype/N"
                            ]
                        }
                    ],
                    "doc": "Add uniref_type to output file name.  Default Y. (Ignored when output_filename_prefix is used)",
                    "label": "Add uniref type",
                    "default": "Y",
                    "inputBinding": {
                        "position": 3
                    },
                    "id": "#humann_regroup_table.cwl/add_unireftype"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_regroup_table.cwl/function/sum",
                                "#humann_regroup_table.cwl/function/mean"
                            ]
                        }
                    ],
                    "doc": "How to combine grouped features; default=sum",
                    "label": "Function",
                    "default": "sum",
                    "inputBinding": {
                        "prefix": "--function",
                        "position": 15
                    },
                    "id": "#humann_regroup_table.cwl/function"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_regroup_table.cwl/group/all",
                                "#humann_regroup_table.cwl/group/uniref90_rxn",
                                "#humann_regroup_table.cwl/group/uniref90_go",
                                "#humann_regroup_table.cwl/group/uniref90_ko",
                                "#humann_regroup_table.cwl/group/uniref90_level4ec",
                                "#humann_regroup_table.cwl/group/uniref90_pfam",
                                "#humann_regroup_table.cwl/group/uniref90_eggnog",
                                "#humann_regroup_table.cwl/group/uniref50_rxn",
                                "#humann_regroup_table.cwl/group/uniref50_go",
                                "#humann_regroup_table.cwl/group/uniref50_ko",
                                "#humann_regroup_table.cwl/group/uniref50_level4ec",
                                "#humann_regroup_table.cwl/group/uniref50_pfam",
                                "#humann_regroup_table.cwl/group/uniref50_eggnog"
                            ]
                        }
                    ],
                    "doc": "Built in grouping options. Choose all to generate all possible tables based on your uniref_type input.",
                    "label": "Group",
                    "inputBinding": {
                        "prefix": "--group",
                        "position": 99
                    },
                    "id": "#humann_regroup_table.cwl/group"
                },
                {
                    "type": "File",
                    "doc": "Input table",
                    "label": "Input table",
                    "inputBinding": {
                        "prefix": "--input",
                        "position": 13
                    },
                    "id": "#humann_regroup_table.cwl/input_table"
                },
                {
                    "type": "string",
                    "doc": "Optional output filename. Default is based on the input table; inputtablename_uniref-type_group.tsv",
                    "label": "Threads",
                    "default": "None",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#humann_regroup_table.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Decimal places to round to after applying function; default=Don't round",
                    "label": "Precision",
                    "inputBinding": {
                        "prefix": "--precision",
                        "position": 14
                    },
                    "id": "#humann_regroup_table.cwl/precision"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_regroup_table.cwl/protected/Y",
                                "#humann_regroup_table.cwl/protected/N"
                            ]
                        }
                    ],
                    "doc": "Carry through protected features, such as 'UNMAPPED'? default=Y",
                    "label": "Protected",
                    "default": "Y",
                    "inputBinding": {
                        "prefix": "--protected",
                        "position": 17
                    },
                    "id": "#humann_regroup_table.cwl/protected"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use",
                    "label": "Threads",
                    "default": 2,
                    "inputBinding": {
                        "position": 0
                    },
                    "id": "#humann_regroup_table.cwl/threads"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_regroup_table.cwl/ungrouped/Y",
                                "#humann_regroup_table.cwl/ungrouped/N"
                            ]
                        }
                    ],
                    "doc": "Include an 'UNGROUPED' group to capture features that did not belong to other groups? default=Y",
                    "label": "Ungrouped",
                    "default": "Y",
                    "inputBinding": {
                        "prefix": "--ungrouped",
                        "position": 16
                    },
                    "id": "#humann_regroup_table.cwl/ungrouped"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_regroup_table.cwl/uniref_type/uniref90",
                                "#humann_regroup_table.cwl/uniref_type/uniref50"
                            ]
                        }
                    ],
                    "doc": "UniRef50 or UniRef90. Match this with the database you used. Only has effect when selected \"all\" as the group input.",
                    "label": "UniRef database type",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#humann_regroup_table.cwl/uniref_type"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#humann_regroup_table.cwl/regrouped_table"
                }
            ],
            "id": "#humann_regroup_table.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-02-21",
            "https://schema.org/dateCreated": "2025-02-11",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "HUMAnN3 humann_renorm_table",
            "doc": "Runs the HUMAnN 3 humann_renorm_table function.\nHUMAnN utility for renormalizing TSV files\n===========================================\nEach level of a stratified table will be \nnormalized using the desired scheme.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/humann:3.9--py312hdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.8"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/humann",
                                "file:///home/bart/git/cwl/tools/humann/doi.org/10.7554/eLife.65088"
                            ],
                            "package": "humann"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "humann_renorm_table"
            ],
            "arguments": [
                {
                    "prefix": "--output",
                    "valueFrom": "$(inputs.input_table.nameroot)-$(inputs.mode)-$(inputs.units).tsv"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Input table",
                    "label": "Input table",
                    "inputBinding": {
                        "prefix": "--input"
                    },
                    "id": "#humann_renorm_table.cwl/input_table"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_renorm_table.cwl/mode/community",
                                "#humann_renorm_table.cwl/mode/levelwise"
                            ]
                        }
                    ],
                    "doc": "Normalize all levels by [community] total or [levelwise] totals; default=[community]",
                    "label": "Mode",
                    "default": "community",
                    "inputBinding": {
                        "prefix": "--mode"
                    },
                    "id": "#humann_renorm_table.cwl/mode"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_renorm_table.cwl/special/y",
                                "#humann_renorm_table.cwl/special/n"
                            ]
                        }
                    ],
                    "doc": "Include the special features UNMAPPED, UNINTEGRATED, and UNGROUPED; default=[y]",
                    "label": "Special",
                    "default": "y",
                    "inputBinding": {
                        "prefix": "--special"
                    },
                    "id": "#humann_renorm_table.cwl/special"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#humann_renorm_table.cwl/units/cpm",
                                "#humann_renorm_table.cwl/units/relab"
                            ]
                        }
                    ],
                    "doc": "Normalization scheme, copies per million [cpm], relative abundance [relab] default=[cpm]",
                    "label": "Units",
                    "default": "cpm",
                    "inputBinding": {
                        "prefix": "--units"
                    },
                    "id": "#humann_renorm_table.cwl/units"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Update '-RPK' in sample names to appropriate suffix; default false",
                    "label": "Update sname",
                    "inputBinding": {
                        "prefix": "--update-sname"
                    },
                    "id": "#humann_renorm_table.cwl/update-sname"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#humann_renorm_table.cwl/renormalized_table"
                }
            ],
            "id": "#humann_renorm_table.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-02-14",
            "https://schema.org/dateCreated": "2025-02-11",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "HUMAnN3 humann_unpack_pathways",
            "doc": "Runs the HUMAnN 3 humann_unpack_pathways function.\nThis utility will unpack the pathways to show the genes for each. \nIt adds another level of stratification to the pathway abundance table by including the gene families (or EC) abundances.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/humann:3.9--py312hdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.8"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/humann",
                                "file:///home/bart/git/cwl/tools/humann/doi.org/10.7554/eLife.65088"
                            ],
                            "package": "humann"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "humann_unpack_pathways"
            ],
            "arguments": [
                {
                    "prefix": "--output",
                    "valueFrom": "$(inputs.identifier)_HUMAnN_pathways_unpacked.tsv"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "doc": "Identifier for output files.",
                    "label": "Identifier",
                    "id": "#humann_unpack_pathways.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "A file containing the gene families (or EC) abundance table (tsv format)",
                    "label": "Input genes",
                    "inputBinding": {
                        "prefix": "--input-genes"
                    },
                    "id": "#humann_unpack_pathways.cwl/input_genes"
                },
                {
                    "type": "File",
                    "doc": "A file containing the pathways abundance table (tsv format)",
                    "label": "Input pathways",
                    "inputBinding": {
                        "prefix": "--input-pathways"
                    },
                    "id": "#humann_unpack_pathways.cwl/input_pathways"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_HUMAnN_pathways_unpacked.tsv"
                    },
                    "id": "#humann_unpack_pathways.cwl/pathway_genes_abundances"
                }
            ],
            "id": "#humann_unpack_pathways.cwl",
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
            "https://schema.org/dateModified": "2025-02-14",
            "https://schema.org/dateCreated": "2024-05-22",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "MetaPhlAn 4",
            "doc": "MetaPhlAn 4 is a computational tool for profiling the composition of microbial communities (Bacteria, Archaea and Eukaryotes) \nfrom metagenomic shotgun sequencing data (i.e. not 16S) with species-level.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/metaphlan:4.1.1--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "4.1.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/metaphlan",
                                "file:///home/bart/git/cwl/tools/metaphlan/doi.org/10.1101/2022.08.22.504593"
                            ],
                            "package": "diamond"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "metaphlan"
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "position": 4,
                    "valueFrom": "$(inputs.identifier)_MetaPhlAn4_profile.txt"
                },
                {
                    "prefix": "--bowtie2out",
                    "position": 5,
                    "valueFrom": "$(inputs.identifier)_MetaPhlAn4.bowtie2.bz2"
                }
            ],
            "inputs": [
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#metaphlan4.cwl/analysis_type/rel_ab",
                                "#metaphlan4.cwl/analysis_type/rel_ab_w_read_stats",
                                "#metaphlan4.cwl/analysis_type/reads_map",
                                "#metaphlan4.cwl/analysis_type/clade_profiles",
                                "#metaphlan4.cwl/analysis_type/marker_ab_table",
                                "#metaphlan4.cwl/analysis_type/marker_counts",
                                "#metaphlan4.cwl/analysis_type/marker_pres_table",
                                "#metaphlan4.cwl/analysis_type/clade_specific_strain_tracker"
                            ],
                            "inputBinding": {
                                "prefix": "-t"
                            }
                        }
                    ],
                    "doc": "Type of analysis to perform\n* rel_ab: profiling a metagenomes in terms of relative abundances\n* rel_ab_w_read_stats: profiling a metagenomes in terms of relative abundances and estimate the number of reads coming from each clade.\n* reads_map: mapping from reads to clades (only reads hitting a marker)\n* clade_profiles: normalized marker counts for clades with at least a non-null marker\n* marker_ab_table: normalized marker counts (only when > 0.0 and normalized by metagenome size if --nreads is specified)\n* marker_counts: non-normalized marker counts [use with extreme caution]\n* marker_pres_table: list of markers present in the sample (threshold at 1.0 if not differently specified with --pres_th\n* clade_specific_strain_tracker: list of markers present for a specific clade, specified with --clade, and all its subclades\n",
                    "label": "Analysis type",
                    "default": "rel_ab",
                    "id": "#metaphlan4.cwl/analysis_type"
                },
                {
                    "type": "Directory",
                    "doc": "location of the metaphlan4 bowtie2 database",
                    "label": "Bowtie2 database",
                    "inputBinding": {
                        "prefix": "--bowtie2db",
                        "position": 3
                    },
                    "id": "#metaphlan4.cwl/bowtie2db"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Identifier for this dataset. Default \"metagenome\"",
                    "label": "identifier used",
                    "default": "metagenome",
                    "id": "#metaphlan4.cwl/identifier"
                },
                {
                    "type": "string",
                    "doc": "set whether the input is the FASTA file of metagenomic reads or the SAM file of the mapping of the reads against the MetaPhlAn db. \nfastq, fasta, bowtie2out, sam.\n",
                    "label": "Input type",
                    "inputBinding": {
                        "prefix": "--input_type",
                        "position": 2
                    },
                    "id": "#metaphlan4.cwl/input_type"
                },
                {
                    "type": "File",
                    "doc": "Input reads file",
                    "label": "Reads",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#metaphlan4.cwl/reads"
                },
                {
                    "type": "int",
                    "label": "threads",
                    "doc": "Number of computational threads to use",
                    "inputBinding": {
                        "prefix": "--nproc",
                        "position": 4
                    },
                    "id": "#metaphlan4.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_MetaPhlAn4.bowtie2.bz2"
                    },
                    "id": "#metaphlan4.cwl/bowtie2out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_MetaPhlAn4_profile.txt"
                    },
                    "id": "#metaphlan4.cwl/profile"
                }
            ],
            "id": "#metaphlan4.cwl",
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
            "https://schema.org/dateCreated": "2025-04-04",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Sequali, fast sequencing data quality metrics",
            "doc": "Sequence quality metrics for FASTQ and uBAM files.\nDocumentation on how to install and run Sequali can be found here:\nhttps://sequali.readthedocs.io/en/latest/\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/sequali:0.12.0--py311haab0aaa_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.12.0"
                            ],
                            "specs": [
                                "file:///home/bart/git/cwl/tools/sequali/identifiers.org/RRID:SCR_026466"
                            ],
                            "package": "sequali"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "sequali"
            ],
            "arguments": [
                {
                    "valueFrom": "sequali_output",
                    "prefix": "--outdir",
                    "position": 3
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "adapter file",
                    "doc": "File with adapters to search for. See default file for formatting.\nDefaults to /home/docs/checkouts/readthedocs.org/user_builds/sequali/envs/latest/lib/python3.13/site-packages/sequali/adapters/adapter_list.tsv\nDefault adapter file also present in the container: /usr/local/lib/python3.11/site-packages/sequali/adapters/adapter_list.tsv\n",
                    "inputBinding": {
                        "prefix": "--adapter-file"
                    },
                    "id": "#sequali.cwl/adapter_file"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "maximum number of fingerprints for duplication estimation",
                    "doc": "Max number of fingerprints to store for estimation of duplication rate.\nMore fingerprints leads to a more accurate estimate, but also more memory usage. Default: 1000000\n",
                    "inputBinding": {
                        "prefix": "--duplication-max-stored-fingerprints"
                    },
                    "id": "#sequali.cwl/duplication_max_stored_fingerprints"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "amount of deduplication bases back",
                    "doc": "Number of bases taken for the deduplication fingerprint from the back. Default: 8",
                    "inputBinding": {
                        "prefix": "--fingerprint-back-length"
                    },
                    "id": "#sequali.cwl/fingerprint_back_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "offset deduplication back",
                    "doc": "Offset for the back part of the deduplication fingerprint. Useful for avoiding adapter sequences.\nDefault: 64 for single end (0 for paired sequences).\n",
                    "inputBinding": {
                        "prefix": "--fingerprint-back-offset"
                    },
                    "id": "#sequali.cwl/fingerprint_back_offset"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "amount of deduplication bases front",
                    "doc": "Number of bases taken for the deduplication fingerprint from the front. Default: 8",
                    "inputBinding": {
                        "prefix": "--fingerprint-front-length"
                    },
                    "id": "#sequali.cwl/fingerprint_front_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "offset deduplication front",
                    "doc": "Offset for the front part of the deduplication fingerprint. Useful for avoiding adapter sequences.\nDefault: 64 for single end (0 for paired sequences).\n",
                    "inputBinding": {
                        "prefix": "--fingerprint-front-offset"
                    },
                    "id": "#sequali.cwl/fingerprint_front_offset"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "output HTML filename",
                    "doc": "File path for .json out put file, defaults to \"<outdir>/($input_file).html\".",
                    "inputBinding": {
                        "prefix": "--html"
                    },
                    "id": "#sequali.cwl/html_output"
                },
                {
                    "type": "File",
                    "label": "input file",
                    "doc": "Input file in FASTQ or uBAM format, compressed formats are supported.",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#sequali.cwl/input_file"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "output json filename",
                    "doc": "File path for .json out put file, defaults to \"<outdir>/($input_file).json\".",
                    "inputBinding": {
                        "prefix": "--json"
                    },
                    "id": "#sequali.cwl/json_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "fragment length",
                    "doc": "Length of fragments to sample. Maximum is 31. Default: 21",
                    "inputBinding": {
                        "prefix": "--overrepresentation-fragment-length"
                    },
                    "id": "#sequali.cwl/overrep_fragment_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "overrepresentation maximum",
                    "doc": "Maximum occurrences for a sequence to be considered overrepresented regardless of the fraction. Default: 9223372036854775807",
                    "inputBinding": {
                        "prefix": "--overrepresentation-max-threshold"
                    },
                    "id": "#sequali.cwl/overrep_max_threshold"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "maximum unique fragments",
                    "doc": "Maximum amount of unique fragments to store.\nLarger amounts increase the sensitivity of finding overrepresented sequences at the cost of increasing memory usage. Default: 5000000\n",
                    "inputBinding": {
                        "prefix": "--overrepresentation-max-unique-fragments"
                    },
                    "id": "#sequali.cwl/overrep_max_unique_fragments"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "overrepresentation minimum",
                    "doc": "Minimum occurrences for a sequence to be considered overrepresented regardless of the fraction. Default: 100",
                    "inputBinding": {
                        "prefix": "--overrepresentation-min-threshold"
                    },
                    "id": "#sequali.cwl/overrep_min_threshold"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "sample frequency",
                    "doc": "How often a read should be sampled.\nMore samples improve precision at the cost of speed as well as more bias towards the beginning of the file as the fragment store gets filled up with more sequences from the beginning.\nValue is set ax 1 in X, defaults to 8\n",
                    "inputBinding": {
                        "prefix": "--overrepresentation-sample-every"
                    },
                    "id": "#sequali.cwl/overrep_sample_every"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "overrepresentation fraction",
                    "doc": "At what fraction a sequence is determined to be overrepresented.\nDefault: 0.001 (1 in 1000)\n",
                    "inputBinding": {
                        "prefix": "--overrepresentation-threshold-fraction"
                    },
                    "id": "#sequali.cwl/overrep_threshold_fraction"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "second input file",
                    "doc": "Second input file for paired-end data.",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#sequali.cwl/paired_input"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "CPU usage",
                    "doc": "The number of threads used, defaults to 2.",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#sequali.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "label": "output directory",
                    "outputBinding": {
                        "glob": "sequali_output"
                    },
                    "id": "#sequali.cwl/output_directory"
                },
                {
                    "type": "File",
                    "label": "output HTML file",
                    "format": "http://edamontology.org/format_2331",
                    "streamable": true,
                    "outputBinding": {
                        "glob": "sequali_output/*.html"
                    },
                    "id": "#sequali.cwl/report_html"
                },
                {
                    "type": "File",
                    "label": "output JSON file",
                    "format": "http://edamontology.org/format_3464",
                    "streamable": true,
                    "outputBinding": {
                        "glob": "sequali_output/*.json"
                    },
                    "id": "#sequali.cwl/report_json"
                }
            ],
            "id": "#sequali.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0005-0017-0928",
                    "https://schema.org/email": "mailto:martijn.melissen@wur.nl",
                    "https://schema.org/name": "Martijn Melissen"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://git.wur.nl/ssb/automated-data-analysis",
            "https://schema.org/dateCreated": "2025-02-24",
            "https://schema.org/dateModified": "2025-02-24",
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
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "label": "HUMAnN 3 workflow",
            "doc": "Runs MetaPhlAn 4 and HUMAnN 3 pipeline. Including illumina quality control reads. (Only paired end) \\\nIncludes renormalizing and all regroupings to other functional categories (EC,KO.. etc)\n",
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Filtered forward read",
                    "doc": "Filtered forward read",
                    "outputSource": "#main/out_fwd_reads/fwd_out",
                    "id": "#main/QC_forward_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Filtered reverse read",
                    "doc": "Filtered reverse read",
                    "outputSource": "#main/out_rev_reads/rev_out",
                    "id": "#main/QC_reverse_reads"
                },
                {
                    "type": "File",
                    "label": "Gene families",
                    "doc": "HUMAnN 3 Gene families abundances",
                    "outputSource": "#main/humann/genefamilies_out",
                    "id": "#main/humann_genefamilies_out"
                },
                {
                    "type": "File",
                    "label": "HUMAnN 3 log",
                    "doc": "HUMAnN 3",
                    "outputSource": "#main/humann/log_out",
                    "id": "#main/humann_log_out"
                },
                {
                    "type": "File",
                    "label": "Pathway abundances",
                    "doc": "HUMAnN 3 pathway abundances",
                    "outputSource": "#main/humann/pathabundance_out",
                    "id": "#main/humann_pathabundance_out"
                },
                {
                    "type": "File",
                    "label": "Pathway coverage",
                    "doc": "HUMAnN 3 pathway coverage",
                    "outputSource": "#main/humann/pathcoverage_out",
                    "id": "#main/humann_pathcoverage_out"
                },
                {
                    "type": "File",
                    "label": "Pathways unpacked",
                    "doc": "HUMAnN 3 pathways gene abundances",
                    "outputSource": "#main/humann_unpack_pathways/pathway_genes_abundances",
                    "id": "#main/humann_pathways_unpacked"
                },
                {
                    "type": "File",
                    "label": "HUMAnN 3 stdout",
                    "doc": "HUMAnN 3 standard out",
                    "outputSource": "#main/humann/stdout_out",
                    "id": "#main/humann_stdout_out"
                },
                {
                    "type": "File",
                    "label": "MetaPhlAn4 bt2out",
                    "doc": "MetaPhlAn4 bowtie 2 output",
                    "outputSource": "#main/metaphlan/bowtie2out",
                    "id": "#main/metaphlan_bt2out"
                },
                {
                    "type": "File",
                    "label": "MetaPhlAn4 profile",
                    "doc": "MetaPhlAn4 profile tsv",
                    "outputSource": "#main/metaphlan/profile",
                    "id": "#main/metaphlan_profile"
                },
                {
                    "type": "Directory",
                    "label": "Normalized tables",
                    "doc": "Normalized tables Director",
                    "outputSource": "#main/files_to_folder_normalized/results",
                    "id": "#main/normalized_tables"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Quality reports output directory",
                    "outputSource": "#main/workflow_illumina_quality/reports_folder",
                    "id": "#main/quality_reports"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "Regrouped tables",
                    "doc": "Regrouped tabes unnormalized",
                    "outputSource": "#main/humann_regroup_table/regrouped_table",
                    "id": "#main/regrouped_tables"
                }
            ],
            "inputs": [
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
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Forward sequence fastq file",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#main/forward_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Bowtie2 index folder. Provide the folder in which the in index files are located.",
                    "label": "Filter human reads",
                    "loadListing": "no_listing",
                    "id": "#main/humandb"
                },
                {
                    "type": "Directory",
                    "label": "HUMAnN3 nucleotide database",
                    "doc": "HUMAnN3 nucleotide database location",
                    "loadListing": "no_listing",
                    "id": "#main/humann3_nucleotide_database"
                },
                {
                    "type": "Directory",
                    "label": "HUMAnN3 protein database",
                    "doc": "HUMAnN3 protein database location",
                    "loadListing": "no_listing",
                    "id": "#main/humann3_protein_database"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#main/identifier"
                },
                {
                    "type": "int",
                    "doc": "Maximum memory usage in megabytes (default 8000)",
                    "label": "Memory usage (MB)",
                    "default": 8000,
                    "id": "#main/memory"
                },
                {
                    "type": "Directory",
                    "label": "MetaPhlAn4 database",
                    "doc": "MetaPhlAn4 database location",
                    "loadListing": "no_listing",
                    "id": "#main/metaphlan4_bt2_database"
                },
                {
                    "type": "boolean",
                    "label": "Output filtered reads",
                    "doc": "Output filtered reads when filtering is applied. (Default false)",
                    "default": false,
                    "id": "#main/output_filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Custom reference database for filtering with Hostile. \nProvide the folder in which the bowtie2 index files are located. (default false)\n",
                    "label": "Filter reference file(s)",
                    "loadListing": "no_listing",
                    "id": "#main/reference_filter_db"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Reverse sequence fastq file",
                    "label": "Reverse reads",
                    "loadListing": "no_listing",
                    "id": "#main/reverse_reads"
                },
                {
                    "type": "boolean",
                    "label": "Skip quality filtering",
                    "doc": "Skip quality filtering. (Default false)",
                    "default": false,
                    "id": "#main/skip_read_filter"
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
                    "type": "int",
                    "doc": "Number of threads to use for computational processes",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#main/threads"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#main/uniref_dbtype/uniref50",
                                "#main/uniref_dbtype/uniref90"
                            ]
                        }
                    ],
                    "doc": "uniref50 or uniref90. Match this with your selected database!",
                    "label": "UniRef database type",
                    "id": "#main/uniref_dbtype"
                },
                {
                    "type": "boolean",
                    "doc": "Use mapped reads mapped to the custom reference db. (Default false, discard mapped)",
                    "label": "Use mapped reads",
                    "default": false,
                    "id": "#main/use_reference_mapped_reads"
                }
            ],
            "steps": [
                {
                    "label": "Normalized tables",
                    "doc": "Normalized tables folder",
                    "in": [
                        {
                            "default": "normalized_tables",
                            "id": "#main/files_to_folder_normalized/destination"
                        },
                        {
                            "source": [
                                "#main/humann_renorm_table_genefamilies/renormalized_table",
                                "#main/humann_renorm_table_pathways/renormalized_table",
                                "#main/renorm_groups_to_array/output"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/files_to_folder_normalized/files"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#main/files_to_folder_normalized/results"
                    ],
                    "id": "#main/files_to_folder_normalized"
                },
                {
                    "label": "HUMAnN 3",
                    "doc": "HMP Unified Metabolic Analysis Network.",
                    "run": "#humann.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_$(inputs.uniref_dbtype)",
                            "id": "#main/humann/identifier"
                        },
                        {
                            "source": "#main/interleave_fastq/fastq_out",
                            "id": "#main/humann/input_file"
                        },
                        {
                            "source": "#main/humann3_nucleotide_database",
                            "id": "#main/humann/nucleotide_database"
                        },
                        {
                            "source": "#main/humann3_protein_database",
                            "id": "#main/humann/protein_database"
                        },
                        {
                            "source": "#main/metaphlan/profile",
                            "id": "#main/humann/taxonomic_profile"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/humann/threads"
                        },
                        {
                            "source": "#main/uniref_dbtype",
                            "id": "#main/humann/uniref_dbtype"
                        }
                    ],
                    "out": [
                        "#main/humann/genefamilies_out",
                        "#main/humann/pathabundance_out",
                        "#main/humann/pathcoverage_out",
                        "#main/humann/log_out",
                        "#main/humann/stdout_out"
                    ],
                    "id": "#main/humann"
                },
                {
                    "label": "Regroup renormalized",
                    "doc": "HUMAnN 3 regroup renormalized genefamilies",
                    "run": "#humann_regroup_table.cwl",
                    "scatter": "#main/humann_regroup_renorm_table/input_table",
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "default": "N",
                            "id": "#main/humann_regroup_renorm_table/add_unireftype"
                        },
                        {
                            "default": "all",
                            "id": "#main/humann_regroup_renorm_table/group"
                        },
                        {
                            "source": [
                                "#main/humann_renorm_table_genefamilies/renormalized_table"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/humann_regroup_renorm_table/input_table"
                        },
                        {
                            "source": "#main/uniref_dbtype",
                            "id": "#main/humann_regroup_renorm_table/uniref_type"
                        }
                    ],
                    "out": [
                        "#main/humann_regroup_renorm_table/regrouped_table"
                    ],
                    "id": "#main/humann_regroup_renorm_table"
                },
                {
                    "label": "Regroup unnormalized",
                    "doc": "HUMAnN 3 regroup genefamily",
                    "run": "#humann_regroup_table.cwl",
                    "in": [
                        {
                            "default": "N",
                            "id": "#main/humann_regroup_table/add_unireftype"
                        },
                        {
                            "default": "all",
                            "id": "#main/humann_regroup_table/group"
                        },
                        {
                            "source": "#main/humann/genefamilies_out",
                            "id": "#main/humann_regroup_table/input_table"
                        },
                        {
                            "source": "#main/uniref_dbtype",
                            "id": "#main/humann_regroup_table/uniref_type"
                        }
                    ],
                    "out": [
                        "#main/humann_regroup_table/regrouped_table"
                    ],
                    "id": "#main/humann_regroup_table"
                },
                {
                    "label": "Renorm gene families",
                    "doc": "HUMAnN 3 renormalize genefamilies",
                    "scatter": "#main/humann_renorm_table_genefamilies/units",
                    "scatterMethod": "dotproduct",
                    "run": "#humann_renorm_table.cwl",
                    "in": [
                        {
                            "source": "#main/humann/genefamilies_out",
                            "id": "#main/humann_renorm_table_genefamilies/input_table"
                        },
                        {
                            "default": "community",
                            "id": "#main/humann_renorm_table_genefamilies/mode"
                        },
                        {
                            "default": [
                                "cpm",
                                "relab"
                            ],
                            "id": "#main/humann_renorm_table_genefamilies/units"
                        },
                        {
                            "default": true,
                            "id": "#main/humann_renorm_table_genefamilies/update-sname"
                        }
                    ],
                    "out": [
                        "#main/humann_renorm_table_genefamilies/renormalized_table"
                    ],
                    "id": "#main/humann_renorm_table_genefamilies"
                },
                {
                    "label": "Renorm pathways",
                    "doc": "HUMAnN 3 renormalize pathways",
                    "run": "#humann_renorm_table.cwl",
                    "scatter": [
                        "#main/humann_renorm_table_pathways/units",
                        "#main/humann_renorm_table_pathways/input_table"
                    ],
                    "scatterMethod": "flat_crossproduct",
                    "in": [
                        {
                            "source": [
                                "#main/humann/pathabundance_out",
                                "#main/humann_unpack_pathways/pathway_genes_abundances"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/humann_renorm_table_pathways/input_table"
                        },
                        {
                            "default": "community",
                            "id": "#main/humann_renorm_table_pathways/mode"
                        },
                        {
                            "default": [
                                "cpm",
                                "relab"
                            ],
                            "id": "#main/humann_renorm_table_pathways/units"
                        }
                    ],
                    "out": [
                        "#main/humann_renorm_table_pathways/renormalized_table"
                    ],
                    "id": "#main/humann_renorm_table_pathways"
                },
                {
                    "label": "Unpack pathways",
                    "doc": "HUMAnN 3 Unpack pathways",
                    "run": "#humann_unpack_pathways.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_$(inputs.uniref_dbtype)",
                            "id": "#main/humann_unpack_pathways/identifier"
                        },
                        {
                            "source": "#main/humann/genefamilies_out",
                            "id": "#main/humann_unpack_pathways/input_genes"
                        },
                        {
                            "source": "#main/humann/pathabundance_out",
                            "id": "#main/humann_unpack_pathways/input_pathways"
                        },
                        {
                            "source": "#main/uniref_dbtype",
                            "id": "#main/humann_unpack_pathways/uniref_dbtype"
                        }
                    ],
                    "out": [
                        "#main/humann_unpack_pathways/pathway_genes_abundances"
                    ],
                    "id": "#main/humann_unpack_pathways"
                },
                {
                    "label": "Interleave fastq",
                    "doc": "Interleave QC forward and reverse files for subsequent tools",
                    "run": "#interleave_fastq.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/workflow_illumina_quality/QC_forward_reads",
                                "#main/workflow_merge_reads/forward_reads_out"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/interleave_fastq/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_interleaved",
                            "id": "#main/interleave_fastq/identifier"
                        },
                        {
                            "source": [
                                "#main/workflow_illumina_quality/QC_reverse_reads",
                                "#main/workflow_merge_reads/reverse_reads_out"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/interleave_fastq/reverse_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/interleave_fastq/threads"
                        }
                    ],
                    "out": [
                        "#main/interleave_fastq/fastq_out"
                    ],
                    "id": "#main/interleave_fastq"
                },
                {
                    "label": "MetaPhlAn 4",
                    "doc": "Profiling the composition of microbial communities",
                    "run": "#metaphlan4.cwl",
                    "in": [
                        {
                            "default": "rel_ab_w_read_stats",
                            "id": "#main/metaphlan/analysis_type"
                        },
                        {
                            "source": "#main/metaphlan4_bt2_database",
                            "id": "#main/metaphlan/bowtie2db"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/metaphlan/identifier"
                        },
                        {
                            "default": "fastq",
                            "id": "#main/metaphlan/input_type"
                        },
                        {
                            "source": "#main/interleave_fastq/fastq_out",
                            "id": "#main/metaphlan/reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/metaphlan/threads"
                        }
                    ],
                    "out": [
                        "#main/metaphlan/profile",
                        "#main/metaphlan/bowtie2out"
                    ],
                    "id": "#main/metaphlan"
                },
                {
                    "label": "Output fwd reads",
                    "doc": "Step needed to output filtered reads because there is an option to not to.",
                    "when": "$(!inputs.skip_read_filter && inputs.output_filtered_reads)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "id": "#main/out_fwd_reads/run/fwd_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/out_fwd_reads/run/fwd_out"
                            }
                        ],
                        "expression": "${ return {'fwd_out': inputs.fwd_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#main/workflow_illumina_quality/QC_forward_reads",
                            "id": "#main/out_fwd_reads/fwd_in"
                        },
                        {
                            "source": "#main/output_filtered_reads",
                            "id": "#main/out_fwd_reads/output_filtered_reads"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/out_fwd_reads/skip_read_filter"
                        }
                    ],
                    "out": [
                        "#main/out_fwd_reads/fwd_out"
                    ],
                    "id": "#main/out_fwd_reads"
                },
                {
                    "label": "Output rev reads",
                    "doc": "Step needed to output filtered reads because there is an option to not to.",
                    "when": "$(!inputs.skip_read_filter && inputs.output_filtered_reads)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "id": "#main/out_rev_reads/run/rev_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/out_rev_reads/run/rev_out"
                            }
                        ],
                        "expression": "${ return {'rev_out': inputs.rev_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#main/output_filtered_reads",
                            "id": "#main/out_rev_reads/output_filtered_reads"
                        },
                        {
                            "source": "#main/workflow_illumina_quality/QC_reverse_reads",
                            "id": "#main/out_rev_reads/rev_in"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/out_rev_reads/skip_read_filter"
                        }
                    ],
                    "out": [
                        "#main/out_rev_reads/rev_out"
                    ],
                    "id": "#main/out_rev_reads"
                },
                {
                    "run": "#merge_file_arrays.cwl",
                    "label": "Merge file arrays",
                    "doc": "Merges arrays of files in an array to an array of files",
                    "in": [
                        {
                            "source": "#main/humann_regroup_renorm_table/regrouped_table",
                            "id": "#main/renorm_groups_to_array/input"
                        }
                    ],
                    "out": [
                        "#main/renorm_groups_to_array/output"
                    ],
                    "id": "#main/renorm_groups_to_array"
                },
                {
                    "label": "Oxford Nanopore quality workflow",
                    "doc": "Quality, filtering and taxonomic classification workflow for Oxford Nanopore reads",
                    "when": "$(!inputs.skip_read_filter)",
                    "run": "#workflow_illumina_quality.cwl",
                    "in": [
                        {
                            "source": "#main/forward_reads",
                            "id": "#main/workflow_illumina_quality/forward_reads"
                        },
                        {
                            "source": "#main/humandb",
                            "id": "#main/workflow_illumina_quality/humandb"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_illumina_quality/identifier"
                        },
                        {
                            "source": "#main/use_reference_mapped_reads",
                            "id": "#main/workflow_illumina_quality/keep_reference_mapped_reads"
                        },
                        {
                            "source": "#main/reference_filter_db",
                            "id": "#main/workflow_illumina_quality/reference_filter_db"
                        },
                        {
                            "source": "#main/reverse_reads",
                            "id": "#main/workflow_illumina_quality/reverse_reads"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/workflow_illumina_quality/skip_read_filter"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_illumina_quality/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_illumina_quality/QC_forward_reads",
                        "#main/workflow_illumina_quality/QC_reverse_reads",
                        "#main/workflow_illumina_quality/reports_folder"
                    ],
                    "id": "#main/workflow_illumina_quality"
                },
                {
                    "label": "Merge paired reads",
                    "doc": "This is workflow specific step and creates a single file object. \nAlso merges reads if multiple files are given. (not interleaving)\n",
                    "when": "$(inputs.skip_read_filter)",
                    "run": "#workflow_merge_pe_reads.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self)_merged",
                            "id": "#main/workflow_merge_reads/filename"
                        },
                        {
                            "source": "#main/forward_reads",
                            "id": "#main/workflow_merge_reads/forward_reads"
                        },
                        {
                            "source": "#main/reverse_reads",
                            "id": "#main/workflow_merge_reads/reverse_reads"
                        },
                        {
                            "source": "#main/skip_read_filter",
                            "id": "#main/workflow_merge_reads/skip_read_filter"
                        }
                    ],
                    "out": [
                        "#main/workflow_merge_reads/forward_reads_out",
                        "#main/workflow_merge_reads/reverse_reads_out"
                    ],
                    "id": "#main/workflow_merge_reads"
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
            "https://schema.org/dateCreated": "2024-05-21",
            "https://schema.org/dateModified": "2025-07-30",
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
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "label": "Illumina read quality control, trimming and contamination filter.",
            "doc": "**Workflow for Illumina paired read quality control, trimming and filtering.**<br />\nMultiple paired datasets will be merged into single paired dataset.<br />\nSummary:\n- Sequali QC on raw data files<br />\n- fastp for read quality trimming<br />\n- BBduk for phiX and rRNA filtering (optional)<br />\n- Filter human reads using Hostile (optional)<br />\n- Custom read filtering using Hostile (optional)<br />\n- Sequali QC on filtered (merged) data<br />\n\nOther UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>\n\n**All tool CWL files and other workflows can be found at:**<br>\nhttps://gitlab.com/m-unlock/cwl\n\n**How to setup and use an UNLOCK workflow:**<br>\nhttps://docs.m-unlock.nl/docs/workflows/setup.html<br>\n",
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Filtered forward read",
                    "doc": "Filtered forward read",
                    "outputSource": "#workflow_illumina_quality.cwl/out_fwd_reads/fwd_out",
                    "id": "#workflow_illumina_quality.cwl/QC_forward_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Filtered reverse read",
                    "doc": "Filtered reverse read",
                    "outputSource": "#workflow_illumina_quality.cwl/out_rev_reads/rev_out",
                    "id": "#workflow_illumina_quality.cwl/QC_reverse_reads"
                },
                {
                    "type": "Directory",
                    "label": "Filtering reports folder",
                    "doc": "Folder containing all reports of filtering and quality control",
                    "outputSource": "#workflow_illumina_quality.cwl/reports_files_to_folder/results",
                    "id": "#workflow_illumina_quality.cwl/reports_folder"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "doc": "Remove exact duplicate reads with fastp. (default false)",
                    "label": "Deduplicate reads",
                    "default": false,
                    "id": "#workflow_illumina_quality.cwl/deduplicate"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional output destination only used for cwl-prov reporting.",
                    "id": "#workflow_illumina_quality.cwl/destination"
                },
                {
                    "type": "boolean",
                    "label": "Don't output reads.",
                    "doc": "Do not output filtered reads. (default false)",
                    "default": false,
                    "id": "#workflow_illumina_quality.cwl/do_not_output_filtered_reads"
                },
                {
                    "type": "boolean",
                    "doc": "Optionally remove rRNA sequences from the reads (default false)",
                    "label": "filter rRNA",
                    "default": false,
                    "id": "#workflow_illumina_quality.cwl/filter_rrna"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Forward sequence fastq file(s) locally",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_illumina_quality.cwl/forward_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Bowtie2 index folder. Provide the folder in which the in index files are located.",
                    "label": "Filter human reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_illumina_quality.cwl/humandb"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow.",
                    "label": "Identifier",
                    "id": "#workflow_illumina_quality.cwl/identifier"
                },
                {
                    "type": "boolean",
                    "doc": "Discard unmapped and keep reads mapped to the given reference. Default false (discard mapped)",
                    "label": "Keep mapped reads",
                    "default": false,
                    "id": "#workflow_illumina_quality.cwl/keep_reference_mapped_reads"
                },
                {
                    "type": "int",
                    "doc": "Maximum memory usage in MegaBytes. (default 8000)",
                    "label": "Maximum memory in MB",
                    "default": 8000,
                    "id": "#workflow_illumina_quality.cwl/memory"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Custom reference database for filtering with Hostile. \nProvide the folder in which the bowtie2 index files are located. (default false)\n",
                    "label": "Filter reference file(s)",
                    "loadListing": "no_listing",
                    "id": "#workflow_illumina_quality.cwl/reference_filter_db"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Reverse sequence fastq file(s) locally",
                    "label": "Reverse reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_illumina_quality.cwl/reverse_reads"
                },
                {
                    "type": "boolean",
                    "doc": "Skip FastQC analyses of filtered input reads (default false)",
                    "label": "Skip QC filtered",
                    "default": false,
                    "id": "#workflow_illumina_quality.cwl/skip_qc_filtered"
                },
                {
                    "type": "boolean",
                    "doc": "Skip FastQC analyses of raw input reads (default false)",
                    "label": "Skip QC unfiltered",
                    "default": false,
                    "id": "#workflow_illumina_quality.cwl/skip_qc_unfiltered"
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
                    "id": "#workflow_illumina_quality.cwl/source"
                },
                {
                    "type": "int",
                    "doc": "Number of threads to use for computational processes. (default 2)",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#workflow_illumina_quality.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "fastp",
                    "doc": "Read quality filtering and (barcode) trimming.",
                    "run": "#fastp.cwl",
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/deduplicate",
                            "id": "#workflow_illumina_quality.cwl/fastp/deduplicate"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/forward_reads_out",
                            "id": "#workflow_illumina_quality.cwl/fastp/forward_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "id": "#workflow_illumina_quality.cwl/fastp/identifier"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/reverse_reads_out",
                            "id": "#workflow_illumina_quality.cwl/fastp/reverse_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/threads",
                            "id": "#workflow_illumina_quality.cwl/fastp/threads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/fastp/out_forward_reads",
                        "#workflow_illumina_quality.cwl/fastp/out_reverse_reads",
                        "#workflow_illumina_quality.cwl/fastp/html_report",
                        "#workflow_illumina_quality.cwl/fastp/json_report"
                    ],
                    "id": "#workflow_illumina_quality.cwl/fastp"
                },
                {
                    "label": "Human filter",
                    "doc": "Filter human reads from the dataset using Hostile",
                    "when": "$(inputs.indexfolder !== null)",
                    "run": "#hostile_clean_shortreads.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/rrna_filter/out_forward_reads",
                                "#workflow_illumina_quality.cwl/fastp/out_forward_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_illumina_quality.cwl/human_filter/forward_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/humandb",
                            "id": "#workflow_illumina_quality.cwl/human_filter/indexfolder"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_human-filter\")",
                            "id": "#workflow_illumina_quality.cwl/human_filter/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/rrna_filter/out_reverse_reads",
                                "#workflow_illumina_quality.cwl/fastp/out_reverse_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_illumina_quality.cwl/human_filter/reverse_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/threads",
                            "id": "#workflow_illumina_quality.cwl/human_filter/threads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/human_filter/out_forward_reads",
                        "#workflow_illumina_quality.cwl/human_filter/out_reverse_reads",
                        "#workflow_illumina_quality.cwl/human_filter/summary"
                    ],
                    "id": "#workflow_illumina_quality.cwl/human_filter"
                },
                {
                    "label": "Output fwd reads",
                    "doc": "Step needed to output filtered reads because there is an option to not to.",
                    "when": "$(!inputs.do_not_output_filtered_reads)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "id": "#workflow_illumina_quality.cwl/out_fwd_reads/run/fwd_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#workflow_illumina_quality.cwl/out_fwd_reads/run/fwd_out"
                            }
                        ],
                        "expression": "${ return {'fwd_out': inputs.fwd_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/do_not_output_filtered_reads",
                            "id": "#workflow_illumina_quality.cwl/out_fwd_reads/do_not_output_filtered_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/phix_filter/out_forward_reads",
                            "id": "#workflow_illumina_quality.cwl/out_fwd_reads/fwd_in"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/out_fwd_reads/fwd_out"
                    ],
                    "id": "#workflow_illumina_quality.cwl/out_fwd_reads"
                },
                {
                    "label": "Output rev reads",
                    "doc": "Step needed to output filtered reads because there is an option to not to.",
                    "when": "$(!inputs.do_not_output_filtered_reads)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": "File",
                                "id": "#workflow_illumina_quality.cwl/out_rev_reads/run/rev_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#workflow_illumina_quality.cwl/out_rev_reads/run/rev_out"
                            }
                        ],
                        "expression": "${ return {'rev_out': inputs.rev_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/do_not_output_filtered_reads",
                            "id": "#workflow_illumina_quality.cwl/out_rev_reads/do_not_output_filtered_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/phix_filter/out_reverse_reads",
                            "id": "#workflow_illumina_quality.cwl/out_rev_reads/rev_in"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/out_rev_reads/rev_out"
                    ],
                    "id": "#workflow_illumina_quality.cwl/out_rev_reads"
                },
                {
                    "label": "PhiX filter (bbduk)",
                    "doc": "Filters illumina spike-in PhiX sequences from reads using bbduk",
                    "run": "#bbduk_filter.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/reference_filter/out_forward_reads",
                                "#workflow_illumina_quality.cwl/human_filter/out_forward_reads",
                                "#workflow_illumina_quality.cwl/rrna_filter/out_forward_reads",
                                "#workflow_illumina_quality.cwl/fastp/out_forward_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_illumina_quality.cwl/phix_filter/forward_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_illumina_filtered\")",
                            "id": "#workflow_illumina_quality.cwl/phix_filter/identifier"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/memory",
                            "id": "#workflow_illumina_quality.cwl/phix_filter/memory"
                        },
                        {
                            "valueFrom": "/opt/conda/opt/bbmap-39.06-0/resources/phix174_ill.ref.fa.gz",
                            "id": "#workflow_illumina_quality.cwl/phix_filter/reference"
                        },
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/reference_filter/out_reverse_reads",
                                "#workflow_illumina_quality.cwl/human_filter/out_reverse_reads",
                                "#workflow_illumina_quality.cwl/rrna_filter/out_reverse_reads",
                                "#workflow_illumina_quality.cwl/fastp/out_reverse_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_illumina_quality.cwl/phix_filter/reverse_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/threads",
                            "id": "#workflow_illumina_quality.cwl/phix_filter/threads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/phix_filter/out_forward_reads",
                        "#workflow_illumina_quality.cwl/phix_filter/out_reverse_reads",
                        "#workflow_illumina_quality.cwl/phix_filter/summary",
                        "#workflow_illumina_quality.cwl/phix_filter/stats_file"
                    ],
                    "id": "#workflow_illumina_quality.cwl/phix_filter"
                },
                {
                    "label": "Custom reference filter",
                    "doc": "Filter reads using custom references with Hostile",
                    "when": "$(inputs.indexfolder !== null)",
                    "run": "#hostile_clean_shortreads.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/human_filter/out_forward_reads",
                                "#workflow_illumina_quality.cwl/rrna_filter/out_forward_reads",
                                "#workflow_illumina_quality.cwl/fastp/out_forward_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_illumina_quality.cwl/reference_filter/forward_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "id": "#workflow_illumina_quality.cwl/reference_filter/identifier"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/reference_filter_db",
                            "id": "#workflow_illumina_quality.cwl/reference_filter/indexfolder"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/keep_reference_mapped_reads",
                            "id": "#workflow_illumina_quality.cwl/reference_filter/invert"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_ref-filter\")",
                            "id": "#workflow_illumina_quality.cwl/reference_filter/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/human_filter/out_reverse_reads",
                                "#workflow_illumina_quality.cwl/rrna_filter/out_reverse_reads",
                                "#workflow_illumina_quality.cwl/fastp/out_reverse_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_illumina_quality.cwl/reference_filter/reverse_reads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/reference_filter/out_forward_reads",
                        "#workflow_illumina_quality.cwl/reference_filter/out_reverse_reads",
                        "#workflow_illumina_quality.cwl/reference_filter/summary"
                    ],
                    "id": "#workflow_illumina_quality.cwl/reference_filter"
                },
                {
                    "label": "Reports to folder",
                    "doc": "Preparation of QC output files to a specific output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "default": "illumina_quality_filter_reports",
                            "id": "#workflow_illumina_quality.cwl/reports_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_illumina_quality.cwl/sequali_illumina_before/report_html",
                                "#workflow_illumina_quality.cwl/sequali_illumina_before/report_json",
                                "#workflow_illumina_quality.cwl/sequali_illumina_after/report_html",
                                "#workflow_illumina_quality.cwl/sequali_illumina_after/report_json",
                                "#workflow_illumina_quality.cwl/fastp/html_report",
                                "#workflow_illumina_quality.cwl/fastp/json_report",
                                "#workflow_illumina_quality.cwl/human_filter/summary",
                                "#workflow_illumina_quality.cwl/reference_filter/summary",
                                "#workflow_illumina_quality.cwl/phix_filter/summary",
                                "#workflow_illumina_quality.cwl/phix_filter/stats_file",
                                "#workflow_illumina_quality.cwl/rrna_filter/summary",
                                "#workflow_illumina_quality.cwl/rrna_filter/stats_file"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_illumina_quality.cwl/reports_files_to_folder/files"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/reports_files_to_folder/results"
                    ],
                    "id": "#workflow_illumina_quality.cwl/reports_files_to_folder"
                },
                {
                    "label": "rRNA filter (bbduk)",
                    "doc": "Filters rRNA sequences from reads using bbduk",
                    "when": "$(inputs.filter_rrna)",
                    "run": "#bbduk_filter.cwl",
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/filter_rrna",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/filter_rrna"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/fastp/out_forward_reads",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/forward_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_rRNA-filter\")",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/identifier"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/memory",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/memory"
                        },
                        {
                            "valueFrom": "/opt/conda/opt/bbmap-39.06-0/resources/riboKmers.fa.gz",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/reference"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/fastp/out_reverse_reads",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/reverse_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/threads",
                            "id": "#workflow_illumina_quality.cwl/rrna_filter/threads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/rrna_filter/out_forward_reads",
                        "#workflow_illumina_quality.cwl/rrna_filter/out_reverse_reads",
                        "#workflow_illumina_quality.cwl/rrna_filter/summary",
                        "#workflow_illumina_quality.cwl/rrna_filter/stats_file"
                    ],
                    "id": "#workflow_illumina_quality.cwl/rrna_filter"
                },
                {
                    "label": "Sequali after",
                    "doc": "Quality assessment and report of reads after filtering",
                    "run": "#sequali.cwl",
                    "when": "$(!inputs.skip_qc_filtered)",
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/phix_filter/out_forward_reads",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_after/input_file"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/phix_filter/out_reverse_reads",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_after/paired_input"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/skip_qc_filtered",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_after/skip_qc_filtered"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/threads",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_after/threads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/sequali_illumina_after/report_html",
                        "#workflow_illumina_quality.cwl/sequali_illumina_after/report_json"
                    ],
                    "id": "#workflow_illumina_quality.cwl/sequali_illumina_after"
                },
                {
                    "label": "Sequali before",
                    "doc": "Quality assessment and report of reads before filtering",
                    "run": "#sequali.cwl",
                    "when": "$(!inputs.skip_qc_unfiltered)",
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/forward_reads_out",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_before/input_file"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/reverse_reads_out",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_before/paired_input"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/skip_qc_unfiltered",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_before/skip_qc_unfiltered"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/threads",
                            "id": "#workflow_illumina_quality.cwl/sequali_illumina_before/threads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/sequali_illumina_before/report_html",
                        "#workflow_illumina_quality.cwl/sequali_illumina_before/report_json"
                    ],
                    "id": "#workflow_illumina_quality.cwl/sequali_illumina_before"
                },
                {
                    "label": "Merge paired reads",
                    "doc": "Merge multiple forward and reverse fastq reads to single file objects",
                    "run": "#workflow_merge_pe_reads.cwl",
                    "in": [
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "valueFrom": "$(self)_illumina_merged",
                            "id": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/filename"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/forward_reads",
                            "id": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/forward_reads"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/identifier",
                            "id": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/identifier"
                        },
                        {
                            "source": "#workflow_illumina_quality.cwl/reverse_reads",
                            "id": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/reverse_reads"
                        }
                    ],
                    "out": [
                        "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/forward_reads_out",
                        "#workflow_illumina_quality.cwl/workflow_merge_pe_reads/reverse_reads_out"
                    ],
                    "id": "#workflow_illumina_quality.cwl/workflow_merge_pe_reads"
                }
            ],
            "id": "#workflow_illumina_quality.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2025-04-24",
            "https://schema.org/dateModified": "2025-07-25",
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
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "label": "Merge multiple PE reads",
            "doc": "!! this is not interleaving !!\nMerge (cat) fastq paired end reads when multiple files.\nAlso converts single file array to a non array object.\n\nOutput is as single (non array) file object for each read end. \nThis (non array files) is usually required for tool inputs \n",
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Filename prefix to be used when reads are going to merged. File extensions are preserved.\nThis is only used when multiple reads are given. default \"merged\"\n",
                    "label": "Filename prefix",
                    "default": "merged",
                    "id": "#workflow_merge_pe_reads.cwl/filename"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Forward sequence reads file(s). Can be compressed. Do not mix filetypes.",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_merge_pe_reads.cwl/forward_reads"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Reverse sequence reads file(s). Can be compressed. Do not mix filetypes.",
                    "label": "Reverse reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_merge_pe_reads.cwl/reverse_reads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": [
                        "#workflow_merge_pe_reads.cwl/fastq_merge_fwd/output",
                        "#workflow_merge_pe_reads.cwl/fastq_fwd_array_to_file/file"
                    ],
                    "pickValue": "first_non_null",
                    "id": "#workflow_merge_pe_reads.cwl/forward_reads_out"
                },
                {
                    "type": "File",
                    "outputSource": [
                        "#workflow_merge_pe_reads.cwl/fastq_merge_rev/output",
                        "#workflow_merge_pe_reads.cwl/fastq_rev_array_to_file/file"
                    ],
                    "pickValue": "first_non_null",
                    "id": "#workflow_merge_pe_reads.cwl/reverse_reads_out"
                }
            ],
            "steps": [
                {
                    "label": "Fwd reads array to file",
                    "doc": "Forward file of single file array to file object",
                    "when": "$(inputs.files.length === 1)",
                    "run": "#array_to_file_tool.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_pe_reads.cwl/forward_reads",
                            "id": "#workflow_merge_pe_reads.cwl/fastq_fwd_array_to_file/files"
                        }
                    ],
                    "out": [
                        "#workflow_merge_pe_reads.cwl/fastq_fwd_array_to_file/file"
                    ],
                    "id": "#workflow_merge_pe_reads.cwl/fastq_fwd_array_to_file"
                },
                {
                    "label": "Merge forward reads",
                    "doc": "Merge multiple forward fastq reads to a single file",
                    "when": "$(inputs.infiles.length > 1)",
                    "run": "#concatenate.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_pe_reads.cwl/forward_reads",
                            "id": "#workflow_merge_pe_reads.cwl/fastq_merge_fwd/infiles"
                        },
                        {
                            "source": "#workflow_merge_pe_reads.cwl/filename",
                            "valueFrom": "${\n  return self+\"_1\"+inputs.infiles[0].basename.match(/\\.(fastq|fq)(\\.gz)?$/)[0];\n}\n",
                            "id": "#workflow_merge_pe_reads.cwl/fastq_merge_fwd/outname"
                        }
                    ],
                    "out": [
                        "#workflow_merge_pe_reads.cwl/fastq_merge_fwd/output"
                    ],
                    "id": "#workflow_merge_pe_reads.cwl/fastq_merge_fwd"
                },
                {
                    "label": "Merge reverse reads",
                    "doc": "Merge multiple reverse fastq reads to a single file",
                    "when": "$(inputs.infiles.length > 1)",
                    "run": "#concatenate.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_pe_reads.cwl/reverse_reads",
                            "id": "#workflow_merge_pe_reads.cwl/fastq_merge_rev/infiles"
                        },
                        {
                            "source": "#workflow_merge_pe_reads.cwl/filename",
                            "valueFrom": "${\n  return self+\"_2\"+inputs.infiles[0].basename.match(/\\.(fastq|fq)(\\.gz)?$/)[0];\n}\n",
                            "id": "#workflow_merge_pe_reads.cwl/fastq_merge_rev/outname"
                        }
                    ],
                    "out": [
                        "#workflow_merge_pe_reads.cwl/fastq_merge_rev/output"
                    ],
                    "id": "#workflow_merge_pe_reads.cwl/fastq_merge_rev"
                },
                {
                    "label": "Rev reads array to file",
                    "doc": "Forward file of single file array to file object",
                    "when": "$(inputs.files.length === 1)",
                    "run": "#array_to_file_tool.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_pe_reads.cwl/reverse_reads",
                            "id": "#workflow_merge_pe_reads.cwl/fastq_rev_array_to_file/files"
                        }
                    ],
                    "out": [
                        "#workflow_merge_pe_reads.cwl/fastq_rev_array_to_file/file"
                    ],
                    "id": "#workflow_merge_pe_reads.cwl/fastq_rev_array_to_file"
                }
            ],
            "id": "#workflow_merge_pe_reads.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2025-04-04",
            "https://schema.org/dateModified": "2025-04-30",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
