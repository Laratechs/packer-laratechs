#!/bin/bash

FOLDER_TO_ZIP="/etc/terraria"
GCS_BUCKET="laratechs-game-backups"
CONFIG_FILE="/tmp/game_instance_id"

archive_folder() {
  local folder_path="$1"
  local archive_name="$2"
  tar -czvf "$archive_name" --directory="$folder_path" .
}

upload_to_gcs() {
  local archive_name="$1"
  local gcs_path="gs://$GCS_BUCKET/terraria/$archive_name"
  
  echo "Uploading $archive_name to $gcs_path..."
  gsutil cp "$archive_name" "$gcs_path"
  echo "Upload successful."
}

# Main function
main() {
  if [ -f "$CONFIG_FILE" ]; then
    # Read save name from the configuration file
    local save_name=$(cat $CONFIG_FILE)
  else
    # If the configuration file doesn't exist, use Google Cloud Metadata
    local save_name=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/game_instance_id)
  fi

  if [ -z "$save_name" ]; then
    echo "Save name not found in config file or game instance metadata. Exiting."
    echo "Config file: Please provide the instance_id in a plain text file @ /tmp/game_instance_id."
    echo "Metadata: Please provide a key 'game_instance_id' with its value as the save name in the instance's custom metadata."
    exit 1
  fi

  local archive_name="$save_name.backup"

  archive_folder /etc/terraria "$archive_name"

  # Upload the zip file to GCS
  upload_to_gcs "$archive_name"

  # Delete the zip file
  rm "$archive_name"
}

# Run the main function with folder path and save name as arguments
main $1

