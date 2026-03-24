{
    "$graph": [
        {
            "class": "CommandLineTool",
            "id": "#bakta.cwl",
            "label": "Bakta: rapid & standardized annotation of bacterial genomes, MAGs & plasmids",
            "doc": "The software and documentation can be found here:\nhttps://github.com/oschwengers/bakta\n\nNecessary database files can be found here:\nhttps://doi.org/10.5281/zenodo.4247252\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "ramMin": 4096,
                    "coresMin": 1,
                    "class": "ResourceRequirement"
                }
            ],
            "hints": [
                {
                    "class": "LoadListingRequirement",
                    "loadListing": "deep_listing"
                },
                {
                    "class": "NetworkAccess",
                    "networkAccess": true
                },
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/bakta:1.9.4-db-light5.1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.9.4"
                            ],
                            "specs": [
                                "https://github.com/oschwengers/bakta",
                                "doi.org/10.1099/mgen.0.000685"
                            ],
                            "package": "bakta"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                {
                    "prefix": "--db",
                    "valueFrom": "${\n  // check if custom profile directory is used\n  if (inputs.db){\n    return inputs.db.path\n  }\n  // else use default built-in bakta db-light database\n  else { \n    return \"/bakta-db_v5.1-light\";\n  }\n}\n"
                }
            ],
            "inputs": [
                {
                    "doc": "Genome assembly in Fasta format",
                    "id": "#bakta.cwl/bakta/fasta_file",
                    "inputBinding": {
                        "position": 100
                    },
                    "type": "File"
                },
                {
                    "doc": "Database path (default = build-in light database)",
                    "id": "#bakta.cwl/bakta/db",
                    "type": [
                        "null",
                        "Directory"
                    ]
                },
                {
                    "doc": "Minimum contig size (default = 1; 200 in compliant mode)",
                    "id": "#bakta.cwl/bakta/min_contig_length",
                    "inputBinding": {
                        "prefix": "--min-contig-length"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Prefix for output files",
                    "id": "#bakta.cwl/bakta/prefix",
                    "inputBinding": {
                        "prefix": "--prefix"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Output directory (default = current working directory)",
                    "id": "#bakta.cwl/bakta/output",
                    "inputBinding": {
                        "prefix": "--output"
                    },
                    "type": [
                        "null",
                        "Directory"
                    ]
                },
                {
                    "doc": "Force overwriting existing output folder (except for current working directory)",
                    "id": "#bakta.cwl/bakta/force",
                    "inputBinding": {
                        "prefix": "--force"
                    },
                    "default": true,
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Genus name",
                    "id": "#bakta.cwl/bakta/genus",
                    "inputBinding": {
                        "prefix": "--genus"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Species name",
                    "id": "#bakta.cwl/bakta/species",
                    "inputBinding": {
                        "prefix": "--species"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Strain name",
                    "id": "#bakta.cwl/bakta/strain",
                    "inputBinding": {
                        "prefix": "--strain"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Plasmid name",
                    "id": "#bakta.cwl/bakta/plasmid",
                    "inputBinding": {
                        "prefix": "--plasmid"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "All sequences are complete replicons (chromosome/plasmid[s])",
                    "id": "#bakta.cwl/bakta/complete",
                    "inputBinding": {
                        "prefix": "--complete"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Prodigal training file for CDS prediction",
                    "id": "#bakta.cwl/bakta/prodigal_tf_file",
                    "inputBinding": {
                        "prefix": "--prodigal-tf"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Translation table 11/4 (default = 11)",
                    "id": "#bakta.cwl/bakta/translation_table",
                    "inputBinding": {
                        "prefix": "--translation-table"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Gram type (default = ?)",
                    "id": "#bakta.cwl/bakta/gram",
                    "inputBinding": {
                        "prefix": "--gram"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Locus prefix (default = contig)",
                    "id": "#bakta.cwl/bakta/locus",
                    "inputBinding": {
                        "prefix": "--locus"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Locus tag prefix (default = autogenerated)",
                    "id": "#bakta.cwl/bakta/locus_tag",
                    "inputBinding": {
                        "prefix": "--locus-tag"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Keep original contig headers",
                    "id": "#bakta.cwl/bakta/keep_contig_headers",
                    "inputBinding": {
                        "prefix": "--keep-contig-headers"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Force Genbank/ENA/DDJB compliance",
                    "id": "#bakta.cwl/bakta/compliant",
                    "inputBinding": {
                        "prefix": "--compliant"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Replicon information table (tsv/csv)",
                    "id": "#bakta.cwl/bakta/replicons",
                    "inputBinding": {
                        "prefix": "--replicons"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Genbank/GFF3 file of trusted regions for pre-detected feature coordinates",
                    "id": "#bakta.cwl/bakta/regions",
                    "inputBinding": {
                        "prefix": "--regions"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Fasta file of trusted protein sequences for CDS annotation",
                    "id": "#bakta.cwl/bakta/proteins",
                    "inputBinding": {
                        "prefix": "--proteins"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Run in metagenome mode",
                    "id": "#bakta.cwl/bakta/meta",
                    "inputBinding": {
                        "prefix": "--meta"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip tRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_tRNA",
                    "inputBinding": {
                        "prefix": "--skip-trna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip tmRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_tmrna",
                    "inputBinding": {
                        "prefix": "--skip-tmrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip rRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_rrna",
                    "inputBinding": {
                        "prefix": "--skip-rrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ncRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ncrna",
                    "inputBinding": {
                        "prefix": "--skip-ncrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ncRNA region detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ncrna_region",
                    "inputBinding": {
                        "prefix": "--skip-ncrna-region"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip CRISPR detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_crispr",
                    "inputBinding": {
                        "prefix": "--skip-crispr"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip CDS detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_cds",
                    "inputBinding": {
                        "prefix": "--skip-cds"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip Pseudogene detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_pseudo",
                    "inputBinding": {
                        "prefix": "--skip-pseudo"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip sORF detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_sorf",
                    "inputBinding": {
                        "prefix": "--skip-sorf"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip gap detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_gap",
                    "inputBinding": {
                        "prefix": "--skip-gap"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ori detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ori",
                    "inputBinding": {
                        "prefix": "--skip-ori"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip genome plotting",
                    "id": "#bakta.cwl/bakta/skip_plot",
                    "inputBinding": {
                        "prefix": "--skip-plot"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Print verbose information",
                    "id": "#bakta.cwl/bakta/verbose",
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": true,
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Run Bakta in debug mode",
                    "id": "#bakta.cwl/bakta/debug",
                    "inputBinding": {
                        "prefix": "--debug"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Threads",
                    "id": "#bakta.cwl/bakta/threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Directory for temporary files (default = system dependent auto detection)",
                    "id": "#bakta.cwl/bakta/tmp_dir",
                    "inputBinding": {
                        "prefix": "--tmp-dir"
                    },
                    "type": [
                        "null",
                        "Directory"
                    ]
                }
            ],
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
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-4216-2721",
                    "https://schema.org/email": "mailto:oliver.schwengers@computational.bio.uni-giessen.de",
                    "https://schema.org/name": "Oliver Schwengers"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2024-07-08",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "doc": "Hypothetical CDS AA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/hypo_sequences_cds",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.hypotheticals.faa"
                    }
                },
                {
                    "doc": "Information on hypothetical CDS as TSV",
                    "id": "#bakta.cwl/bakta/hypo_annotation_tsv",
                    "type": "File",
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "*.hypotheticals.tsv"
                    }
                },
                {
                    "doc": "Annotation as TSV",
                    "id": "#bakta.cwl/bakta/annotation_tsv",
                    "type": "File",
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "${ if (inputs.prefix !== null) { return inputs.prefix + '.tsv'; } else{ return inputs.fasta_file.basename.replace(/\\.[^/.]+$/, '') + '.tsv'; } }"
                    }
                },
                {
                    "doc": "Annotation summary as txt",
                    "id": "#bakta.cwl/bakta/summary_txt",
                    "type": "File",
                    "format": "http://edamontology.org/format_2330",
                    "outputBinding": {
                        "glob": "*.txt"
                    }
                },
                {
                    "doc": "Annotation as JSON",
                    "id": "#bakta.cwl/bakta/annotation_json",
                    "type": "File",
                    "format": "http://edamontology.org/format_3464",
                    "outputBinding": {
                        "glob": "*.json"
                    }
                },
                {
                    "doc": "Annotation as GFF3",
                    "id": "#bakta.cwl/bakta/annotation_gff3",
                    "type": "File",
                    "format": "http://edamontology.org/format_1939",
                    "outputBinding": {
                        "glob": "*.gff3"
                    }
                },
                {
                    "doc": "Annotation as GenBank",
                    "id": "#bakta.cwl/bakta/annotation_gbff",
                    "type": "File",
                    "format": "http://edamontology.org/format_1936",
                    "outputBinding": {
                        "glob": "*.gbff"
                    }
                },
                {
                    "doc": "Annotation as EMBL",
                    "id": "#bakta.cwl/bakta/annotation_embl",
                    "type": "File",
                    "format": "http://edamontology.org/format_1927",
                    "outputBinding": {
                        "glob": "*.embl"
                    }
                },
                {
                    "doc": "Genome Sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_fna",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.fna"
                    }
                },
                {
                    "doc": "Gene DNA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_ffn",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.ffn"
                    }
                },
                {
                    "doc": "CDS AA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_cds",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "${ if (inputs.prefix !== null) { return inputs.prefix + '.faa'; } else{ return inputs.fasta_file.basename.replace(/\\.[^/.]+$/, '') + '.faa'; } }"
                    }
                },
                {
                    "doc": "Circular genome plot as PNG",
                    "id": "#bakta.cwl/bakta/plot_png",
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3603",
                    "outputBinding": {
                        "glob": "*.png"
                    }
                },
                {
                    "doc": "Circular genome plot as SVG",
                    "id": "#bakta.cwl/bakta/plot_svg",
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3604",
                    "outputBinding": {
                        "glob": "*.svg"
                    }
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "Compress a directory (tar)",
            "hints": [
                {
                    "dockerPull": "debian:buster",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": [
                "tar",
                "czfh"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.indir.basename).tar.gz"
                },
                {
                    "valueFrom": "-C"
                },
                {
                    "valueFrom": "$(inputs.indir.path)/.."
                },
                {
                    "valueFrom": "$(inputs.indir.basename)"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "id": "#compress_directory.cwl/indir"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.indir.basename).tar.gz"
                    },
                    "id": "#compress_directory.cwl/outfile"
                }
            ],
            "id": "#compress_directory.cwl",
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
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.inputfile.basename).gz"
                    },
                    "id": "#pigz.cwl/outfile"
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
            "label": "Binette",
            "doc": "Binette is a fast and accurate binning refinement tool designed to construct high-quality MAGs from the output of multiple binning tools.\nThe docker image contains the already downloaded checkm2 database.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/binette:1.1.2_uniref100",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.1.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/binette",
                                "https://doi.org/10.21105/joss.06782"
                            ],
                            "package": "binette"
                        },
                        {
                            "version": [
                                "1.1.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/checkm2",
                                "https://doi.org/10.1038/s41592-020-00923-9"
                            ],
                            "package": "checkm2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "binette"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "doc": "Array of bin folders containing each bin in a fasta file.",
                    "label": "Bins directories",
                    "inputBinding": {
                        "prefix": "--bin_dirs"
                    },
                    "id": "#binette.cwl/bins_dirs"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "CheckM2 database location. Optional when using the container image, it has the database already downloaded.",
                    "label": "CheckM2 database",
                    "inputBinding": {
                        "prefix": "--checkm2_db"
                    },
                    "id": "#binette.cwl/checkm2_db"
                },
                {
                    "type": "float",
                    "doc": "Bin are scored as follow; completeness - weight * contamination. A low contamination_weight favor complete bins over low contaminated bins. Default 2",
                    "label": "Contamination weight",
                    "inputBinding": {
                        "prefix": "--contamination_weight"
                    },
                    "default": 2.0,
                    "id": "#binette.cwl/contamination_weight"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "List of contig2bin table with two columns separated with a tabulation; contig, bin",
                    "label": "Contig2Bin table",
                    "inputBinding": {
                        "prefix": "--contig2bin_tables"
                    },
                    "id": "#binette.cwl/contig2bin_tables"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Contigs in fasta format.",
                    "label": "Contigs",
                    "inputBinding": {
                        "prefix": "--contigs"
                    },
                    "id": "#binette.cwl/contigs"
                },
                {
                    "type": "boolean",
                    "doc": "Debug output. Default false",
                    "label": "Debug",
                    "inputBinding": {
                        "prefix": "--debug"
                    },
                    "default": false,
                    "id": "#binette.cwl/debug"
                },
                {
                    "type": "boolean",
                    "doc": "Use low mem mode when running diamond. Defaullt false",
                    "label": "Low memory",
                    "inputBinding": {
                        "prefix": "--low_mem"
                    },
                    "default": false,
                    "id": "#binette.cwl/low_mem"
                },
                {
                    "type": "int",
                    "doc": "Minimum completeness required for final bin selections. Default 40",
                    "label": "Minimum completeness",
                    "inputBinding": {
                        "prefix": "--min_completeness"
                    },
                    "default": 40,
                    "id": "#binette.cwl/min_completeness"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "FASTA file of predicted proteins in Prodigal format",
                    "label": "Proteins",
                    "inputBinding": {
                        "prefix": "--proteins"
                    },
                    "id": "#binette.cwl/proteins"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use. Default 1",
                    "label": "Threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "default": 1,
                    "id": "#binette.cwl/threads"
                },
                {
                    "type": "boolean",
                    "doc": "Verbose output. Default false",
                    "label": "Verbose",
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": false,
                    "id": "#binette.cwl/verbose"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "doc": "This directory stores all the selected bins in fasta format.",
                    "outputBinding": {
                        "glob": "results/final_bins"
                    },
                    "id": "#binette.cwl/final_bins"
                },
                {
                    "type": "File",
                    "doc": "This is a TSV (tab-separated values) file containing quality information about the final selected bins.",
                    "outputBinding": {
                        "glob": "results/final_bins_quality_reports.tsv"
                    },
                    "id": "#binette.cwl/final_bins_quality_report"
                },
                {
                    "type": "Directory",
                    "doc": "A directory storing quality reports for the input bin sets, with files following the same structure as final_bins_quality_reports.tsv",
                    "outputBinding": {
                        "glob": "results/input_bins_quality_reports"
                    },
                    "id": "#binette.cwl/input_bins_quality_reports"
                }
            ],
            "id": "#binette.cwl",
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
            "https://schema.org/dateModified": "2025-09-02",
            "https://schema.org/dateCreated": "2025-05-02",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
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
            "class": "CommandLineTool",
            "label": "BUSCO",
            "doc": "Based on evolutionarily-informed expectations of gene content of near-universal single-copy orthologs, \nBUSCO metric is complementary to technical metrics like N50.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": "$(inputs.busco_data !== undefined)",
                    "class": "NetworkAccess"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/busco:5.7.0--pyhdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5.7.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/busco",
                                "file:///home/bart/git/cwl/tools/busco/doi.org/10.1093/molbev/msab199"
                            ],
                            "package": "busco"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "busco"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Auto-lineage detection",
                    "doc": "Run auto-lineage to find optimum lineage path",
                    "inputBinding": {
                        "prefix": "--auto-lineage"
                    },
                    "id": "#busco.cwl/auto-lineage"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Eukaryote auto-lineage detection",
                    "doc": "Run auto-placement just on eukaryote tree to find optimum lineage path.",
                    "inputBinding": {
                        "prefix": "--auto-lineage-euk"
                    },
                    "id": "#busco.cwl/auto-lineage-euk"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Prokaryote auto-lineage detection",
                    "doc": "Run auto-lineage just on non-eukaryote trees to find optimum lineage path.",
                    "inputBinding": {
                        "prefix": "--auto-lineage-prok"
                    },
                    "id": "#busco.cwl/auto-lineage-prok"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Dataset location",
                    "doc": "This assumes --offline mode. Specify local filepath for finding BUSCO dataset downloads",
                    "inputBinding": {
                        "prefix": "--download_path"
                    },
                    "id": "#busco.cwl/busco_data"
                },
                {
                    "type": "string",
                    "label": "Name of the output file",
                    "doc": "Give your analysis run a recognisable short name. Output folders and files will be labelled with this name.",
                    "inputBinding": {
                        "prefix": "--out"
                    },
                    "id": "#busco.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Lineage",
                    "doc": "Specify the name of the BUSCO lineage to be used.",
                    "inputBinding": {
                        "prefix": "--lineage_dataset"
                    },
                    "id": "#busco.cwl/lineage"
                },
                {
                    "type": "string",
                    "label": "Input molecule type",
                    "doc": "Specify which BUSCO analysis mode to run.\nThere are three valid modes:\n- geno or genome, for genome assemblies (DNA)\n- tran or transcriptome, for transcriptome assemblies (DNA)\n- prot or proteins, for annotated gene sets (protein)\n",
                    "inputBinding": {
                        "prefix": "--mode"
                    },
                    "id": "#busco.cwl/mode"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Input fasta file",
                    "doc": "Input sequence file in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set. Also possible to use a path to a directory containing multiple input files.",
                    "inputBinding": {
                        "prefix": "--in"
                    },
                    "id": "#busco.cwl/sequence_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Input folder",
                    "doc": "Input folder with sequence files in FASTA format. Can be an assembled genome or transcriptome (DNA), or protein sequences from an annotated gene set. Also possible to use a path to a directory containing multiple input files.",
                    "inputBinding": {
                        "prefix": "--in"
                    },
                    "id": "#busco.cwl/sequence_folder"
                },
                {
                    "type": "boolean",
                    "label": "Skip BBTools",
                    "doc": "Skip BBTools steps",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--skip_bbtools"
                    },
                    "id": "#busco.cwl/skip_bbtools"
                },
                {
                    "type": "boolean",
                    "label": "Compress output",
                    "doc": "Compress some subdirectories with many files to save space",
                    "default": true,
                    "inputBinding": {
                        "prefix": "--tar"
                    },
                    "id": "#busco.cwl/tar_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "id": "#busco.cwl/threads"
                }
            ],
            "arguments": [
                "${\n  if (inputs.busco_data){\n    return '--offline';\n  } else {\n    return null;\n  }\n}\n"
            ],
            "outputs": [
                {
                    "label": "Batch summary",
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Summary file when input is multiple files",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)/batch_summary.txt",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_batch_summary.txt\"; return self;}"
                    },
                    "id": "#busco.cwl/batch_summary"
                },
                {
                    "label": "BUSCO logs folder",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)/logs"
                    },
                    "id": "#busco.cwl/logs"
                },
                {
                    "label": "BUSCO short summary files",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)/short_summary.*"
                    },
                    "id": "#busco.cwl/short_summaries"
                }
            ],
            "id": "#busco.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-01-01",
            "https://schema.org/dateModified": "2025-08-28",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "CoverM",
            "doc": "CoverM calculates coverage of genomes/MAGs coverm genome or individual contigs coverm contig. \nCalculating coverage by read mapping, its input can either be BAM files sorted by reference, or raw reads and reference genomes in various formats.\n\nCurrently only bam files and genome directory input is implemented in this CWL.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/coverm:0.7.0--hcb7b614_4",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.7.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/coverm",
                                "https://doi.org/10.1093/bioinformatics/btaf147"
                            ],
                            "package": "coverm"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "coverm",
                "genome"
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "BAM files",
                    "doc": "Path to BAM file(s). These must be reference sorted (e.g. with samtools sort).\n",
                    "inputBinding": {
                        "prefix": "--bam-files"
                    },
                    "id": "#coverm_genome.cwl/bam_files"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Genome fasta directory",
                    "doc": "Directory containing genome fasta files",
                    "inputBinding": {
                        "prefix": "--genome-fasta-directory"
                    },
                    "id": "#coverm_genome.cwl/genome_fasta_directory"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "File extension of genomes in the directory specified with genome-fasta-directory. (default; fna)",
                    "label": "Genome fasta extension",
                    "inputBinding": {
                        "prefix": "--genome-fasta-extension"
                    },
                    "id": "#coverm_genome.cwl/genome_fasta_extension"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "label": "Genome files",
                    "doc": "Path to genome file(s) in fasta format.",
                    "inputBinding": {
                        "prefix": "--genome-fasta-files"
                    },
                    "id": "#coverm_genome.cwl/genome_fasta_files"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#coverm_genome.cwl/identifier"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#coverm_genome.cwl/method/relative_abundance",
                                "#coverm_genome.cwl/method/mean",
                                "#coverm_genome.cwl/method/trimmed_mean",
                                "#coverm_genome.cwl/method/coverage_histogram",
                                "#coverm_genome.cwl/method/covered_bases",
                                "#coverm_genome.cwl/method/length",
                                "#coverm_genome.cwl/method/count",
                                "#coverm_genome.cwl/method/reads_per_base",
                                "#coverm_genome.cwl/method/anir",
                                "#coverm_genome.cwl/method/rpkm",
                                "#coverm_genome.cwl/method/tpm"
                            ]
                        }
                    ],
                    "doc": "Method to calculate coverage (default; relative_abundance)",
                    "label": "Method to calculate coverage",
                    "default": "relative_abundance",
                    "inputBinding": {
                        "prefix": "--methods"
                    },
                    "id": "#coverm_genome.cwl/method"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "doc": "Genomes with less covered bases than this are reported as having zero coverage.(default; 10)",
                    "label": "Minimum covered fraction",
                    "default": 10,
                    "inputBinding": {
                        "prefix": "--min-covered-fraction"
                    },
                    "id": "#coverm_genome.cwl/min_covered_fraction"
                }
            ],
            "stdout": "coverm.tsv",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "coverm.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_coverm.tsv\"; return self;}"
                    },
                    "id": "#coverm_genome.cwl/coverm_tsv"
                }
            ],
            "id": "#coverm_genome.cwl",
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
            "https://schema.org/dateModified": "2025-09-03",
            "https://schema.org/dateCreated": "2025-09-03",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "eggNOG",
            "doc": "eggNOG is a public resource that provides Orthologous Groups (OGs)\nof proteins at different taxonomic levels, each with integrated and summarized functional annotations.\n",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/eggnog-mapper:2.1.12--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.1.12"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/eggnog-mapper",
                                "https://doi.org/10.1101/2021.06.03.446934"
                            ],
                            "package": "eggnog"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "emapper.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "default": 4,
                    "id": "#eggnog-mapper.cwl/cpu"
                },
                {
                    "type": "boolean",
                    "inputBinding": {
                        "prefix": "--dbmem"
                    },
                    "doc": "Use this option to allocate the whole eggnog.db DB in memory. Database will be unloaded after execution. (default false)",
                    "default": false,
                    "id": "#eggnog-mapper.cwl/dbmem"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog",
                            "fields": [
                                {
                                    "type": "Directory",
                                    "inputBinding": {
                                        "prefix": "--data_dir"
                                    },
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/data_dir"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--database"
                                    },
                                    "doc": "eggNOG database file",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/db"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--dmnd_db"
                                    },
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#eggnog-mapper.cwl/eggnog_dbs"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#eggnog-mapper.cwl/go_evidence/experimental",
                                "#eggnog-mapper.cwl/go_evidence/non-electronic",
                                "#eggnog-mapper.cwl/go_evidence/all"
                            ],
                            "inputBinding": {
                                "prefix": "--go_evidence"
                            }
                        }
                    ],
                    "default": "non-electronic",
                    "doc": "Defines what type of GO terms should be used for annotation. \nexperimental = Use only terms inferred from experimental evidence. \nnon-electronic = Use only non-electronically curated terms.\nDefault non-electronic.\n",
                    "id": "#eggnog-mapper.cwl/go_evidence"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "separate": true,
                        "prefix": "-i"
                    },
                    "label": "Input FASTA file containing protein sequences",
                    "id": "#eggnog-mapper.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#eggnog-mapper.cwl/mode/diamond",
                                "#eggnog-mapper.cwl/mode/hmmer"
                            ],
                            "inputBinding": {
                                "prefix": "-m"
                            }
                        }
                    ],
                    "default": "diamond",
                    "doc": "Run with hmmer or diamond. Default diamond",
                    "id": "#eggnog-mapper.cwl/mode"
                }
            ],
            "arguments": [
                {
                    "position": 2,
                    "prefix": "--annotate_hits_table",
                    "valueFrom": "$(inputs.input_fasta.nameroot)"
                },
                {
                    "position": 3,
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot)"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot)*annotations*"
                    },
                    "id": "#eggnog-mapper.cwl/output_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot)*orthologs*"
                    },
                    "id": "#eggnog-mapper.cwl/output_orthologs"
                }
            ],
            "id": "#eggnog-mapper.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/author": "Ekaterina Sakharova"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                }
            ],
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/dateCreated": "2019-06-14",
            "http://schema.org/dateModified": "2024-10-03"
        },
        {
            "class": "CommandLineTool",
            "label": "EukRep",
            "doc": "EukRep, Classification of Eukaryotic and Prokaryotic sequences from metagenomic datasets",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/eukrep:0.6.7",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.6.7"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/eukrep",
                                "file:///home/bart/git/cwl/tools/eukrep/doi.org/10.1101/171355"
                            ],
                            "package": "diamond"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "EukRep"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Input assembly in fasta format",
                    "label": "Input assembly",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#eukrep.cwl/assembly"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#eukrep.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Minumum contig length",
                    "doc": "Minimum sequence length cutoff for sequences to be included in prediction. Default is 3kb",
                    "id": "#eukrep.cwl/min_contig_size"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "{strict,balanced,lenient} Default is balanced.\nHow stringent the algorithm is in identifying eukaryotic scaffolds. Strict has a lower false positive rate and true positive rate; vice verso for leneient.\n",
                    "label": "Algorithm stringency",
                    "inputBinding": {
                        "prefix": "-m"
                    },
                    "id": "#eukrep.cwl/stringency"
                }
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.identifier)_eukrep.fasta"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_eukrep.fasta"
                    },
                    "id": "#eukrep.cwl/euk_fasta_out"
                }
            ],
            "id": "#eukrep.cwl",
            "https://schema.org/author": [
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
            "https://schema.org/dateModified": "2024-05-30",
            "https://schema.org/dateCreated": "2022-06-00",
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
            "doc": "Expression to filter files (by name) in a directory using a regular expression.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "loadListing": "shallow_listing",
                    "class": "LoadListingRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Reverse",
                    "doc": "Exclude files with regex. (default false)",
                    "default": false,
                    "id": "#folder_file_regex.cwl/exclude"
                },
                {
                    "label": "Input folder",
                    "doc": "Folder with only files",
                    "type": "Directory",
                    "id": "#folder_file_regex.cwl/folder"
                },
                {
                    "type": "boolean",
                    "label": "Output as folder",
                    "doc": "Output files in folder when true. (default false)",
                    "default": false,
                    "id": "#folder_file_regex.cwl/output_as_folder"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output folder name",
                    "doc": "Output folder name. When output folder is true. (default 'filtered')",
                    "default": "filtered",
                    "id": "#folder_file_regex.cwl/output_folder_name"
                },
                {
                    "label": "Regex (JS)",
                    "doc": "JavaScript regular expression to be used on the filenames\nMetaBAT2 example: \"bin\\.[0-9]+\\.fa\"\n",
                    "type": "string",
                    "id": "#folder_file_regex.cwl/regex"
                }
            ],
            "expression": "${\n  var regex = new RegExp(inputs.regex);\n  var array = [];\n  if (inputs.exclude == false) {\n    for (var i = 0; i < inputs.folder.listing.length; i++) {\n      if (regex.test(inputs.folder.listing[i].location)){\n        array = array.concat(inputs.folder.listing[i]);\n      }\n    }\n  } else {\n    for (var i = 0; i < inputs.folder.listing.length; i++) {\n      if (!regex.test(inputs.folder.listing[i].location)){\n        array = array.concat(inputs.folder.listing[i]);\n      }  \n    }    \n  }\n  if (inputs.output_as_folder) {\n        var r = {\n     'output_folder':\n       { \"class\": \"Directory\",\n         \"basename\": inputs.output_folder_name,\n         \"listing\": array\n       }\n     };\n  } else {\n    r = array;\n  }\n   return r;\n}\n",
            "outputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "id": "#folder_file_regex.cwl/output_files"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "id": "#folder_file_regex.cwl/output_folder"
                }
            ],
            "id": "#folder_file_regex.cwl",
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
            "https://schema.org/dateCreated": "2022-10-00",
            "https://schema.org/dateModified": "2022-10-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "ExpressionTool",
            "doc": "Transforms the input folder to an array of files\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "loadListing": "shallow_listing",
                    "class": "LoadListingRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "id": "#folder_to_files.cwl/folder"
                }
            ],
            "expression": "${\n  var files = [];\n  for (var i = 0; i < inputs.folder.listing.length; i++) {\n    files.push(inputs.folder.listing[i]);\n  }\n  return {\"files\": files};\n}  \n",
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "id": "#folder_to_files.cwl/files"
                }
            ],
            "id": "#folder_to_files.cwl",
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
            "https://schema.org/dateCreated": "2022-10-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
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
            "label": "Fastplong",
            "doc": "Ultrafast preprocessing and quality control for long reads (Nanopore, PacBio, Cyclone, etc.).",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/fastplong:0.3.0--h224cc79_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.3.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/fastplong"
                            ],
                            "package": "fastp"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                {
                    "prefix": "--out",
                    "valueFrom": "$(inputs.output_filename_prefix)_fastplong.fastq.gz"
                },
                {
                    "prefix": "--html",
                    "valueFrom": "$(inputs.output_filename_prefix)_fastplong-report.html"
                },
                {
                    "prefix": "--json",
                    "valueFrom": "$(inputs.output_filename_prefix)_fastplong-report.json"
                },
                {
                    "${ inputs.failed_out ? \"--failed-out\"": "null }"
                },
                {
                    "${ inputs.failed_out ? inputs.identifier + \"_fastplong_failed.fastq.gz\"": "null }"
                }
            ],
            "baseCommand": [
                "fastplong"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--adapter_fasta"
                    },
                    "label": "Adapter fasta",
                    "doc": "Specify a FASTA file to trim both read by all the sequences in this FASTA file (string [=])",
                    "id": "#fastplong.cwl/adapter_fasta"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 30,
                    "inputBinding": {
                        "prefix": "--complexity_threshold"
                    },
                    "label": "Complexity threshold",
                    "doc": "The threshold for low complexity filter (0~100). Default is 30, which means 30% complexity is required",
                    "id": "#fastplong.cwl/complexity_threshold"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--compression"
                    },
                    "label": "Compression",
                    "doc": "Compression level for gzip output (1 ~ 9). 1 is fastest, 9 is smallest, Default 4",
                    "id": "#fastplong.cwl/compression"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_front"
                    },
                    "label": "Cut front",
                    "doc": "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise. Default false",
                    "id": "#fastplong.cwl/cut_front"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_front_mean_quality"
                    },
                    "label": "Cut_front_mean_quality",
                    "doc": "The mean quality requirement option for cut_front, default to cut_mean_quality if not specified (int [=20])",
                    "id": "#fastplong.cwl/cut_front_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_front_window_size"
                    },
                    "label": "Cut_front_window_size",
                    "doc": "The window size option of cut_front, default to cut_window_size if not specified (int [=4])",
                    "id": "#fastplong.cwl/cut_front_window_size"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_mean_quality"
                    },
                    "label": "Cut mean quality",
                    "doc": "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36. Default 20",
                    "id": "#fastplong.cwl/cut_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_tail"
                    },
                    "label": "Cut tail",
                    "doc": "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise Default false.",
                    "id": "#fastplong.cwl/cut_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_tail_mean_quality"
                    },
                    "label": "Cut_tail_mean_quality",
                    "doc": "The mean quality requirement option for cut_tail, default to cut_mean_quality if not specified (int [=20])",
                    "id": "#fastplong.cwl/cut_tail_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_tail_window_size"
                    },
                    "label": "Cut_tail_window_size",
                    "doc": "The window size option of cut_tail, default to cut_window_size if not specified (int [=4])",
                    "id": "#fastplong.cwl/cut_tail_window_size"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cut_window_size"
                    },
                    "label": "Cut window size",
                    "doc": "The window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000. Default 4",
                    "id": "#fastplong.cwl/cut_window_size"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--disable_adapter_trimming"
                    },
                    "label": "Disable adapter trimming",
                    "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. Default false",
                    "id": "#fastplong.cwl/disable_adapter_trimming"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--disable_length_filtering"
                    },
                    "label": "Disable_length_filtering",
                    "doc": "Length filtering is enabled by default. If this option is specified, length filtering is disabled",
                    "id": "#fastplong.cwl/disable_length_filtering"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--disable_quality_filtering"
                    },
                    "label": "Disable_quality_filtering",
                    "doc": "Quality filtering is enabled by default. If this option is specified, quality filtering is disabled",
                    "id": "#fastplong.cwl/disable_quality_filtering"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "prefix": "--distance_threshold"
                    },
                    "label": "Distance threshold",
                    "doc": "Threshold of sequence-adapter-distance/adapter-length (0.0 ~ 1.0), greater value means more adapters detected. Default 0.25",
                    "id": "#fastplong.cwl/distance_threshold"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--end_adapter"
                    },
                    "label": "End adapter",
                    "doc": "The adapter sequence at read end (3'). Default auto-detect",
                    "id": "#fastplong.cwl/end_adapter"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "failed_out",
                    "inputBinding": {
                        "prefix": "--failed-out"
                    },
                    "doc": "Output failed reads to a separate file. Disabled by default.",
                    "id": "#fastplong.cwl/failed_out"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "prefix": "--in"
                    },
                    "label": "Input file",
                    "doc": "Read input file name (string [=])",
                    "id": "#fastplong.cwl/input_file"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 0,
                    "inputBinding": {
                        "prefix": "--length_limit"
                    },
                    "label": "Length limit",
                    "doc": "Reads longer than length_limit will be discarded. Default 0 means no limitation",
                    "id": "#fastplong.cwl/length_limit"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 15,
                    "inputBinding": {
                        "prefix": "--length_required"
                    },
                    "label": "Length required",
                    "doc": "Reads shorter than length required will be discarded. Default 15",
                    "id": "#fastplong.cwl/length_required"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--low_complexity_filter"
                    },
                    "label": "Low complexity filter",
                    "doc": "Enable low complexity filter. The complexity is defined as the percentage of base that is different from its next base (base[i] != base[i+1]).",
                    "id": "#fastplong.cwl/low_complexity_filter"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--mean_qual"
                    },
                    "label": "Mean quality",
                    "doc": "If one read's mean_qual quality score <mean_qual, then this read is discarded. Default 0 means no requirement",
                    "id": "#fastplong.cwl/mean_qual"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 5,
                    "inputBinding": {
                        "prefix": "--n_base_limit"
                    },
                    "label": "N_base_limit",
                    "doc": "If one read's number of N base is >n_base_limit, then this read is discarded. Default 5",
                    "id": "#fastplong.cwl/n_base_limit"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Name of the output file. .fastq.gz will be appended to the reads. Default \"fastplong_out\"",
                    "label": "Output filename (base)",
                    "default": "fastplong_out",
                    "id": "#fastplong.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--poly_x_min_len"
                    },
                    "label": "Poly_x_min_len",
                    "doc": "The minimum length to detect polyX in the read tail. Default 10",
                    "id": "#fastplong.cwl/poly_x_min_len"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 8,
                    "inputBinding": {
                        "prefix": "--qualified_quality_phred"
                    },
                    "label": "Qualified_quality_phred",
                    "doc": "The quality value that a base is qualified. Default 8 means phred quality >=Q8 is qualified.",
                    "id": "#fastplong.cwl/qualified_quality_phred"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--reads_to_process"
                    },
                    "label": "Reads_to_process",
                    "doc": "Specify how many reads/pairs to be processed. Default 0 means process all reads. Default 0",
                    "id": "#fastplong.cwl/reads_to_process"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--report_title"
                    },
                    "doc": "Should be quoted with ' or \", default is \"fastplong report\" (string [=fastplong report])",
                    "id": "#fastplong.cwl/report_title"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--split"
                    },
                    "label": "Split",
                    "doc": "Split output by limiting total split file number with this option (2~999), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default",
                    "id": "#fastplong.cwl/split"
                },
                {
                    "type": [
                        "null",
                        "long"
                    ],
                    "inputBinding": {
                        "prefix": "--split_by_lines"
                    },
                    "label": "Split by lines",
                    "doc": "Split output by limiting lines of each file with this option(>=1000), a sequential number prefix will be added to output name ( 0001.out.fq, 0002.out.fq...), disabled by default",
                    "id": "#fastplong.cwl/split_by_lines"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--split_prefix_digits"
                    },
                    "label": "Split prefix digits",
                    "doc": "The digits for the sequential number padding (1~10), default is 4, so the filename will be padded as 0001.xxx, 0 to disable padding",
                    "id": "#fastplong.cwl/split_prefix_digits"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--start_adapter"
                    },
                    "label": "start_adapter",
                    "doc": "The adapter sequence at read start (5'). Default auto-detect",
                    "id": "#fastplong.cwl/start_adapter"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 3,
                    "inputBinding": {
                        "prefix": "--thread"
                    },
                    "label": "Threads",
                    "doc": "Worker thread number. Default 3",
                    "id": "#fastplong.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_front"
                    },
                    "label": "Trim_front",
                    "doc": "Trimming how many bases in front for read. Default 0",
                    "id": "#fastplong.cwl/trim_front"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_poly_x"
                    },
                    "label": "Trim_poly_x",
                    "doc": "Enable polyX trimming in 3' ends. Default false",
                    "id": "#fastplong.cwl/trim_poly_x"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--trim_tail"
                    },
                    "label": "trim_tail",
                    "doc": "Trimming how many bases in tail for read, Default 0",
                    "id": "#fastplong.cwl/trim_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--trimming_extension"
                    },
                    "label": "Trimming extension",
                    "doc": "When an adapter is detected, extend the trimming to make cleaner trimming, Default 10 means trimming 10 bases more",
                    "id": "#fastplong.cwl/trimming_extension"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 40,
                    "inputBinding": {
                        "prefix": "--unqualified_percent_limit"
                    },
                    "label": "Unqualified_percent_limit",
                    "doc": "How many percents of bases are allowed to be unqualified (0~100). Default 40 means 40%",
                    "id": "#fastplong.cwl/unqualified_percent_limit"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "label": "Verbose",
                    "doc": "Output verbose log information (i.e. when every 1M reads are processed).",
                    "id": "#fastplong.cwl/verbose"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_fastplong-report.html"
                    },
                    "id": "#fastplong.cwl/html_report"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_fastplong-report.json"
                    },
                    "id": "#fastplong.cwl/json_report"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_fastplong.fastq.gz"
                    },
                    "id": "#fastplong.cwl/out_reads"
                }
            ],
            "id": "#fastplong.cwl",
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
            "https://schema.org/dateCreated": "2025-07-22",
            "https://schema.org/dateModified": "2025-08-04",
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
                    "dockerPull": "quay.io/biocontainers/flye:2.9.6--py310h275bdba_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.9.6"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/flye",
                                "file:///home/bart/git/cwl/tools/flye/doi.org/10.1038/s41592-020-00971-x",
                                "https://identifiers.org/RRID:SCR_017016"
                            ],
                            "package": "flye"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "flye"
            ],
            "label": "Flye",
            "doc": "Flye De novo assembler for single molecule sequencing reads, with a focus in Oxford Nanopore Technologies reads",
            "arguments": [
                {
                    "valueFrom": "flye_output",
                    "prefix": "--out-dir"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Debug mode",
                    "doc": "Set to true to display debug output while running",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--debug"
                    },
                    "id": "#flye.cwl/debug_mode"
                },
                {
                    "type": "boolean",
                    "label": "deterministic",
                    "doc": "Perform disjointig assembly single-threaded. Default false",
                    "inputBinding": {
                        "prefix": "--deterministic"
                    },
                    "default": false,
                    "id": "#flye.cwl/deterministic"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Genome size",
                    "doc": "Estimated genome size (for example, 5m or 2.6g)",
                    "inputBinding": {
                        "prefix": "--genome-size"
                    },
                    "id": "#flye.cwl/genome_size"
                },
                {
                    "type": "boolean",
                    "label": "Keep haplotypes",
                    "doc": "do not collapse alternative haplotypes. Default false",
                    "inputBinding": {
                        "prefix": "--keep-haplotypes"
                    },
                    "default": false,
                    "id": "#flye.cwl/keep_haplotypes"
                },
                {
                    "type": "boolean",
                    "label": "Metagenome",
                    "doc": "Set to true if assembling a metagenome. Default false",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--meta"
                    },
                    "id": "#flye.cwl/metagenome"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "ONT corrected",
                    "doc": "ONT reads in FASTQ format that were corrected with other methods (<3% error)",
                    "inputBinding": {
                        "prefix": "--nano-corr"
                    },
                    "id": "#flye.cwl/nano_corrected"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "ONT high quality",
                    "doc": "ONT high-quality reads in FASTQ format, Guppy5+ (SUP mode) and Q20 reads (3-5% error rate)",
                    "inputBinding": {
                        "prefix": "--nano-hq"
                    },
                    "id": "#flye.cwl/nano_high_quality"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "ONT reads raw",
                    "doc": "ONT regular reads in FASTQ format, pre-Guppy5 (<20% error)",
                    "inputBinding": {
                        "prefix": "--nano-raw"
                    },
                    "id": "#flye.cwl/nano_raw"
                },
                {
                    "type": "boolean",
                    "label": "No alternative contigs",
                    "doc": "Do not output contigs representing alternative haplotypes. Default false",
                    "inputBinding": {
                        "prefix": "--no-alt-contigs"
                    },
                    "default": false,
                    "id": "#flye.cwl/no_alt_contigs"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Prefix for output files. Underscore will be added after. Default none",
                    "label": "Output prefix",
                    "id": "#flye.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "PacBio reads corrected",
                    "doc": "PacBio  reads in FASTQ format, that were corrected with other methods (<3% error)",
                    "inputBinding": {
                        "prefix": "--pacbio-corr"
                    },
                    "id": "#flye.cwl/pacbio_corrected"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "PacBio HiFi reads",
                    "doc": "PacBio HiFi  reads in FASTQ format, (<1% error)",
                    "inputBinding": {
                        "prefix": "--pacbio-hifi"
                    },
                    "id": "#flye.cwl/pacbio_hifi"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "PacBio reads raw",
                    "doc": "PacBio regular CLR  reads in FASTQ format, (<20% error)",
                    "inputBinding": {
                        "prefix": "--pacbio-raw"
                    },
                    "id": "#flye.cwl/pacbio_raw"
                },
                {
                    "label": "Flye will carry out polishing multiple times as determined here. Default 1",
                    "type": "int",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--iterations"
                    },
                    "id": "#flye.cwl/polishing_iterations"
                },
                {
                    "type": "int",
                    "label": "Threads",
                    "doc": "Maximum threads to use. Default 1",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#flye.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "flye_output/00-assembly"
                    },
                    "id": "#flye.cwl/00_assembly"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "flye_output/10-consensus"
                    },
                    "id": "#flye.cwl/10_consensus"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "flye_output/20-repeat"
                    },
                    "id": "#flye.cwl/20_repeat"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "flye_output/30-contigger"
                    },
                    "id": "#flye.cwl/30_contigger"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "flye_output/40-polishing"
                    },
                    "id": "#flye.cwl/40_polishing"
                },
                {
                    "label": "Polished assembly created by flye, main output for after polishing with next tool",
                    "type": "File",
                    "outputBinding": {
                        "glob": "flye_output/assembly.fasta",
                        "outputEval": "${\n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_flye_assembly.fasta\"; return self; \n   } else {\n    self[0].basename=\"flye_assembly.fasta\"; return self;\n   }\n}\n"
                    },
                    "id": "#flye.cwl/assembly"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "flye_output/assembly_graph.gfa",
                        "outputEval": "${\n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_flye_assembly_graph.gfa\"; return self; \n   } else {\n    self[0].basename=\"flye_assembly_graph.gfa\"; return self;\n   }\n}\n"
                    },
                    "id": "#flye.cwl/assembly_graph"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "flye_output/assembly_info.txt",
                        "outputEval": "${\n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_flye_assembly_info.txt\"; return self; \n   } else {\n    self[0].basename=\"flye_assembly_info.txt\"; return self;\n   }\n}\n"
                    },
                    "id": "#flye.cwl/assembly_info"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "flye_output/flye.log",
                        "outputEval": "${\n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_flye.log\"; return self; \n   } else { return self;}\n}\n"
                    },
                    "id": "#flye.cwl/flye_log"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "flye_output/params.json",
                        "outputEval": "${\n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_flye_params.json\"; return self; \n   } else {\n    self[0].basename=\"flye_params.json\"; return self;\n   }\n}\n"
                    },
                    "id": "#flye.cwl/params"
                }
            ],
            "id": "#flye.cwl",
            "https://schema.org/author": [
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
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-11-29",
            "https://schema.org/dateModified": "2025-05-22",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "GTDBTK Classify Workflow",
            "doc": "Taxonomic genome classification workflow with GTDBTK. \n",
            "baseCommand": [
                "bash",
                "script.sh"
            ],
            "requirements": [
                {
                    "listing": [
                        {
                            "entryname": "script.sh",
                            "entry": "#!/bin/bash\nexport GTDBTK_DATA_PATH=$1\nshift;\ngtdbtk classify_wf $@"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/gtdbtk:2.4.0--pyhdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.4.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/gtdbtk",
                                "file:///home/bart/git/cwl/tools/gtdbtk/doi.org/10.1093/bioinformatics/btac672"
                            ],
                            "package": "gtdbtk"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "doc": "Directory containing bins in fasta format from metagenomic binning",
                    "label": "bins with directory",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--genome_dir"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "fasta file extension",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--extension"
                    },
                    "default": "fa",
                    "id": "#gtdbtk_classify_wf.cwl/fasta_extension"
                },
                {
                    "type": "Directory",
                    "doc": "Directory containing the GTDBTK repository",
                    "label": "gtdbtk data directory",
                    "loadListing": "no_listing",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#gtdbtk_classify_wf.cwl/gtdbtk_data"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#gtdbtk_classify_wf.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "skip ani screen, or specify a --mash_db location",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--skip_ani_screen"
                    },
                    "default": true,
                    "id": "#gtdbtk_classify_wf.cwl/skip_ani_screen"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 8,
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--cpus"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "valueFrom": "--force",
                    "position": 10
                },
                {
                    "prefix": "--prefix",
                    "valueFrom": "$(inputs.identifier).gtdbtk",
                    "position": 11
                },
                {
                    "prefix": "--out_dir",
                    "position": 12,
                    "valueFrom": "$(inputs.identifier)_GTDB-Tk"
                }
            ],
            "stdout": "$(inputs.identifier)_GTDB-Tk.stdout.log",
            "outputs": [
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_GTDB-Tk"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/gtdbtk_out_folder"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_GTDB-Tk/classify/$(inputs.identifier).gtdbtk.bac120.summary.tsv"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/gtdbtk_summary"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_GTDB-Tk.stdout.log"
                    },
                    "id": "#gtdbtk_classify_wf.cwl/stdout_out"
                }
            ],
            "id": "#gtdbtk_classify_wf.cwl",
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
            "https://schema.org/dateModified": "2022-02-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Hostile",
            "doc": "Read contamination filtering for longread paired end data. \nIt will use minimap2 as it's aligner.\n",
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
                    "valueFrom": "minimap2"
                },
                {
                    "prefix": "--out",
                    "valueFrom": "hostile_out"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Index file",
                    "inputBinding": {
                        "prefix": "--index"
                    },
                    "id": "#hostile_clean_longreads.cwl/index"
                },
                {
                    "type": "boolean",
                    "doc": "Keep only reads aligning to the index (and their mates if applicable) (default false)",
                    "label": "Invert",
                    "default": false,
                    "inputBinding": {
                        "prefix": "--invert"
                    },
                    "id": "#hostile_clean_longreads.cwl/invert"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Name of the output file. (_1/_2).fq.gz will be appended to the reads. Default \"hostile_clean\"",
                    "label": "Output filename (base)",
                    "default": "hostile_clean",
                    "id": "#hostile_clean_longreads.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Reads",
                    "doc": "Long read file",
                    "inputBinding": {
                        "prefix": "--fastq1"
                    },
                    "id": "#hostile_clean_longreads.cwl/reads"
                },
                {
                    "type": "int",
                    "doc": "Number of parallel threads to use. Default 4",
                    "label": "Threads",
                    "default": 4,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#hostile_clean_longreads.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "hostile_out/*fastq.gz",
                        "outputEval": "${self[0].basename=inputs.output_filename_prefix+\".fastq.gz\"; return self;}"
                    },
                    "id": "#hostile_clean_longreads.cwl/out_reads"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#hostile_clean_longreads.cwl/summary"
                }
            ],
            "id": "#hostile_clean_longreads.cwl",
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
            "label": "InterProScan",
            "doc": "InterProScan is the software package that allows sequences to be scanned  against InterPro's signatures. Signatures are predictive models,  provided by several different databases, that make up the InterPro consortium.\nYou need to to download a copy of InterProScan v5 here:  https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/\nBefore you run InterProScan 5 for the first time, you should run the command: > python3 setup.py -f interproscan.properties\nDocumentation on InterProScan can be found here: https://interproscan-docs.readthedocs.io",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/interproscan_v5:base",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5"
                            ],
                            "specs": [
                                "https://doi.org/10.1093/bioinformatics/btu031"
                            ],
                            "package": "interproscan"
                        },
                        {
                            "version": [
                                "21.0.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "5.32"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/perl"
                            ],
                            "package": "perl"
                        },
                        {
                            "version": [
                                "3.12.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python"
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
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "baseCommand": [
                "bash",
                "-x"
            ],
            "arguments": [
                {
                    "position": 1,
                    "valueFrom": "$(inputs.interproscan_directory.path)/interproscan.sh"
                },
                {
                    "prefix": "--output-file-base",
                    "position": 9,
                    "valueFrom": "$(inputs.protein_fasta.nameroot).interproscan"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "inputBinding": {
                        "position": 4,
                        "prefix": "--applications"
                    },
                    "default": "Pfam,SFLD,SMART,AntiFam,NCBIfam",
                    "label": "Applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "id": "#interproscan_v5.cwl/applications"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 7,
                        "prefix": "--goterms"
                    },
                    "label": "GOterms",
                    "doc": "Lookup of corresponding Gene Ontology annotation (IMPLIES -iprlookup option). Default true",
                    "id": "#interproscan_v5.cwl/goterms"
                },
                {
                    "inputBinding": {
                        "position": 1
                    },
                    "type": "Directory",
                    "label": "IPR directory",
                    "doc": "InterProScan (full) program directory path",
                    "id": "#interproscan_v5.cwl/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 6,
                        "prefix": "--iprlookup"
                    },
                    "label": "IPR lookup",
                    "doc": "Also include lookup of corresponding InterPro annotation in the TSV and GFF3 output formats. Default true",
                    "id": "#interproscan_v5.cwl/ipr_lookup"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "default": "TSV,JSON",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--formats"
                    },
                    "label": "Output format",
                    "doc": "Optional, case-insensitive, comma separated list of output formats. Supported formats are TSV, XML, JSON, and GFF3. Default  JSON,TSV",
                    "id": "#interproscan_v5.cwl/output_formats"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 8,
                        "prefix": "--pathways"
                    },
                    "label": "Pathways",
                    "doc": "Lookup of corresponding Pathway annotation (IMPLIES -iprlookup option). Default true",
                    "id": "#interproscan_v5.cwl/pathways"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--input"
                    },
                    "label": "Input protein fasta file path",
                    "id": "#interproscan_v5.cwl/protein_fasta"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "position": 3,
                        "prefix": "--cpu"
                    },
                    "id": "#interproscan_v5.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.gff3"
                    },
                    "id": "#interproscan_v5.cwl/gff3_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#interproscan_v5.cwl/json_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#interproscan_v5.cwl/tsv_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.xml"
                    },
                    "id": "#interproscan_v5.cwl/xml_annotations"
                }
            ],
            "id": "#interproscan_v5.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/author": "Michael Crusoe, Aleksandra Ola Tarkowska, Maxim Scheremetjew, Ekaterina Sakharova"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                }
            ],
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/dateCreated": "2019-06-14",
            "http://schema.org/dateModified": "2024-03-00",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl"
        },
        {
            "class": "CommandLineTool",
            "label": "KofamScan",
            "doc": "KofamScan / KofamKOALA assigns K numbers to the user's sequence data by HMMER/HMMSEARCH against KOfam, a customized HMM database of KEGG Orthologs (KOs). \nK number assignments with scores above the predefined thresholds for individual KOs are more reliable than other proposed assignments. \nSuch high score assignments are highlighted with asterisks '*' in the output. \nThe K number assignments facilitate the interpretation of the annotation results by linking the user's sequence data to the KEGG pathways and EC numbers..\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/kofamscan:1.3.0-db.2024-01-01",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.2.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/hmmer",
                                "file:///home/bart/git/cwl/tools/kofamscan/doi.org/10.1093/nar/gkr367"
                            ],
                            "package": "hmmer"
                        },
                        {
                            "version": [
                                "1.3.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/kofamscan",
                                "file:///home/bart/git/cwl/tools/kofamscan/doi.org/10.1093/bioinformatics/btu031"
                            ],
                            "package": "kofamscan"
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
                "exec_annotation"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#kofamscan.cwl/format/detail",
                                "#kofamscan.cwl/format/detail-tsv",
                                "#kofamscan.cwl/format/mapper",
                                "#kofamscan.cwl/format/mapper-one-line"
                            ],
                            "inputBinding": {
                                "prefix": "--format"
                            }
                        }
                    ],
                    "default": "detail-tsv",
                    "doc": "Format of the output. (default detail-tsv)\ndetail:          Detail for each hits (including hits below threshold)\ndetail-tsv:      Tab separeted values for detail format\nmapper:          KEGG Mapper compatible format\nmapper-one-line: Similar to mapper, but all hit KOs are listed in one line\n",
                    "id": "#kofamscan.cwl/format"
                },
                {
                    "type": "File",
                    "doc": "Protein sequences in fasta file format",
                    "label": "Protein fasta file",
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#kofamscan.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#kofamscan.cwl/ko_list"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Profile directory",
                    "doc": "Use a custom profile directory instead of the build-in version.",
                    "id": "#kofamscan.cwl/profile_directory"
                },
                {
                    "label": "Profile organism",
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Specify organism profile; 'eukaryote' and 'prokaryote' are valid choices for the build-in database. Takes the \".hal\" file in the profile directory with given name.",
                    "id": "#kofamscan.cwl/profile_organism"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 3,
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "id": "#kofamscan.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "prefix": "-f",
                    "valueFrom": "detail-tsv"
                },
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot).KofamKOALA.txt"
                },
                {
                    "prefix": "--profile",
                    "valueFrom": "${\n  // set profile organism subset (.hal) file\n  var po = \"\";\n  if (inputs.profile_organism){\n    po = \"/\"+inputs.profile_organism+\".hal\" ;\n  }\n  // check if custom profile directory is used\n  if (inputs.profile_directory){\n    return inputs.profile_directory.path+po\n  }\n  // else use default built-in kofam database\n  else { \n    return \"/profiles\"+po;\n  }\n}\n"
                },
                {
                    "prefix": "--ko-list",
                    "valueFrom": "${\n  if (inputs.ko_list){\n    return inputs.ko_list;\n  } else {\n    return '/ko_list';\n  }\n}\n"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot).KofamKOALA.txt"
                    },
                    "id": "#kofamscan.cwl/output"
                }
            ],
            "id": "#kofamscan.cwl",
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
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-00-00",
            "https://schema.org/dateModified": "2024-03-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
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
            "class": "CommandLineTool",
            "label": "MaxBin2",
            "doc": "MaxBin2 is a software for binning assembled metagenomic sequences based on an Expectation-Maximization algorithm.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/maxbin2:2.2.7",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.7"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/maxbin2",
                                "file:///home/bart/git/cwl/tools/maxbin2/doi.org/10.1093/bioinformatics/btv638"
                            ],
                            "package": "maxbin2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "run_MaxBin.pl"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Abundances file",
                    "label": "Abundances",
                    "inputBinding": {
                        "prefix": "-abund"
                    },
                    "id": "#maxbin2.cwl/abundances"
                },
                {
                    "type": "File",
                    "doc": "Input assembly in fasta format",
                    "label": "Input assembly",
                    "inputBinding": {
                        "prefix": "-contig"
                    },
                    "id": "#maxbin2.cwl/contigs"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#maxbin2.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 1,
                    "inputBinding": {
                        "position": 0,
                        "prefix": "-thread"
                    },
                    "id": "#maxbin2.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "prefix": "-out",
                    "valueFrom": "$(inputs.identifier)_maxbin2.bin"
                }
            ],
            "stdout": "$(inputs.identifier)_maxbin2.log",
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "label": "Bins",
                    "doc": "Bin fasta files. The XX bin. XX are numbers, e.g. out.001.fasta",
                    "outputBinding": {
                        "glob": "*.fasta"
                    },
                    "id": "#maxbin2.cwl/bins"
                },
                {
                    "type": "File",
                    "label": "Log",
                    "doc": "Log file recording the core steps of MaxBin algorithm",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_maxbin2.log"
                    },
                    "id": "#maxbin2.cwl/log"
                },
                {
                    "type": "File",
                    "label": "Markers",
                    "doc": "Marker gene presence numbers for each bin. This table is ready to be plotted by R or other 3rd-party software.",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_maxbin2.bin.marker"
                    },
                    "id": "#maxbin2.cwl/markers"
                },
                {
                    "type": "File",
                    "label": "MaxBin2 Summary",
                    "doc": "Summary file describing which contigs are being classified into which bin.",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_maxbin2.bin.summary"
                    },
                    "id": "#maxbin2.cwl/summary"
                }
            ],
            "id": "#maxbin2.cwl",
            "https://schema.org/author": [
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
            "https://schema.org/dateModified": "2025-05-30",
            "https://schema.org/dateCreated": "2022-08-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Polishing of assembly created from ONT nanopore long reads",
            "doc": "Uses Medaka to polish an assembly constructed from ONT nanopore reads\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/medaka:1.11.3",
                    "class": "DockerRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.11.3"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/medaka"
                            ],
                            "package": "medaka"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "medaka.py"
            ],
            "requirements": [
                {
                    "listing": [
                        "$(inputs.draft_assembly)"
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "label": "Basecalling model that was used by guppy.",
                    "doc": "Please consult https://github.com/nanoporetech/medaka for detailed information.\nChoice of medaka model depends on how basecalling was performed. Run \"medaka tools list\\_models\".\n{pore}_{device}_{caller variant}_{caller version}\nAvailable models: {r103_fast_g507, r103_fast_snp_g507, r103_fast_variant_g507, r103_hac_g507, r103_hac_snp_g507, r103_hac_variant_g507, r103_min_high_g345, r103_min_high_g360, r103_prom_high_g360, r103_prom_snp_g3210, r103_prom_variant_g3210,\n                  r103_sup_g507, r103_sup_snp_g507, r103_sup_variant_g507, r1041_e82_400bps_fast_g615, r1041_e82_400bps_fast_variant_g615, r1041_e82_400bps_hac_g615, r1041_e82_400bps_hac_variant_g615, r1041_e82_400bps_sup_g615, r1041_e82_400bps_sup_variant_g615,\n                  r104_e81_fast_g5015, r104_e81_fast_variant_g5015, r104_e81_hac_g5015, r104_e81_hac_variant_g5015, r104_e81_sup_g5015, r104_e81_sup_g610, r104_e81_sup_variant_g610, r10_min_high_g303, r10_min_high_g340, r941_e81_fast_g514, r941_e81_fast_variant_g514,\n                  r941_e81_hac_g514, r941_e81_hac_variant_g514, r941_e81_sup_g514, r941_e81_sup_variant_g514, r941_min_fast_g303, r941_min_fast_g507, r941_min_fast_snp_g507, r941_min_fast_variant_g507, r941_min_hac_g507, r941_min_hac_snp_g507,\n                  r941_min_hac_variant_g507, r941_min_high_g303, r941_min_high_g330, r941_min_high_g340_rle, r941_min_high_g344, r941_min_high_g351, r941_min_high_g360, r941_min_sup_g507, r941_min_sup_snp_g507, r941_min_sup_variant_g507, r941_prom_fast_g303,\n                  r941_prom_fast_g507, r941_prom_fast_snp_g507, r941_prom_fast_variant_g507, r941_prom_hac_g507, r941_prom_hac_snp_g507, r941_prom_hac_variant_g507, r941_prom_high_g303, r941_prom_high_g330, r941_prom_high_g344, r941_prom_high_g360,\n                  r941_prom_high_g4011, r941_prom_snp_g303, r941_prom_snp_g322, r941_prom_snp_g360, r941_prom_sup_g507, r941_prom_sup_snp_g507, r941_prom_sup_variant_g507, r941_prom_variant_g303, r941_prom_variant_g322, r941_prom_variant_g360, r941_sup_plant_g610,\n                  r941_sup_plant_variant_g610}\nFor basecalling with guppy version >= v3.0.3, select model based on pore name and whether high or fast basecalling was used.\nFor flip flop basecalling with v3.03 > guppy version => v2.3.5 select r941_flip235.\nFor flip flop basecalling with v2.3.5 > guppy version >= 2.1.3 select r941_flip213.\nFor transducer basecaling using Albacore or non-flip-flop guppy basecalling, select r941_trans.\n\nFor test set (https://denbi-nanopore-training-course.readthedocs.io/en/latest/basecalling/basecalling.html?highlight=flowcell),\nuse \"r941_min_hac_g507\" according to the list of available models.\n",
                    "type": "string",
                    "inputBinding": {
                        "prefix": "--model"
                    },
                    "id": "#medaka_consensus_py.cwl/basecall_model"
                },
                {
                    "label": "Assembly that medaka will try to polish.",
                    "type": "File",
                    "inputBinding": {
                        "prefix": "-r"
                    },
                    "id": "#medaka_consensus_py.cwl/draft_assembly"
                },
                {
                    "label": "Basecalled ONT nanopore reads in fastq format.",
                    "type": "File",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#medaka_consensus_py.cwl/reads"
                },
                {
                    "label": "Number of CPU threads used by tool.",
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "-t"
                    },
                    "id": "#medaka_consensus_py.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "polished_*bed"
                    },
                    "id": "#medaka_consensus_py.cwl/gaps_in_draft_coords"
                },
                {
                    "label": "draft assembly polished by medaka.",
                    "type": "File",
                    "outputBinding": {
                        "glob": "polished_*fasta"
                    },
                    "id": "#medaka_consensus_py.cwl/polished_assembly"
                }
            ],
            "id": "#medaka_consensus_py.cwl",
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
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2021-11-29",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "MetaBAT2 binning",
            "doc": "Metagenome Binning based on Abundance and Tetranucleotide frequency (MetaBat2)\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/metabat2:2.15--h4da6f23_2",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.15"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/metabat2",
                                "file:///home/bart/git/cwl/tools/metabat2/doi.org/10.7717%2Fpeerj.7359"
                            ],
                            "package": "metabat2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "metabat2"
            ],
            "arguments": [
                {
                    "prefix": "--outFile",
                    "valueFrom": "metabat2_bins/$(inputs.identifier)_metabat2_bin"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "label": "The input assembly in fasta format",
                    "inputBinding": {
                        "position": 4,
                        "prefix": "--inFile"
                    },
                    "id": "#metabat2.cwl/assembly"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--abdFile"
                    },
                    "id": "#metabat2.cwl/depths"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#metabat2.cwl/identifier"
                },
                {
                    "type": "int",
                    "label": "Number of threads to use",
                    "default": 1,
                    "inputBinding": {
                        "position": 0,
                        "prefix": "--numThreads"
                    },
                    "id": "#metabat2.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Export unbinned contigs as fasta file",
                    "label": "Write unbinned",
                    "inputBinding": {
                        "prefix": "--unbinned"
                    },
                    "id": "#metabat2.cwl/write_unbinned"
                }
            ],
            "stdout": "$(inputs.identifier)_metabat2.log",
            "outputs": [
                {
                    "type": "Directory",
                    "label": "Bin directory",
                    "doc": "Bin directory",
                    "outputBinding": {
                        "glob": "metabat2_bins"
                    },
                    "id": "#metabat2.cwl/bin_dir"
                },
                {
                    "type": "File",
                    "label": "Log",
                    "doc": "MetaBat2 log file",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_metabat2.log"
                    },
                    "id": "#metabat2.cwl/log"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Unbinned contigs",
                    "doc": "Unbinned contig fasta files",
                    "outputBinding": {
                        "glob": "metabat2_bins/$(inputs.identifier)_metabat2_bin.unbinned.fa"
                    },
                    "id": "#metabat2.cwl/unbinned"
                }
            ],
            "id": "#metabat2.cwl",
            "https://schema.org/author": [
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
            "https://schema.org/dateModified": "2025-05-30",
            "https://schema.org/dateCreated": "2022-10-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "jgi_summarize_bam_contig_depths",
            "doc": "Summarize contig read depth from bam file for metabat2 binning.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/metabat2:2.15--h4da6f23_2",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.15"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/metabat2",
                                "file:///home/bart/git/cwl/tools/metabat2/doi.org/10.7717%2Fpeerj.7359"
                            ],
                            "package": "metabat2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "jgi_summarize_bam_contig_depths"
            ],
            "arguments": [
                {
                    "position": 1,
                    "prefix": "--outputDepth",
                    "valueFrom": "$(inputs.identifier)_contigdepths.tsv"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#metabatContigDepths.cwl/bamFile"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file",
                    "label": "output file name",
                    "id": "#metabatContigDepths.cwl/identifier"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_contigdepths.tsv"
                    },
                    "id": "#metabatContigDepths.cwl/depths"
                }
            ],
            "id": "#metabatContigDepths.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                }
            ],
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateModified": "2025-05-30",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/license": "https://spdx.org/licenses/CC0-1.0.html",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Bin read mapping stats",
            "doc": "Table of general read mapping statistics of the bins and assembly\n\nid\nreads\nassembly_size\ncontigs\nn50\nlargest_contig\nmapped reads (percentage)\nbins\ntotal_binned_size\nunbinned_size\nbinned (percentage)\nreads_mapped_to_bins (percentage)\nbinned_contigs\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:e197a628",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.23.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/pysam"
                            ],
                            "package": "pysam"
                        },
                        {
                            "version": [
                                "3.12.0"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python3"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "python3",
                "/scripts/metagenomics/assembly_bins_readstats.py"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "BAM file with reads mapped to the assembly",
                    "label": "BAM file",
                    "inputBinding": {
                        "prefix": "--bam"
                    },
                    "id": "#assembly_bins_readstats.cwl/bam_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing bins in fasta format from metagenomic binning",
                    "label": "Bins directory",
                    "inputBinding": {
                        "prefix": "--bin_dir"
                    },
                    "id": "#assembly_bins_readstats.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Array of bin files in fasta format",
                    "label": "Bin files",
                    "inputBinding": {
                        "prefix": "--bin_files"
                    },
                    "id": "#assembly_bins_readstats.cwl/bin_files"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "inputBinding": {
                        "prefix": "--identifier"
                    },
                    "id": "#assembly_bins_readstats.cwl/identifier"
                }
            ],
            "stdout": "$(inputs.identifier)_binning-stats.tsv",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_binning-stats.tsv"
                    },
                    "id": "#assembly_bins_readstats.cwl/binReadStats"
                }
            ],
            "id": "#assembly_bins_readstats.cwl",
            "https://schema.org/author": [
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
            "https://schema.org/dateModified": "2025-09-05",
            "https://schema.org/dateCreated": "2022-12-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Bin summary",
            "doc": "Creates a summary table of the bins and their quality and taxonomy.\n\nColumns are:\nBin\nContigs\nSize\nLargest_contig\nN50\nGC\nRelative abundance\nGTDB-Tk_taxonomy\nBUSCO_Taxonomy\nBUSCO_score\nCheckM_Completeness\nCheckM_Contamination\nCheckM_Strain-heterogeneity    \n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:e197a628",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/pandas",
                                "file:///home/bart/git/cwl/tools/metagenomics/doi.org/10.5281/zenodo.3509134"
                            ],
                            "package": "pandas"
                        },
                        {
                            "version": [
                                "3.12.0"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python3"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "python3",
                "/scripts/metagenomics/bins_summary.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing bins in fasta format from metagenomic binning",
                    "label": "Bins directory",
                    "inputBinding": {
                        "prefix": "--bin_dir"
                    },
                    "id": "#bins_summary.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Array of bin files in fasta format",
                    "label": "Bin files",
                    "inputBinding": {
                        "prefix": "--bin_files"
                    },
                    "id": "#bins_summary.cwl/bin_files"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Binette report file",
                    "label": "Binette report",
                    "inputBinding": {
                        "prefix": "--binette"
                    },
                    "id": "#bins_summary.cwl/binette_report"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "BUSCO batch report file",
                    "label": "BUSCO batch",
                    "inputBinding": {
                        "prefix": "--busco_batch"
                    },
                    "id": "#bins_summary.cwl/busco_batch"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "CoverM tsv with bins coverages/abundances",
                    "label": "CoverM tsv",
                    "inputBinding": {
                        "prefix": "--coverm"
                    },
                    "id": "#bins_summary.cwl/coverm"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "GTDB-Tk summary file",
                    "label": "GTDB-Tk summary",
                    "inputBinding": {
                        "prefix": "--gtdbtk"
                    },
                    "id": "#bins_summary.cwl/gtdbtk_summary"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#bins_summary.cwl/identifier"
                }
            ],
            "arguments": [
                {
                    "prefix": "--output",
                    "valueFrom": "$(inputs.identifier)"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_bin-contigs.tsv"
                    },
                    "id": "#bins_summary.cwl/bin_contigs"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_bin-summary.tsv"
                    },
                    "id": "#bins_summary.cwl/bins_summary_table"
                }
            ],
            "id": "#bins_summary.cwl",
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
            "https://schema.org/dateModified": "2025-09-03",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Unbinned contigs",
            "doc": "Get unbinned contigs of the assembbly from a set of binned fasta files in fasta format.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:d98a4a55",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5"
                            ],
                            "package": "bash"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "bash",
                "/scripts/metagenomics/get_unbinned_contigs.sh"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "fasta file that was used for the binning.",
                    "label": "assembly fasta file",
                    "inputBinding": {
                        "prefix": "-a"
                    },
                    "id": "#get_unbinned_contigs.cwl/assembly_fasta"
                },
                {
                    "type": "Directory",
                    "doc": "Folder containing bins in fasta format",
                    "label": "Bin folder",
                    "inputBinding": {
                        "prefix": "-b"
                    },
                    "id": "#get_unbinned_contigs.cwl/bin_dir"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Extension of bin files (default; fa)",
                    "label": "Bin file extension",
                    "default": "fa",
                    "inputBinding": {
                        "prefix": "-e"
                    },
                    "id": "#get_unbinned_contigs.cwl/bin_extension"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Enable compression with pigz",
                    "label": "Enable compression",
                    "inputBinding": {
                        "prefix": "-z"
                    },
                    "id": "#get_unbinned_contigs.cwl/compress"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#get_unbinned_contigs.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Threads",
                    "doc": "Number of threads for compression (default; 4)",
                    "default": 4,
                    "inputBinding": {
                        "prefix": "-t"
                    },
                    "id": "#get_unbinned_contigs.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_unbinned-contigs.*"
                    },
                    "id": "#get_unbinned_contigs.cwl/unbinned_fasta"
                }
            ],
            "id": "#get_unbinned_contigs.cwl",
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
            "https://schema.org/dateModified": "2025-09-01",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Minimap2 to (un)mapped long reads",
            "doc": "Get unmapped or mapped long reads reads in fastq.gz format using minimap2 and samtools. Mainly used for contamination removal.\n - requires pigz!\nminimap2 | samtools | pigz\n",
            "requirements": [
                {
                    "listing": [
                        {
                            "entry": "$({class: 'Directory', listing: []})",
                            "entryname": "minimap_run",
                            "writable": true
                        },
                        {
                            "entryname": "script.sh",
                            "entry": "#!/bin/bash\n# 1 $1 = ref\n# 2 $2 = forward_reads\n# 3 $3 = forward_reads\n# 4 $4 = threads\n# 5 $5 = identifier\n# 6 $6 = preset\nminimap2 --split-prefix temp -a -t $4 -x $6 $1 $2 $3 | samtools view -@ $4 -hu - | samtools sort -@ $4 -o $5_sorted.bam"
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
                "-x",
                "script.sh"
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/minimap2:2.28",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.28"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/minimap2",
                                "file:///home/bart/git/cwl/tools/minimap2/doi.org/10.1093/bioinformatics/bty191"
                            ],
                            "package": "minimap2"
                        },
                        {
                            "version": [
                                "1.19.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/samtools",
                                "file:///home/bart/git/cwl/tools/minimap2/doi.org/10.1093/gigascience/giab008"
                            ],
                            "package": "samtools"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Forward sequence in FASTQ/FASTA format (can be gzipped).",
                    "label": "Forward reads",
                    "inputBinding": {
                        "position": 2
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Output prefix (_filtered.fastq.gz will be added)",
                    "label": "identifier",
                    "inputBinding": {
                        "position": 5
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/identifier"
                },
                {
                    "type": "string",
                    "doc": "- map-pb/map-ont - PacBio CLR/Nanopore vs reference mapping\n- map-hifi - PacBio HiFi reads vs reference mapping\n- ava-pb/ava-ont - PacBio/Nanopore read overlap\n- asm5/asm10/asm20 - asm-to-ref mapping, for ~0.1/1/5% sequence divergence\n- splice/splice:hq - long-read/Pacbio-CCS spliced alignment\n- sr - genomic short-read mapping\n",
                    "label": "Read type",
                    "inputBinding": {
                        "position": 6
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/preset"
                },
                {
                    "type": "File",
                    "doc": "Target sequence in FASTQ/FASTA format (can be gzipped).",
                    "label": "Reference",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/reference"
                },
                {
                    "type": "File",
                    "doc": "Reverse sequence in FASTQ/FASTA format (can be gzipped).",
                    "label": "Reverse reads",
                    "inputBinding": {
                        "position": 3
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Maximum threads to use",
                    "label": "Threads",
                    "default": 4,
                    "inputBinding": {
                        "position": 4
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_sorted.bam"
                    },
                    "id": "#minimap2_to_sorted-bam_PE.cwl/sorted_bam"
                }
            ],
            "id": "#minimap2_to_sorted-bam_PE.cwl",
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
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2024-05-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "NanoPlot",
            "doc": "Plotting suite for long read sequencing data and alignments\n\nModified from:\n  https://github.com/common-workflow-library/bio-cwl-tools/blob/release/nanoplot/nanoplot.cwl\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/nanoplot:1.43.0--pyhdfd78af_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "specs": [
                                "https://github.com/wdecoster/NanoPlot/releases",
                                "file:///home/bart/git/cwl/tools/nanoplot/doi.org/10.1093/bioinformatics/btad311"
                            ],
                            "version": [
                                "1.43.0"
                            ],
                            "package": "NanoPlot"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": "NanoPlot",
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--alength"
                    },
                    "id": "#nanoplot.cwl/aligned_length"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "format": "http://edamontology.org/format_2572",
                    "inputBinding": {
                        "prefix": "--bam"
                    },
                    "id": "#nanoplot.cwl/bam_files"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--barcoded"
                    },
                    "id": "#nanoplot.cwl/barcoded"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--color"
                    },
                    "id": "#nanoplot.cwl/color"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--colormap"
                    },
                    "id": "#nanoplot.cwl/colormap"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "format": "http://edamontology.org/format_3462",
                    "inputBinding": {
                        "prefix": "--cram"
                    },
                    "id": "#nanoplot.cwl/cram_files"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--downsample"
                    },
                    "id": "#nanoplot.cwl/downsample"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--dpi"
                    },
                    "id": "#nanoplot.cwl/dpi"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--drop_outliers"
                    },
                    "id": "#nanoplot.cwl/drop_outliers"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "format": "http://edamontology.org/format_1931",
                    "inputBinding": {
                        "prefix": "--fasta"
                    },
                    "id": "#nanoplot.cwl/fasta_files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--fastq"
                    },
                    "id": "#nanoplot.cwl/fastq_files"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--prefix"
                    },
                    "default": "",
                    "id": "#nanoplot.cwl/file_prefix"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "inputBinding": {
                        "prefix": "--font_scale"
                    },
                    "id": "#nanoplot.cwl/font_scale"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#nanoplot.cwl/format/eps",
                                "#nanoplot.cwl/format/jpeg",
                                "#nanoplot.cwl/format/jpg",
                                "#nanoplot.cwl/format/pdf",
                                "#nanoplot.cwl/format/pgf",
                                "#nanoplot.cwl/format/png",
                                "#nanoplot.cwl/format/ps",
                                "#nanoplot.cwl/format/raw",
                                "#nanoplot.cwl/format/rgba",
                                "#nanoplot.cwl/format/svg",
                                "#nanoplot.cwl/format/svgz",
                                "#nanoplot.cwl/format/tif",
                                "#nanoplot.cwl/format/tiff"
                            ]
                        },
                        "null"
                    ],
                    "inputBinding": {
                        "prefix": "--format"
                    },
                    "id": "#nanoplot.cwl/format"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--no-N50"
                    },
                    "id": "#nanoplot.cwl/hide_n50"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--hide_stats"
                    },
                    "id": "#nanoplot.cwl/hide_stats"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Add NanoPlot run info in the report.",
                    "inputBinding": {
                        "prefix": "--info_in_report"
                    },
                    "id": "#nanoplot.cwl/info_in_report"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--listcolormaps"
                    },
                    "id": "#nanoplot.cwl/listcolormaps"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--listcolors"
                    },
                    "id": "#nanoplot.cwl/listcolors"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--loglength"
                    },
                    "id": "#nanoplot.cwl/log_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--maxlength"
                    },
                    "id": "#nanoplot.cwl/max_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--minlength"
                    },
                    "id": "#nanoplot.cwl/min_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--minqual"
                    },
                    "id": "#nanoplot.cwl/min_quality"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--fastq_minimal"
                    },
                    "id": "#nanoplot.cwl/minimal_fastq_files"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--percentqual"
                    },
                    "id": "#nanoplot.cwl/percent_quality"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "--title"
                    },
                    "id": "#nanoplot.cwl/plot_title"
                },
                {
                    "type": [
                        {
                            "type": "array",
                            "items": {
                                "type": "enum",
                                "symbols": [
                                    "#nanoplot.cwl/plots/kde",
                                    "#nanoplot.cwl/plots/hex",
                                    "#nanoplot.cwl/plots/dot"
                                ]
                            }
                        },
                        "null"
                    ],
                    "inputBinding": {
                        "prefix": "--plots"
                    },
                    "id": "#nanoplot.cwl/plots"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#nanoplot.cwl/read_type/1D",
                                "#nanoplot.cwl/read_type/2D",
                                "#nanoplot.cwl/read_type/1D2"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--readtype"
                    },
                    "id": "#nanoplot.cwl/read_type"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--fastq_rich"
                    },
                    "id": "#nanoplot.cwl/rich_fastq_files"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--runtime_until"
                    },
                    "id": "#nanoplot.cwl/run_until"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--N50"
                    },
                    "id": "#nanoplot.cwl/show_n50"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Store the extracted data in a pickle file for future plotting.",
                    "inputBinding": {
                        "prefix": "--store"
                    },
                    "id": "#nanoplot.cwl/store_pickle"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Store the extracted data in tab separated file.",
                    "inputBinding": {
                        "prefix": "--raw"
                    },
                    "id": "#nanoplot.cwl/store_raw"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--summary"
                    },
                    "id": "#nanoplot.cwl/summary_files"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#nanoplot.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Output the stats file as a properly formatted TSV.",
                    "inputBinding": {
                        "prefix": "--tsv_stats"
                    },
                    "id": "#nanoplot.cwl/tsv_stats"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "inputBinding": {
                        "prefix": "--ubam"
                    },
                    "id": "#nanoplot.cwl/ubam_files"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--pickle"
                    },
                    "id": "#nanoplot.cwl/use_pickle_file"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": true,
                    "id": "#nanoplot.cwl/verbose"
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
                        "glob": "$(inputs.file_prefix)ActivePores_Over_Time.*"
                    },
                    "id": "#nanoplot.cwl/ActivePores_Over_Time"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)ActivityMap_ReadsPerChannel.*"
                    },
                    "id": "#nanoplot.cwl/ActivityMap_ReadsPerChannel"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)CumulativeYieldPlot_Gigabases.*"
                    },
                    "id": "#nanoplot.cwl/CumulativeYieldPlot_Gigabases"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)CumulativeYieldPlot_NumberOfReads.*"
                    },
                    "id": "#nanoplot.cwl/CumulativeYieldPlot_NumberOfReads"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)LengthvsQualityScatterPlot_*.*"
                    },
                    "id": "#nanoplot.cwl/LengthvsQualityScatterPlot"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)Non_weightedHistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/Non_weightedHistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)Non_weightedLogTransformed_HistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/Non_weightedLogTransformed_HistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NumberOfReads_Over_Time.*"
                    },
                    "id": "#nanoplot.cwl/NumberOfReads_Over_Time"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)TimeLengthViolinPlot.*"
                    },
                    "id": "#nanoplot.cwl/TimeLengthViolinPlot"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)TimeQualityViolinPlot.*"
                    },
                    "id": "#nanoplot.cwl/TimeQualityViolinPlot"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)WeightedHistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/WeightedHistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)WeightedLogTransformed_HistogramReadlength.*"
                    },
                    "id": "#nanoplot.cwl/WeightedLogTransformed_HistogramReadlength"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)Yield_By_Length.*"
                    },
                    "id": "#nanoplot.cwl/Yield_By_Length"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputBinding": {
                        "glob": "*.log"
                    },
                    "id": "#nanoplot.cwl/log"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot_*.log"
                    },
                    "id": "#nanoplot.cwl/logfile"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoStats.txt"
                    },
                    "id": "#nanoplot.cwl/nanostats"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot-data.pickle"
                    },
                    "id": "#nanoplot.cwl/pickle"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot-data.tsv.gz"
                    },
                    "id": "#nanoplot.cwl/raw_data"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "$(inputs.file_prefix)NanoPlot-report.html"
                    },
                    "id": "#nanoplot.cwl/report"
                }
            ],
            "id": "#nanoplot.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-2703-8936",
                    "https://schema.org/name": "Miguel Boland"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/name": "Michael R. Crusoe"
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
            "https://schema.org/dateCreated": "2020-04-04",
            "https://schema.org/dateModified": "2023-04-03",
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
            "label": "pypolca",
            "doc": "pypolca is a Standalone Python re-implementation of the POLCA genome polisher from the MaSuRCA genome assembly and analysis toolkit.",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/pypolca:0.3.1--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.3.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/pypolca",
                                "file:///home/bart/git/cwl/tools/pypolca/doi.org/10.1099/mgen.0.001254"
                            ],
                            "package": "fastqc"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "pypolca",
                "run"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Path to assembly contigs or scaffolds.",
                    "label": "Assembly Contigs/Scaffolds",
                    "inputBinding": {
                        "prefix": "--assembly"
                    },
                    "id": "#pypolca.cwl/assembly"
                },
                {
                    "type": "boolean",
                    "doc": "Equivalent to --min_alt 4 --min_ratio 3.",
                    "label": "Careful mode",
                    "inputBinding": {
                        "prefix": "--careful"
                    },
                    "default": true,
                    "id": "#pypolca.cwl/careful"
                },
                {
                    "type": "File",
                    "doc": "Path to polishing forward reads. Can be FASTQ or FASTQ gzipped.",
                    "label": "Forward reads",
                    "inputBinding": {
                        "prefix": "--reads1"
                    },
                    "id": "#pypolca.cwl/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Identifier for output files.",
                    "label": "Identifier",
                    "inputBinding": {
                        "prefix": "-p"
                    },
                    "default": "polca",
                    "id": "#pypolca.cwl/identifier"
                },
                {
                    "type": "string",
                    "doc": "Memory per thread to use in samtools sort, set to 2G or more for large genomes. default 2G",
                    "label": "Memory limit per thread",
                    "inputBinding": {
                        "prefix": "-m"
                    },
                    "default": "4G",
                    "id": "#pypolca.cwl/memory_limit"
                },
                {
                    "type": "int",
                    "default": 2,
                    "doc": "Minimum alt allele count to make a change. Default 2",
                    "label": "Minimum Alt Allele Count",
                    "inputBinding": {
                        "prefix": "--min_alt"
                    },
                    "id": "#pypolca.cwl/min_alt"
                },
                {
                    "type": "float",
                    "default": 2.0,
                    "doc": "Minimum alt allele to ref allele ratio to make a change.",
                    "label": "Minimum Alt Allele to Ref Allele Ratio",
                    "inputBinding": {
                        "prefix": "--min_ratio"
                    },
                    "id": "#pypolca.cwl/min_ratio"
                },
                {
                    "type": "boolean",
                    "doc": "Do not polish, just create vcf file, evaluate the assembly and exit.",
                    "label": "Skip polishing",
                    "inputBinding": {
                        "prefix": "-n"
                    },
                    "default": false,
                    "id": "#pypolca.cwl/no_polish"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Path to polishing reverse reads. Can be FASTQ or FASTQ gzipped. Optional. Only use -1 if you have single end reads.",
                    "label": "Reverse reads",
                    "inputBinding": {
                        "prefix": "--reads2"
                    },
                    "id": "#pypolca.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Number of threads. Default 2",
                    "label": "Threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "default": 4,
                    "id": "#pypolca.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output_pypolca/*.log"
                    },
                    "id": "#pypolca.cwl/log"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "output_pypolca/logs"
                    },
                    "id": "#pypolca.cwl/logs_dir"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output_pypolca/*.fasta"
                    },
                    "id": "#pypolca.cwl/polished_genome"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output_pypolca/*.report"
                    },
                    "id": "#pypolca.cwl/report"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output_pypolca/*.vcf"
                    },
                    "id": "#pypolca.cwl/vcf"
                }
            ],
            "id": "#pypolca.cwl",
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
            "https://schema.org/dateCreated": "2024-04-19",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "samtools idxstats",
            "doc": "samtools idxstats - reports alignment summary statistics",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/samtools:1.19.2--h50ea8bc_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.19.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/samtools",
                                "file:///home/bart/git/cwl/tools/samtools/doi.org/10.1093/gigascience/giab008"
                            ],
                            "package": "samtools"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "File",
                    "label": "Bam file",
                    "doc": "(sorted) Bam file",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#samtools_idxstats.cwl/bam_file"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#samtools_idxstats.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 2,
                    "inputBinding": {
                        "position": 0,
                        "prefix": "--threads"
                    },
                    "id": "#samtools_idxstats.cwl/threads"
                }
            ],
            "baseCommand": [
                "samtools",
                "idxstats"
            ],
            "stdout": "$(inputs.identifier)_contigreadcounts.tsv",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_contigreadcounts.tsv"
                    },
                    "id": "#samtools_idxstats.cwl/contigReadCounts"
                }
            ],
            "id": "#samtools_idxstats.cwl",
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
            "https://schema.org/dateModified": "2022-02-22",
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
            "class": "CommandLineTool",
            "label": "SemiBin2",
            "doc": "Single-sample Metagenomic binning with semi-supervised deep learning using information from reference genomes.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/semibin:2.2.0--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/semibin",
                                "file:///home/bart/git/cwl/tools/semibin/doi.org/10.1038/s41467-022-29843-y"
                            ],
                            "package": "semibin"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "SemiBin2",
                "single_easy_bin"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "Input assembly in fasta format",
                    "label": "Input assembly",
                    "inputBinding": {
                        "prefix": "--input-fasta"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/assembly"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Mapped reads to assembly in sorted BAM format",
                    "label": "BAM file",
                    "inputBinding": {
                        "prefix": "--input-bam"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/bam_file"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Built-in models (human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/chicken_caecum/global)",
                    "label": "Environment",
                    "inputBinding": {
                        "prefix": "--environment"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/environment"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "inputBinding": {
                        "prefix": "--tag-output"
                    },
                    "default": "semibin2",
                    "id": "#semibin2_single_easy_bin.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Contig depth file from MetaBAT2",
                    "label": "MetaBAT2 depths",
                    "inputBinding": {
                        "prefix": "--depth-metabat2"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/metabat2_depth_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Reference Database data directory (usually, MMseqs2 GTDB)",
                    "label": "Reference Database",
                    "inputBinding": {
                        "prefix": "--reference-db"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/reference_database"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "An alternative binning algorithm for assemblies from long-read datasets.",
                    "label": "Long read assembly",
                    "inputBinding": {
                        "prefix": "--sequencing-type=long_read"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/sequencing_type_longread"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Number of threads to use",
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/threads"
                }
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "semibin2"
                },
                {
                    "prefix": "--compression",
                    "valueFrom": "none"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Coverage data",
                    "doc": "Coverage data generated from depth file.",
                    "outputBinding": {
                        "glob": "semibin2/\"*_cov.csv\""
                    },
                    "id": "#semibin2_single_easy_bin.cwl/coverage"
                },
                {
                    "type": "File",
                    "label": "Training data",
                    "doc": "Data used in the training of deep learning model",
                    "outputBinding": {
                        "glob": "semibin2/data.csv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_semibin2_data.csv\"; return self;}"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/data"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Training data",
                    "doc": "Data used in the training of deep learning model, not generated when using MetaBAT2 depth file.",
                    "outputBinding": {
                        "glob": "semibin2/data_split.csv"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/data_split"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Bins info",
                    "doc": "Info on (reclustered) bins (contig,nbs,n50 etc..)",
                    "outputBinding": {
                        "glob": "semibin2/recluster_bins_info.tsv",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_semibin2_recluster_bins_info.tsv\"; return self;}"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/info"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "MMseqs annotation",
                    "doc": "MMseqs contig annotation",
                    "outputBinding": {
                        "glob": "mmseqs_contig_annotation"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/mmseqs_contig_annotation"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Deep learning model",
                    "doc": "Saved semi-supervised deep learning model.",
                    "outputBinding": {
                        "glob": "semibin2/model.h5"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/model"
                },
                {
                    "type": "Directory",
                    "label": "Bins",
                    "doc": "Directory of all reconstructed bins before reclustering.",
                    "outputBinding": {
                        "glob": "semibin2/output_bins",
                        "outputEval": "${self[0].basename=inputs.identifier+\"_semibin2_output_bins\"; return self;}"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/output_bins"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Markers",
                    "doc": "Directory with HMM marker hits",
                    "outputBinding": {
                        "glob": "semibin2/sample0"
                    },
                    "id": "#semibin2_single_easy_bin.cwl/sample0"
                }
            ],
            "id": "#semibin2_single_easy_bin.cwl",
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
            "https://schema.org/dateCreated": "2022-09-00",
            "https://schema.org/dateModified": "2025-08-28",
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
            "class": "CommandLineTool",
            "label": "SPAdes assembler",
            "doc": "SPAdes is a versatile toolkit designed for assembly and analysis of sequencing data. \nSPAdes is primarily developed for Illumina sequencing data, but can be used for IonTorrent as well. \nMost of SPAdes pipelines support hybrid mode, i.e. allow using long reads (PacBio and Oxford Nanopore) as a supplementary data.\n",
            "requirements": [
                {
                    "listing": [
                        {
                            "entryname": "input_spades.json",
                            "entry": "[\n  {\n    orientation: \"fr\",\n    type: \"paired-end\",\n    right reads: $( inputs.forward_reads.map( function(x) {return  x.path} ) ),\n    left reads: $( inputs.reverse_reads.map( function(x) {return  x.path} ) )\n  }            \n  ${\n    var pacbio=\"\"\n      if (inputs.pacbio_reads != null) {\n       pacbio+=',{ type: \"pacbio\", single reads: [\"' + inputs.pacbio_reads.map( function(x) {return  x.path} ).join('\",\"') + '\"] }' \n    }\n    return pacbio;\n  }\n  ${\n    var nanopore=\"\"\n      if (inputs.nanopore_reads != null) {\n       nanopore+=',{ type: \"nanopore\", single reads: [\"' + inputs.nanopore_reads.map( function(x) {return  x.path} ).join('\",\"') + '\"] }'\n      //  nanopore+=',{ type: \"nanopore\", single reads: [\"' + inputs.nanopore_reads.join('\",\"') + '\"] }'\n    }\n    return nanopore;\n  }\n]"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/spades:3.15.5--h95f258a_1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.15.5"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/spades",
                                "file:///home/bart/git/cwl/tools/spades/doi.org/10.1002/cpbi.102"
                            ],
                            "package": "spades"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "spades.py",
                "--dataset",
                "input_spades.json"
            ],
            "arguments": [
                {
                    "valueFrom": "$(runtime.outdir)/output",
                    "prefix": "-o"
                },
                {
                    "valueFrom": "$(inputs.memory / 1000)",
                    "prefix": "--memory"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "this flag is required for IonTorrent data",
                    "label": "iontorrent data",
                    "inputBinding": {
                        "prefix": "--iontorrent"
                    },
                    "id": "#spades.cwl/IonTorrent"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "this flag is required for biosyntheticSPAdes mode",
                    "label": "biosynthetic spades mode",
                    "inputBinding": {
                        "prefix": "--bio"
                    },
                    "id": "#spades.cwl/biosyntheticSPAdes"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "The file containing the forward reads",
                    "label": "Forward reads",
                    "id": "#spades.cwl/forward_reads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "this flag is highly recommended for high-coverage isolate and multi-cell data",
                    "label": "high-coverage mode",
                    "inputBinding": {
                        "prefix": "--isolate"
                    },
                    "id": "#spades.cwl/isolate"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "List of k-mer sizes (must be odd and less than 128). Separate with comma, no space. Default 'auto'",
                    "label": "Kmer sizes",
                    "inputBinding": {
                        "prefix": "-k"
                    },
                    "id": "#spades.cwl/kmer_sizes"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Memory used in megabytes",
                    "id": "#spades.cwl/memory"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "this flag is required for metagenomic sample data",
                    "label": "metagenomics sample",
                    "inputBinding": {
                        "prefix": "--meta"
                    },
                    "id": "#spades.cwl/metagenome"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Fastq file with Oxford NanoPore reads",
                    "label": "NanoPore reads",
                    "id": "#spades.cwl/nanopore_reads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Runs only assembling (without read error correction)",
                    "label": "Only assembler",
                    "inputBinding": {
                        "prefix": "--only-assembler"
                    },
                    "id": "#spades.cwl/only_assembler"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Prefix for output files. Underscore will be added after. Default none",
                    "label": "Output prefix",
                    "id": "#spades.cwl/output_filename_prefix"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Fastq file with PacBio CLR reads",
                    "label": "PacBio CLR reads",
                    "id": "#spades.cwl/pacbio_reads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "runs plasmidSPAdes pipeline for plasmid detection",
                    "label": "plasmid spades run",
                    "inputBinding": {
                        "prefix": "--plasmid"
                    },
                    "id": "#spades.cwl/plasmid"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "The file containing the reverse reads",
                    "label": "Reverse reads",
                    "id": "#spades.cwl/reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "this flag is required for RNA-Seq data",
                    "label": "rnaseq data",
                    "inputBinding": {
                        "prefix": "--rna"
                    },
                    "id": "#spades.cwl/rna"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "number of threads to use",
                    "label": "threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "default": 10,
                    "id": "#spades.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/assembly_graph.fastg",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_assembly_graph.fastg\"; return self; \n   } else {\n    self[0].basename=\"spades_assembly_graph.fastg\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/assembly_graph"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/assembly_graph_with_scaffolds.gfa",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_assembly_graph_with_scaffolds.gfa\"; return self; \n   } else {\n    self[0].basename=\"spades_assembly_graph_with_scaffolds.gfa\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/assembly_graph_with_scaffolds"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/contigs.fasta",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_contigs.fasta\"; return self; \n   } else {\n    self[0].basename=\"spades_contigs.fasta\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/contigs"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/contigs.paths",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_contigs.paths\"; return self; \n   } else {\n    self[0].basename=\"spades_contigs.paths\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/contigs_assembly_paths"
                },
                {
                    "label": "contigs before repeat resolution",
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/before_rr.fasta",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_before_rr.fasta\"; return self; \n   } else {\n    self[0].basename=\"spades_before_rr.fasta\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/contigs_before_rr"
                },
                {
                    "label": "internal configuration file",
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/dataset.info",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_dataset.info\"; return self; \n   } else {\n    self[0].basename=\"spades_dataset.info\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/internal_config"
                },
                {
                    "label": "internal YAML data set file",
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/input_dataset.yaml",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_input_dataset.yaml\"; return self; \n   } else {\n    self[0].basename=\"spades_input_dataset.yaml\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/internal_dataset"
                },
                {
                    "label": "SPAdes log",
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/spades.log",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename = inputs.output_filename_prefix+\"_spades.log\"; return self; \n   } else { return self; }\n}\n"
                    },
                    "id": "#spades.cwl/log"
                },
                {
                    "label": "information about SPAdes parameters in this run",
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/params.txt",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_params.txt\"; return self; \n   } else {\n    self[0].basename=\"spades_params.txt\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/params"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/scaffolds.fasta",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_scaffolds.fasta\"; return self; \n   } else {\n    self[0].basename=\"spades_scaffolds.fasta\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/scaffolds"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "output/scaffolds.paths",
                        "outputEval": "${ \n   // rename default output name and add prefix if given\n   if (inputs.output_filename_prefix) {\n    self[0].basename=inputs.output_filename_prefix+\"_spades_scaffolds.paths\"; return self; \n   } else {\n    self[0].basename=\"spades_scaffolds.paths\"; return self;\n   }\n}\n"
                    },
                    "id": "#spades.cwl/scaffolds_assembly_paths"
                }
            ],
            "id": "#spades.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                }
            ],
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/dateModified": "2024-05-22",
            "http://schema.org/license": "https://spdx.org/licenses/CC0-1.0.html",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Fasta statistics",
            "doc": "Fasta statistics like N50, total length, etc..",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/raw_n50:idba-1.1.3",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": [
                "raw_n50"
            ],
            "stdout": "$(inputs.identifier)_stats.txt",
            "inputs": [
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#raw_n50.cwl/identifier"
                },
                {
                    "type": "File",
                    "label": "Input fasta",
                    "doc": "Input multi fasta file",
                    "inputBinding": {
                        "position": 1
                    },
                    "id": "#raw_n50.cwl/input_fasta"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_stats.txt"
                    },
                    "id": "#raw_n50.cwl/output"
                }
            ],
            "id": "#raw_n50.cwl",
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
            "https://schema.org/dateCreated": "2022-00-06",
            "https://schema.org/dateModified": "2024-03-00",
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
                    "outputSource": "#workflow_kraken2-bracken.cwl/files_to_folder_bracken/results",
                    "id": "#workflow_kraken2-bracken.cwl/bracken_folder"
                },
                {
                    "type": "Directory",
                    "label": "Kraken2 folder",
                    "doc": "Folder with Kraken2 output files",
                    "outputSource": "#workflow_kraken2-bracken.cwl/files_to_folder_kraken/results",
                    "id": "#workflow_kraken2-bracken.cwl/kraken2_folder"
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
                    "id": "#workflow_kraken2-bracken.cwl/bracken_levels"
                },
                {
                    "type": "int",
                    "label": "Bracken reads threshold",
                    "doc": "Number of reads required PRIOR to abundance estimation to perform reestimation in bracken. Default 0",
                    "default": 0,
                    "id": "#workflow_kraken2-bracken.cwl/bracken_reads_threshold"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional output destination only used for cwl-prov reporting.",
                    "id": "#workflow_kraken2-bracken.cwl/destination"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#workflow_kraken2-bracken.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "Forward sequence fastq file(s) locally",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_kraken2-bracken.cwl/illumina_forward_reads"
                },
                {
                    "type": "File",
                    "doc": "Reverse sequence fastq file(s) locally",
                    "label": "Reverse reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_kraken2-bracken.cwl/illumina_reverse_reads"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "Kraken2 confidence threshold",
                    "doc": "Confidence score threshold (default 0.0) must be between [0, 1]",
                    "id": "#workflow_kraken2-bracken.cwl/kraken2_confidence"
                },
                {
                    "type": "Directory",
                    "label": "Kraken2 database",
                    "doc": "Kraken2 database location",
                    "loadListing": "no_listing",
                    "id": "#workflow_kraken2-bracken.cwl/kraken2_database"
                },
                {
                    "type": "boolean",
                    "label": "Kraken2 standard report",
                    "doc": "Also output Kraken2 standard report with per read classification. These can be large. (default true)",
                    "default": true,
                    "id": "#workflow_kraken2-bracken.cwl/output_standard_report"
                },
                {
                    "type": "int",
                    "label": "Read length",
                    "doc": "Read length to use in bracken",
                    "id": "#workflow_kraken2-bracken.cwl/read_length"
                },
                {
                    "type": "boolean",
                    "label": "Run Bracken",
                    "doc": "Skip Bracken analysis. Default false.",
                    "default": false,
                    "id": "#workflow_kraken2-bracken.cwl/skip_bracken"
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
                    "id": "#workflow_kraken2-bracken.cwl/source"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Number of threads to use for computational processes",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#workflow_kraken2-bracken.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "Bracken folder",
                    "doc": "Bracken files to single folder",
                    "in": [
                        {
                            "default": "Bracken_Illumina",
                            "id": "#workflow_kraken2-bracken.cwl/files_to_folder_bracken/destination"
                        },
                        {
                            "source": [
                                "#workflow_kraken2-bracken.cwl/illumina_bracken/output_report"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_kraken2-bracken.cwl/files_to_folder_bracken/files"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#workflow_kraken2-bracken.cwl/files_to_folder_bracken/results"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/files_to_folder_bracken"
                },
                {
                    "label": "Kraken2 folder",
                    "doc": "Kraken2 files to single folder",
                    "in": [
                        {
                            "default": "Kraken2_Illumina",
                            "id": "#workflow_kraken2-bracken.cwl/files_to_folder_kraken/destination"
                        },
                        {
                            "source": [
                                "#workflow_kraken2-bracken.cwl/illumina_kraken2/sample_report",
                                "#workflow_kraken2-bracken.cwl/illumina_kraken2/sample_report",
                                "#workflow_kraken2-bracken.cwl/kraken2krona_txt/krona_txt",
                                "#workflow_kraken2-bracken.cwl/krona/krona_html",
                                "#workflow_kraken2-bracken.cwl/kraken2_compress/outfile"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_kraken2-bracken.cwl/files_to_folder_kraken/files"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#workflow_kraken2-bracken.cwl/files_to_folder_kraken/results"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/files_to_folder_kraken"
                },
                {
                    "label": "Illumina bracken",
                    "doc": "Bracken runs on Illumina reads",
                    "run": "#bracken.cwl",
                    "when": "$(!inputs.skip_bracken)",
                    "scatter": "#workflow_kraken2-bracken.cwl/illumina_bracken/level",
                    "in": [
                        {
                            "source": "#workflow_kraken2-bracken.cwl/kraken2_database",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/database"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/identifier",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/identifier"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/illumina_kraken2/sample_report",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/kraken_report"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/bracken_levels",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/level"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/read_length",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/read_length"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/skip_bracken",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/skip_bracken"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/bracken_reads_threshold",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_bracken/threshold"
                        }
                    ],
                    "out": [
                        "#workflow_kraken2-bracken.cwl/illumina_bracken/output_report"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/illumina_bracken"
                },
                {
                    "label": "Kraken2",
                    "doc": "bla",
                    "run": "#kraken2.cwl",
                    "in": [
                        {
                            "source": "#workflow_kraken2-bracken.cwl/kraken2_confidence",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/confidence"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/kraken2_database",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/database"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/illumina_forward_reads",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/forward_reads"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/identifier",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/identifier"
                        },
                        {
                            "default": true,
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/paired_end"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/illumina_reverse_reads",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/reverse_reads"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/threads",
                            "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2/threads"
                        }
                    ],
                    "out": [
                        "#workflow_kraken2-bracken.cwl/illumina_kraken2/sample_report",
                        "#workflow_kraken2-bracken.cwl/illumina_kraken2/standard_report"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/illumina_kraken2"
                },
                {
                    "label": "Compress kraken2",
                    "doc": "Compress large kraken2 report file",
                    "when": "$(inputs.kraken2_standard_report)",
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#workflow_kraken2-bracken.cwl/illumina_kraken2/standard_report",
                            "id": "#workflow_kraken2-bracken.cwl/kraken2_compress/inputfile"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/output_standard_report",
                            "id": "#workflow_kraken2-bracken.cwl/kraken2_compress/kraken2_standard_report"
                        },
                        {
                            "source": "#workflow_kraken2-bracken.cwl/threads",
                            "id": "#workflow_kraken2-bracken.cwl/kraken2_compress/threads"
                        }
                    ],
                    "out": [
                        "#workflow_kraken2-bracken.cwl/kraken2_compress/outfile"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/kraken2_compress"
                },
                {
                    "label": "kraken2krona",
                    "doc": "Convert kraken2 report to krona format",
                    "run": "#kreport2krona.cwl",
                    "in": [
                        {
                            "source": "#workflow_kraken2-bracken.cwl/illumina_kraken2/sample_report",
                            "id": "#workflow_kraken2-bracken.cwl/kraken2krona_txt/report"
                        }
                    ],
                    "out": [
                        "#workflow_kraken2-bracken.cwl/kraken2krona_txt/krona_txt"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/kraken2krona_txt"
                },
                {
                    "label": "Krona",
                    "doc": "Krona visualization of Kraken2",
                    "run": "#krona_ktImportText.cwl",
                    "in": [
                        {
                            "source": "#workflow_kraken2-bracken.cwl/kraken2krona_txt/krona_txt",
                            "id": "#workflow_kraken2-bracken.cwl/krona/input"
                        }
                    ],
                    "out": [
                        "#workflow_kraken2-bracken.cwl/krona/krona_html"
                    ],
                    "id": "#workflow_kraken2-bracken.cwl/krona"
                }
            ],
            "id": "#workflow_kraken2-bracken.cwl",
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
            "label": "Long Read Quality Control and Filtering",
            "doc": "**Workflow for long read quality control and contamination filtering.**\n- NanoPlot before and after filtering (read quality control)\n- Filtlong filter on quality and length\n- minimap2 read filtering based on given references\n\nOther UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>\n\n**All tool CWL files and other workflows can be found here:**<br>\n  Tools: https://gitlab.com/m-unlock/cwl/-/tree/master/cwl <br>\n  Workflows: https://gitlab.com/m-unlock/cwl/-/tree/master/cwl/workflows<br>\n\n**How to setup and use an UNLOCK workflow:**<br>\nhttps://docs.m-unlock.nl/docs/workflows/setup.html<br>\n",
            "outputs": [
                {
                    "type": "File",
                    "label": "Filtered long reads",
                    "doc": "Filtered long reads",
                    "outputSource": "#workflow_longread_quality.cwl/output_filtered_reads/reads_out",
                    "id": "#workflow_longread_quality.cwl/filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Reports folder",
                    "doc": "Folder with quality plots and filter reports",
                    "outputSource": "#workflow_longread_quality.cwl/reports_files_to_folder/results",
                    "id": "#workflow_longread_quality.cwl/reports_folder"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Adapter fasta",
                    "doc": "Specify a FASTA file to trim both read ends by all the sequences in this FASTA file. (Default None)",
                    "id": "#workflow_longread_quality.cwl/adapter_fasta"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Cut front",
                    "doc": "Move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise. Default false",
                    "id": "#workflow_longread_quality.cwl/cut_front"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Cut mean quality",
                    "doc": "The mean quality requirement option shared by cut_front, cut_tail or cut_sliding. Range: 1~36. Default 20",
                    "id": "#workflow_longread_quality.cwl/cut_mean_quality"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Cut tail",
                    "doc": "Move a sliding window from tail (3') to front, drop the bases in the window if its mean quality < threshold, stop otherwise Default false.",
                    "id": "#workflow_longread_quality.cwl/cut_tail"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "label": "Cut window size",
                    "doc": "The window size option shared by cut_front, cut_tail or cut_sliding. Range: 1~1000. Default 4",
                    "id": "#workflow_longread_quality.cwl/cut_window_size"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional output destination only used for cwl-prov reporting.",
                    "id": "#workflow_longread_quality.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable adapter trimming",
                    "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. Default false",
                    "id": "#workflow_longread_quality.cwl/disable_adapter_trimming"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable_quality_filtering",
                    "doc": "\"Quality filtering is enabled by default. If this option is specified, quality filtering is disabled. \nDoes not apply to human and reference filtering. (Default false)\"\n",
                    "id": "#workflow_longread_quality.cwl/disable_quality_filtering"
                },
                {
                    "type": "boolean",
                    "label": "Don't output reads.",
                    "doc": "Do not output filtered reads. (default false)",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/do_not_output_filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "End adapter",
                    "doc": "The adapter sequence at read end (3'). (Default auto-detect)",
                    "id": "#workflow_longread_quality.cwl/end_adapter"
                },
                {
                    "type": "boolean",
                    "doc": "Input fastq is generated by albacore, MinKNOW or guppy  with additional information concerning channel and time. \nUsed to creating more informative quality plots (Default false)\n",
                    "label": "Fastq rich (ONT)",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/fastq_rich"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (Default None)",
                    "label": "Filter human reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_longread_quality.cwl/humandb"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#workflow_longread_quality.cwl/identifier"
                },
                {
                    "type": "boolean",
                    "doc": "Discard unmapped and keep reads mapped to the given reference. Default false (discard mapped)",
                    "label": "Keep mapped reads",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/keep_reference_mapped_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Maximum length limit",
                    "doc": "Reads longer than length_limit will be discarded. (Default no limit)",
                    "id": "#workflow_longread_quality.cwl/length_limit"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Long read sequence file locally fastq format",
                    "label": "Long reads",
                    "id": "#workflow_longread_quality.cwl/longreads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Mean quality",
                    "doc": "if one read's mean_qual quality score < mean_qual, then this read is discarded. (Default 10)",
                    "default": 10,
                    "id": "#workflow_longread_quality.cwl/mean_qual"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 100,
                    "label": "Minimum length required",
                    "doc": "Reads shorter will be discarded. (Default 100)",
                    "id": "#workflow_longread_quality.cwl/minimum_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Poly_x_min_len",
                    "doc": "The minimum length to detect polyX in the read tail. (Default 10 when trim_poly_x is true)",
                    "id": "#workflow_longread_quality.cwl/poly_x_min_len"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Qualified_quality_phred",
                    "doc": "the quality value that a base is qualified. Default 9 means phred quality >=Q9 is qualified.",
                    "default": 9,
                    "id": "#workflow_longread_quality.cwl/qualified_quality_phred"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#workflow_longread_quality.cwl/readtype/nanopore",
                                "#workflow_longread_quality.cwl/readtype/pacbio"
                            ]
                        }
                    ],
                    "doc": "Type of read PacBio or Nanopore.",
                    "label": "Read type",
                    "id": "#workflow_longread_quality.cwl/readtype"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (Default none)",
                    "label": "Filter reference file(s)",
                    "loadListing": "no_listing",
                    "id": "#workflow_longread_quality.cwl/reference_filter_db"
                },
                {
                    "type": "boolean",
                    "doc": "Skip quality plot of filter input data (Default false)",
                    "label": "Skip NanoPlot after",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/skip_qc_filtered"
                },
                {
                    "type": "boolean",
                    "doc": "Skip quality plot of unfiltered input data (Default false)",
                    "label": "Skip NanoPlot before",
                    "default": false,
                    "id": "#workflow_longread_quality.cwl/skip_qc_unfiltered"
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
                    "id": "#workflow_longread_quality.cwl/source"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "start_adapter",
                    "doc": "The adapter sequence at read start (5'). (Default auto-detect)",
                    "id": "#workflow_longread_quality.cwl/start_adapter"
                },
                {
                    "type": "int",
                    "doc": "Number of threads to use for computational processes",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#workflow_longread_quality.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Trim_front",
                    "doc": "Trimming how many bases in front for read. (Default 0)",
                    "id": "#workflow_longread_quality.cwl/trim_front"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Trim_poly_x",
                    "doc": "Enable polyX trimming in 3' ends. (Default false)",
                    "id": "#workflow_longread_quality.cwl/trim_poly_x"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "trim_tail",
                    "doc": "Trimming how many bases in tail for read, Default 0)",
                    "id": "#workflow_longread_quality.cwl/trim_tail"
                }
            ],
            "steps": [
                {
                    "label": "Human filter",
                    "doc": "Filter human reads from the dataset using Hostile",
                    "when": "$(inputs.index !== null)",
                    "run": "#hostile_clean_longreads.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/humandb",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/index"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_\"+inputs.readtype+\"_human_filter\")",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                                "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/human_filter_longreads/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                        "#workflow_longread_quality.cwl/human_filter_longreads/summary"
                    ],
                    "id": "#workflow_longread_quality.cwl/human_filter_longreads"
                },
                {
                    "label": "Fastplong",
                    "doc": "Filter longreads on quality and length",
                    "run": "#fastplong.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/adapter_fasta",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/adapter_fasta"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_front",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_front"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_mean_quality",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_mean_quality"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_tail",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_tail"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/cut_window_size",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/cut_window_size"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/disable_adapter_trimming",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/disable_adapter_trimming"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/disable_quality_filtering",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/disable_quality_filtering"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/end_adapter",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/end_adapter"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/identifier"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/input_file"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/length_limit",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/length_limit"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/minimum_length",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/length_required"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/mean_qual",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/mean_qual"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_filtered",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/output_filename_prefix"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/poly_x_min_len",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/poly_x_min_len"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/qualified_quality_phred",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/qualified_quality_phred"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/readtype"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_fastplong_report",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/report_title"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/start_adapter",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/start_adapter"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/threads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/trim_front",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/trim_front"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/trim_poly_x",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/trim_poly_x"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/trim_tail",
                            "id": "#workflow_longread_quality.cwl/longread_quality_filter/trim_tail"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                        "#workflow_longread_quality.cwl/longread_quality_filter/html_report",
                        "#workflow_longread_quality.cwl/longread_quality_filter/json_report"
                    ],
                    "id": "#workflow_longread_quality.cwl/longread_quality_filter"
                },
                {
                    "label": "Nanoplot filtered folder",
                    "doc": "Nanoplot plots and files to single folder",
                    "when": "$(inputs.skip !== null)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "valueFrom": "$(self+\"_nanoplot_filtered\")",
                            "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/log",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/LengthvsQualityScatterPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Yield_By_Length",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/report",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/logfile",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/nanostats",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/pickle",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/raw_data",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_Gigabases",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_NumberOfReads",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/NumberOfReads_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/ActivePores_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeLengthViolinPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeQualityViolinPlot"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/log",
                            "valueFrom": "valueFrom: ${ return inputs.self ? [inputs.self] : null }\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/skip"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/results"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder"
                },
                {
                    "label": "NanoPlot before",
                    "doc": "NanoPlot Quality assessment and report of reads after filtering",
                    "run": "#nanoplot.cwl",
                    "when": "$(inputs.skip_qc_filtered == false && inputs.fastq_files !== null && inputs.fastq_files.length !== 0)",
                    "in": [
                        {
                            "valueFrom": "${\n  const sources = [\n    inputs.reffilt_reads,\n    inputs.humanfilt_reads,\n    inputs.filt_reads\n  ];\n  const first = sources.find(x => x !== null);\n  if (!first || first.size < 100) {\n    return null;\n  }\n  return [first];\n}\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/fastq_files"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_filtered_",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/file_prefix"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/filt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/humanfilt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/identifier"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_filtered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/plot_title"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/reference_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/reffilt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/skip_qc_filtered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/skip_qc_filtered"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/store_pickle"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/store_raw"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/log",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/WeightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Non_weightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/LengthvsQualityScatterPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/Yield_By_Length",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/report",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/logfile",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/nanostats",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/pickle",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/raw_data",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_Gigabases",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/CumulativeYieldPlot_NumberOfReads",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/NumberOfReads_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/ActivePores_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeLengthViolinPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_filtered/TimeQualityViolinPlot"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_longreads_filtered"
                },
                {
                    "label": "NanoPlot unfiltered",
                    "doc": "NanoPlot Quality assessment and report of reads before filtering",
                    "run": "#nanoplot.cwl",
                    "when": "$(inputs.skip_qc_unfiltered == false)",
                    "in": [
                        {
                            "valueFrom": "${ return !inputs.fastq_rich ? [inputs.longreads] : null; }\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/fastq_files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/fastq_rich",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/fastq_rich"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_unfiltered_",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/file_prefix"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/identifier"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/longreads"
                        },
                        {
                            "valueFrom": "$(inputs.identifier)_$(inputs.readtype)_unfiltered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/plot_title"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/readtype"
                        },
                        {
                            "valueFrom": "${ return inputs.fastq_rich ? [inputs.longreads] : null }\n",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/rich_fastq_files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/skip_qc_unfiltered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/skip_qc_unfiltered"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/store_pickle"
                        },
                        {
                            "default": true,
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/store_raw"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/log",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedHistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedLogTransformed_HistogramReadlength",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/LengthvsQualityScatterPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Yield_By_Length",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/report",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/logfile",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/nanostats",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/pickle",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/raw_data",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_Gigabases",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_NumberOfReads",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/NumberOfReads_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/ActivePores_Over_Time",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeLengthViolinPlot",
                        "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeQualityViolinPlot"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered"
                },
                {
                    "label": "Nanoplot unfiltered folder",
                    "doc": "Nanoplot plots and files to single folder",
                    "when": "$(inputs.skip_qc_unfiltered == false)",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "valueFrom": "$(self+\"_nanoplot_unfiltered\")",
                            "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/log",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/WeightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedHistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Non_weightedLogTransformed_HistogramReadlength",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/LengthvsQualityScatterPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/Yield_By_Length",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/report",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/logfile",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/nanostats",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/pickle",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/raw_data",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_Gigabases",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/CumulativeYieldPlot_NumberOfReads",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/NumberOfReads_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/ActivePores_Over_Time",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeLengthViolinPlot",
                                "#workflow_longread_quality.cwl/nanoplot_longreads_unfiltered/TimeQualityViolinPlot"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/files"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/skip_qc_unfiltered",
                            "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/skip_qc_unfiltered"
                        }
                    ],
                    "run": "#files_to_folder.cwl",
                    "out": [
                        "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/results"
                    ],
                    "id": "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder"
                },
                {
                    "label": "Output reads",
                    "doc": "Step needed to output filtered reads because there is an option to not to.",
                    "when": "$(!inputs.do_not_output_filtered_reads && inputs.reads_in !== null)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#workflow_longread_quality.cwl/output_filtered_reads/run/reads_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#workflow_longread_quality.cwl/output_filtered_reads/run/reads_out"
                            }
                        ],
                        "expression": "${ return {'reads_out': inputs.reads_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/do_not_output_filtered_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/do_not_output_filtered_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/filt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/humanfilt_reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/identifier"
                        },
                        {
                            "valueFrom": "${\n  const sources = [\n    inputs.reffilt_reads,\n    inputs.humanfilt_reads,\n    inputs.filt_reads\n  ];\n  const firstAvailable = sources.find(x => x !== null);\n  // If the first available read is not null, change output filename.\n  if (firstAvailable) {\n    firstAvailable.basename = inputs.identifier+\"_\"+inputs.readtype+\"_filtered.fastq.gz\";\n  }\n  return firstAvailable || null;\n}\n",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/reads_in"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/reference_filter_longreads/out_reads",
                            "id": "#workflow_longread_quality.cwl/output_filtered_reads/reffilt_reads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/output_filtered_reads/reads_out"
                    ],
                    "id": "#workflow_longread_quality.cwl/output_filtered_reads"
                },
                {
                    "label": "Custom reference filter",
                    "doc": "Filter reads using custom references with Hostile",
                    "when": "$(inputs.index !== null)",
                    "run": "#hostile_clean_longreads.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/reference_filter_db",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/index"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/keep_reference_mapped_reads",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/invert"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "valueFrom": "$(self+\"_\"+inputs.readtype+\"_ref-filter\")",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/output_filename_prefix"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/human_filter_longreads/out_reads",
                                "#workflow_longread_quality.cwl/longread_quality_filter/out_reads",
                                "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/reads"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/readtype"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/threads",
                            "id": "#workflow_longread_quality.cwl/reference_filter_longreads/threads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/reference_filter_longreads/out_reads",
                        "#workflow_longread_quality.cwl/reference_filter_longreads/summary"
                    ],
                    "id": "#workflow_longread_quality.cwl/reference_filter_longreads"
                },
                {
                    "label": "Reports to folder",
                    "doc": "Preparation of QC output files to a specific output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "valueFrom": "$(self+\"_quality_filter_reports\")",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/longread_quality_filter/html_report",
                                "#workflow_longread_quality.cwl/longread_quality_filter/json_report",
                                "#workflow_longread_quality.cwl/human_filter_longreads/summary",
                                "#workflow_longread_quality.cwl/reference_filter_longreads/summary"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#workflow_longread_quality.cwl/nanoplot_unfiltered_files_to_folder/results",
                                "#workflow_longread_quality.cwl/nanoplot_filtered_files_to_folder/results"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/folders"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/readtype",
                            "id": "#workflow_longread_quality.cwl/reports_files_to_folder/readtype"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/reports_files_to_folder/results"
                    ],
                    "id": "#workflow_longread_quality.cwl/reports_files_to_folder"
                },
                {
                    "label": "Merge paired reads",
                    "doc": "Creates a single file object. Also merges reads if multiple files are given.",
                    "run": "#workflow_merge_se_reads.cwl",
                    "in": [
                        {
                            "source": "#workflow_longread_quality.cwl/identifier",
                            "valueFrom": "$(self)_merged",
                            "id": "#workflow_longread_quality.cwl/workflow_merge_reads/filename"
                        },
                        {
                            "source": "#workflow_longread_quality.cwl/longreads",
                            "id": "#workflow_longread_quality.cwl/workflow_merge_reads/reads"
                        }
                    ],
                    "out": [
                        "#workflow_longread_quality.cwl/workflow_merge_reads/merged_reads"
                    ],
                    "id": "#workflow_longread_quality.cwl/workflow_merge_reads"
                }
            ],
            "id": "#workflow_longread_quality.cwl",
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
            "https://schema.org/dateModified": "2025-08-22",
            "https://schema.org/dateCreated": "2025-04-30",
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
            "label": "Merge multiple SE reads",
            "doc": "Merge (cat) fastq Single End reads (e.g. long reads) when multiple files.\nAlso converts single file array to a non array object.\n\nOutput is as single (non array) file object. \nThis (non array files) is usually required for tool inputs \n",
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Filename prefix to be used when reads are going to merged. File extensions are preserved.\nThis is only used when multiple reads are given. default \"merged\"\n",
                    "label": "Filename prefix",
                    "default": "merged",
                    "id": "#workflow_merge_se_reads.cwl/filename"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "doc": "Single end reads reads. E.g Nanopore or PacBio. Can be compressed. Do not mix filetypes.",
                    "label": "Singe end reads",
                    "loadListing": "no_listing",
                    "id": "#workflow_merge_se_reads.cwl/reads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": [
                        "#workflow_merge_se_reads.cwl/fastq_merge_se/output",
                        "#workflow_merge_se_reads.cwl/fastq_se_array_to_file/file"
                    ],
                    "pickValue": "first_non_null",
                    "id": "#workflow_merge_se_reads.cwl/merged_reads"
                }
            ],
            "steps": [
                {
                    "label": "Merge SE reads",
                    "doc": "Merge multiple forward single end reads to a single file",
                    "when": "$(inputs.infiles.length > 1)",
                    "run": "#concatenate.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_se_reads.cwl/reads",
                            "id": "#workflow_merge_se_reads.cwl/fastq_merge_se/infiles"
                        },
                        {
                            "source": "#workflow_merge_se_reads.cwl/filename",
                            "valueFrom": "${\n  return self+inputs.infiles[0].basename.match(/\\.(fastq|fq)(\\.gz)?$/)[0];\n}\n",
                            "id": "#workflow_merge_se_reads.cwl/fastq_merge_se/outname"
                        }
                    ],
                    "out": [
                        "#workflow_merge_se_reads.cwl/fastq_merge_se/output"
                    ],
                    "id": "#workflow_merge_se_reads.cwl/fastq_merge_se"
                },
                {
                    "label": "SE reads array to file",
                    "doc": "Forward file of single file array to file object",
                    "when": "$(inputs.files.length === 1)",
                    "run": "#array_to_file_tool.cwl",
                    "in": [
                        {
                            "source": "#workflow_merge_se_reads.cwl/reads",
                            "id": "#workflow_merge_se_reads.cwl/fastq_se_array_to_file/files"
                        }
                    ],
                    "out": [
                        "#workflow_merge_se_reads.cwl/fastq_se_array_to_file/file"
                    ],
                    "id": "#workflow_merge_se_reads.cwl/fastq_se_array_to_file"
                }
            ],
            "id": "#workflow_merge_se_reads.cwl",
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
            "https://schema.org/dateCreated": "2025-04-30",
            "https://schema.org/dateModified": "2025-04-30",
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
            "label": "(Hybrid) Metagenomics workflow",
            "doc": "**Workflow (hybrid) metagenomic assembly and binning  **<br>\n  - Workflow Illumina Quality: \n    - FastQC (control)\n    - fastp (quality trimming)\n  - Workflow Longread Quality:\t\n    - NanoPlot (control)\n    - filtlong (quality trimming)\n    - minimap2 contamination filter\n  - Kraken2 taxonomic classification of FASTQ reads\n  - SPAdes/Flye (Assembly)\n  - Medaka/PyPolCA (Assembly polishing)\n  - QUAST (Assembly quality report)\n\n  (optional)\n  - Workflow binnning\n    - Metabat2/MaxBin2/SemiBin\n    - Binette\n    - BUSCO\n    - GTDB-Tk\n\n  (optional)\n  - Workflow Genome-scale metabolic models https://workflowhub.eu/workflows/372\n    - CarveMe (GEM generation)\n    - MEMOTE (GEM test suite)\n    - SMETANA (Species METabolic interaction ANAlysis)\n\nOther UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>\n\n**All tool CWL files and other workflows can be found here:**<br>\n  https://gitlab.com/m-unlock/cwl/ <br>\n\n**How to setup and use an UNLOCK workflow:**<br>\nhttps://docs.m-unlock.nl/docs/workflows/setup.html<br>\n",
            "outputs": [
                {
                    "label": "Assembly output",
                    "doc": "Output from different assembly steps",
                    "type": "Directory",
                    "outputSource": "#main/assembly_files_to_folder/results",
                    "id": "#main/assembly_output"
                },
                {
                    "label": "Binning output",
                    "doc": "Binning outputfolders",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/binning_files_to_folder/results",
                    "id": "#main/binning_output"
                },
                {
                    "label": "Read filtering output",
                    "doc": "Read filtering stats",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/readfilter_files_to_folder/results",
                    "id": "#main/read_filtering_output"
                },
                {
                    "label": "Read filtering output",
                    "doc": "Read filtering stats + filtered reads",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/keep_readfilter_files_to_folder/results",
                    "id": "#main/read_filtering_output_keep"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Annotate bins",
                    "doc": "Annotate bins. (default false)",
                    "default": false,
                    "id": "#main/annotate_bins"
                },
                {
                    "type": "boolean",
                    "label": "Annotate unbinned",
                    "doc": "Annotate unbinned contigs. Will be treated as metagenome. (default false)",
                    "default": false,
                    "id": "#main/annotate_unbinned"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#main/assembly_choice/spades",
                                "#main/assembly_choice/flye",
                                "#main/assembly_choice/pypolca",
                                "#main/assembly_choice/medaka"
                            ]
                        }
                    ],
                    "label": "Assembly choice",
                    "doc": "User's choice of assembly for post-assembly (binning) processes ('spades', 'flye', 'pypolca', 'medaka'). Optional. Only one choice allowed.\nWhen none is given, the first available assembly in this order is chosen: pypolca, medaka, flye, spades.\n",
                    "id": "#main/assembly_choice"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Bakta DB",
                    "doc": "Bakta Database directory. Default is built-in bakta-light db. (optional)",
                    "id": "#main/bakta_db"
                },
                {
                    "type": "boolean",
                    "label": "Run binning workflow",
                    "doc": "Run with contig binning workflow (default false)",
                    "default": false,
                    "id": "#main/binning"
                },
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
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "BUSCO dataset",
                    "doc": "Path to the BUSCO dataset downloaded location. (optional)",
                    "loadListing": "no_listing",
                    "id": "#main/busco_data"
                },
                {
                    "type": "boolean",
                    "doc": "Remove exact duplicate reads Illumina reads with fastp (default false)",
                    "label": "Deduplicate illumina reads",
                    "default": false,
                    "id": "#main/deduplicate_illumina_reads"
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
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#main/eggnog_dbs/eggnog_dbs",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        "Directory"
                                    ],
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/data_dir"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/db"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#main/eggnog_dbs"
                },
                {
                    "type": "boolean",
                    "doc": "Input fastq is generated by albacore, MinKNOW or guppy  with additional information concerning channel and time. \nUsed to creating more informative quality plots (default false)\n",
                    "label": "Fastq rich (ONT)",
                    "default": false,
                    "id": "#main/fastq_rich"
                },
                {
                    "type": "boolean",
                    "label": "Deterministic Flye",
                    "doc": "Perform disjointig assembly single-threaded in Flye assembler (slower). (default false)",
                    "default": false,
                    "id": "#main/flye_deterministic"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Genome Size",
                    "doc": "Estimated genome size (for example, 5m or 2.6g). Used in Flye. (optional)",
                    "id": "#main/genome_size"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing the GTDBTK repository",
                    "label": "gtdbtk data directory",
                    "loadListing": "no_listing",
                    "id": "#main/gtdbtk_data"
                },
                {
                    "type": "string",
                    "label": "Identifier",
                    "doc": "Identifier for this dataset used in this workflow (required)",
                    "id": "#main/identifier"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "Illumina Forward sequence file(s)",
                    "label": "Forward reads",
                    "loadListing": "no_listing",
                    "id": "#main/illumina_forward_reads"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Bowtie2 index folder. Provide the folder in which the in index files are located. (optional)",
                    "label": "Filter human reads",
                    "loadListing": "no_listing",
                    "id": "#main/illumina_humandb"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Read length",
                    "doc": "Read length to use in bracken only atm. Usually 50,75,100,150,200,250 or 300. (default 150)",
                    "default": 150,
                    "id": "#main/illumina_read_length"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Custom reference database for filtering with Hostile. \nProvide the folder in which the bowtie2 index files are located. (optional)\n",
                    "label": "Illumina reference filter db",
                    "loadListing": "no_listing",
                    "id": "#main/illumina_reference_filter_db"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "label": "Reverse reads",
                    "doc": "Illumina Reverse sequence file(s)",
                    "loadListing": "no_listing",
                    "id": "#main/illumina_reverse_reads"
                },
                {
                    "type": "string",
                    "label": "InterProScan applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\n\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "default": "Pfam,SFLD,SMART,AntiFam,NCBIfam",
                    "id": "#main/interproscan_applications"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "InterProScan 5 directory",
                    "doc": "Directory of the (full) InterProScan 5 program. Used for annotating bins. (optional)",
                    "id": "#main/interproscan_directory"
                },
                {
                    "type": "boolean",
                    "doc": "Keep filtered reads in the final output (default false)",
                    "label": "Keep filtered reads",
                    "default": false,
                    "id": "#main/keep_filtered_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan limit",
                    "doc": "Limit max number of entries of kofamscan hits per locus in SAPP. (default 5)",
                    "default": 5,
                    "id": "#main/kofamscan_limit_sapp"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "label": "Kraken2 confidence threshold",
                    "doc": "Confidence score threshold must be in [0, 1] (default 0.0)",
                    "id": "#main/kraken2_confidence"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "doc": "Database location of kraken2. (optional)",
                    "label": "Kraken2 database",
                    "default": [],
                    "loadListing": "no_listing",
                    "id": "#main/kraken2_database"
                },
                {
                    "type": "boolean",
                    "label": "Kraken2 standard report",
                    "doc": "Also output Kraken2 standard report with per read classification. These can be large. (default false)",
                    "default": false,
                    "id": "#main/kraken2_standard_report"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "Adapter fasta",
                    "doc": "Specify a FASTA file to trim both read ends by all the sequences in this FASTA file. (default None)",
                    "id": "#main/longread_adapter_fasta"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Disable adapter trimming",
                    "doc": "Adapter trimming is enabled by default. If this option is specified, adapter trimming is disabled. (default false)",
                    "id": "#main/longread_disable_adapter_trimming"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "End adapter",
                    "doc": "The adapter sequence at read end (3'). (default auto-detect)",
                    "id": "#main/longread_end_adapter"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (optional)",
                    "label": "Filter human illumina reads",
                    "loadListing": "no_listing",
                    "id": "#main/longread_humandb"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Maximum length limit",
                    "doc": "Reads longer than length_limit will be discarded. (default no limit)",
                    "id": "#main/longread_length_limit"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Mean quality",
                    "doc": "If one read's mean_qual quality score < mean_qual, then this read is discarded. (default 10)",
                    "default": 10,
                    "id": "#main/longread_mean_qual"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Minimum length required",
                    "doc": "Reads shorter will be discarded. (default 100)",
                    "id": "#main/longread_minimum_length"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Poly_x_min_len",
                    "doc": "The minimum length to detect polyX in the read tail. (default 10 when trim_poly_x is true)",
                    "id": "#main/longread_poly_x_min_len"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Qualified_quality_phred",
                    "doc": "The quality value that a base is qualified. (default 9 means phred quality >=Q9 is qualified)",
                    "default": 9,
                    "id": "#main/longread_qualified_quality_phred"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "A fasta file or minimap2 indexed filed (.mmi) index needs to be provided. Preindexed is much faster. (optional)",
                    "label": "Longread reference filter db",
                    "loadListing": "no_listing",
                    "id": "#main/longread_reference_filter_db"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "start_adapter",
                    "doc": "The adapter sequence at read start (5'). (default auto-detect)",
                    "id": "#main/longread_start_adapter"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Trim_front",
                    "doc": "Trimming how many bases in front for read. (default 0)",
                    "id": "#main/longread_trim_front"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "label": "Trim_poly_x",
                    "doc": "Enable polyX trimming in 3' ends. (default false)",
                    "id": "#main/longread_trim_poly_x"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "trim_tail",
                    "doc": "Trimming how many bases in tail for read. (default 0)",
                    "id": "#main/longread_trim_tail"
                },
                {
                    "type": "int",
                    "doc": "Maximum memory usage in megabytes. This mostly important for SPAdes assembly. (default 8GB)",
                    "label": "Memory usage (MB)",
                    "default": 8000,
                    "id": "#main/memory"
                },
                {
                    "type": "boolean",
                    "default": true,
                    "doc": "Metagenome option for assemblers (default true)",
                    "label": "When working with metagenomes",
                    "id": "#main/metagenome"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "label": "Oxford Nanopore reads",
                    "doc": "File(s) with Oxford Nanopore reads in FASTQ format",
                    "loadListing": "no_listing",
                    "id": "#main/nanopore_reads"
                },
                {
                    "type": "boolean",
                    "label": "Only spades assembler",
                    "doc": "Run spades in only assembler mode (without read error correction). (default false)",
                    "default": true,
                    "id": "#main/only_assembler_mode_spades"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "ONT Basecalling model used for MEDAKA",
                    "doc": "Used in MEDAKA\nBasecalling model used with guppy default r941_min_high.\nAvailable: r103_fast_g507, r103_fast_snp_g507, r103_fast_variant_g507, r103_hac_g507, r103_hac_snp_g507, r103_hac_variant_g507, r103_min_high_g345, r103_min_high_g360, r103_prom_high_g360, r103_prom_snp_g3210, r103_prom_variant_g3210, r103_sup_g507, r103_sup_snp_g507, r103_sup_variant_g507, r1041_e82_400bps_fast_g615, r1041_e82_400bps_fast_variant_g615, r1041_e82_400bps_hac_g615, r1041_e82_400bps_hac_variant_g615, r1041_e82_400bps_sup_g615, r1041_e82_400bps_sup_variant_g615, r104_e81_fast_g5015, r104_e81_fast_variant_g5015, r104_e81_hac_g5015, r104_e81_hac_variant_g5015, r104_e81_sup_g5015, r104_e81_sup_g610, r104_e81_sup_variant_g610, r10_min_high_g303, r10_min_high_g340, r941_e81_fast_g514, r941_e81_fast_variant_g514, r941_e81_hac_g514, r941_e81_hac_variant_g514, r941_e81_sup_g514, r941_e81_sup_variant_g514, r941_min_fast_g303, r941_min_fast_g507, r941_min_fast_snp_g507, r941_min_fast_variant_g507, r941_min_hac_g507, r941_min_hac_snp_g507, r941_min_hac_variant_g507, r941_min_high_g303, r941_min_high_g330, r941_min_high_g340_rle, r941_min_high_g344, r941_min_high_g351, r941_min_high_g360, r941_min_sup_g507, r941_min_sup_snp_g507, r941_min_sup_variant_g507, r941_prom_fast_g303, r941_prom_fast_g507, r941_prom_fast_snp_g507, r941_prom_fast_variant_g507, r941_prom_hac_g507, r941_prom_hac_snp_g507, r941_prom_hac_variant_g507, r941_prom_high_g303, r941_prom_high_g330, r941_prom_high_g344, r941_prom_high_g360, r941_prom_high_g4011, r941_prom_snp_g303, r941_prom_snp_g322, r941_prom_snp_g360, r941_prom_sup_g507, r941_prom_sup_snp_g507, r941_prom_sup_variant_g507, r941_prom_variant_g303, r941_prom_variant_g322, r941_prom_variant_g360, r941_sup_plant_g610, r941_sup_plant_variant_g610\n(required for Medaka)\n",
                    "id": "#main/ont_basecall_model"
                },
                {
                    "type": "boolean",
                    "label": "Output BAM file",
                    "doc": "Output BAM file of mapped reads to assembly of choice. (default false)",
                    "default": false,
                    "id": "#main/output_bam_file"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "label": "PacBio reads",
                    "doc": "File(s) with PacBio reads in FASTQ format",
                    "loadListing": "no_listing",
                    "id": "#main/pacbio_reads"
                },
                {
                    "type": "boolean",
                    "label": "Run eggNOG-mapper",
                    "doc": "Run with eggNOG-mapper annotation. Requires eggnog database files. (default false)",
                    "default": false,
                    "id": "#main/run_eggnog"
                },
                {
                    "type": "boolean",
                    "label": "Use Flye",
                    "doc": "Run with Flye assembler. Requires long reads (default false)",
                    "default": false,
                    "id": "#main/run_flye"
                },
                {
                    "type": "boolean",
                    "label": "Run InterProScan",
                    "doc": "Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. (default false)",
                    "default": false,
                    "id": "#main/run_interproscan"
                },
                {
                    "type": "boolean",
                    "label": "Run kofamscan",
                    "doc": "Run with KEGG KO KoFamKOALA annotation. (default false)",
                    "default": false,
                    "id": "#main/run_kofamscan"
                },
                {
                    "type": "boolean",
                    "doc": "Run kraken2 on Illumina reads. A kraken2 database needs to be provided using the input kraken2_database. (default false)",
                    "label": "Run kraken2 on Illumina reads",
                    "default": false,
                    "id": "#main/run_kraken2_illumina"
                },
                {
                    "type": "boolean",
                    "doc": "Run with MaxBin2 binner. (default true)",
                    "label": "Run Maxbin2",
                    "default": true,
                    "id": "#main/run_maxbin2"
                },
                {
                    "type": "boolean",
                    "label": "Use Medaka",
                    "doc": "Run with Mekada assembly polishing using nanopore (not pacbio) reads only. (default false)",
                    "default": false,
                    "id": "#main/run_medaka"
                },
                {
                    "type": "boolean",
                    "label": "Use PyPolCA",
                    "doc": "Run with PyPolCA assembly polishing using Illumina reads only. (default false)",
                    "default": false,
                    "id": "#main/run_pypolca"
                },
                {
                    "type": "boolean",
                    "doc": "Run with SemiBin2 binner. (default true)",
                    "label": "Run SemiBin",
                    "default": true,
                    "id": "#main/run_semibin2"
                },
                {
                    "type": "boolean",
                    "label": "Use SPAdes",
                    "doc": "Run with SPAdes assembler (default true)",
                    "default": true,
                    "id": "#main/run_spades"
                },
                {
                    "doc": "Semibin2 Built-in models (none/global/human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/chicken_caecum). \nChoosing a built-in model is generally faster. Otherwise it will do (single-sample) training on the data.\nDefault global. Choose none if you want to do training on your own data.\n",
                    "label": "SemiBin Environment",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#main/semibin2_environment/none",
                                "#main/semibin2_environment/global",
                                "#main/semibin2_environment/human_gut",
                                "#main/semibin2_environment/dog_gut",
                                "#main/semibin2_environment/ocean",
                                "#main/semibin2_environment/soil",
                                "#main/semibin2_environment/cat_gut",
                                "#main/semibin2_environment/human_oral",
                                "#main/semibin2_environment/mouse_gut",
                                "#main/semibin2_environment/pig_gut",
                                "#main/semibin2_environment/built_environment",
                                "#main/semibin2_environment/wastewater",
                                "#main/semibin2_environment/chicken_caecum"
                            ]
                        }
                    ],
                    "default": "global",
                    "id": "#main/semibin2_environment"
                },
                {
                    "type": "boolean",
                    "label": "Skip bakta CRISPR",
                    "doc": "Skip bakta CRISPR array prediction using PILER-CR. (default false)",
                    "default": false,
                    "id": "#main/skip_bakta_crispr"
                },
                {
                    "type": "boolean",
                    "label": "Run Bracken",
                    "doc": "Skip Bracken analysis. Illumina only. A bracken compatible kraken2 database needs to be provided using the input kraken2_database. (default false)",
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
                    "type": "int",
                    "doc": "Number of threads to use for each computational processe (default 2)",
                    "label": "Number of threads",
                    "default": 2,
                    "id": "#main/threads"
                },
                {
                    "type": "boolean",
                    "doc": "Discard unmapped and keep reads mapped to the given reference. (default false (discard mapped))",
                    "label": "Keep mapped reads",
                    "default": false,
                    "id": "#main/use_reference_mapped_reads"
                },
                {
                    "type": "boolean",
                    "label": "Use SPAdes scaffolds",
                    "doc": "Use SPAdes scaffolds instead of contigs for post-processing (polishing/mapping/binning). (default false)",
                    "default": false,
                    "id": "#main/use_spades_scaffolds"
                }
            ],
            "steps": [
                {
                    "doc": "Preparation of Flye output files to a specific output folder",
                    "label": "Flye output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"assembly\")",
                            "id": "#main/assembly_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/output_bamfile/bam_out",
                                "#main/contig_read_counts/contigReadCounts"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/assembly_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/spades_files_to_folder/results",
                                "#main/flye_files_to_folder/results",
                                "#main/medaka_files_to_folder/results",
                                "#main/pypolca_files_to_folder/results"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/assembly_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#main/assembly_files_to_folder/results"
                    ],
                    "id": "#main/assembly_files_to_folder"
                },
                {
                    "label": "Minimap2",
                    "doc": "Illumina read mapping using Minimap2 on assembled scaffolds",
                    "when": "${\n   return (inputs.output_bam_file && inputs.forward_reads !== null && inputs.forward_reads.length !== 0) ||\n   (inputs.binning && inputs.forward_reads !== null && inputs.forward_reads.length !== 0);\n}\n",
                    "run": "#minimap2_to_sorted-bam_PE.cwl",
                    "in": [
                        {
                            "source": "#main/get_assembly_to_use/assembly_choice",
                            "id": "#main/assembly_read_mapping_illumina/assembly_choice"
                        },
                        {
                            "source": "#main/binning",
                            "id": "#main/assembly_read_mapping_illumina/binning"
                        },
                        {
                            "source": "#main/workflow_quality_illumina/QC_forward_reads",
                            "id": "#main/assembly_read_mapping_illumina/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self+\"_\"+inputs.assembly_choice)",
                            "id": "#main/assembly_read_mapping_illumina/identifier"
                        },
                        {
                            "source": "#main/output_bam_file",
                            "id": "#main/assembly_read_mapping_illumina/output_bam_file"
                        },
                        {
                            "default": "sr",
                            "id": "#main/assembly_read_mapping_illumina/preset"
                        },
                        {
                            "source": "#main/get_assembly_to_use/assembly",
                            "id": "#main/assembly_read_mapping_illumina/reference"
                        },
                        {
                            "source": "#main/workflow_quality_illumina/QC_reverse_reads",
                            "id": "#main/assembly_read_mapping_illumina/reverse_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/assembly_read_mapping_illumina/threads"
                        }
                    ],
                    "out": [
                        "#main/assembly_read_mapping_illumina/sorted_bam"
                    ],
                    "id": "#main/assembly_read_mapping_illumina"
                },
                {
                    "doc": "Preparation of binning output files and folders to a specific output folder",
                    "label": "Binning output to folder",
                    "when": "$(inputs.binning)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#main/binning",
                            "id": "#main/binning_files_to_folder/binning"
                        },
                        {
                            "valueFrom": "$(\"binning\")",
                            "id": "#main/binning_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/workflow_binning/bins_read_stats",
                                "#main/workflow_binning/bins_summary_table",
                                "#main/workflow_binning/eukrep_fasta",
                                "#main/workflow_binning/eukrep_stats_file"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/binning_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/workflow_binning/binette_output",
                                "#main/workflow_binning/metabat2_output",
                                "#main/workflow_binning/maxbin2_output",
                                "#main/workflow_binning/semibin_output",
                                "#main/workflow_binning/gtdbtk_output",
                                "#main/workflow_binning/busco_output",
                                "#main/workflow_binning/annotation_output"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/binning_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#main/binning_files_to_folder/results"
                    ],
                    "id": "#main/binning_files_to_folder"
                },
                {
                    "label": "SPAdes compressed",
                    "doc": "Compress the large Spades assembly output files",
                    "when": "$(inputs.run_spades && inputs.forward_reads !== null && inputs.forward_reads.length !== 0)",
                    "run": "#pigz.cwl",
                    "scatter": [
                        "#main/compress_spades/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/compress_spades/forward_reads"
                        },
                        {
                            "source": [
                                "#main/spades/contigs",
                                "#main/spades/scaffolds",
                                "#main/spades/assembly_graph",
                                "#main/spades/assembly_graph_with_scaffolds",
                                "#main/spades/contigs_before_rr",
                                "#main/spades/contigs_assembly_paths",
                                "#main/spades/scaffolds_assembly_paths"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/compress_spades/inputfile"
                        },
                        {
                            "source": "#main/run_spades",
                            "id": "#main/compress_spades/run_spades"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/compress_spades/threads"
                        }
                    ],
                    "out": [
                        "#main/compress_spades/outfile"
                    ],
                    "id": "#main/compress_spades"
                },
                {
                    "label": "Samtools idxstats",
                    "doc": "Reports alignment summary statistics",
                    "when": "${\n   return (inputs.output_bam_file && inputs.forward_reads !== null && inputs.forward_reads.length !== 0) ||\n   (inputs.binning && inputs.forward_reads !== null && inputs.forward_reads.length !== 0);\n}\n",
                    "run": "#samtools_idxstats.cwl",
                    "in": [
                        {
                            "source": "#main/get_assembly_to_use/assembly_choice",
                            "id": "#main/contig_read_counts/assembly_choice"
                        },
                        {
                            "source": "#main/assembly_read_mapping_illumina/sorted_bam",
                            "id": "#main/contig_read_counts/bam_file"
                        },
                        {
                            "source": "#main/binning",
                            "id": "#main/contig_read_counts/binning"
                        },
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/contig_read_counts/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "valueFrom": "$(self+\"_\"+inputs.assembly_choice)",
                            "id": "#main/contig_read_counts/identifier"
                        },
                        {
                            "source": "#main/output_bam_file",
                            "id": "#main/contig_read_counts/output_bam_file"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/contig_read_counts/threads"
                        }
                    ],
                    "out": [
                        "#main/contig_read_counts/contigReadCounts"
                    ],
                    "id": "#main/contig_read_counts"
                },
                {
                    "label": "Flye assembly",
                    "doc": "De novo assembly of single-molecule reads with Flye",
                    "when": "$(inputs.run_flye && ((inputs.nanopore_reads !== null && inputs.nanopore_reads.length !== 0) || (inputs.pacbio_reads !== null && inputs.pacbio_reads.length !== 0)))",
                    "run": "#flye.cwl",
                    "in": [
                        {
                            "source": "#main/flye_deterministic",
                            "id": "#main/flye/deterministic"
                        },
                        {
                            "source": "#main/genome_size",
                            "id": "#main/flye/genome_size"
                        },
                        {
                            "source": "#main/metagenome",
                            "id": "#main/flye/metagenome"
                        },
                        {
                            "source": "#main/workflow_quality_nanopore/filtered_reads",
                            "id": "#main/flye/nano_raw"
                        },
                        {
                            "source": "#main/nanopore_reads",
                            "id": "#main/flye/nanopore_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/flye/output_filename_prefix"
                        },
                        {
                            "source": "#main/workflow_quality_pacbio/filtered_reads",
                            "id": "#main/flye/pacbio_raw"
                        },
                        {
                            "source": "#main/pacbio_reads",
                            "id": "#main/flye/pacbio_reads"
                        },
                        {
                            "source": "#main/run_flye",
                            "id": "#main/flye/run_flye"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/flye/threads"
                        }
                    ],
                    "out": [
                        "#main/flye/00_assembly",
                        "#main/flye/10_consensus",
                        "#main/flye/20_repeat",
                        "#main/flye/30_contigger",
                        "#main/flye/40_polishing",
                        "#main/flye/assembly",
                        "#main/flye/assembly_info",
                        "#main/flye/flye_log",
                        "#main/flye/params",
                        "#main/flye/assembly_graph"
                    ],
                    "id": "#main/flye"
                },
                {
                    "doc": "Preparation of Flye output files to a specific output folder",
                    "label": "Flye output folder",
                    "when": "$(inputs.run_flye)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"flye_assembly\")",
                            "id": "#main/flye_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/flye/assembly",
                                "#main/flye/assembly_info",
                                "#main/flye/flye_log",
                                "#main/flye/params",
                                "#main/flye/assembly_graph"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/flye_files_to_folder/files"
                        },
                        {
                            "source": "#main/run_flye",
                            "id": "#main/flye_files_to_folder/run_flye"
                        }
                    ],
                    "out": [
                        "#main/flye_files_to_folder/results"
                    ],
                    "id": "#main/flye_files_to_folder"
                },
                {
                    "label": "Assembly choice",
                    "doc": "Get assembly choice",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": [
                                    "null",
                                    {
                                        "type": "enum",
                                        "symbols": [
                                            "#main/get_assembly_to_use/run/assembly_choice_string/spades",
                                            "#main/get_assembly_to_use/run/assembly_choice_string/medaka",
                                            "#main/get_assembly_to_use/run/assembly_choice_string/flye",
                                            "#main/get_assembly_to_use/run/assembly_choice_string/pypolca"
                                        ]
                                    }
                                ],
                                "id": "#main/get_assembly_to_use/run/assembly_choice_string"
                            },
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#main/get_assembly_to_use/run/flye_assembly"
                            },
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#main/get_assembly_to_use/run/medaka_polished_assembly"
                            },
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#main/get_assembly_to_use/run/spades_assembly"
                            },
                            {
                                "type": "boolean",
                                "id": "#main/get_assembly_to_use/run/use_spades_scaffolds"
                            },
                            {
                                "type": [
                                    "null",
                                    "File"
                                ],
                                "id": "#main/get_assembly_to_use/run/workflow_pypolca_polished_genome"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/get_assembly_to_use/run/assembly"
                            },
                            {
                                "type": "string",
                                "id": "#main/get_assembly_to_use/run/assembly_choice"
                            }
                        ],
                        "expression": "${\n  // Define the mapping of user choices to assembly step outputs\n  var assemblyOutputs = {\n    \"pypolca\": inputs.workflow_pypolca_polished_genome, \n    \"medaka\": inputs.medaka_polished_assembly,\n    \"flye\": inputs.flye_assembly,\n    \"spades\": inputs.spades_assembly\n  };\n  // If the user has made a specific assembly choice, return the corresponding output\n  // Otherwise, return the first non-null assembly output\n  var assembly_to_use = inputs.assembly_choice_string ? assemblyOutputs[inputs.assembly_choice_string] : Object.values(assemblyOutputs).find(function(file) { return file !== null; });\n  var assembly_choice = inputs.assembly_choice_string || Object.keys(assemblyOutputs).find(function(key) { return assemblyOutputs[key] !== null; });\n  \n  // If the user has chosen to use SPAdes, append \"_scaffolds\" or \"_contigs\" to the name\n  if (assembly_choice == \"spades\" && inputs.use_spades_scaffolds) {\n    assembly_choice = assembly_choice+\"_scaffolds\";\n  } else if (assembly_choice == \"spades\" && !inputs.use_spades_scaffolds) {\n    assembly_choice = assembly_choice+\"_contigs\";\n  }\n  return {\n    'assembly': assembly_to_use,\n    'assembly_choice': assembly_choice\n  };\n}\n"
                    },
                    "in": [
                        {
                            "source": "#main/assembly_choice",
                            "id": "#main/get_assembly_to_use/assembly_choice_string"
                        },
                        {
                            "source": "#main/flye/assembly",
                            "id": "#main/get_assembly_to_use/flye_assembly"
                        },
                        {
                            "source": "#main/medaka/polished_assembly",
                            "id": "#main/get_assembly_to_use/medaka_polished_assembly"
                        },
                        {
                            "valueFrom": "${return inputs.use_spades_scaffolds ? inputs.spades_scaffolds : inputs.spades_contigs;}\n",
                            "id": "#main/get_assembly_to_use/spades_assembly"
                        },
                        {
                            "source": "#main/spades/contigs",
                            "id": "#main/get_assembly_to_use/spades_contigs"
                        },
                        {
                            "source": "#main/spades/scaffolds",
                            "id": "#main/get_assembly_to_use/spades_scaffolds"
                        },
                        {
                            "source": "#main/use_spades_scaffolds",
                            "id": "#main/get_assembly_to_use/use_spades_scaffolds"
                        },
                        {
                            "source": "#main/workflow_pypolca/polished_genome",
                            "id": "#main/get_assembly_to_use/workflow_pypolca_polished_genome"
                        }
                    ],
                    "out": [
                        "#main/get_assembly_to_use/assembly",
                        "#main/get_assembly_to_use/assembly_choice"
                    ],
                    "id": "#main/get_assembly_to_use"
                },
                {
                    "doc": "Preparation of read filtering output files to a specific output folder",
                    "label": "Read filtering output folder",
                    "when": "$(inputs.keep_filtered_reads)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"read_filtering_and_classification\")",
                            "id": "#main/keep_readfilter_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/workflow_quality_illumina/QC_forward_reads",
                                "#main/workflow_quality_illumina/QC_reverse_reads",
                                "#main/workflow_quality_nanopore/filtered_reads",
                                "#main/workflow_quality_pacbio/filtered_reads"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/keep_readfilter_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/workflow_quality_illumina/reports_folder",
                                "#main/workflow_quality_nanopore/reports_folder",
                                "#main/workflow_quality_pacbio/reports_folder"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/keep_readfilter_files_to_folder/folders"
                        },
                        {
                            "source": "#main/keep_filtered_reads",
                            "id": "#main/keep_readfilter_files_to_folder/keep_filtered_reads"
                        }
                    ],
                    "out": [
                        "#main/keep_readfilter_files_to_folder/results"
                    ],
                    "id": "#main/keep_readfilter_files_to_folder"
                },
                {
                    "label": "Medaka polishing of assembly",
                    "doc": "Medaka for (ont reads) polishing of an assembled (flye) genome",
                    "when": "$(inputs.run_medaka && inputs.run_flye && inputs.nanopore_reads !== null && inputs.nanopore_reads.length !== 0)",
                    "run": "#medaka_consensus_py.cwl",
                    "in": [
                        {
                            "source": "#main/ont_basecall_model",
                            "id": "#main/medaka/basecall_model"
                        },
                        {
                            "source": "#main/flye/assembly",
                            "id": "#main/medaka/draft_assembly"
                        },
                        {
                            "source": "#main/nanopore_reads",
                            "id": "#main/medaka/nanopore_reads"
                        },
                        {
                            "source": "#main/workflow_quality_nanopore/filtered_reads",
                            "id": "#main/medaka/reads"
                        },
                        {
                            "source": "#main/run_flye",
                            "id": "#main/medaka/run_flye"
                        },
                        {
                            "source": "#main/run_medaka",
                            "id": "#main/medaka/run_medaka"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/medaka/threads"
                        }
                    ],
                    "out": [
                        "#main/medaka/polished_assembly",
                        "#main/medaka/gaps_in_draft_coords"
                    ],
                    "id": "#main/medaka"
                },
                {
                    "doc": "Preparation of Medaka output files to a specific output folder",
                    "label": "Medaka output folder",
                    "when": "$(inputs.run_medaka && inputs.nanopore_reads !== null && inputs.nanopore_reads.length !== 0)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"medaka_assembly_polishing\")",
                            "id": "#main/medaka_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/medaka/polished_assembly",
                                "#main/medaka/gaps_in_draft_coords"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/medaka_files_to_folder/files"
                        },
                        {
                            "source": "#main/nanopore_reads",
                            "id": "#main/medaka_files_to_folder/nanopore_reads"
                        },
                        {
                            "source": "#main/run_medaka",
                            "id": "#main/medaka_files_to_folder/run_medaka"
                        }
                    ],
                    "out": [
                        "#main/medaka_files_to_folder/results"
                    ],
                    "id": "#main/medaka_files_to_folder"
                },
                {
                    "label": "Output bam file",
                    "doc": "Step needed to output bam file because there is an option to.",
                    "when": "${\n   return (inputs.output_bam_file && inputs.forward_reads !== null && inputs.forward_reads.length !== 0) ||\n   (inputs.binning && inputs.forward_reads !== null && inputs.forward_reads.length !== 0);\n}\n",
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
                                "id": "#main/output_bamfile/run/bam_in"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/output_bamfile/run/bam_out"
                            }
                        ],
                        "expression": "${ return {'bam_out': inputs.bam_in}; }\n"
                    },
                    "in": [
                        {
                            "source": "#main/assembly_read_mapping_illumina/sorted_bam",
                            "id": "#main/output_bamfile/bam_in"
                        },
                        {
                            "source": "#main/binning",
                            "id": "#main/output_bamfile/binning"
                        },
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/output_bamfile/forward_reads"
                        },
                        {
                            "source": "#main/output_bam_file",
                            "id": "#main/output_bamfile/output_bam_file"
                        }
                    ],
                    "out": [
                        "#main/output_bamfile/bam_out"
                    ],
                    "id": "#main/output_bamfile"
                },
                {
                    "doc": "Preparation of PyPolCA output files to a specific output folder",
                    "label": "PyPolca output folder",
                    "when": "$(inputs.run_pypolca && inputs.forward_reads !== null && inputs.forward_reads.length !== 0)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"pypolca_polished_assembly\")",
                            "id": "#main/pypolca_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/workflow_pypolca/polished_genome",
                                "#main/workflow_pypolca/vcf",
                                "#main/workflow_pypolca/report",
                                "#main/workflow_pypolca/log"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/pypolca_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/workflow_pypolca/logs_dir"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/pypolca_files_to_folder/folders"
                        },
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/pypolca_files_to_folder/forward_reads"
                        },
                        {
                            "source": "#main/run_pypolca",
                            "id": "#main/pypolca_files_to_folder/run_pypolca"
                        }
                    ],
                    "out": [
                        "#main/pypolca_files_to_folder/results"
                    ],
                    "id": "#main/pypolca_files_to_folder"
                },
                {
                    "doc": "Preparation of read filtering reports specific output folder",
                    "label": "Read filtering output folder",
                    "when": "$(inputs.keep_filtered_reads == false)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"read_filtering_and_classification\")",
                            "id": "#main/readfilter_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/workflow_quality_illumina/reports_folder",
                                "#main/workflow_quality_nanopore/reports_folder",
                                "#main/workflow_quality_pacbio/reports_folder"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/readfilter_files_to_folder/folders"
                        },
                        {
                            "source": "#main/keep_filtered_reads",
                            "id": "#main/readfilter_files_to_folder/keep_filtered_reads"
                        }
                    ],
                    "out": [
                        "#main/readfilter_files_to_folder/results"
                    ],
                    "id": "#main/readfilter_files_to_folder"
                },
                {
                    "doc": "Genome assembly using SPAdes with illumina and or long reads",
                    "label": "SPAdes assembly",
                    "when": "$(inputs.run_spades && inputs.forward_reads !== null && inputs.forward_reads.length !== 0)",
                    "run": "#spades.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/workflow_quality_illumina/QC_forward_reads"
                            ],
                            "linkMerge": "merge_nested",
                            "id": "#main/spades/forward_reads"
                        },
                        {
                            "source": "#main/memory",
                            "id": "#main/spades/memory"
                        },
                        {
                            "source": "#main/metagenome",
                            "id": "#main/spades/metagenome"
                        },
                        {
                            "source": "#main/workflow_quality_nanopore/filtered_reads",
                            "valueFrom": "${ var reads = null; if (self !== null) { reads = [self]; } return reads; }",
                            "id": "#main/spades/nanopore_reads"
                        },
                        {
                            "source": "#main/only_assembler_mode_spades",
                            "id": "#main/spades/only_assembler"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/spades/output_filename_prefix"
                        },
                        {
                            "source": "#main/workflow_quality_pacbio/filtered_reads",
                            "valueFrom": "${ var reads = null; if (self !== null) { reads = [self]; } return reads; }",
                            "id": "#main/spades/pacbio_reads"
                        },
                        {
                            "source": [
                                "#main/workflow_quality_illumina/QC_reverse_reads"
                            ],
                            "linkMerge": "merge_nested",
                            "id": "#main/spades/reverse_reads"
                        },
                        {
                            "source": "#main/run_spades",
                            "id": "#main/spades/run_spades"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/spades/threads"
                        }
                    ],
                    "out": [
                        "#main/spades/contigs",
                        "#main/spades/scaffolds",
                        "#main/spades/assembly_graph",
                        "#main/spades/assembly_graph_with_scaffolds",
                        "#main/spades/contigs_assembly_paths",
                        "#main/spades/scaffolds_assembly_paths",
                        "#main/spades/contigs_before_rr",
                        "#main/spades/params",
                        "#main/spades/log",
                        "#main/spades/internal_config",
                        "#main/spades/internal_dataset"
                    ],
                    "id": "#main/spades"
                },
                {
                    "label": "SPAdes contigs or scaffolds",
                    "doc": "Get chosen spades assembly. Contigs or scaffolds",
                    "when": "$(inputs.run_spades && inputs.forward_reads !== null && inputs.forward_reads.length !== 0)",
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
                                "id": "#main/spades_assembly/run/spades_contigs"
                            },
                            {
                                "type": "File",
                                "id": "#main/spades_assembly/run/spades_scaffolds"
                            },
                            {
                                "type": "boolean",
                                "id": "#main/spades_assembly/run/use_spades_scaffolds"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "id": "#main/spades_assembly/run/assembly"
                            }
                        ],
                        "expression": "${ \n  return {'assembly' : inputs.use_spades_scaffolds ? inputs.spades_scaffolds : inputs.spades_contigs};\n}\n"
                    },
                    "in": [
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/spades_assembly/forward_reads"
                        },
                        {
                            "source": "#main/run_spades",
                            "id": "#main/spades_assembly/run_spades"
                        },
                        {
                            "source": "#main/spades/contigs",
                            "id": "#main/spades_assembly/spades_contigs"
                        },
                        {
                            "source": "#main/spades/scaffolds",
                            "id": "#main/spades_assembly/spades_scaffolds"
                        },
                        {
                            "source": "#main/use_spades_scaffolds",
                            "id": "#main/spades_assembly/use_spades_scaffolds"
                        }
                    ],
                    "out": [
                        "#main/spades_assembly/assembly"
                    ],
                    "id": "#main/spades_assembly"
                },
                {
                    "doc": "Preparation of SPAdes output files to a specific output folder",
                    "label": "SPADES output to folder",
                    "when": "$(inputs.run_spades)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"spades_assembly\")",
                            "id": "#main/spades_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/compress_spades/outfile",
                                "#main/spades/params",
                                "#main/spades/log",
                                "#main/spades/internal_config",
                                "#main/spades/internal_dataset"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/spades_files_to_folder/files"
                        },
                        {
                            "source": "#main/run_spades",
                            "id": "#main/spades_files_to_folder/run_spades"
                        }
                    ],
                    "out": [
                        "#main/spades_files_to_folder/results"
                    ],
                    "id": "#main/spades_files_to_folder"
                },
                {
                    "label": "Binning workflow",
                    "doc": "Binning workflow to create bins",
                    "when": "$(inputs.binning && inputs.forward_reads !== null && inputs.forward_reads.length !== 0)",
                    "run": "#workflow_metagenomics_binning.cwl",
                    "in": [
                        {
                            "source": "#main/annotate_bins",
                            "id": "#main/workflow_binning/annotate_bins"
                        },
                        {
                            "source": "#main/annotate_unbinned",
                            "id": "#main/workflow_binning/annotate_unbinned"
                        },
                        {
                            "source": "#main/get_assembly_to_use/assembly",
                            "id": "#main/workflow_binning/assembly"
                        },
                        {
                            "source": "#main/get_assembly_to_use/assembly_choice",
                            "id": "#main/workflow_binning/assembly_choice"
                        },
                        {
                            "source": "#main/bakta_db",
                            "id": "#main/workflow_binning/bakta_db"
                        },
                        {
                            "source": "#main/assembly_read_mapping_illumina/sorted_bam",
                            "id": "#main/workflow_binning/bam_file"
                        },
                        {
                            "source": "#main/binning",
                            "id": "#main/workflow_binning/binning"
                        },
                        {
                            "source": "#main/busco_data",
                            "id": "#main/workflow_binning/busco_data"
                        },
                        {
                            "source": "#main/eggnog_dbs",
                            "id": "#main/workflow_binning/eggnog_dbs"
                        },
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/workflow_binning/forward_reads"
                        },
                        {
                            "source": "#main/gtdbtk_data",
                            "id": "#main/workflow_binning/gtdbtk_data"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_binning/identifier"
                        },
                        {
                            "source": "#main/interproscan_applications",
                            "id": "#main/workflow_binning/interproscan_applications"
                        },
                        {
                            "source": "#main/interproscan_directory",
                            "id": "#main/workflow_binning/interproscan_directory"
                        },
                        {
                            "source": "#main/kofamscan_limit_sapp",
                            "id": "#main/workflow_binning/kofamscan_limit_sapp"
                        },
                        {
                            "source": "#main/run_eggnog",
                            "id": "#main/workflow_binning/run_eggnog"
                        },
                        {
                            "source": "#main/run_interproscan",
                            "id": "#main/workflow_binning/run_interproscan"
                        },
                        {
                            "source": "#main/run_kofamscan",
                            "id": "#main/workflow_binning/run_kofamscan"
                        },
                        {
                            "source": "#main/run_maxbin2",
                            "id": "#main/workflow_binning/run_maxbin2"
                        },
                        {
                            "source": "#main/run_semibin2",
                            "id": "#main/workflow_binning/run_semibin2"
                        },
                        {
                            "source": "#main/semibin2_environment",
                            "id": "#main/workflow_binning/semibin2_environment"
                        },
                        {
                            "source": "#main/skip_bakta_crispr",
                            "id": "#main/workflow_binning/skip_bakta_crispr"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_binning/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_binning/bins",
                        "#main/workflow_binning/binette_output",
                        "#main/workflow_binning/maxbin2_output",
                        "#main/workflow_binning/semibin_output",
                        "#main/workflow_binning/metabat2_output",
                        "#main/workflow_binning/gtdbtk_output",
                        "#main/workflow_binning/busco_output",
                        "#main/workflow_binning/bins_summary_table",
                        "#main/workflow_binning/bins_read_stats",
                        "#main/workflow_binning/eukrep_fasta",
                        "#main/workflow_binning/eukrep_stats_file",
                        "#main/workflow_binning/annotation_output"
                    ],
                    "id": "#main/workflow_binning"
                },
                {
                    "label": "Kraken2 illumina",
                    "doc": "Taxonomic classification using kraken2 Illumina reads",
                    "when": "$(!inputs.run_kraken2_illumina && inputs.kraken2_database !== null && inputs.kraken2_database.length !== 0)",
                    "run": "#workflow_kraken2-bracken.cwl",
                    "scatter": "#main/workflow_kraken2_illumina/kraken2_database",
                    "in": [
                        {
                            "source": "#main/bracken_levels",
                            "id": "#main/workflow_kraken2_illumina/bracken_levels"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_kraken2_illumina/identifier"
                        },
                        {
                            "source": "#main/workflow_quality_illumina/QC_forward_reads",
                            "id": "#main/workflow_kraken2_illumina/illumina_forward_reads"
                        },
                        {
                            "source": "#main/workflow_quality_illumina/QC_reverse_reads",
                            "id": "#main/workflow_kraken2_illumina/illumina_reverse_reads"
                        },
                        {
                            "source": "#main/kraken2_confidence",
                            "id": "#main/workflow_kraken2_illumina/kraken2_confidence"
                        },
                        {
                            "source": "#main/kraken2_database",
                            "id": "#main/workflow_kraken2_illumina/kraken2_database"
                        },
                        {
                            "source": "#main/kraken2_standard_report",
                            "id": "#main/workflow_kraken2_illumina/output_standard_report"
                        },
                        {
                            "source": "#main/illumina_read_length",
                            "id": "#main/workflow_kraken2_illumina/read_length"
                        },
                        {
                            "source": "#main/run_kraken2_illumina",
                            "id": "#main/workflow_kraken2_illumina/run_kraken2_illumina"
                        },
                        {
                            "source": "#main/skip_bracken",
                            "id": "#main/workflow_kraken2_illumina/skip_bracken"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_kraken2_illumina/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_kraken2_illumina/kraken2_folder",
                        "#main/workflow_kraken2_illumina/bracken_folder"
                    ],
                    "id": "#main/workflow_kraken2_illumina"
                },
                {
                    "label": "Run PyPolCA assemlby polishing",
                    "doc": "PyPolCA polishing of longreads assembly with illumina reads",
                    "when": "$(inputs.run_pypolca && inputs.forward_reads !== null && inputs.forward_reads.length !== 0)",
                    "run": "#pypolca.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/medaka/polished_assembly",
                                "#main/flye/assembly",
                                "#main/spades_assembly/assembly"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#main/workflow_pypolca/assembly"
                        },
                        {
                            "source": "#main/workflow_quality_illumina/QC_forward_reads",
                            "id": "#main/workflow_pypolca/forward_reads"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_pypolca/identifier"
                        },
                        {
                            "source": "#main/workflow_quality_illumina/QC_reverse_reads",
                            "id": "#main/workflow_pypolca/reverse_reads"
                        },
                        {
                            "source": "#main/run_pypolca",
                            "id": "#main/workflow_pypolca/run_pypolca"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_pypolca/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_pypolca/polished_genome",
                        "#main/workflow_pypolca/vcf",
                        "#main/workflow_pypolca/report",
                        "#main/workflow_pypolca/log",
                        "#main/workflow_pypolca/logs_dir"
                    ],
                    "id": "#main/workflow_pypolca"
                },
                {
                    "label": "Oxford Nanopore quality workflow",
                    "doc": "Quality, filtering and taxonomic classification workflow for Oxford Nanopore reads",
                    "when": "$(inputs.forward_reads !== null)",
                    "run": "#workflow_illumina_quality.cwl",
                    "in": [
                        {
                            "source": "#main/deduplicate_illumina_reads",
                            "id": "#main/workflow_quality_illumina/deduplicate"
                        },
                        {
                            "source": "#main/illumina_forward_reads",
                            "id": "#main/workflow_quality_illumina/forward_reads"
                        },
                        {
                            "source": "#main/illumina_humandb",
                            "id": "#main/workflow_quality_illumina/humandb"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_quality_illumina/identifier"
                        },
                        {
                            "source": "#main/use_reference_mapped_reads",
                            "id": "#main/workflow_quality_illumina/keep_reference_mapped_reads"
                        },
                        {
                            "source": "#main/illumina_reference_filter_db",
                            "id": "#main/workflow_quality_illumina/reference_filter_db"
                        },
                        {
                            "source": "#main/illumina_reverse_reads",
                            "id": "#main/workflow_quality_illumina/reverse_reads"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_quality_illumina/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_quality_illumina/QC_forward_reads",
                        "#main/workflow_quality_illumina/QC_reverse_reads",
                        "#main/workflow_quality_illumina/reports_folder"
                    ],
                    "id": "#main/workflow_quality_illumina"
                },
                {
                    "label": "Oxford Nanopore quality workflow",
                    "doc": "Quality, filtering and taxonomic classification workflow for Oxford Nanopore reads",
                    "when": "$(inputs.longreads !== null)",
                    "run": "#workflow_longread_quality.cwl",
                    "in": [
                        {
                            "source": "#main/longread_adapter_fasta",
                            "id": "#main/workflow_quality_nanopore/adapter_fasta"
                        },
                        {
                            "source": "#main/longread_disable_adapter_trimming",
                            "id": "#main/workflow_quality_nanopore/disable_adapter_trimming"
                        },
                        {
                            "source": "#main/longread_end_adapter",
                            "id": "#main/workflow_quality_nanopore/end_adapter"
                        },
                        {
                            "source": "#main/longread_humandb",
                            "id": "#main/workflow_quality_nanopore/humandb"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_quality_nanopore/identifier"
                        },
                        {
                            "source": "#main/use_reference_mapped_reads",
                            "id": "#main/workflow_quality_nanopore/keep_reference_mapped_reads"
                        },
                        {
                            "source": "#main/longread_length_limit",
                            "id": "#main/workflow_quality_nanopore/length_limit"
                        },
                        {
                            "source": "#main/nanopore_reads",
                            "id": "#main/workflow_quality_nanopore/longreads"
                        },
                        {
                            "source": "#main/longread_mean_qual",
                            "id": "#main/workflow_quality_nanopore/mean_qual"
                        },
                        {
                            "source": "#main/longread_minimum_length",
                            "id": "#main/workflow_quality_nanopore/minimum_length"
                        },
                        {
                            "source": "#main/longread_poly_x_min_len",
                            "id": "#main/workflow_quality_nanopore/poly_x_min_len"
                        },
                        {
                            "source": "#main/longread_qualified_quality_phred",
                            "id": "#main/workflow_quality_nanopore/qualified_quality_phred"
                        },
                        {
                            "default": "nanopore",
                            "id": "#main/workflow_quality_nanopore/readtype"
                        },
                        {
                            "source": "#main/longread_reference_filter_db",
                            "id": "#main/workflow_quality_nanopore/reference_filter_db"
                        },
                        {
                            "source": "#main/longread_start_adapter",
                            "id": "#main/workflow_quality_nanopore/start_adapter"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_quality_nanopore/threads"
                        },
                        {
                            "source": "#main/longread_trim_front",
                            "id": "#main/workflow_quality_nanopore/trim_front"
                        },
                        {
                            "source": "#main/longread_trim_poly_x",
                            "id": "#main/workflow_quality_nanopore/trim_poly_x"
                        },
                        {
                            "source": "#main/longread_trim_tail",
                            "id": "#main/workflow_quality_nanopore/trim_tail"
                        }
                    ],
                    "out": [
                        "#main/workflow_quality_nanopore/filtered_reads",
                        "#main/workflow_quality_nanopore/reports_folder"
                    ],
                    "id": "#main/workflow_quality_nanopore"
                },
                {
                    "label": "PacBio quality and filtering workflow",
                    "when": "$(inputs.longreads !== null)",
                    "doc": "Quality, filtering and taxonomic classification for PacBio reads",
                    "run": "#workflow_longread_quality.cwl",
                    "in": [
                        {
                            "source": "#main/longread_adapter_fasta",
                            "id": "#main/workflow_quality_pacbio/adapter_fasta"
                        },
                        {
                            "source": "#main/longread_disable_adapter_trimming",
                            "id": "#main/workflow_quality_pacbio/disable_adapter_trimming"
                        },
                        {
                            "source": "#main/longread_end_adapter",
                            "id": "#main/workflow_quality_pacbio/end_adapter"
                        },
                        {
                            "source": "#main/longread_humandb",
                            "id": "#main/workflow_quality_pacbio/humandb"
                        },
                        {
                            "source": "#main/identifier",
                            "id": "#main/workflow_quality_pacbio/identifier"
                        },
                        {
                            "source": "#main/use_reference_mapped_reads",
                            "id": "#main/workflow_quality_pacbio/keep_reference_mapped_reads"
                        },
                        {
                            "source": "#main/longread_length_limit",
                            "id": "#main/workflow_quality_pacbio/length_limit"
                        },
                        {
                            "source": "#main/pacbio_reads",
                            "id": "#main/workflow_quality_pacbio/longreads"
                        },
                        {
                            "source": "#main/longread_mean_qual",
                            "id": "#main/workflow_quality_pacbio/mean_qual"
                        },
                        {
                            "source": "#main/longread_minimum_length",
                            "id": "#main/workflow_quality_pacbio/minimum_length"
                        },
                        {
                            "source": "#main/longread_poly_x_min_len",
                            "id": "#main/workflow_quality_pacbio/poly_x_min_len"
                        },
                        {
                            "source": "#main/longread_qualified_quality_phred",
                            "id": "#main/workflow_quality_pacbio/qualified_quality_phred"
                        },
                        {
                            "default": "pacbio",
                            "id": "#main/workflow_quality_pacbio/readtype"
                        },
                        {
                            "source": "#main/longread_reference_filter_db",
                            "id": "#main/workflow_quality_pacbio/reference_filter_db"
                        },
                        {
                            "source": "#main/longread_start_adapter",
                            "id": "#main/workflow_quality_pacbio/start_adapter"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_quality_pacbio/threads"
                        },
                        {
                            "source": "#main/longread_trim_front",
                            "id": "#main/workflow_quality_pacbio/trim_front"
                        },
                        {
                            "source": "#main/longread_trim_poly_x",
                            "id": "#main/workflow_quality_pacbio/trim_poly_x"
                        },
                        {
                            "source": "#main/longread_trim_tail",
                            "id": "#main/workflow_quality_pacbio/trim_tail"
                        }
                    ],
                    "out": [
                        "#main/workflow_quality_pacbio/filtered_reads",
                        "#main/workflow_quality_pacbio/reports_folder"
                    ],
                    "id": "#main/workflow_quality_pacbio"
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
            "https://schema.org/dateCreated": "2025-05-05",
            "https://schema.org/dateModified": "2025-08-04",
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
            "label": "Metagenomic Binning from Assembly",
            "doc": "Workflow for Metagenomics binning from assembly.<br>\n\nMinimal inputs are: Identifier, assembly (fasta) and a associated sorted BAM file\n\nSummary\n  - MetaBAT2 (binning)\n  - MaxBin2 (binning)\n  - SemiBin2 (binning)\n  - BinSPreader (bin refinement)\n  - DAS Tool (bin merging)\n  - binette (bin merging) In Development\n  - EukRep (eukaryotic classification)\n  - CheckM (bin completeness and contamination)\n  - BUSCO (bin completeness)\n  - GTDB-Tk (bin taxonomic classification)\n\nOther UNLOCK workflows on WorkflowHub: https://workflowhub.eu/projects/16/workflows?view=default<br><br>\n\n**All tool CWL files and other workflows can be found here:**<br>\n  Tools: https://gitlab.com/m-unlock/cwl<br>\n  Workflows: https://gitlab.com/m-unlock/cwl/workflows<br>\n\n**How to setup and use an UNLOCK workflow:**<br>\nhttps://docs.m-unlock.nl/docs/workflows/setup.html<br>\n",
            "outputs": [
                {
                    "label": "Annotation",
                    "doc": "Bin annotation",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/results",
                    "id": "#workflow_metagenomics_binning.cwl/annotation_output"
                },
                {
                    "label": "DAS Tool",
                    "doc": "DAS Tool output directory",
                    "type": "Directory",
                    "outputSource": "#workflow_metagenomics_binning.cwl/binette_files_to_folder/results",
                    "id": "#workflow_metagenomics_binning.cwl/binette_output"
                },
                {
                    "label": "Binned contigs",
                    "doc": "File with contig to bin assignment",
                    "type": "File",
                    "outputSource": "#workflow_metagenomics_binning.cwl/bins_summary/bin_contigs",
                    "id": "#workflow_metagenomics_binning.cwl/binned_contigs"
                },
                {
                    "label": "Bin files",
                    "doc": "Bins files in fasta format. To be be used in other workflows.",
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#workflow_metagenomics_binning.cwl/binette_bins/files",
                    "id": "#workflow_metagenomics_binning.cwl/bins"
                },
                {
                    "label": "Assembly/Bin read stats",
                    "doc": "General assembly and bin coverage",
                    "type": "File",
                    "outputSource": "#workflow_metagenomics_binning.cwl/bin_readstats/binReadStats",
                    "id": "#workflow_metagenomics_binning.cwl/bins_read_stats"
                },
                {
                    "label": "Bins summary",
                    "doc": "Summary of info about the bins",
                    "type": "File",
                    "outputSource": "#workflow_metagenomics_binning.cwl/bins_summary/bins_summary_table",
                    "id": "#workflow_metagenomics_binning.cwl/bins_summary_table"
                },
                {
                    "label": "BUSCO",
                    "doc": "BUSCO output directory",
                    "type": "Directory",
                    "outputSource": "#workflow_metagenomics_binning.cwl/busco_files_to_folder/results",
                    "id": "#workflow_metagenomics_binning.cwl/busco_output"
                },
                {
                    "label": "EukRep fasta",
                    "doc": "EukRep eukaryotic classified contigs",
                    "type": "File",
                    "outputSource": "#workflow_metagenomics_binning.cwl/eukrep/euk_fasta_out",
                    "id": "#workflow_metagenomics_binning.cwl/eukrep_fasta"
                },
                {
                    "label": "EukRep stats",
                    "doc": "EukRep fasta statistics",
                    "type": "File",
                    "outputSource": "#workflow_metagenomics_binning.cwl/eukrep_stats/output",
                    "id": "#workflow_metagenomics_binning.cwl/eukrep_stats_file"
                },
                {
                    "label": "GTDB-Tk",
                    "doc": "GTDB-Tk output directory",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#workflow_metagenomics_binning.cwl/gtdbtk_files_to_folder/results",
                    "id": "#workflow_metagenomics_binning.cwl/gtdbtk_output"
                },
                {
                    "label": "MaxBin2",
                    "doc": "MaxBin2 output directory\u00df",
                    "type": "Directory",
                    "outputSource": "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder/results",
                    "id": "#workflow_metagenomics_binning.cwl/maxbin2_output"
                },
                {
                    "label": "MetaBAT2",
                    "doc": "MetaBAT2 output directory",
                    "type": "Directory",
                    "outputSource": "#workflow_metagenomics_binning.cwl/metabat2_files_to_folder/results",
                    "id": "#workflow_metagenomics_binning.cwl/metabat2_output"
                },
                {
                    "label": "SemiBin",
                    "doc": "MaxBin2 output directory",
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#workflow_metagenomics_binning.cwl/semibin_files_to_folder/results",
                    "id": "#workflow_metagenomics_binning.cwl/semibin_output"
                }
            ],
            "inputs": [
                {
                    "type": "boolean",
                    "label": "Annotate bins",
                    "doc": "Annotate bins. Default false",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/annotate_bins"
                },
                {
                    "type": "boolean",
                    "label": "Annotate unbinned",
                    "doc": "Annotate unbinned contigs. Will be treated as metagenome. Default false",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/annotate_unbinned"
                },
                {
                    "type": "File",
                    "doc": "Assembly in fasta format",
                    "label": "Assembly fasta",
                    "loadListing": "no_listing",
                    "id": "#workflow_metagenomics_binning.cwl/assembly"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Assembly graph file from asssembler for BinSPreader",
                    "label": "BinSPreader graph file",
                    "id": "#workflow_metagenomics_binning.cwl/assembly_graph"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Bakta DB",
                    "doc": "Bakta Database directory (required when annotating bins)",
                    "id": "#workflow_metagenomics_binning.cwl/bakta_db"
                },
                {
                    "type": "File",
                    "doc": "Mapping file in sorted bam format containing reads mapped to the assembly",
                    "label": "Bam file",
                    "loadListing": "no_listing",
                    "id": "#workflow_metagenomics_binning.cwl/bam_file"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "BUSCO dataset",
                    "doc": "Directory containing the BUSCO dataset location.",
                    "loadListing": "no_listing",
                    "id": "#workflow_metagenomics_binning.cwl/busco_data"
                },
                {
                    "type": "float",
                    "doc": "Score metric used in Binette bin refinement. Bin are scored as follow; completeness - weight * contamination. A low contamination_weight favor complete bins over low contaminated bins. Default 2.0",
                    "label": "Contamination weight",
                    "default": 2.0,
                    "id": "#workflow_metagenomics_binning.cwl/contamination_weight"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output destination",
                    "doc": "Optional output destination path for cwl-prov reporting. (not used in the workflow itself)",
                    "id": "#workflow_metagenomics_binning.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#workflow_metagenomics_binning.cwl/eggnog_dbs/eggnog_dbs",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        "Directory"
                                    ],
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "loadListing": "no_listing",
                                    "name": "#workflow_metagenomics_binning.cwl/eggnog_dbs/eggnog_dbs/data_dir"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file",
                                    "loadListing": "no_listing",
                                    "name": "#workflow_metagenomics_binning.cwl/eggnog_dbs/eggnog_dbs/db"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file for diamond blast search",
                                    "loadListing": "no_listing",
                                    "name": "#workflow_metagenomics_binning.cwl/eggnog_dbs/eggnog_dbs/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/eggnog_dbs"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing the GTDB database. When none is given GTDB-Tk will be skipped.",
                    "label": "gtdbtk data directory",
                    "loadListing": "no_listing",
                    "id": "#workflow_metagenomics_binning.cwl/gtdbtk_data"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "Identifier used",
                    "id": "#workflow_metagenomics_binning.cwl/identifier"
                },
                {
                    "type": "string",
                    "label": "InterProScan applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "default": "Pfam",
                    "id": "#workflow_metagenomics_binning.cwl/interproscan_applications"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "InterProScan 5 directory",
                    "doc": "Directory of the (full) InterProScan 5 program. Used for annotating bins. (required when running with interproscan)",
                    "loadListing": "no_listing",
                    "id": "#workflow_metagenomics_binning.cwl/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan limit",
                    "doc": "Limit max number of entries of kofamscan hits per locus in SAPP. Default 5",
                    "default": 5,
                    "id": "#workflow_metagenomics_binning.cwl/kofamscan_limit_sapp"
                },
                {
                    "type": "int",
                    "doc": "Minimum completeness for Binette bin refinement. Default 40",
                    "label": "Minimum completeness",
                    "default": 40,
                    "id": "#workflow_metagenomics_binning.cwl/min_completeness"
                },
                {
                    "type": "boolean",
                    "doc": "Run with BUSCO bin completeness assessment. Default false",
                    "label": "Run BUSCO",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/run_busco"
                },
                {
                    "type": "boolean",
                    "label": "Run eggNOG-mapper",
                    "doc": "Run with eggNOG-mapper annotation. Requires eggnog database files. Default false",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/run_eggnog"
                },
                {
                    "type": "boolean",
                    "label": "Run InterProScan",
                    "doc": "Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/run_interproscan"
                },
                {
                    "type": "boolean",
                    "label": "Run kofamscan",
                    "doc": "Run with KEGG KO KoFamKOALA annotation. Default false",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/run_kofamscan"
                },
                {
                    "type": "boolean",
                    "doc": "Run with MaxBin2 binner. Default true",
                    "label": "Run Maxbin2",
                    "default": true,
                    "id": "#workflow_metagenomics_binning.cwl/run_maxbin2"
                },
                {
                    "type": "boolean",
                    "doc": "Run with SemiBin2 binner. Default true",
                    "label": "Run SemiBin",
                    "default": true,
                    "id": "#workflow_metagenomics_binning.cwl/run_semibin2"
                },
                {
                    "doc": "Semibin2 Built-in models (none/global/human_gut/dog_gut/ocean/soil/cat_gut/human_oral/mouse_gut/pig_gut/built_environment/wastewater/chicken_caecum). \nChoosing a built-in model is generally faster. Otherwise it will do (single-sample) training on the data.\nDefault global\n",
                    "label": "SemiBin Environment",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/none",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/global",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/human_gut",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/dog_gut",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/ocean",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/soil",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/cat_gut",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/human_oral",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/mouse_gut",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/pig_gut",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/built_environment",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/wastewater",
                                "#workflow_metagenomics_binning.cwl/semibin2_environment/chicken_caecum"
                            ]
                        }
                    ],
                    "default": "global",
                    "id": "#workflow_metagenomics_binning.cwl/semibin2_environment"
                },
                {
                    "type": "boolean",
                    "label": "Skip CRISPR",
                    "doc": "Skip CRISPR array prediction using PILER-CR",
                    "default": false,
                    "id": "#workflow_metagenomics_binning.cwl/skip_bakta_crispr"
                },
                {
                    "type": "int",
                    "doc": "Number of threads to use for computational processes",
                    "label": "Threads",
                    "default": 2,
                    "id": "#workflow_metagenomics_binning.cwl/threads"
                }
            ],
            "steps": [
                {
                    "doc": "Preparation of annotation output files to a specific output folder",
                    "label": "Annotation output folder",
                    "when": "$((inputs.annotate_bins || inputs.annotate_unbinned))",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/annotate_bins",
                            "id": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/annotate_bins"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/annotate_unbinned",
                            "id": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/annotate_unbinned"
                        },
                        {
                            "valueFrom": "bin_annotation",
                            "id": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/compressed_other_files",
                                "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/sapp_hdt_file",
                                "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/sapp_hdt_file",
                                "#workflow_metagenomics_binning.cwl/annotation_output_to_array_bins/output"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/files"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/bakta_folder_compressed",
                                "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/bakta_folder_compressed"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/folders"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/annotation_files_to_folder_bins"
                },
                {
                    "when": "$(inputs.annotate_bins)",
                    "run": "#merge_file_arrays.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/annotate_bins",
                            "id": "#workflow_metagenomics_binning.cwl/annotation_output_to_array_bins/annotate_bins"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/compressed_other_files"
                            ],
                            "id": "#workflow_metagenomics_binning.cwl/annotation_output_to_array_bins/input"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/annotation_output_to_array_bins/output"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/annotation_output_to_array_bins"
                },
                {
                    "doc": "Table general bin and assembly read mapping stats",
                    "label": "Bin and assembly read stats",
                    "run": "#assembly_bins_readstats.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/bam_file",
                            "id": "#workflow_metagenomics_binning.cwl/bin_readstats/bam_file"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette/final_bins",
                            "id": "#workflow_metagenomics_binning.cwl/bin_readstats/bin_dir"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/bin_readstats/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/bin_readstats/binReadStats"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/bin_readstats"
                },
                {
                    "doc": "Binning refinement using Binette",
                    "label": "Binette",
                    "run": "#binette.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/metabat2_filter_bins/output_folder",
                                "#workflow_metagenomics_binning.cwl/maxbin2_to_folder/results",
                                "#workflow_metagenomics_binning.cwl/semibin2/output_bins"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/binette/bins_dirs"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/contamination_weight",
                            "id": "#workflow_metagenomics_binning.cwl/binette/contamination_weight"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/assembly",
                            "id": "#workflow_metagenomics_binning.cwl/binette/contigs"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/min_completeness",
                            "id": "#workflow_metagenomics_binning.cwl/binette/min_completeness"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/binette/threads"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/binette/verbose"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/binette/final_bins",
                        "#workflow_metagenomics_binning.cwl/binette/final_bins_quality_report",
                        "#workflow_metagenomics_binning.cwl/binette/input_bins_quality_reports"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/binette"
                },
                {
                    "doc": "Binette bins folder to File array for further analysis",
                    "label": "Bin folder to files[]",
                    "run": "#folder_to_files.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette/final_bins",
                            "id": "#workflow_metagenomics_binning.cwl/binette_bins/folder"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/binette_bins/files"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/binette_bins"
                },
                {
                    "doc": "Preparation of DAS Tool output files to a specific output folder.",
                    "label": "DAS Tool output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "bin_refinement_binette",
                            "id": "#workflow_metagenomics_binning.cwl/binette_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/binette/final_bins_quality_report",
                                "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/unbinned_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#workflow_metagenomics_binning.cwl/binette_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/binette/final_bins",
                                "#workflow_metagenomics_binning.cwl/binette/input_bins_quality_reports"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#workflow_metagenomics_binning.cwl/binette_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/binette_files_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/binette_files_to_folder"
                },
                {
                    "doc": "Table of final bins and their statistics like size, contigs, completeness etc",
                    "label": "Bins summary",
                    "run": "#bins_summary.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/binette_bins/files",
                                "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/unbinned_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/bins_summary/bin_files"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette/final_bins_quality_report",
                            "id": "#workflow_metagenomics_binning.cwl/bins_summary/binette_report"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/busco/batch_summary",
                            "id": "#workflow_metagenomics_binning.cwl/bins_summary/busco_batch"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/coverm/coverm_tsv",
                            "id": "#workflow_metagenomics_binning.cwl/bins_summary/coverm"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/gtdbtk/gtdbtk_summary",
                            "id": "#workflow_metagenomics_binning.cwl/bins_summary/gtdbtk_summary"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/bins_summary/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/bins_summary/bins_summary_table",
                        "#workflow_metagenomics_binning.cwl/bins_summary/bin_contigs"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/bins_summary"
                },
                {
                    "doc": "BUSCO assembly completeness workflow",
                    "label": "BUSCO",
                    "run": "#busco.cwl",
                    "when": "$(inputs.bins.length !== 0 && inputs.run_busco)",
                    "in": [
                        {
                            "valueFrom": "$(true)",
                            "id": "#workflow_metagenomics_binning.cwl/busco/auto-lineage-prok"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette_bins/files",
                            "id": "#workflow_metagenomics_binning.cwl/busco/bins"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/busco_data",
                            "id": "#workflow_metagenomics_binning.cwl/busco/busco_data"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/busco/identifier"
                        },
                        {
                            "valueFrom": "geno",
                            "id": "#workflow_metagenomics_binning.cwl/busco/mode"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_busco",
                            "id": "#workflow_metagenomics_binning.cwl/busco/run_busco"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette/final_bins",
                            "id": "#workflow_metagenomics_binning.cwl/busco/sequence_folder"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/busco/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/busco/batch_summary"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/busco"
                },
                {
                    "doc": "Preparation of BUSCO output files to a specific output folder",
                    "label": "BUSCO output folder",
                    "when": "$(inputs.run_busco)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "busco_bin_completeness",
                            "id": "#workflow_metagenomics_binning.cwl/busco_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/busco/batch_summary"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/busco_files_to_folder/files"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_busco",
                            "id": "#workflow_metagenomics_binning.cwl/busco_files_to_folder/run_busco"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/busco_files_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/busco_files_to_folder"
                },
                {
                    "doc": "Compress GTDB-Tk output folder",
                    "label": "Compress GTDB-Tk",
                    "when": "$(inputs.gtdbtk_data !== null)",
                    "run": "#compress_directory.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/gtdbtk_data",
                            "id": "#workflow_metagenomics_binning.cwl/compress_gtdbtk/gtdbtk_data"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/gtdbtk/gtdbtk_out_folder",
                            "id": "#workflow_metagenomics_binning.cwl/compress_gtdbtk/indir"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/compress_gtdbtk/outfile"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/compress_gtdbtk"
                },
                {
                    "doc": "CoverM to obtain bin coverages/abundances",
                    "label": "CoverM",
                    "run": "#coverm_genome.cwl",
                    "when": "$(inputs.genome_fasta_files.length !== 0)",
                    "in": [
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/bam_file"
                            ],
                            "linkMerge": "merge_nested",
                            "id": "#workflow_metagenomics_binning.cwl/coverm/bam_files"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/binette_bins/files",
                                "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/unbinned_fasta"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/coverm/genome_fasta_files"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/coverm/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/coverm/coverm_tsv"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/coverm"
                },
                {
                    "doc": "EukRep, eukaryotic sequence classification",
                    "label": "EukRep",
                    "run": "#eukrep.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/assembly",
                            "id": "#workflow_metagenomics_binning.cwl/eukrep/assembly"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/eukrep/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/eukrep/euk_fasta_out"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/eukrep"
                },
                {
                    "doc": "EukRep fasta statistics",
                    "label": "EukRep stats",
                    "run": "#raw_n50.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "valueFrom": "$(self)_eukrep",
                            "id": "#workflow_metagenomics_binning.cwl/eukrep_stats/identifier"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/eukrep/euk_fasta_out",
                            "id": "#workflow_metagenomics_binning.cwl/eukrep_stats/input_fasta"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/eukrep_stats/output"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/eukrep_stats"
                },
                {
                    "doc": "Extract unbinned contigs",
                    "label": "Extract unbinned contigs from assembly and bins",
                    "when": "$(inputs.bins.length !== 0)",
                    "run": "#get_unbinned_contigs.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/assembly",
                            "id": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/assembly_fasta"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette/final_bins",
                            "id": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/bin_dir"
                        },
                        {
                            "valueFrom": "fa",
                            "id": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/bin_extension"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette_bins/files",
                            "id": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/bins"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "valueFrom": "$(self)_binette",
                            "id": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/unbinned_fasta"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs"
                },
                {
                    "doc": "Taxonomic assigment of bins with GTDB-Tk",
                    "label": "GTDBTK",
                    "when": "$(inputs.gtdbtk_data !== null && inputs.bins.length !== 0)",
                    "run": "#gtdbtk_classify_wf.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette/final_bins",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk/bin_dir"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette_bins/files",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk/bins"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/gtdbtk_data",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk/gtdbtk_data"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk/identifier"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/gtdbtk/gtdbtk_summary",
                        "#workflow_metagenomics_binning.cwl/gtdbtk/gtdbtk_out_folder"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/gtdbtk"
                },
                {
                    "doc": "Preparation of GTDB-Tk output files to a specific output folder",
                    "label": "GTBD-Tk output folder",
                    "when": "$(inputs.gtdbtk_data !== null)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "gtdb-tk_bin_classification",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/gtdbtk/gtdbtk_summary",
                                "#workflow_metagenomics_binning.cwl/compress_gtdbtk/outfile"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk_files_to_folder/files"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/gtdbtk_data",
                            "id": "#workflow_metagenomics_binning.cwl/gtdbtk_files_to_folder/gtdbtk_data"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/gtdbtk_files_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/gtdbtk_files_to_folder"
                },
                {
                    "doc": "Binning procedure using MaxBin2",
                    "label": "MaxBin2 binning",
                    "when": "$(inputs.run_maxbin2)",
                    "run": "#maxbin2.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/depths",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2/abundances"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/assembly",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2/contigs"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2/identifier"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_maxbin2",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2/run_maxbin2"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/maxbin2/bins",
                        "#workflow_metagenomics_binning.cwl/maxbin2/summary",
                        "#workflow_metagenomics_binning.cwl/maxbin2/log"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/maxbin2"
                },
                {
                    "doc": "Preparation of maxbin2 output files to a specific output folder.",
                    "label": "MaxBin2 output folder",
                    "when": "$(inputs.run_maxbin2)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "binner_maxbin2",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/maxbin2/summary",
                                "#workflow_metagenomics_binning.cwl/maxbin2/log"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/maxbin2_to_folder/results"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder/folders"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_maxbin2",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder/run_maxbin2"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/maxbin2_files_to_folder"
                },
                {
                    "doc": "Create folder with MaxBin2 bins",
                    "label": "MaxBin2 bins to folder",
                    "when": "$(inputs.run_maxbin2)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "maxbin2_bins",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_to_folder/destination"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/maxbin2/bins",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_to_folder/files"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_maxbin2",
                            "id": "#workflow_metagenomics_binning.cwl/maxbin2_to_folder/run_maxbin2"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/maxbin2_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/maxbin2_to_folder"
                },
                {
                    "doc": "Binning procedure using MetaBAT2",
                    "label": "MetaBAT2 binning",
                    "run": "#metabat2.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/assembly",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2/assembly"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/depths",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2/depths"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2/identifier"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/metabat2/bin_dir",
                        "#workflow_metagenomics_binning.cwl/metabat2/log"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/metabat2"
                },
                {
                    "label": "contig depths",
                    "doc": "MetabatContigDepths to obtain the depth file used in the MetaBat2 and SemiBin2 binning process",
                    "run": "#metabatContigDepths.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/bam_file",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/bamFile"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/depths"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/metabat2_contig_depths"
                },
                {
                    "doc": "Preparation of MetaBAT2 output files + unbinned contigs to a specific output folder",
                    "label": "MetaBAT2 output folder",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "binner_metabat2",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/metabat2/log",
                                "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/depths"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/metabat2/bin_dir"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/metabat2_files_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/metabat2_files_to_folder"
                },
                {
                    "doc": "Only keep genome bin fasta files (exlude e.g TooShort.fa)",
                    "label": "Keep MetaBAT2 genome bins",
                    "run": "#folder_file_regex.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/metabat2/bin_dir",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_filter_bins/folder"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_filter_bins/output_as_folder"
                        },
                        {
                            "valueFrom": "metabat2_bins",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_filter_bins/output_folder_name"
                        },
                        {
                            "valueFrom": "bin\\.[0-9]+\\.fa",
                            "id": "#workflow_metagenomics_binning.cwl/metabat2_filter_bins/regex"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/metabat2_filter_bins/output_folder"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/metabat2_filter_bins"
                },
                {
                    "doc": "Binning procedure using SemiBin2",
                    "label": "Semibin2 binning",
                    "run": "#semibin2_single_easy_bin.cwl",
                    "when": "$(inputs.run_semibin2)",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/assembly",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/assembly"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/bam_file",
                            "valueFrom": "${ return inputs.environment === \"none\" ? self : null; }\n",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/bam_file"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/semibin2_environment",
                            "valueFrom": "${ return self !== \"none\" ? self : null; }\n",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/environment"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/identifier",
                            "valueFrom": "$(self)_SemiBin2",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/identifier"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/metabat2_contig_depths/depths",
                            "valueFrom": "${ return inputs.environment !== \"none\" ? self : null; }\n",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/metabat2_depth_file"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_semibin2",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/run_semibin2"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/semibin2/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/semibin2/output_bins",
                        "#workflow_metagenomics_binning.cwl/semibin2/data",
                        "#workflow_metagenomics_binning.cwl/semibin2/data_split",
                        "#workflow_metagenomics_binning.cwl/semibin2/model",
                        "#workflow_metagenomics_binning.cwl/semibin2/coverage"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/semibin2"
                },
                {
                    "doc": "Preparation of SemiBin output files to a specific output folder.",
                    "label": "SemiBin output folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.run_semibin2)",
                    "in": [
                        {
                            "valueFrom": "binner_semibin2",
                            "id": "#workflow_metagenomics_binning.cwl/semibin_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/semibin2/data",
                                "#workflow_metagenomics_binning.cwl/semibin2/data_split",
                                "#workflow_metagenomics_binning.cwl/semibin2/model",
                                "#workflow_metagenomics_binning.cwl/semibin2/coverage"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/semibin_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#workflow_metagenomics_binning.cwl/semibin2/output_bins"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_metagenomics_binning.cwl/semibin_files_to_folder/folders"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_semibin2",
                            "id": "#workflow_metagenomics_binning.cwl/semibin_files_to_folder/run_semibin2"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/semibin_files_to_folder/results"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/semibin_files_to_folder"
                },
                {
                    "doc": "Microbial annotation workflow of the predicted bins",
                    "label": "Annotate bins",
                    "when": "$(inputs.annotate_bins)",
                    "run": "#workflow_microbial_annotation.cwl",
                    "scatter": [
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/genome_fasta"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/annotate_bins",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/annotate_bins"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/bakta_db",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/bakta_db"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/compress_output"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/eggnog_dbs",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/eggnog_dbs"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/binette_bins/files",
                            "default": [],
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/genome_fasta"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/interproscan_applications",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/interproscan_applications"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/interproscan_directory",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/interproscan_directory"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/kofamscan_limit_sapp",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/kofamscan_limit_sapp"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_eggnog",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/run_eggnog"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_interproscan",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/run_interproscan"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_kofamscan",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/run_kofamscan"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/sapp_conversion"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/skip_bakta_crispr",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/skip_bakta_crispr"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/bakta_folder_compressed",
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/compressed_other_files",
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins/sapp_hdt_file"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_bins"
                },
                {
                    "doc": "Microbial annotation workflow of the predicted bins",
                    "label": "Annotate bins",
                    "when": "$(inputs.annotate_unbinned && inputs.genome_fasta !== null)",
                    "run": "#workflow_microbial_annotation.cwl",
                    "in": [
                        {
                            "source": "#workflow_metagenomics_binning.cwl/annotate_unbinned",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/annotate_unbinned"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/bakta_db",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/bakta_db"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/compress_output"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/eggnog_dbs",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/eggnog_dbs"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/get_unbinned_contigs/unbinned_fasta",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/genome_fasta"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/interproscan_applications",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/interproscan_applications"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/interproscan_directory",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/interproscan_directory"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/kofamscan_limit_sapp",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/kofamscan_limit_sapp"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/metagenome"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_eggnog",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/run_eggnog"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_interproscan",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/run_interproscan"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/run_kofamscan",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/run_kofamscan"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/sapp_conversion"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/skip_bakta_crispr",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/skip_bakta_crispr"
                        },
                        {
                            "default": true,
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/skip_bakta_plot"
                        },
                        {
                            "source": "#workflow_metagenomics_binning.cwl/threads",
                            "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/threads"
                        }
                    ],
                    "out": [
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/bakta_folder_compressed",
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/compressed_other_files",
                        "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned/sapp_hdt_file"
                    ],
                    "id": "#workflow_metagenomics_binning.cwl/workflow_microbial_annotation_unbinned"
                }
            ],
            "id": "#workflow_metagenomics_binning.cwl",
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
            "https://schema.org/dateCreated": "2025-05-02",
            "https://schema.org/dateModified": "2025-09-05",
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
            "label": "Microbial (meta-) genome annotation",
            "doc": "Workflow for microbial genome annotation.",
            "outputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/results",
                    "id": "#workflow_microbial_annotation.cwl/bakta_folder_compressed"
                },
                {
                    "type": "Directory",
                    "outputSource": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/results",
                    "id": "#workflow_microbial_annotation.cwl/bakta_folder_uncompressed"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#workflow_microbial_annotation.cwl/compress_other/outfile",
                    "linkMerge": "merge_flattened",
                    "pickValue": "all_non_null",
                    "id": "#workflow_microbial_annotation.cwl/compressed_other_files"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/hdt_file",
                    "id": "#workflow_microbial_annotation.cwl/sapp_hdt_file"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#workflow_microbial_annotation.cwl/uncompressed_other/outfiles",
                    "id": "#workflow_microbial_annotation.cwl/uncompressed_other_files"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Bakta DB",
                    "doc": "Bakta database directory (default bakta-db_v5.1-light built in the container) (optional)\n",
                    "id": "#workflow_microbial_annotation.cwl/bakta_db"
                },
                {
                    "type": "int",
                    "default": 11,
                    "doc": "Codon table 11/4. Default = 11",
                    "label": "Codon table",
                    "id": "#workflow_microbial_annotation.cwl/codon_table"
                },
                {
                    "type": "boolean",
                    "doc": "Compress output files. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/compress_output"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination (prov only)",
                    "doc": "Not used in this workflow. Output destination used in cwl-prov reporting only.",
                    "id": "#workflow_microbial_annotation.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        "Directory"
                                    ],
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs/data_dir"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file",
                                    "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs/db"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#workflow_microbial_annotation.cwl/eggnog_dbs/eggnog_dbs/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#workflow_microbial_annotation.cwl/eggnog_dbs"
                },
                {
                    "type": "File",
                    "label": "Genome fasta file",
                    "doc": "Genome fasta file used for annotation (required)",
                    "id": "#workflow_microbial_annotation.cwl/genome_fasta"
                },
                {
                    "type": "string",
                    "default": "Pfam",
                    "label": "Interproscan applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "id": "#workflow_microbial_annotation.cwl/interproscan_applications"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "InterProScan 5 directory",
                    "doc": "Directory of the (full) InterProScan 5 program. When not given InterProscan will not run. (optional)",
                    "id": "#workflow_microbial_annotation.cwl/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit max number of entries of kofamscan hits per locus in SAPP. Default 5",
                    "default": 5,
                    "id": "#workflow_microbial_annotation.cwl/kofamscan_limit_sapp"
                },
                {
                    "type": "boolean",
                    "label": "metagenome",
                    "doc": "Run in metagenome mode. Affects only protein prediction. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/metagenome"
                },
                {
                    "type": "boolean",
                    "label": "Run eggNOG-mapper",
                    "doc": "Run with eggNOG-mapper annotation. Requires eggnog database files. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/run_eggnog"
                },
                {
                    "type": "boolean",
                    "label": "Run InterProScan",
                    "doc": "Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/run_interproscan"
                },
                {
                    "type": "boolean",
                    "label": "Run kofamscan",
                    "doc": "Run with KEGG KO KoFamKOALA annotation. Default false",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/run_kofamscan"
                },
                {
                    "type": "boolean",
                    "doc": "Run SAPP (Semantic Annotation Platform with Provenance) on the annotations. Default true",
                    "default": true,
                    "id": "#workflow_microbial_annotation.cwl/sapp_conversion"
                },
                {
                    "type": "boolean",
                    "label": "Skip bakta CRISPR array prediction using PILER-CR",
                    "doc": "Skip CRISPR prediction",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/skip_bakta_crispr"
                },
                {
                    "type": "boolean",
                    "label": "Skip plot",
                    "doc": "Skip Bakta plotting",
                    "default": false,
                    "id": "#workflow_microbial_annotation.cwl/skip_bakta_plot"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "doc": "Number of threads to use for computational processes. Default 4",
                    "label": "Number of threads",
                    "id": "#workflow_microbial_annotation.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "Bakta",
                    "doc": "Bacterial genome annotation tool",
                    "when": "$(inputs.bakta_db !== null)",
                    "run": "#bakta.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta_db",
                            "id": "#workflow_microbial_annotation.cwl/bakta/db"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/genome_fasta",
                            "id": "#workflow_microbial_annotation.cwl/bakta/fasta_file"
                        },
                        {
                            "default": true,
                            "id": "#workflow_microbial_annotation.cwl/bakta/keep_contig_headers"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/metagenome",
                            "id": "#workflow_microbial_annotation.cwl/bakta/meta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/skip_bakta_crispr",
                            "id": "#workflow_microbial_annotation.cwl/bakta/skip_crispr"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/skip_bakta_plot",
                            "id": "#workflow_microbial_annotation.cwl/bakta/skip_plot"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/bakta/threads"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/codon_table",
                            "id": "#workflow_microbial_annotation.cwl/bakta/translation_table"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/bakta/hypo_sequences_cds",
                        "#workflow_microbial_annotation.cwl/bakta/hypo_annotation_tsv",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_tsv",
                        "#workflow_microbial_annotation.cwl/bakta/summary_txt",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_json",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_gff3",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_gbff",
                        "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                        "#workflow_microbial_annotation.cwl/bakta/sequences_fna",
                        "#workflow_microbial_annotation.cwl/bakta/sequences_ffn",
                        "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                        "#workflow_microbial_annotation.cwl/bakta/plot_png",
                        "#workflow_microbial_annotation.cwl/bakta/plot_svg"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/bakta"
                },
                {
                    "label": "Compressed Bakta folder",
                    "doc": "Move all compressed bakta files to a folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.compress_output)",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/compress_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/genome_fasta",
                            "valueFrom": "$(\"bakta_\"+self.nameroot)",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/destination"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/compress_bakta/outfile",
                                "#workflow_microbial_annotation.cwl/bakta/plot_png"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/files"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed/results"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_compressed"
                },
                {
                    "label": "Uncompressed Bakta folder",
                    "doc": "Move all uncompressed bakta files to a folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.compress_output == false)",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/compress_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/genome_fasta",
                            "valueFrom": "$(\"bakta_\"+self.nameroot)",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/destination"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/bakta/hypo_sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/hypo_annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/summary_txt",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_json",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gff3",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gbff",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_fna",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_ffn",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/plot_svg",
                                "#workflow_microbial_annotation.cwl/bakta/plot_png"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/files"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed/results"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/bakta_to_folder_uncompressed"
                },
                {
                    "label": "Compress Bakta",
                    "run": "#pigz.cwl",
                    "when": "$(inputs.compress_output)",
                    "scatter": [
                        "#workflow_microbial_annotation.cwl/compress_bakta/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/compress_bakta/compress_output"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/bakta/hypo_sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/hypo_annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_tsv",
                                "#workflow_microbial_annotation.cwl/bakta/summary_txt",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_json",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gff3",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_gbff",
                                "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_fna",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_ffn",
                                "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                                "#workflow_microbial_annotation.cwl/bakta/plot_svg"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/compress_bakta/inputfile"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/compress_bakta/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/compress_bakta/outfile"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/compress_bakta"
                },
                {
                    "label": "Compressed other",
                    "doc": "Compress files when compression is true",
                    "when": "$(inputs.compress_output)",
                    "run": "#pigz.cwl",
                    "scatter": [
                        "#workflow_microbial_annotation.cwl/compress_other/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/compress_other/compress_output"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/kofamscan/output",
                                "#workflow_microbial_annotation.cwl/interproscan/json_annotations",
                                "#workflow_microbial_annotation.cwl/interproscan/tsv_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_orthologs"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/compress_other/inputfile"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/compress_other/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/compress_other/outfile"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/compress_other"
                },
                {
                    "label": "eggNOG-mapper",
                    "when": "$(inputs.run_eggnog && inputs.eggnog !== null && inputs.input_fasta.size > 1024)",
                    "run": "#eggnog-mapper.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/cpu"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/eggnog_dbs",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/eggnog_dbs"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/input_fasta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/run_eggnog",
                            "id": "#workflow_microbial_annotation.cwl/eggnogmapper/run_eggnog"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/eggnogmapper/output_annotations",
                        "#workflow_microbial_annotation.cwl/eggnogmapper/output_orthologs"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/eggnogmapper"
                },
                {
                    "label": "InterProScan 5",
                    "when": "$(inputs.run_interproscan && inputs.interproscan_directory !== null && inputs.protein_fasta.size > 1024)",
                    "run": "#interproscan_v5.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/interproscan_applications",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/applications"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/interproscan_directory",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/interproscan_directory"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/protein_fasta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/run_interproscan",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/run_interproscan"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/interproscan/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/interproscan/tsv_annotations",
                        "#workflow_microbial_annotation.cwl/interproscan/json_annotations"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/interproscan"
                },
                {
                    "label": "KofamScan",
                    "when": "$(inputs.run_kofamscan && inputs.input_fasta.size > 1024)",
                    "run": "#kofamscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/sequences_cds",
                            "id": "#workflow_microbial_annotation.cwl/kofamscan/input_fasta"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/run_kofamscan",
                            "id": "#workflow_microbial_annotation.cwl/kofamscan/run_kofamscan"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/kofamscan/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/kofamscan/output"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/kofamscan"
                },
                {
                    "label": "Uncompressed other",
                    "doc": "Gather files when compression is false",
                    "when": "$(inputs.compress_output == false)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#workflow_microbial_annotation.cwl/uncompressed_other/run/files"
                            }
                        ],
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#workflow_microbial_annotation.cwl/uncompressed_other/run/outfiles"
                            }
                        ],
                        "expression": "${return {'outfiles': inputs.files} }\n"
                    },
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/compress_output",
                            "id": "#workflow_microbial_annotation.cwl/uncompressed_other/compress_output"
                        },
                        {
                            "source": [
                                "#workflow_microbial_annotation.cwl/kofamscan/output",
                                "#workflow_microbial_annotation.cwl/interproscan/json_annotations",
                                "#workflow_microbial_annotation.cwl/interproscan/tsv_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_annotations",
                                "#workflow_microbial_annotation.cwl/eggnogmapper/output_orthologs"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#workflow_microbial_annotation.cwl/uncompressed_other/files"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/uncompressed_other/outfiles"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/uncompressed_other"
                },
                {
                    "label": "SAPP conversion",
                    "doc": "Convert annotation output to SAPP (RDF) format",
                    "when": "$(inputs.sapp_conversion && inputs.embl_file.size > 1024)",
                    "run": "#workflow_sapp_conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_microbial_annotation.cwl/bakta/annotation_embl",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/embl_file"
                        },
                        {
                            "valueFrom": "$(inputs.embl_file.nameroot)",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/identifier"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/interproscan/json_annotations",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/interproscan_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/kofamscan_limit_sapp",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/kofamscan_limit"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/kofamscan/output",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/kofamscan_output"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/sapp_conversion",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/sapp_conversion"
                        },
                        {
                            "source": "#workflow_microbial_annotation.cwl/threads",
                            "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/threads"
                        }
                    ],
                    "out": [
                        "#workflow_microbial_annotation.cwl/workflow_sapp_conversion/hdt_file"
                    ],
                    "id": "#workflow_microbial_annotation.cwl/workflow_sapp_conversion"
                }
            ],
            "id": "#workflow_microbial_annotation.cwl",
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
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2025-08-04",
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
                    "outputSource": "#workflow_sapp_conversion.cwl/compress_hdt/outfile",
                    "id": "#workflow_sapp_conversion.cwl/hdt_file"
                }
            ],
            "inputs": [
                {
                    "type": "int",
                    "doc": "The codon table used for gene prediction",
                    "label": "Codon table",
                    "default": 11,
                    "id": "#workflow_sapp_conversion.cwl/codon_table"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Output destination used for cwl-prov reporting.",
                    "id": "#workflow_sapp_conversion.cwl/destination"
                },
                {
                    "label": "eggnog-mapper output",
                    "doc": "eggnog-mapper output file. Annotations tsv file (optional)",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/eggnog_output"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/embl_file"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "FASTA input file",
                    "doc": "Genome sequence in FASTA format",
                    "id": "#workflow_sapp_conversion.cwl/genome_fasta"
                },
                {
                    "type": "string",
                    "doc": "Identifier of the sample being converted",
                    "label": "Identifier",
                    "id": "#workflow_sapp_conversion.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "InterProScan output",
                    "doc": "InterProScan output file. JSON or TSV (optional)",
                    "id": "#workflow_sapp_conversion.cwl/interproscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit the number of hits per locus tag to be converted (0=no limit) (optional). Default 0",
                    "id": "#workflow_sapp_conversion.cwl/kofamscan_limit"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "kofamscan output",
                    "doc": "KoFamScan / KoFamKOALA output file. detail-tsv (optional)",
                    "id": "#workflow_sapp_conversion.cwl/kofamscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "id": "#workflow_sapp_conversion.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "Compress HDT",
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/turtle_to_hdt/hdt_output",
                            "id": "#workflow_sapp_conversion.cwl/compress_hdt/inputfile"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/threads",
                            "id": "#workflow_sapp_conversion.cwl/compress_hdt/threads"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/compress_hdt/outfile"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/compress_hdt"
                },
                {
                    "when": "$(inputs.embl != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/codon_table",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/codon_table"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/embl_file",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/embl"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/embl_conversion/output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/embl_conversion"
                },
                {
                    "when": "$(inputs.fasta != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/codon_table",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/codon_table"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/genome_fasta",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/fasta"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/genome_conversion/output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/genome_conversion"
                },
                {
                    "label": "eggNOG conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_eggnog.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/output_prefix"
                        },
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/eggnog_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_eggnog/eggnog_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_eggnog"
                },
                {
                    "label": "InterProScan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_interproscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/output_prefix"
                        },
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/interproscan_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_interproscan"
                },
                {
                    "label": "Kofamscan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_kofamscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/kofamscan_limit",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/limit"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/output_prefix"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/embl_conversion/output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/kofamscan_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan"
                },
                {
                    "label": "TTL to HDT",
                    "run": "#toHDT.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_eggnog/eggnog_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt/input"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "valueFrom": "$(self).SAPP.hdt",
                            "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt/output"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/turtle_to_hdt/hdt_output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt"
                }
            ],
            "id": "#workflow_sapp_conversion.cwl",
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
    "$schemas": [
        "https://schema.org/version/latest/schemaorg-current-http.rdf",
        "https://schema.org/version/latest/schemaorg-current-https.rdf",
        "http://edamontology.org/EDAM_1.16.owl",
        "http://edamontology.org/EDAM_1.20.owl",
        "http://edamontology.org/EDAM_1.18.owl"
    ],
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
