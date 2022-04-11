#!/bin/bash
aws kms encrypt --key-id alias/tf-example-key --plaintext file://<(cat - | base64) --output text --query CiphertextBlob
