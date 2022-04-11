#!/bin/bash
aws kms decrypt --ciphertext-blob fileb://<(cat - | base64 -d) --output text --query Plaintext | base64 -d
