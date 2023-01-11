#!/bin/bash
echo "$version"
version=`cat version |grep version |awk '{print \$2}'`
sed -i "s/{{theversion}}/$version/" resource/webapp.yaml
echo "!Done"