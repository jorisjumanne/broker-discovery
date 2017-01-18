#!/bin/sh -x

# == Watch Services
oc get pods --selector="${FILTER}" --watch --template='{{ .metadata.name}}
' |while read line
do
  echo "== Found new broker: " $line
  oc get pods --selector="${FILTER}" --template="`cat $TEMPLATE`" |oc create -f -
  oc get routes --selector="${FILTER}" -o name |egrep -v "`oc get pods --template='{{range .items}}{{if eq .status.phase "Running" }}{{.metadata.name}}|{{end}}{{end}}'`dummy" |xargs --no-run-if-empty -L1 oc delete 

done

