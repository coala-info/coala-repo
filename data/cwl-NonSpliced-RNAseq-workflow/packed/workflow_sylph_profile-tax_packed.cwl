{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "sylph",
            "doc": "sylph is a program that performs ultrafast (1) ANI querying or (2) metagenomic profiling for metagenomic shotgun samples.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/sylph:0.8.1--ha6fb395_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.8.1"
                            ],
                            "specs": [
                                "https://identifiers.org/RRID:SCR_026478",
                                "https://anaconda.org/bioconda/sylph",
                                "https://doi.org/10.1038/s41587-024-02412-y"
                            ],
                            "package": "sylph"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "sylph",
                "profile"
            ],
            "arguments": [
                {
                    "prefix": "--output-file",
                    "valueFrom": "$(inputs.output_filename_prefix+\".\"+inputs.database.basename.replace(/\\.syldb$/, '')+\".sylph-profile.tsv\")"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Sylph database",
                    "label": "Database",
                    "inputBinding": {
                        "position": 0
                    },
                    "id": "#sylph_profile.cwl/database"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Estimate true coverage and scale sequence abundance in `profile` by estimated unknown sequence percentage",
                    "label": "Estimate unknown",
                    "inputBinding": {
                        "prefix": "--estimate-unknown",
                        "position": 14
                    },
                    "id": "#sylph_profile.cwl/estimate_unknown"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "The file containing the forward reads. (fastx/gzip)",
                    "label": "Forward reads",
                    "inputBinding": {
                        "prefix": "--first-pairs",
                        "position": 11
                    },
                    "id": "#sylph_profile.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file. (_sylph-profile.tsv will be appended)",
                    "label": "Output filename (base)",
                    "id": "#sylph_profile.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "The file containing the reverse reads. (fastx/gzip)",
                    "label": "Reverse reads",
                    "inputBinding": {
                        "prefix": "--second-pairs",
                        "position": 12
                    },
                    "id": "#sylph_profile.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Single end reads, for example long reads. (fastx/gzip)",
                    "label": "Single end reads",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#sylph_profile.cwl/single_end_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use. Default 3",
                    "label": "Threads",
                    "default": 3,
                    "inputBinding": {
                        "prefix": "-t",
                        "position": 10
                    },
                    "id": "#sylph_profile.cwl/threads"
                }
            ],
            "id": "#sylph_profile.cwl",
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
            "https://schema.org/dateCreated": "2025-02-21",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#sylph_profile.cwl/sylph_profile"
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "sylph-tax",
            "doc": "Sylph is an efficient and accurate metagenome profiler. \nHowever, its output does not have taxonomic information. \nsylph-tax can turn sylph's TSV output into a taxonomic profile like Kraken or MetaPhlAn. \nsylph-tax does this by using custom taxonomy files to annotate sylph's output.\n\nCurrently only works with a single sylph input tsv and 1 taxonomy metadata file.\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sylph_sylph-tax:0.8.1_1.2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.1.2"
                            ],
                            "specs": [
                                "file:///home/bart/git/cwl/tools/sylph/identifiers.org/RRID:SCR_026478",
                                "https://anaconda.org/bioconda/sylph-tax",
                                "https://doi.org/10.1038/s41587-024-02412-y"
                            ],
                            "package": "sylph-tax"
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
                "sylph-tax",
                "taxprof"
            ],
            "arguments": [
                {
                    "prefix": "--taxonomy-metadata",
                    "position": 99,
                    "shellQuote": false,
                    "valueFrom": "${\n  if (inputs.taxonomy_metadata.taxonomy_metadata_file){\n    return inputs.taxonomy_metadata.taxonomy_metadata_file.path\n  } else {\n    return inputs.taxonomy_metadata.builtin_taxonomy_metadata\n  }\n}\n"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "doc": "Add additional column(s) by integrating viral-host information available (currently available for IMGVR4.1). Default false",
                    "label": "Annotate virus hosts",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--annotate-virus-hosts",
                        "position": 99
                    },
                    "id": "#sylph_tax.cwl/annotate_virus_hosts"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file. If present builtin_taxonomy will appended i.e. GTDB_R220.sylphmpa Otherwise only .sylphmpa",
                    "label": "Output filename (base)",
                    "id": "#sylph_tax.cwl/output_filename_prefix"
                },
                {
                    "type": "File",
                    "doc": "Sylph profile coming from the 'sylph profile' tool function",
                    "label": "Sylph profile",
                    "inputBinding": {
                        "position": 0
                    },
                    "id": "#sylph_tax.cwl/sylph_profile"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata",
                            "fields": [
                                {
                                    "type": [
                                        {
                                            "type": "enum",
                                            "symbols": [
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r214",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r220",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/IMGVR_4.1",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/SoilSMAG",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/OceanDNA",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/TaraEukaryoticSMAG",
                                                "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/FungiRefSeq-2024-07-25"
                                            ]
                                        }
                                    ],
                                    "doc": "Provided taxonomy metadata from default sylph databases. (only available when running with the container image)",
                                    "label": "Taxonomy metadata",
                                    "name": "#sylph_tax.cwl/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata"
                                }
                            ]
                        },
                        {
                            "type": "record",
                            "name": "#sylph_tax.cwl/taxonomy_metadata/taxonomy_metadata_file",
                            "fields": [
                                {
                                    "type": "File",
                                    "doc": "Taxonomy metadata file(s) that are not incorporated in the docker image.",
                                    "label": "Taxonomy metadata file",
                                    "name": "#sylph_tax.cwl/taxonomy_metadata/taxonomy_metadata_file/taxonomy_metadata_file"
                                }
                            ]
                        }
                    ],
                    "id": "#sylph_tax.cwl/taxonomy_metadata"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$('*.sylphmpa')",
                        "outputEval": "${ \n   // rename default output name and include builtin taxonomy name when used to the outputname\n   if (inputs.taxonomy_metadata.builtin_taxonomy_metadata){\n    self[0].basename=inputs.output_filename_prefix+\".\"+(inputs.taxonomy_metadata.builtin_taxonomy_metadata+\".sylphmpa\").toLowerCase(); return self; \n   } else {\n    self[0].basename=inputs.output_filename_prefix+\".sylphmpa\"; return self;\n   }           \n  }\n"
                    },
                    "id": "#sylph_tax.cwl/sylph_tax"
                }
            ],
            "id": "#sylph_tax.cwl",
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
            "https://schema.org/dateCreated": "2025-02-21",
            "https://schema.org/dateModified": "2025-08-06",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "label": "Sylph profile and sylph-tax",
            "doc": "Taxonomic profiling of reads using Sylph and convert to taxonomy abundances with sylph-tax",
            "outputs": [
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#main/sylph_profile_run/sylph_profile",
                    "id": "#main/sylph_profile"
                },
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#main/sylph_tax/sylph_tax",
                    "id": "#main/tax_file"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "doc": "Add additional column(s) by integrating viral-host information available (currently available for IMGVR4.1). Default false",
                    "label": "Annotate virus hosts",
                    "default": false,
                    "id": "#main/annotate_virus_hosts"
                },
                {
                    "type": "File",
                    "doc": "Sylph database",
                    "label": "Database",
                    "id": "#main/database"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Output destination used for cwl-prov reporting.",
                    "id": "#main/destination"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Estimate true coverage and scale sequence abundance in `profile` by estimated unknown sequence percentage. Default false",
                    "label": "Estimate unknown",
                    "default": true,
                    "id": "#main/estimate_unknown"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "The file containing the forward reads. (fastx/gzip)",
                    "label": "Forward reads",
                    "id": "#main/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow.",
                    "label": "identifier used",
                    "id": "#main/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "The file containing the reverse reads. (fastx/gzip)",
                    "label": "Reverse reads",
                    "id": "#main/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Single end reads, for example long reads. (fastx/gzip)",
                    "label": "Single end reads",
                    "id": "#main/single_end_reads"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#main/taxonomy_metadata/builtin_taxonomy_metadata",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        {
                                            "type": "enum",
                                            "symbols": [
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r214",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/GTDB_r220",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/IMGVR_4.1",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/SoilSMAG",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/OceanDNA",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/TaraEukaryoticSMAG",
                                                "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata/FungiRefSeq-2024-07-25"
                                            ]
                                        }
                                    ],
                                    "doc": "Provided taxonomy metadata from default sylph databases. (only available when running with the container image)",
                                    "label": "Taxonomy metadata",
                                    "name": "#main/taxonomy_metadata/builtin_taxonomy_metadata/builtin_taxonomy_metadata"
                                }
                            ]
                        },
                        {
                            "type": "record",
                            "name": "#main/taxonomy_metadata/taxonomy_metadata_file",
                            "fields": [
                                {
                                    "type": "File",
                                    "doc": "Taxonomy metadata file(s) that are not incorporated in the docker image.",
                                    "label": "Taxonomy metadata file",
                                    "name": "#main/taxonomy_metadata/taxonomy_metadata_file/taxonomy_metadata_file"
                                }
                            ]
                        }
                    ],
                    "id": "#main/taxonomy_metadata"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use. Default 3",
                    "label": "Threads",
                    "default": 3,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "run": "#sylph_profile.cwl",
                    "in": [
                        {
                            "source": "#main/database",
                            "id": "#main/sylph_profile_run/database"
                        },
                        {
                            "source": "#main/estimate_unknown",
                            "id": "#main/sylph_profile_run/estimate_unknown"
                        },
                        {
                            "source": "#main/forward_reads",
                            "id": "#main/sylph_profile_run/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/sylph_profile_run/output_filename_prefix"
                        },
                        {
                            "source": "#main/reverse_reads",
                            "id": "#main/sylph_profile_run/reverse_reads"
                        },
                        {
                            "source": "#main/single_end_reads",
                            "id": "#main/sylph_profile_run/single_end_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/sylph_profile_run/threads"
                        }
                    ],
                    "out": [
                        "#main/sylph_profile_run/sylph_profile"
                    ],
                    "id": "#main/sylph_profile_run"
                },
                {
                    "run": "#sylph_tax.cwl",
                    "in": [
                        {
                            "source": "#main/annotate_virus_hosts",
                            "id": "#main/sylph_tax/annotate_virus_hosts"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/sylph_tax/output_filename_prefix"
                        },
                        {
                            "source": "#main/sylph_profile_run/sylph_profile",
                            "id": "#main/sylph_tax/sylph_profile"
                        },
                        {
                            "source": "#main/taxonomy_metadata",
                            "id": "#main/sylph_tax/taxonomy_metadata"
                        }
                    ],
                    "out": [
                        "#main/sylph_tax/sylph_tax"
                    ],
                    "id": "#main/sylph_tax"
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
            "https://schema.org/dateModified": "2025-04-17",
            "https://schema.org/dateCreated": "2025-02-26",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
