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
                    "id": "#main/filename"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Forward sequence reads file(s). Can be compressed. Do not mix filetypes.",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#main/forward_reads"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Reverse sequence reads file(s). Can be compressed. Do not mix filetypes.",
                    "label": "Reverse reads",
                    "loadListing": "no_listing",
                    "id": "#main/reverse_reads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": [
                        "#main/fastq_merge_fwd/output",
                        "#main/fastq_fwd_array_to_file/file"
                    ],
                    "pickValue": "first_non_null",
                    "id": "#main/forward_reads_out"
                },
                {
                    "type": "File",
                    "outputSource": [
                        "#main/fastq_merge_rev/output",
                        "#main/fastq_rev_array_to_file/file"
                    ],
                    "pickValue": "first_non_null",
                    "id": "#main/reverse_reads_out"
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
                            "source": "#main/forward_reads",
                            "id": "#main/fastq_fwd_array_to_file/files"
                        }
                    ],
                    "out": [
                        "#main/fastq_fwd_array_to_file/file"
                    ],
                    "id": "#main/fastq_fwd_array_to_file"
                },
                {
                    "label": "Merge forward reads",
                    "doc": "Merge multiple forward fastq reads to a single file",
                    "when": "$(inputs.infiles.length > 1)",
                    "run": "#concatenate.cwl",
                    "in": [
                        {
                            "source": "#main/forward_reads",
                            "id": "#main/fastq_merge_fwd/infiles"
                        },
                        {
                            "source": "#main/filename",
                            "valueFrom": "${\n  return self+\"_1\"+inputs.infiles[0].basename.match(/\\.(fastq|fq)(\\.gz)?$/)[0];\n}\n",
                            "id": "#main/fastq_merge_fwd/outname"
                        }
                    ],
                    "out": [
                        "#main/fastq_merge_fwd/output"
                    ],
                    "id": "#main/fastq_merge_fwd"
                },
                {
                    "label": "Merge reverse reads",
                    "doc": "Merge multiple reverse fastq reads to a single file",
                    "when": "$(inputs.infiles.length > 1)",
                    "run": "#concatenate.cwl",
                    "in": [
                        {
                            "source": "#main/reverse_reads",
                            "id": "#main/fastq_merge_rev/infiles"
                        },
                        {
                            "source": "#main/filename",
                            "valueFrom": "${\n  return self+\"_2\"+inputs.infiles[0].basename.match(/\\.(fastq|fq)(\\.gz)?$/)[0];\n}\n",
                            "id": "#main/fastq_merge_rev/outname"
                        }
                    ],
                    "out": [
                        "#main/fastq_merge_rev/output"
                    ],
                    "id": "#main/fastq_merge_rev"
                },
                {
                    "label": "Rev reads array to file",
                    "doc": "Forward file of single file array to file object",
                    "when": "$(inputs.files.length === 1)",
                    "run": "#array_to_file_tool.cwl",
                    "in": [
                        {
                            "source": "#main/reverse_reads",
                            "id": "#main/fastq_rev_array_to_file/files"
                        }
                    ],
                    "out": [
                        "#main/fastq_rev_array_to_file/file"
                    ],
                    "id": "#main/fastq_rev_array_to_file"
                }
            ],
            "id": "#main",
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
