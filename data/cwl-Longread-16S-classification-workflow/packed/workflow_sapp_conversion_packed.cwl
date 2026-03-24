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
            "label": "Genome conversion",
            "doc": "Runs Genome conversion tool from SAPP\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Codon table used for this organism",
                    "label": "Codon table",
                    "inputBinding": {
                        "prefix": "-codon"
                    },
                    "id": "#conversion.cwl/codon_table"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference genome file used in EMBL format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion.cwl/embl"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference genome file used in fasta format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion.cwl/fasta"
                },
                {
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "inputBinding": {
                        "prefix": "-id"
                    },
                    "id": "#conversion.cwl/identifier"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar"
            ],
            "arguments": [
                {
                    "valueFrom": "${\n  if (inputs.embl) {\n    return '-embl2rdf';\n  }\n  if (inputs.fasta) {\n    return '-fasta2rdf';\n  }\n}\n"
                },
                {
                    "valueFrom": "${\n  if (inputs.fasta) {\n    return '-genome';\n  } \n  return null;\n}\n"
                },
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.identifier).ttl"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).ttl"
                    },
                    "id": "#conversion.cwl/output"
                }
            ],
            "id": "#conversion.cwl",
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
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -kofamscan",
            "doc": "SAPP conversion from eggNOG-mapper output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
            "inputs": [
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.eggnog.ttl' will be added.",
                    "id": "#conversion_eggnog.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_eggnog.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_eggnog.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).eggnog.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-eggnog"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).eggnog.ttl"
                    },
                    "id": "#conversion_eggnog.cwl/eggnog_ttl"
                }
            ],
            "id": "#conversion_eggnog.cwl",
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
            "https://schema.org/dateModified": "2025-05-05",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -interproscan",
            "doc": "SAPP conversion from InterProScan 5 output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
            "inputs": [
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.interproscan.ttl' will be added.",
                    "id": "#conversion_interproscan.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_interproscan.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_interproscan.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).interproscan.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-interpro"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).interproscan.ttl"
                    },
                    "id": "#conversion_interproscan.cwl/interproscan_ttl"
                }
            ],
            "id": "#conversion_interproscan.cwl",
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
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/dateModified": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -kofamscan",
            "doc": "SAPP conversion from KoFamScan/KoFamKOALA output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Limit",
                    "doc": "Limit the number of hits per locus tag (0=no limit) (optional). Default 0",
                    "inputBinding": {
                        "prefix": "-limit"
                    },
                    "default": 0,
                    "id": "#conversion_kofamscan.cwl/limit"
                },
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.KoFamKOALA.ttl' will be added.",
                    "id": "#conversion_kofamscan.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_kofamscan.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_kofamscan.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).KoFamKOALA.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-kofamscan"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).KoFamKOALA.ttl"
                    },
                    "id": "#conversion_kofamscan.cwl/kofamscan_ttl"
                }
            ],
            "id": "#conversion_kofamscan.cwl",
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
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/dateModified": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Genome conversion",
            "doc": "Runs Genome conversion tool from SAPP\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
            "inputs": [
                {
                    "type": "File",
                    "doc": "RDF file in any format with the right extension",
                    "label": "RDF input file (hdt, ttl, nt, etc...)",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#toHDT.cwl/input"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file with the right extension",
                    "label": "RDF output file (hdt, ttl, nt, etc...)",
                    "inputBinding": {
                        "prefix": "-o"
                    },
                    "id": "#toHDT.cwl/output"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar",
                "-convert"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output)"
                    },
                    "id": "#toHDT.cwl/hdt_output"
                }
            ],
            "id": "#toHDT.cwl",
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
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ],
            "label": "SAPP conversion Workflow",
            "doc": "Workflow for converting annotation tool output into a GBOL RDF file (TTL/HDT) using SAPP.\nCurrent implemented tools:\n    - Bakta (embl)\n    - InterProScan\n    - eggNOG-mapper\n    - Kofamscan\n",
            "outputs": [
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#main/compress_hdt/outfile",
                    "id": "#main/hdt_file"
                }
            ],
            "inputs": [
                {
                    "type": "int",
                    "doc": "The codon table used for gene prediction",
                    "label": "Codon table",
                    "default": 11,
                    "id": "#main/codon_table"
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
                    "label": "eggnog-mapper output",
                    "doc": "eggnog-mapper output file. Annotations tsv file (optional)",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#main/eggnog_output"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#main/embl_file"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "FASTA input file",
                    "doc": "Genome sequence in FASTA format",
                    "id": "#main/genome_fasta"
                },
                {
                    "type": "string",
                    "doc": "Identifier of the sample being converted",
                    "label": "Identifier",
                    "id": "#main/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "InterProScan output",
                    "doc": "InterProScan output file. JSON or TSV (optional)",
                    "id": "#main/interproscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit the number of hits per locus tag to be converted (0=no limit) (optional). Default 0",
                    "id": "#main/kofamscan_limit"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "kofamscan output",
                    "doc": "KoFamScan / KoFamKOALA output file. detail-tsv (optional)",
                    "id": "#main/kofamscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "label": "Compress HDT",
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#main/turtle_to_hdt/hdt_output",
                            "id": "#main/compress_hdt/inputfile"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/compress_hdt/threads"
                        }
                    ],
                    "out": [
                        "#main/compress_hdt/outfile"
                    ],
                    "id": "#main/compress_hdt"
                },
                {
                    "when": "$(inputs.embl != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#main/codon_table",
                            "id": "#main/embl_conversion/codon_table"
                        },
                        {
                            "source": "#main/embl_file",
                            "id": "#main/embl_conversion/embl"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/embl_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#main/embl_conversion/output"
                    ],
                    "id": "#main/embl_conversion"
                },
                {
                    "when": "$(inputs.fasta != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#main/codon_table",
                            "id": "#main/genome_conversion/codon_table"
                        },
                        {
                            "source": "#main/genome_fasta",
                            "id": "#main/genome_conversion/fasta"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/genome_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#main/genome_conversion/output"
                    ],
                    "id": "#main/genome_conversion"
                },
                {
                    "label": "eggNOG conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_eggnog.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "id": "#main/sapp_eggnog/output_prefix"
                        },
                        {
                            "source": [
                                "#main/sapp_interproscan/interproscan_ttl",
                                "#main/sapp_kofamscan/kofamscan_ttl",
                                "#main/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/sapp_eggnog/rdf"
                        },
                        {
                            "source": "#main/eggnog_output",
                            "id": "#main/sapp_eggnog/resultfile"
                        }
                    ],
                    "out": [
                        "#main/sapp_eggnog/eggnog_ttl"
                    ],
                    "id": "#main/sapp_eggnog"
                },
                {
                    "label": "InterProScan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_interproscan.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "id": "#main/sapp_interproscan/output_prefix"
                        },
                        {
                            "source": [
                                "#main/sapp_kofamscan/kofamscan_ttl",
                                "#main/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/sapp_interproscan/rdf"
                        },
                        {
                            "source": "#main/interproscan_output",
                            "id": "#main/sapp_interproscan/resultfile"
                        }
                    ],
                    "out": [
                        "#main/sapp_interproscan/interproscan_ttl"
                    ],
                    "id": "#main/sapp_interproscan"
                },
                {
                    "label": "Kofamscan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_kofamscan.cwl",
                    "in": [
                        {
                            "source": "#main/kofamscan_limit",
                            "id": "#main/sapp_kofamscan/limit"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/sapp_kofamscan/output_prefix"
                        },
                        {
                            "source": "#main/embl_conversion/output",
                            "id": "#main/sapp_kofamscan/rdf"
                        },
                        {
                            "source": "#main/kofamscan_output",
                            "id": "#main/sapp_kofamscan/resultfile"
                        }
                    ],
                    "out": [
                        "#main/sapp_kofamscan/kofamscan_ttl"
                    ],
                    "id": "#main/sapp_kofamscan"
                },
                {
                    "label": "TTL to HDT",
                    "run": "#toHDT.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/sapp_eggnog/eggnog_ttl",
                                "#main/sapp_interproscan/interproscan_ttl",
                                "#main/sapp_kofamscan/kofamscan_ttl",
                                "#main/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/turtle_to_hdt/input"
                        },
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self).SAPP.hdt",
                            "id": "#main/turtle_to_hdt/output"
                        }
                    ],
                    "out": [
                        "#main/turtle_to_hdt/hdt_output"
                    ],
                    "id": "#main/turtle_to_hdt"
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
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/dateModified": "2025-05-05",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
