"""
Author: Francis Charette-Migneault <francis.charette-migneault@crim.ca>
License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

Extracted from Open Science Persistent Demonstrator algae use-case code (https://osf.io/aujkb).
Added utilities to parse parameters from a command-line interface (CLI).
"""
import argparse
import inspect
import os
import tempfile

from lxml import etree


def make_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="download-band-sentinel2-product-safe",
        description="Downloads the Copernicus product band from S3 using the Sentinel-2 SAFE manifest."
    )
    parser.add_argument("--s3-product-url", type=str, required=True, help="S3 URL to the SAFE product reference.")
    parser.add_argument("--s3-access-key", required=True)
    parser.add_argument("--s3-secret-key", required=True)
    parser.add_argument("--resolution", choices=["10m", "20m", "60m"], required=False,
                        help="Resolution of the band to download.")
    parser.add_argument("--band", required=True, choices=[
        "B01",
        "B02",
        "B03",
        "B04",
        "B05",
        "B06",
        "B07",
        "B08",
        "B8A",
        "B09",
        "B11",
        "B12",
        "AOT",
        "SCL",
        "TCI",
        "WVP",
    ], help="Band to download.")
    parser.add_argument("-d", "--debug", required=False, action="store_true", help=(
        "Enable debugging operations that will leave temporary files and provide debug details from commands."
    ))
    return parser


def download_copernicus_s3_file(s3_path: str, s3_access_key: str, s3_secret_key: str, debug: bool = False) -> str:
    with tempfile.NamedTemporaryFile(suffix="conf.s3cfg", mode="w", encoding="utf-8", delete=not debug) as s3cmd_conf:
        # https://documentation.dataspace.copernicus.eu/APIs/S3.html#example-access-using-s3cmd
        s3cmd_conf.write(inspect.cleandoc(f"""
            [default]
            host_base = eodata.dataspace.copernicus.eu
            host_bucket = eodata.dataspace.copernicus.eu
            human_readable_sizes = False
            use_https = true
            check_ssl_certificate = true
            access_key = {s3_access_key}
            secret_key = {s3_secret_key}
        """) + "\n")
        log_opt = "-d" if debug else "-q"
        s3cmd_conf.flush()  # make sure it gets written right away
        s3cmd_conf.seek(0)  # move to start to allow reading contents
        file_name = os.path.basename(s3_path)
        local_path = os.path.join(os.getcwd(), file_name)
        os.system(f"s3cmd {log_opt} -c '{s3cmd_conf.name}' get '{s3_path}' '{local_path}'")
    return local_path


def extract_band_location(band: str, resolution: str, s3_product_url: str, manifest_path: str) -> str:
    """
    Extract the appropriate selected band location from the SAFE Manifest XML file.

    Assuming the received value is an S3 URL formatted as follows, we can build the underlying path to extract.

        s3:///.../MMM_MSIXXX_YYYYMMDDTHHMMSS_Nxxyy_ROOO_Txxxxx_<Product Discriminator>.SAFE

    References:
    - https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/naming-convention
    - https://sentinels.copernicus.eu/web/sentinel/user-guides/sentinel-2-msi/data-formats
    """
    with open(manifest_path, mode="r", encoding="utf-8") as manifest_fd:
        manifest_xml = etree.parse(manifest_fd)

    # bands names can be encoded using various formats (note how band/resolution in ID and href differ):
    #
    #     <dataObject ID="IMG_DATA_Band_60m_1_Tile1_Data">
    #       <byteStream mimeType="application/octet-stream" size="3029379">
    #         <fileLocation
    #           locatorType="URL"
    #           href="./GRANULE/L1C_T29SPC_A021012_20190701T111753/IMG_DATA/T29SPC_20190701T110621_B01.jp2"
    #         />
    #         <checksum checksumName="MD5">d300a617c7bc937b6c7e48309c88eaf7</checksum>
    #       </byteStream>
    #     </dataObject>
    #
    #     <dataObject ID="IMG_DATA_Band_B01_60m_Tile1_Data">
    #       <byteStream mimeType="application/octet-stream" size="3708333">
    #         <fileLocation
    #           locatorType="URL"
    #           href="./GRANULE/L2A_T29SPC_A012075_20190629T112256/IMG_DATA/R60m/T29SPC_20190629T112119_B01_60m.jp2"
    #         />
    #         <checksum checksumName="MD5">37d26c64bebfdbadcd0ebfb57adc73c2</checksum>
    #       </byteStream>
    #     </dataObject>

    try:
        all_objects = [
            obj for obj in manifest_xml.findall("dataObjectSection/dataObject")  # /byteStream/fileLocation
            if "IMG_DATA" in (obj.attrib.get("ID") or "")
        ]
        all_files = [
            (obj.attrib.get("ID"), item[0].attrib.get("href"))
            for obj, item in (
                (obj, obj.findall("byteStream/fileLocation"))
                for obj in all_objects
            )
        ]
        jp2_files = [
            file for obj_id, file in all_files
            if (
                file.endswith(".jp2") and
                (band in file or band in obj_id) and
                (resolution in file or resolution in obj_id)
            )
        ]
        band_file = jp2_files[0]
        band_file = band_file[2:] if band_file.startswith("./") else band_file
        band_url = os.path.join(s3_product_url, band_file)
    except (AttributeError, IndexError) as exc:
        raise RuntimeError(
            f"Could not find band '{band}' with resolution '{resolution}' from '{s3_product_url}' product."
        ) from exc
    return band_url


def main() -> str:
    parser = make_parser()
    ns = parser.parse_args()
    s3_manifest = f"{ns.s3_product_url}/manifest.safe"
    manifest_path = download_copernicus_s3_file(s3_manifest, ns.s3_access_key, ns.s3_secret_key, ns.debug)

    band_path = extract_band_location(ns.band, ns.resolution, ns.s3_product_url, manifest_path)
    band_file = download_copernicus_s3_file(band_path, ns.s3_access_key, ns.s3_secret_key, ns.debug)

    print(band_file)  # for packages that work using stdout capture
    return band_file  # for applications calling the function directly


if __name__ == "__main__":
    main()
