#!/bin/bash

CURRENT=$(cd $(dirname $0) && pwd)
perl ${CURRENT}/template.pl > ${CURRENT}/template.json
packer build ${CURRENT}/template.json
