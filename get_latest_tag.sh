#!/bin/bash
curl -L --fail "https://hub.docker.com/v2/repositories/theanalyst6/house-prediction-ml/tags/?page_size=1000" | \
	jq '.results | .[] | .name' -r | \
	sed 's/latest//' | \
	sort --version-sort | \
	tail -n 1
