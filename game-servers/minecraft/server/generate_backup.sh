#!/bin/bash

FOLDER_TO_ZIP="/etc/minecraft"
GCS_BUCKET="laratechs-game-backups"

archive_folder() {
  local folder_path="$1"
  local archive_name="$2"
  tar -czvf "$archive_name" --directory="$folder_path" .
}

upload_to_gcs() {
  local archive_name="$1"
  local gcs_path="gs://$GCS_BUCKET/minecraft/$archive_name"
  
  echo "Uploading $archive_name to $gcs_path..."
  gsutil cp "$archive_name" "$gcs_path"
  echo "Upload successful."
}

# Main function
main() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <save_name>"
    exit 1
  fi

  local save_name="$1"
  local archive_name="$save_name.backup"

  archive_folder /etc/minecraft "$archive_name"

  # Upload the zip file to GCS
  upload_to_gcs "$archive_name"

  # Delete the zip file
  rm "$archive_name"
}

# Run the main function with folder path and save name as arguments
main $1

