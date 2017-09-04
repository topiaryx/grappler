#!/usr/bin/env bash
#
# Grappler: Grafana stack installer for CentOS 7+
# Installs Docker, Grafana, InfluxDB, Graphite and Telegraf 
#
# This file is released under whatever license.

# Install with this command:
#
# curl -sSL https://grappler.davemobley.net | bash

# PHASE 4a: TELEGRAF: Create Telegraf persistent data
telegrafCreatePersistentData() {
	sudo mkdir -p /docker/containers/telegraf/
}

# PHASE 4b: TELEGRAF: Create Telegraf default configuration
telegrafGenerateDefaultConfiguration() {
	docker run --rm telegraf -sample-config > /docker/containers/telegraf/conf/telegraf.conf
}

# PHASE 4c: TELEGRAF: Create telegraf update scripts and make it executable
telegrafCreateUpdateScript() {
	sudo wget -O $HOME/grapplerupdaters/telegrafupdater.sh # add link after upload
	sudo chmod +x $HOME/grapplerupdaters/telegrafupdater.sh
}

# PHASE 4e: TELEGRAF: Start and enable the Telegraf cotainer
telegrafStartEnableContainer() {
	docker start influxdb
	sudo systemctl enable influxdb.service
	sudo systemctl start influxdb
}