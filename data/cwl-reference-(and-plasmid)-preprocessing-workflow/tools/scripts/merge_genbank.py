import sys
from pathlib import Path
from Bio import SeqIO
from Bio.SeqRecord import SeqRecord

def main():
    args = sys.argv[1:]

    if "--fasta" in args:
        write_fasta = True
        args.remove("--fasta")
    else:
        write_fasta = False

    if len(args) < 2:
        sys.exit("Usage: python merge_genbanks.py [file1.gb file2.gb ...] output_prefix [--fasta]")

    input_files = args[:-1]
    output_prefix = args[-1]

    merged_records = []

    for gb_file in input_files:
        with open(gb_file, encoding="utf-8", errors="replace") as handle:
            records = list(SeqIO.parse(handle, "genbank"))
        for i, record in enumerate(records):
            # Fix broken IDs from malformed ACCESSION/VERSION fields
            if record.id == "." or not record.id.strip():
                record.id = record.name if record.name and record.name != "." else f"plasmid_{i}"
                record.name = record.id
                record.description = record.description or "synthetic plasmid"

            if "circular" in record.annotations.get("topology", "").lower():
                record.annotations["topology"] = "circular"
            
            merged_records.append(record)


    # Write merged GenBank
    gb_out = f"{output_prefix}.gb"
    with open(gb_out, "w", encoding="utf-8") as handle:
        SeqIO.write(merged_records, handle, "genbank")

    if write_fasta:
        fasta_out = f"{output_prefix}.fasta"
        with open(fasta_out, "w", encoding="utf-8") as handle:
            SeqIO.write(merged_records, fasta_out, "fasta")
        print(f"Merged {len(input_files)} file(s) into {gb_out} and {fasta_out}")
    else:
        print(f"Merged {len(input_files)} file(s) into {gb_out}")

if __name__ == "__main__":
    # Example: python merge_genbanks.py plasmid1.gb plasmid2.gb merged_all --fasta
    main()