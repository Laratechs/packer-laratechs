#!/bin/bash
#

gcloud config set project game-svcs --quiet

BUCKET_NAME="laratechs-game-backups"
CONFIG_FILE="/tmp/game_instance_id"

# Function to download a backup from Google Cloud Storage
download_backup() {
  local save_name="$1"
  # Replace with actual Google Cloud Storage URL
  local gcs_url="gs://$BUCKET_NAME/terraria/$save_name.backup"
  
  # Check if the backup exists in GCS
  if gsutil -q stat "$gcs_url"; then
    echo "Downloading backup for $save_name..."
    rm -rf /etc/terraria/*
    gsutil cp "$gcs_url" "/tmp/backup.tar.gz"
    tar -xzvf "/tmp/backup.tar.gz" -C "/etc/terraria"
    echo "Backup downloaded successfully."
  else
    echo "Backup for $save_name does not exist in GCS. Generating first-time backup."
    /etc/terraria/generate_backup.sh "$save_name"
  fi
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
    echo "Save name not found in config file or GCP Metadata. Exiting."
    exit 1
  fi

  download_backup "$save_name"
  /etc/terraria/TerrariaServer.bin.x86_64 -config /etc/terraria/config.txt

}

# Run the main function
main
