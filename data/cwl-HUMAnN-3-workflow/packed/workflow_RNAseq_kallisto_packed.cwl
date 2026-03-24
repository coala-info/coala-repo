{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "kallisto quantification",
            "doc": "Pseudoalignment with the tool kallisto\nhttps://github.com/common-workflow-library/bio-cwl-tools/tree/release/Kallisto",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "loadListing": "shallow_listing",
                    "class": "LoadListingRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/kallisto:0.48.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.48.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/kallisto",
                                "file:///home/bart/git/cwl/tools/RNAseq/kallisto/doi.org/10.1038/nbt.3519"
                            ],
                            "package": "kallisto"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "separate": false,
                        "prefix": "--bootstrap-samples="
                    },
                    "default": 100,
                    "id": "#kallisto_quant.cwl/BootstrapSamples"
                },
                {
                    "type": [
                        "null",
                        "double"
                    ],
                    "inputBinding": {
                        "separate": false,
                        "prefix": "--fragment-length="
                    },
                    "id": "#kallisto_quant.cwl/FragmentLength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#kallisto_quant.cwl/GenomeBam/genome_bam",
                            "fields": [
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--chromosomes"
                                    },
                                    "name": "#kallisto_quant.cwl/GenomeBam/genome_bam/chromosomes"
                                },
                                {
                                    "type": "boolean",
                                    "inputBinding": {
                                        "prefix": "--genomebam"
                                    },
                                    "name": "#kallisto_quant.cwl/GenomeBam/genome_bam/genomebam"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--gtf"
                                    },
                                    "name": "#kallisto_quant.cwl/GenomeBam/genome_bam/gtf"
                                }
                            ]
                        }
                    ],
                    "id": "#kallisto_quant.cwl/GenomeBam"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--pseudobam"
                    },
                    "id": "#kallisto_quant.cwl/PseudoBam"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--seed"
                    },
                    "id": "#kallisto_quant.cwl/Seed"
                },
                {
                    "type": [
                        "null",
                        "double"
                    ],
                    "inputBinding": {
                        "prefix": "--sd"
                    },
                    "id": "#kallisto_quant.cwl/StandardDeviation"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#kallisto_quant.cwl/Strand/forward",
                            "fields": [
                                {
                                    "type": "boolean",
                                    "inputBinding": {
                                        "prefix": "--fr-stranded"
                                    },
                                    "name": "#kallisto_quant.cwl/Strand/forward/forward"
                                }
                            ]
                        },
                        {
                            "type": "record",
                            "name": "#kallisto_quant.cwl/Strand/reverse",
                            "fields": [
                                {
                                    "type": "boolean",
                                    "inputBinding": {
                                        "prefix": "--rf-stranded"
                                    },
                                    "name": "#kallisto_quant.cwl/Strand/reverse/reverse"
                                }
                            ]
                        }
                    ],
                    "id": "#kallisto_quant.cwl/Strand"
                },
                {
                    "type": [
                        "File"
                    ],
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#kallisto_quant.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "prefix of the filename outputs",
                    "default": "sampleX",
                    "id": "#kallisto_quant.cwl/identifier"
                },
                {
                    "type": "string",
                    "doc": "kallisto index file",
                    "inputBinding": {
                        "prefix": "--index=",
                        "separate": false
                    },
                    "id": "#kallisto_quant.cwl/index"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--bias"
                    },
                    "id": "#kallisto_quant.cwl/isBias"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--fusion"
                    },
                    "id": "#kallisto_quant.cwl/isFusion"
                },
                {
                    "type": "boolean",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--single"
                    },
                    "default": false,
                    "id": "#kallisto_quant.cwl/isSingle"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--single-overhang"
                    },
                    "id": "#kallisto_quant.cwl/isSingleOverhang"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "position": 101
                    },
                    "id": "#kallisto_quant.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "position": 0,
                        "prefix": "--threads=",
                        "separate": false
                    },
                    "id": "#kallisto_quant.cwl/threads"
                }
            ],
            "arguments": [
                "--plaintext",
                {
                    "prefix": "--output-dir=",
                    "separate": false,
                    "valueFrom": "$(inputs.identifier)_kallisto"
                }
            ],
            "baseCommand": [
                "kallisto",
                "quant"
            ],
            "stderr": "$(inputs.identifier)_kallisto_summary.txt",
            "id": "#kallisto_quant.cwl",
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
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_kallisto/abundance.h5"
                    },
                    "id": "#kallisto_quant.cwl/abundance.h5"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_kallisto/abundance.tsv"
                    },
                    "id": "#kallisto_quant.cwl/abundance.tsv"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_kallisto/run_info.json"
                    },
                    "id": "#kallisto_quant.cwl/run_info"
                },
                {
                    "type": "File",
                    "id": "#kallisto_quant.cwl/summary",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_kallisto_summary.txt"
                    }
                }
            ]
        },
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
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.outname)"
                    },
                    "id": "#concatenate.cwl/output"
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
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
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
            "label": "Kallisto RNAseq Workflow",
            "doc": "Workflow Kallisto RNAseq (pseudoalignment on transcripts)\n  - Workflow Illumina Quality: https://workflowhub.eu/workflows/336?version=1\t\n  - kallisto\n\n**All tool CWL files and other workflows can be found here:**<br>\n  Tools: https://git.wur.nl/unlock/cwl/-/tree/master/cwl<br>\n  Workflows: https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows<br>\n\nThe dependencies are either accessible from https://unlock-icat.irods.surfsara.nl (anonymous,anonymous)<br>\nand/or<br>\nBy using the conda / pip environments as shown in https://git.wur.nl/unlock/docker/-/blob/master/kubernetes/scripts/setup.sh<br>\n",
            "outputs": [
                {
                    "label": "Filtered statistics",
                    "doc": "Statistics on quality and preprocessing of the reads",
                    "type": "Directory",
                    "outputSource": "#main/workflow_quality/reports_folder",
                    "id": "#main/illumina_quality_stats"
                },
                {
                    "type": "Directory",
                    "label": "kallisto output",
                    "doc": "kallisto results folder. Contains transcript abundances, run info and summary.",
                    "outputSource": "#main/kallisto_files_to_folder/results",
                    "id": "#main/kallisto_output"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Reference fasta file(s) for filtering (optional)",
                    "label": "Reference filters files",
                    "id": "#main/contamination_references"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional Output destination used for cwl-prov reporting.",
                    "id": "#main/destination"
                },
                {
                    "type": "boolean",
                    "doc": "Optionally remove rRNA sequences from the reads.",
                    "label": "Filter rRNA",
                    "id": "#main/filter_rrna"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Forward sequence file locally",
                    "label": "Forward reads",
                    "id": "#main/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "Identifier",
                    "id": "#main/identifier"
                },
                {
                    "type": "string",
                    "doc": "kallisto index file location",
                    "label": "kallisto index file",
                    "id": "#main/kallisto_index"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum memory usage in megabytes",
                    "label": "Maximum memory in MB",
                    "default": 40000,
                    "id": "#main/memory"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Reverse sequence file locally",
                    "label": "Reverse reads",
                    "id": "#main/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Number of threads to use for computational processes",
                    "label": "Threads",
                    "default": 2,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "label": "kallisto",
                    "doc": "Calculates transcript abundances",
                    "run": "#kallisto_quant.cwl",
                    "in": [
                        {
                            "source": "#main/workflow_quality/QC_forward_reads",
                            "id": "#main/kallisto/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/kallisto/identifier"
                        },
                        {
                            "source": "#main/kallisto_index",
                            "id": "#main/kallisto/index"
                        },
                        {
                            "source": "#main/workflow_quality/QC_reverse_reads",
                            "id": "#main/kallisto/reverse_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/kallisto/threads"
                        }
                    ],
                    "out": [
                        "#main/kallisto/abundance.tsv",
                        "#main/kallisto/run_info",
                        "#main/kallisto/summary"
                    ],
                    "id": "#main/kallisto"
                },
                {
                    "label": "kallisto output",
                    "doc": "Preparation of kallisto output files to a specific output folder",
                    "in": [
                        {
                            "valueFrom": "$(inputs.identifier+\"_kallisto\")",
                            "id": "#main/kallisto_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/kallisto/abundance.tsv",
                                "#main/kallisto/run_info",
                                "#main/kallisto/summary"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/kallisto_files_to_folder/files"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/kallisto_files_to_folder/identifier"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#main/kallisto_files_to_folder/results"
                    ],
                    "id": "#main/kallisto_files_to_folder"
                },
                {
                    "label": "Quality and filtering workflow",
                    "doc": "Quality assessment of illumina reads with rRNA filtering option",
                    "run": "#workflow_illumina_quality.cwl",
                    "in": [
                        {
                            "source": "#main/contamination_references",
                            "id": "#main/workflow_quality/filter_references"
                        },
                        {
                            "source": "#main/filter_rrna",
                            "id": "#main/workflow_quality/filter_rrna"
                        },
                        {
                            "source": "#main/forward_reads",
                            "id": "#main/workflow_quality/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_quality/identifier"
                        },
                        {
                            "source": "#main/memory",
                            "id": "#main/workflow_quality/memory"
                        },
                        {
                            "source": "#main/reverse_reads",
                            "id": "#main/workflow_quality/reverse_reads"
                        },
                        {
                            "default": 1,
                            "id": "#main/workflow_quality/step"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_quality/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_quality/QC_reverse_reads",
                        "#main/workflow_quality/QC_forward_reads",
                        "#main/workflow_quality/reports_folder"
                    ],
                    "id": "#main/workflow_quality"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
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
            "https://schema.org/dateCreated": "2022-05-00",
            "https://schema.org/dateModified": "2022-06-00",
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
