import sys
import pandas as pd
import yaml
from pathlib import Path


def generate_yaml_inputs(excel_path: str, output_dir: str = "yaml_inputs") -> None:
    sample_sheet = pd.read_excel(excel_path, sheet_name='Sample - default')
    assay_sheet = pd.read_excel(excel_path, sheet_name='Assay - default')

    assay_sheet.columns = assay_sheet.columns.str.strip()
    sample_sheet.columns = sample_sheet.columns.str.strip()

    merged = pd.merge(
        assay_sheet,
        sample_sheet,
        on='sample identifier',
        how='inner'
    )

    Path(output_dir).mkdir(exist_ok=True)

    for _, row in merged.iterrows():
        sample_id = str(row['sample identifier']).strip()
        input_read_path = str(row['Path_to_fastq']).strip()

        yaml_data = {
            'input_read': {
                'class': 'File',
                'path': input_read_path
            }
        }

        ref = str(row['Reference_genbank']).strip()
        if ref.endswith('.gb'):
            yaml_data['reference_gb'] = {
                'class': 'File',
                'path': ref
            }
        else:
            yaml_data['NCBI_identifier'] = ref

        if 'Plasmids' in row and pd.notna(row['Plasmids']):
            plasmid_paths = [p.strip() for p in str(row['Plasmids']).split(',')]
            yaml_data['plasmids'] = [{'class': 'File', 'path': p} for p in plasmid_paths]

        yaml_path = Path(output_dir) / f"{sample_id}_inputs.yaml"
        with open(yaml_path, 'w') as f:
            yaml.dump(yaml_data, f, default_flow_style=False, sort_keys=False)

        print(yaml_data)


def main():
    if len(sys.argv) != 2:
        print("Usage: python generate_inputs.py <path_to_excel_file>")
        sys.exit(1)

    excel_path = sys.argv[1]
    generate_yaml_inputs(excel_path)


if __name__ == "__main__":
    main()