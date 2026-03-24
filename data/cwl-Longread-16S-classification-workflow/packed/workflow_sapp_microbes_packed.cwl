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
            "label": "InterProScan annotation",
            "doc": "Runs Genome annotation with InterProScan using an RDF genome file according to the GBOL ontology\n",
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
                },
                {
                    "ramMax": 10000,
                    "coresMax": 10,
                    "class": "ResourceRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "doc": "Which applications to use (e.g. TIGRFAM,SFLD,SUPERFAMILY,Gene3D,Hamap,Coils,ProSiteProfiles,SMART,PRINTS,ProSitePatterns,Pfam,ProDom,MobiDBLite,PIRSF)",
                    "label": "applications",
                    "inputBinding": {
                        "prefix": "-a"
                    },
                    "default": "Pfam",
                    "id": "#interproscan.cwl/applications"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Number of CPUs acccessible for InterProScan",
                    "label": "cpu limit",
                    "inputBinding": {
                        "prefix": "-cpu"
                    },
                    "default": 2,
                    "id": "#interproscan.cwl/cpu"
                },
                {
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "id": "#interproscan.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "Reference genome file used in RDF format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#interproscan.cwl/input"
                },
                {
                    "type": "Directory",
                    "doc": "Path to the interproscan.sh folder",
                    "label": "InterProScan folder",
                    "inputBinding": {
                        "prefix": "-path"
                    },
                    "id": "#interproscan.cwl/interpro"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar",
                "-interpro"
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.identifier).ttl"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_interpro.json"
                    },
                    "id": "#interproscan.cwl/json"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).ttl"
                    },
                    "id": "#interproscan.cwl/output"
                }
            ],
            "id": "#interproscan.cwl",
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
            "label": "Gene prediction",
            "doc": "Runs microbial gene prediction on GBOL RDF file\n",
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
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "id": "#prodigal.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "Reference genome file used in RDF format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#prodigal.cwl/input"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar",
                "-prodigal",
                "-debug"
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.identifier).prodigal.ttl"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).prodigal.ttl"
                    },
                    "id": "#prodigal.cwl/output"
                }
            ],
            "id": "#prodigal.cwl",
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
                },
                {
                    "class": "LoadListingRequirement"
                }
            ],
            "label": "Genome conversion and annotation",
            "doc": "Workflow for genome annotation from FASTA format",
            "inputs": [
                {
                    "type": "int",
                    "doc": "Codon table used for gene prediction",
                    "label": "Codon table",
                    "id": "#main/codon_table"
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
                    "type": "File",
                    "doc": "Genome sequence in FASTA format",
                    "label": "FASTA input file",
                    "id": "#main/fasta"
                },
                {
                    "type": "string",
                    "doc": "Identifier of the sample being converted",
                    "label": "Sample name",
                    "id": "#main/identifier"
                },
                {
                    "type": "Directory",
                    "doc": "Path to the interproscan application directory",
                    "label": "InterProScan path",
                    "loadListing": "no_listing",
                    "id": "#main/interpro"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "number of threads to use for computational processes",
                    "label": "number of threads",
                    "default": 2,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#main/codon_table",
                            "id": "#main/conversion/codon_table"
                        },
                        {
                            "source": "#main/fasta",
                            "id": "#main/conversion/fasta"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/conversion/identifier"
                        }
                    ],
                    "out": [
                        "#main/conversion/output"
                    ],
                    "id": "#main/conversion"
                },
                {
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#main/interproscan/output",
                            "id": "#main/gzip/inputfile"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/gzip/threads"
                        }
                    ],
                    "out": [
                        "#main/gzip/output"
                    ],
                    "id": "#main/gzip"
                },
                {
                    "run": "#interproscan.cwl",
                    "in": [
                        {
                            "source": "#main/threads",
                            "id": "#main/interproscan/cpu"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/interproscan/identifier"
                        },
                        {
                            "source": "#main/prodigal/output",
                            "id": "#main/interproscan/input"
                        },
                        {
                            "source": "#main/interpro",
                            "id": "#main/interproscan/interpro"
                        }
                    ],
                    "out": [
                        "#main/interproscan/output"
                    ],
                    "id": "#main/interproscan"
                },
                {
                    "run": "#prodigal.cwl",
                    "in": [
                        {
                            "source": "#main/identifier",
                            "id": "#main/prodigal/identifier"
                        },
                        {
                            "source": "#main/conversion/output",
                            "id": "#main/prodigal/input"
                        }
                    ],
                    "out": [
                        "#main/prodigal/output"
                    ],
                    "id": "#main/prodigal"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": "#main/gzip/output",
                    "id": "#main/output"
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
            "https://schema.org/dateModified": "2022-05-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
